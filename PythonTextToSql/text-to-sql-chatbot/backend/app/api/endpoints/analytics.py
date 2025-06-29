"""
Analytics Dashboard Endpoints for Text-to-SQL Chatbot API
Provides comprehensive monitoring, insights, and performance analytics
"""

from datetime import datetime, timedelta
from typing import Dict, Any, List, Optional
from fastapi import APIRouter, Depends, HTTPException, status, Query
import logging

from ...models.schemas import APIResponse
from ...utils.auth import get_current_active_user, TokenData
from ...utils.analytics import get_analytics_service, AnalyticsService
from ...utils.query_cache import get_query_cache, QueryCacheService
from ...middleware.rate_limiter import get_rate_limiter_stats
from ...utils.pipeline_wrapper import get_pipeline, TextToSQLPipelineWrapper
from ...utils.context_manager import get_context_manager, ConversationContextManager
from ...core.config import settings

# Setup logging
logger = logging.getLogger(__name__)

# Create router
router = APIRouter(prefix="/analytics", tags=["Analytics"])

@router.get("/dashboard", response_model=APIResponse)
async def get_dashboard_overview(
    current_user: TokenData = Depends(get_current_active_user),
    analytics: AnalyticsService = Depends(get_analytics_service),
    cache: QueryCacheService = Depends(get_query_cache),
    pipeline: TextToSQLPipelineWrapper = Depends(get_pipeline),
    context_manager: ConversationContextManager = Depends(get_context_manager)
):
    """
    Get comprehensive dashboard overview
    Includes system health, performance metrics, and key statistics
    """
    try:
        # Check permissions (only admins and lecturers can view full dashboard)
        if current_user.user_role not in ["Training Manager", "lecturer"]:
            # Students get limited dashboard
            return await get_user_dashboard(current_user, analytics, cache)
        
        # Get system analytics
        system_analytics = analytics.get_system_analytics(hours=24)
        
        # Get cache statistics
        cache_stats = cache.get_cache_stats()
        
        # Get rate limiting statistics
        rate_limit_stats = get_rate_limiter_stats()
        
        # Get pipeline status
        pipeline_status = pipeline.get_status()
        
        # Get conversation statistics
        conversation_stats = context_manager.get_stats()
        
        # Calculate system health score
        health_score = _calculate_system_health_score(
            system_analytics, cache_stats, rate_limit_stats, pipeline_status
        )
        
        # Recent activity summary
        recent_activity = _get_recent_activity_summary(analytics)
        
        # Performance insights
        performance_insights = analytics.get_query_insights()
        
        dashboard_data = {
            "overview": {
                "health_score": health_score,
                "status": "healthy" if health_score >= 80 else "degraded" if health_score >= 60 else "critical",
                "uptime_hours": 24,  # Placeholder - would track actual uptime
                "total_users": system_analytics.get("unique_users", 0),
                "total_queries_24h": system_analytics.get("total_queries", 0),
                "avg_response_time": system_analytics.get("avg_execution_time_ms", 0),
                "success_rate": system_analytics.get("success_rate", 0)
            },
            "system_metrics": {
                "pipeline_status": pipeline_status,
                "cache_performance": {
                    "hit_rate": cache_stats.hit_rate,
                    "total_entries": cache_stats.total_entries,
                    "size_mb": cache_stats.total_size_mb,
                    "avg_time_saved": cache_stats.avg_execution_time_saved
                },
                "rate_limiting": {
                    "total_requests": rate_limit_stats.get("total_requests", 0),
                    "blocked_requests": rate_limit_stats.get("blocked_requests", 0),
                    "block_rate": rate_limit_stats.get("block_rate", 0),
                    "active_clients": rate_limit_stats.get("active_clients", 0)
                },
                "conversations": conversation_stats
            },
            "analytics": system_analytics,
            "recent_activity": recent_activity,
            "performance_insights": performance_insights,
            "timestamp": datetime.utcnow().isoformat()
        }
        
        return APIResponse(
            success=True,
            message="Dashboard data retrieved successfully",
            data=dashboard_data,
            timestamp=datetime.utcnow()
        )
        
    except Exception as e:
        logger.error(f"Failed to get dashboard overview: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve dashboard data"
        )

@router.get("/user-dashboard", response_model=APIResponse)
async def get_user_dashboard(
    current_user: TokenData = Depends(get_current_active_user),
    analytics: AnalyticsService = Depends(get_analytics_service),
    cache: QueryCacheService = Depends(get_query_cache),
    days: int = Query(7, ge=1, le=30, description="Number of days to analyze")
):
    """
    Get personalized dashboard for current user
    Shows user-specific analytics and insights
    """
    try:
        # Get user analytics
        user_analytics = analytics.get_user_analytics(current_user.user_id, days)
        
        # Get similar queries for recommendations
        if user_analytics.get("total_queries", 0) > 0:
            # Get a recent query to find similar ones
            recent_queries = [
                q for q in analytics.query_metrics 
                if q.user_id == current_user.user_id
            ][-5:]  # Last 5 queries
            
            recommendations = []
            if recent_queries:
                similar_queries = cache.find_similar_queries(
                    recent_queries[-1].question, 
                    current_user.user_role,
                    threshold=0.6
                )
                recommendations = [
                    {
                        "question": q.question,
                        "hit_count": q.hit_count,
                        "avg_execution_time": q.execution_time_ms
                    }
                    for q in similar_queries[:3]
                ]
        else:
            recommendations = []
        
        # Personal insights
        personal_insights = _generate_personal_insights(user_analytics, current_user.user_role)
        
        user_dashboard_data = {
            "user_info": {
                "user_id": current_user.user_id,
                "user_role": current_user.user_role,
                "username": current_user.username
            },
            "analytics": user_analytics,
            "recommendations": recommendations,
            "insights": personal_insights,
            "quick_stats": {
                "queries_today": _get_queries_today_count(analytics, current_user.user_id),
                "avg_weekly_queries": user_analytics.get("total_queries", 0) / max(days/7, 1),
                "most_common_question_type": _get_most_common_question_type(user_analytics),
                "improvement_suggestions": _get_improvement_suggestions(user_analytics)
            }
        }
        
        return APIResponse(
            success=True,
            message="User dashboard data retrieved successfully",
            data=user_dashboard_data,
            timestamp=datetime.utcnow()
        )
        
    except Exception as e:
        logger.error(f"Failed to get user dashboard: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve user dashboard data"
        )

@router.get("/performance", response_model=APIResponse)
async def get_performance_metrics(
    current_user: TokenData = Depends(get_current_active_user),
    analytics: AnalyticsService = Depends(get_analytics_service),
    hours: int = Query(24, ge=1, le=168, description="Number of hours to analyze"),
    granularity: str = Query("hour", regex="^(hour|day)$", description="Data granularity")
):
    """
    Get detailed performance metrics and trends
    """
    try:
        # Check permissions
        if current_user.user_role not in ["Training Manager", "lecturer"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Insufficient permissions for performance metrics"
            )
        
        # Get system analytics
        system_analytics = analytics.get_system_analytics(hours)
        
        # Get performance trends
        performance_trends = _calculate_performance_trends(analytics, hours, granularity)
        
        # Get bottleneck analysis
        bottlenecks = _analyze_performance_bottlenecks(analytics)
        
        # Get user performance distribution
        user_performance = _analyze_user_performance_distribution(analytics, hours)
        
        performance_data = {
            "summary": {
                "period_hours": hours,
                "total_queries": system_analytics.get("total_queries", 0),
                "avg_execution_time": system_analytics.get("avg_execution_time_ms", 0),
                "success_rate": system_analytics.get("success_rate", 0),
                "unique_users": system_analytics.get("unique_users", 0)
            },
            "trends": performance_trends,
            "bottlenecks": bottlenecks,
            "user_distribution": user_performance,
            "recommendations": _generate_performance_recommendations(system_analytics, bottlenecks)
        }
        
        return APIResponse(
            success=True,
            message="Performance metrics retrieved successfully",
            data=performance_data,
            timestamp=datetime.utcnow()
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get performance metrics: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve performance metrics"
        )

@router.get("/cache-analysis", response_model=APIResponse)
async def get_cache_analysis(
    current_user: TokenData = Depends(get_current_active_user),
    cache: QueryCacheService = Depends(get_query_cache),
    limit: int = Query(50, ge=10, le=100, description="Number of cache entries to analyze")
):
    """
    Get detailed cache performance analysis
    """
    try:
        # Check permissions
        if current_user.user_role not in ["Training Manager", "lecturer"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Insufficient permissions for cache analysis"
            )
        
        # Get cache statistics
        cache_stats = cache.get_cache_stats()
        
        # Get cache entries information
        cache_entries = cache.get_cache_entries_info(limit)
        
        # Analyze cache effectiveness
        cache_analysis = _analyze_cache_effectiveness(cache_entries, cache_stats)
        
        cache_data = {
            "statistics": cache_stats.__dict__,
            "entries": cache_entries,
            "analysis": cache_analysis,
            "recommendations": _generate_cache_recommendations(cache_stats, cache_analysis)
        }
        
        return APIResponse(
            success=True,
            message="Cache analysis retrieved successfully",
            data=cache_data,
            timestamp=datetime.utcnow()
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get cache analysis: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve cache analysis"
        )

@router.get("/export-data", response_model=APIResponse)
async def export_analytics_data(
    current_user: TokenData = Depends(get_current_active_user),
    analytics: AnalyticsService = Depends(get_analytics_service),
    export_type: str = Query("csv", regex="^(csv|json)$", description="Export format"),
    days: int = Query(7, ge=1, le=30, description="Number of days to export"),
    include_personal: bool = Query(False, description="Include personal user data")
):
    """
    Export analytics data for analysis or reporting
    """
    try:
        # Check permissions
        if current_user.user_role not in ["Training Manager", "lecturer"]:
            # Users can only export their own data
            include_personal = False
            export_data = _export_user_data(analytics, current_user.user_id, days, export_type)
        else:
            # Admins can export system-wide data
            export_data = _export_system_data(analytics, days, export_type, include_personal)
        
        return APIResponse(
            success=True,
            message=f"Analytics data exported successfully as {export_type.upper()}",
            data={
                "export_format": export_type,
                "period_days": days,
                "include_personal": include_personal,
                "data": export_data,
                "generated_at": datetime.utcnow().isoformat()
            },
            timestamp=datetime.utcnow()
        )
        
    except Exception as e:
        logger.error(f"Failed to export analytics data: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to export analytics data"
        )

@router.post("/clear-cache", response_model=APIResponse)
async def clear_query_cache(
    current_user: TokenData = Depends(get_current_active_user),
    cache: QueryCacheService = Depends(get_query_cache),
    cache_type: str = Query("user", regex="^(user|role|all)$", description="Type of cache to clear")
):
    """
    Clear query cache (admin only for system-wide, users for their own cache)
    """
    try:
        if cache_type == "all":
            # Only admins can clear all cache
            if current_user.user_role != "Training Manager":
                raise HTTPException(
                    status_code=status.HTTP_403_FORBIDDEN,
                    detail="Insufficient permissions to clear all cache"
                )
            cache.clear_cache()
            message = "All cache cleared successfully"
            
        elif cache_type == "role":
            # Only admins can clear role-based cache
            if current_user.user_role != "Training Manager":
                raise HTTPException(
                    status_code=status.HTTP_403_FORBIDDEN,
                    detail="Insufficient permissions to clear role cache"
                )
            cache.invalidate_role_cache(current_user.user_role)
            message = f"Cache cleared for role: {current_user.user_role}"
            
        else:  # user
            # Users can clear their own cache
            cache.invalidate_user_cache(current_user.user_id)
            message = "User cache cleared successfully"
        
        return APIResponse(
            success=True,
            message=message,
            data={
                "cache_type": cache_type,
                "cleared_at": datetime.utcnow().isoformat()
            },
            timestamp=datetime.utcnow()
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to clear cache: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to clear cache"
        )

# Helper functions
def _calculate_system_health_score(system_analytics, cache_stats, rate_limit_stats, pipeline_status) -> int:
    """Calculate overall system health score (0-100)"""
    score = 100
    
    # Deduct for high error rate
    success_rate = system_analytics.get("success_rate", 0)
    if success_rate < 90:
        score -= (90 - success_rate)
    
    # Deduct for slow response times
    avg_time = system_analytics.get("avg_execution_time_ms", 0)
    if avg_time > 2000:
        score -= min(20, (avg_time - 2000) / 100)
    
    # Deduct for high rate limiting
    block_rate = rate_limit_stats.get("block_rate", 0)
    if block_rate > 5:
        score -= min(10, block_rate)
    
    # Deduct for pipeline issues
    if not pipeline_status.get("ready", False):
        score -= 30
    
    return max(0, int(score))

def _get_recent_activity_summary(analytics) -> Dict[str, Any]:
    """Get summary of recent activity"""
    recent_queries = analytics.query_metrics[-10:] if analytics.query_metrics else []
    
    return {
        "total_recent_queries": len(recent_queries),
        "recent_users": len(set(q.user_id for q in recent_queries)),
        "recent_errors": len([q for q in recent_queries if not q.success]),
        "avg_recent_time": sum(q.execution_time_ms for q in recent_queries) / len(recent_queries) if recent_queries else 0
    }

def _generate_personal_insights(user_analytics, user_role) -> List[str]:
    """Generate personalized insights for user"""
    insights = []
    
    success_rate = user_analytics.get("success_rate", 0)
    if success_rate < 80:
        insights.append("Consider simplifying your questions for better results")
    elif success_rate > 95:
        insights.append("Excellent query success rate! You're using the system effectively")
    
    avg_time = user_analytics.get("avg_execution_time_ms", 0)
    if avg_time > 3000:
        insights.append("Your queries take longer than average - try using more specific questions")
    
    return insights

def _get_queries_today_count(analytics, user_id) -> int:
    """Get count of queries made today by user"""
    today = datetime.utcnow().date().isoformat()
    return len([
        q for q in analytics.query_metrics 
        if q.user_id == user_id and q.timestamp.startswith(today)
    ])

def _get_most_common_question_type(user_analytics) -> str:
    """Get most common question type for user"""
    question_types = user_analytics.get("question_types", {})
    if question_types:
        return max(question_types, key=question_types.get)
    return "general"

def _get_improvement_suggestions(user_analytics) -> List[str]:
    """Get improvement suggestions for user"""
    suggestions = []
    
    total_queries = user_analytics.get("total_queries", 0)
    if total_queries < 5:
        suggestions.append("Try asking more questions to get familiar with the system")
    
    success_rate = user_analytics.get("success_rate", 0)
    if success_rate < 70:
        suggestions.append("Review the question examples to improve your query success rate")
    
    return suggestions

def _calculate_performance_trends(analytics, hours, granularity) -> Dict[str, Any]:
    """Calculate performance trends over time"""
    # This would implement time-series analysis
    # For now, return placeholder data
    return {
        "query_volume": [],
        "response_times": [],
        "success_rates": [],
        "granularity": granularity
    }

def _analyze_performance_bottlenecks(analytics) -> Dict[str, Any]:
    """Analyze system performance bottlenecks"""
    bottlenecks = []
    
    if analytics.query_metrics:
        avg_time = sum(q.execution_time_ms for q in analytics.query_metrics) / len(analytics.query_metrics)
        if avg_time > 2000:
            bottlenecks.append("High average query execution time")
    
    return {"identified_bottlenecks": bottlenecks}

def _analyze_user_performance_distribution(analytics, hours) -> Dict[str, Any]:
    """Analyze performance distribution across users"""
    return {"user_performance_data": []}  # Placeholder

def _generate_performance_recommendations(system_analytics, bottlenecks) -> List[str]:
    """Generate performance improvement recommendations"""
    recommendations = []
    
    if system_analytics.get("success_rate", 0) < 90:
        recommendations.append("Review and improve query validation logic")
    
    if system_analytics.get("avg_execution_time_ms", 0) > 2000:
        recommendations.append("Consider optimizing database queries or adding more caching")
    
    return recommendations

def _analyze_cache_effectiveness(cache_entries, cache_stats) -> Dict[str, Any]:
    """Analyze cache effectiveness"""
    return {
        "most_hit_queries": cache_entries[:5],
        "cache_efficiency": "good" if cache_stats.hit_rate > 60 else "needs_improvement"
    }

def _generate_cache_recommendations(cache_stats, cache_analysis) -> List[str]:
    """Generate cache optimization recommendations"""
    recommendations = []
    
    if cache_stats.hit_rate < 50:
        recommendations.append("Cache hit rate is low - consider adjusting TTL or improving query normalization")
    
    if cache_stats.total_size_mb > 100:
        recommendations.append("Cache size is large - consider reducing TTL or implementing more aggressive eviction")
    
    return recommendations

def _export_user_data(analytics, user_id, days, export_type) -> Any:
    """Export user-specific analytics data"""
    user_analytics = analytics.get_user_analytics(user_id, days)
    
    if export_type == "json":
        return user_analytics
    else:  # csv
        # Convert to CSV format
        import csv
        import io
        
        output = io.StringIO()
        writer = csv.DictWriter(output, fieldnames=user_analytics.keys())
        writer.writeheader()
        writer.writerow(user_analytics)
        
        return output.getvalue()

def _export_system_data(analytics, days, export_type, include_personal) -> Any:
    """Export system-wide analytics data"""
    system_analytics = analytics.get_system_analytics(days * 24)
    
    if export_type == "json":
        return system_analytics
    else:  # csv
        # Convert to CSV format - placeholder implementation
        return "system,data,in,csv,format" 