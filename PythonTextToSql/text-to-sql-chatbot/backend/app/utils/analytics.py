"""
Analytics Service for Text-to-SQL Chatbot
Tracks query performance, user behavior, and system metrics
"""

import json
import time
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional
from collections import defaultdict, deque
from dataclasses import dataclass, asdict
import logging

from ..core.config import settings

# Setup logging
logger = logging.getLogger(__name__)

@dataclass
class QueryMetrics:
    """Query performance metrics"""
    query_id: str
    user_id: str
    user_role: str
    question: str
    sql_query: Optional[str]
    execution_time_ms: float
    success: bool
    error_message: Optional[str] = None
    blocked_at_step: Optional[str] = None
    result_count: int = 0
    confidence_score: float = 0.0
    timestamp: str = ""
    
    def __post_init__(self):
        if not self.timestamp:
            self.timestamp = datetime.utcnow().isoformat()

@dataclass
class UserSession:
    """User session tracking"""
    user_id: str
    session_start: str
    last_activity: str
    query_count: int = 0
    total_execution_time: float = 0.0
    successful_queries: int = 0
    failed_queries: int = 0
    
@dataclass
class SystemMetrics:
    """System performance metrics"""
    timestamp: str
    active_connections: int
    total_queries: int
    avg_response_time: float
    error_rate: float
    cache_hit_rate: float = 0.0

class AnalyticsService:
    """
    Comprehensive analytics service for tracking:
    - Query performance and user behavior
    - System metrics and health
    - Usage patterns and insights
    """
    
    def __init__(self):
        # In-memory storage (in production, use Redis/Database)
        self.query_metrics: List[QueryMetrics] = []
        self.user_sessions: Dict[str, UserSession] = {}
        self.system_metrics: deque = deque(maxlen=1000)  # Keep last 1000 entries
        
        # Performance tracking
        self.query_times = deque(maxlen=100)  # Last 100 query times
        self.error_count = 0
        self.success_count = 0
        
        # Cache metrics
        self.cache_hits = 0
        self.cache_misses = 0
        
        # User behavior patterns
        self.popular_queries = defaultdict(int)
        self.query_patterns = defaultdict(list)
        
        logger.info("Analytics service initialized")
    
    def track_query(self, metrics: QueryMetrics):
        """Track a single query execution"""
        try:
            # Store query metrics
            self.query_metrics.append(metrics)
            
            # Update performance counters
            self.query_times.append(metrics.execution_time_ms)
            if metrics.success:
                self.success_count += 1
            else:
                self.error_count += 1
            
            # Track popular queries (normalize question)
            normalized_question = self._normalize_question(metrics.question)
            self.popular_queries[normalized_question] += 1
            
            # Update user session
            self._update_user_session(metrics)
            
            # Track query patterns by user role
            self.query_patterns[metrics.user_role].append({
                'timestamp': metrics.timestamp,
                'question_type': self._classify_question(metrics.question),
                'success': metrics.success,
                'execution_time': metrics.execution_time_ms
            })
            
            # Cleanup old data
            self._cleanup_old_data()
            
            logger.debug(f"Tracked query for user {metrics.user_id}: {metrics.success}")
            
        except Exception as e:
            logger.error(f"Failed to track query metrics: {e}")
    
    def track_system_metrics(self, active_connections: int):
        """Track system-level metrics"""
        try:
            avg_response_time = sum(self.query_times) / len(self.query_times) if self.query_times else 0
            total_queries = self.success_count + self.error_count
            error_rate = (self.error_count / total_queries) if total_queries > 0 else 0
            cache_hit_rate = (self.cache_hits / (self.cache_hits + self.cache_misses)) if (self.cache_hits + self.cache_misses) > 0 else 0
            
            system_metric = SystemMetrics(
                timestamp=datetime.utcnow().isoformat(),
                active_connections=active_connections,
                total_queries=total_queries,
                avg_response_time=avg_response_time,
                error_rate=error_rate,
                cache_hit_rate=cache_hit_rate
            )
            
            self.system_metrics.append(system_metric)
            
        except Exception as e:
            logger.error(f"Failed to track system metrics: {e}")
    
    def track_cache_hit(self):
        """Track cache hit"""
        self.cache_hits += 1
    
    def track_cache_miss(self):
        """Track cache miss"""
        self.cache_misses += 1
    
    def get_user_analytics(self, user_id: str, days: int = 7) -> Dict[str, Any]:
        """Get analytics for a specific user"""
        try:
            cutoff_date = datetime.utcnow() - timedelta(days=days)
            cutoff_str = cutoff_date.isoformat()
            
            # Filter user queries
            user_queries = [
                q for q in self.query_metrics 
                if q.user_id == user_id and q.timestamp >= cutoff_str
            ]
            
            if not user_queries:
                return {
                    "user_id": user_id,
                    "period_days": days,
                    "total_queries": 0,
                    "message": "No queries found for this period"
                }
            
            # Calculate metrics
            total_queries = len(user_queries)
            successful_queries = sum(1 for q in user_queries if q.success)
            failed_queries = total_queries - successful_queries
            avg_execution_time = sum(q.execution_time_ms for q in user_queries) / total_queries
            
            # Popular question types
            question_types = defaultdict(int)
            for q in user_queries:
                question_types[self._classify_question(q.question)] += 1
            
            # Performance over time
            daily_stats = defaultdict(lambda: {"queries": 0, "avg_time": 0, "success_rate": 0})
            for q in user_queries:
                day = q.timestamp[:10]  # YYYY-MM-DD
                daily_stats[day]["queries"] += 1
                daily_stats[day]["avg_time"] += q.execution_time_ms
                if q.success:
                    daily_stats[day]["success_rate"] += 1
            
            # Calculate daily averages
            for day_stats in daily_stats.values():
                if day_stats["queries"] > 0:
                    day_stats["avg_time"] /= day_stats["queries"]
                    day_stats["success_rate"] = (day_stats["success_rate"] / day_stats["queries"]) * 100
            
            return {
                "user_id": user_id,
                "period_days": days,
                "total_queries": total_queries,
                "successful_queries": successful_queries,
                "failed_queries": failed_queries,
                "success_rate": (successful_queries / total_queries) * 100,
                "avg_execution_time_ms": round(avg_execution_time, 2),
                "question_types": dict(question_types),
                "daily_stats": dict(daily_stats),
                "most_recent_query": user_queries[-1].timestamp if user_queries else None
            }
            
        except Exception as e:
            logger.error(f"Failed to get user analytics: {e}")
            return {"error": "Failed to retrieve user analytics"}
    
    def get_system_analytics(self, hours: int = 24) -> Dict[str, Any]:
        """Get system-wide analytics"""
        try:
            cutoff_date = datetime.utcnow() - timedelta(hours=hours)
            cutoff_str = cutoff_date.isoformat()
            
            # Filter recent queries
            recent_queries = [
                q for q in self.query_metrics 
                if q.timestamp >= cutoff_str
            ]
            
            # Filter recent system metrics
            recent_system_metrics = [
                m for m in self.system_metrics 
                if m.timestamp >= cutoff_str
            ]
            
            if not recent_queries:
                return {
                    "period_hours": hours,
                    "total_queries": 0,
                    "message": "No queries found for this period"
                }
            
            # Calculate overall metrics
            total_queries = len(recent_queries)
            successful_queries = sum(1 for q in recent_queries if q.success)
            avg_execution_time = sum(q.execution_time_ms for q in recent_queries) / total_queries
            
            # User role distribution
            role_distribution = defaultdict(int)
            for q in recent_queries:
                role_distribution[q.user_role] += 1
            
            # Popular queries
            popular_queries = dict(sorted(
                self.popular_queries.items(), 
                key=lambda x: x[1], 
                reverse=True
            )[:10])
            
            # Error analysis
            error_types = defaultdict(int)
            for q in recent_queries:
                if not q.success and q.blocked_at_step:
                    error_types[q.blocked_at_step] += 1
                elif not q.success:
                    error_types["execution_error"] += 1
            
            # Performance trends
            hourly_stats = defaultdict(lambda: {"queries": 0, "avg_time": 0, "errors": 0})
            for q in recent_queries:
                hour = q.timestamp[:13]  # YYYY-MM-DDTHH
                hourly_stats[hour]["queries"] += 1
                hourly_stats[hour]["avg_time"] += q.execution_time_ms
                if not q.success:
                    hourly_stats[hour]["errors"] += 1
            
            # Calculate hourly averages
            for hour_stats in hourly_stats.values():
                if hour_stats["queries"] > 0:
                    hour_stats["avg_time"] /= hour_stats["queries"]
                    hour_stats["error_rate"] = (hour_stats["errors"] / hour_stats["queries"]) * 100
            
            return {
                "period_hours": hours,
                "total_queries": total_queries,
                "successful_queries": successful_queries,
                "success_rate": (successful_queries / total_queries) * 100,
                "avg_execution_time_ms": round(avg_execution_time, 2),
                "unique_users": len(set(q.user_id for q in recent_queries)),
                "role_distribution": dict(role_distribution),
                "popular_queries": popular_queries,
                "error_types": dict(error_types),
                "hourly_stats": dict(hourly_stats),
                "cache_hit_rate": (self.cache_hits / (self.cache_hits + self.cache_misses)) * 100 if (self.cache_hits + self.cache_misses) > 0 else 0
            }
            
        except Exception as e:
            logger.error(f"Failed to get system analytics: {e}")
            return {"error": "Failed to retrieve system analytics"}
    
    def get_query_insights(self) -> Dict[str, Any]:
        """Get query pattern insights"""
        try:
            insights = {
                "query_complexity": self._analyze_query_complexity(),
                "performance_patterns": self._analyze_performance_patterns(),
                "user_behavior": self._analyze_user_behavior(),
                "recommendation": self._generate_recommendations()
            }
            return insights
            
        except Exception as e:
            logger.error(f"Failed to get query insights: {e}")
            return {"error": "Failed to retrieve query insights"}
    
    def _update_user_session(self, metrics: QueryMetrics):
        """Update user session information"""
        user_id = metrics.user_id
        now = datetime.utcnow().isoformat()
        
        if user_id not in self.user_sessions:
            self.user_sessions[user_id] = UserSession(
                user_id=user_id,
                session_start=now,
                last_activity=now
            )
        
        session = self.user_sessions[user_id]
        session.last_activity = now
        session.query_count += 1
        session.total_execution_time += metrics.execution_time_ms
        
        if metrics.success:
            session.successful_queries += 1
        else:
            session.failed_queries += 1
    
    def _normalize_question(self, question: str) -> str:
        """Normalize question for pattern analysis"""
        # Simple normalization - remove specific values
        normalized = question.lower()
        
        # Replace common patterns
        import re
        normalized = re.sub(r'\b\d+\b', '[NUMBER]', normalized)
        normalized = re.sub(r'\b\w+\d+\w*\b', '[ID]', normalized)
        normalized = re.sub(r'\b\d{4}-\d{2}-\d{2}\b', '[DATE]', normalized)
        
        return normalized.strip()
    
    def _classify_question(self, question: str) -> str:
        """Classify question type for analytics"""
        question_lower = question.lower()
        
        if any(word in question_lower for word in ['grade', 'score', 'mark', 'result']):
            return 'grades'
        elif any(word in question_lower for word in ['course', 'class', 'subject']):
            return 'courses'
        elif any(word in question_lower for word in ['schedule', 'timetable', 'time']):
            return 'schedule'
        elif any(word in question_lower for word in ['exam', 'test', 'quiz']):
            return 'exams'
        elif any(word in question_lower for word in ['attendance', 'present', 'absent']):
            return 'attendance'
        elif any(word in question_lower for word in ['gpa', 'average', 'performance']):
            return 'performance'
        else:
            return 'general'
    
    def _analyze_query_complexity(self) -> Dict[str, Any]:
        """Analyze query complexity patterns"""
        if not self.query_metrics:
            return {}
        
        complexity_stats = defaultdict(list)
        for q in self.query_metrics:
            # Simple complexity measure based on question length and SQL complexity
            question_words = len(q.question.split())
            sql_complexity = len(q.sql_query.split()) if q.sql_query else 0
            
            if question_words <= 5:
                complexity = "simple"
            elif question_words <= 10:
                complexity = "medium"
            else:
                complexity = "complex"
            
            complexity_stats[complexity].append(q.execution_time_ms)
        
        # Calculate averages
        complexity_analysis = {}
        for complexity, times in complexity_stats.items():
            complexity_analysis[complexity] = {
                "count": len(times),
                "avg_execution_time": sum(times) / len(times) if times else 0
            }
        
        return complexity_analysis
    
    def _analyze_performance_patterns(self) -> Dict[str, Any]:
        """Analyze performance patterns"""
        if not self.query_metrics:
            return {}
        
        # Performance by hour of day
        hourly_performance = defaultdict(list)
        for q in self.query_metrics:
            hour = datetime.fromisoformat(q.timestamp.replace('Z', '+00:00')).hour
            hourly_performance[hour].append(q.execution_time_ms)
        
        hourly_avg = {}
        for hour, times in hourly_performance.items():
            hourly_avg[hour] = sum(times) / len(times) if times else 0
        
        return {
            "hourly_performance": hourly_avg,
            "peak_hours": sorted(hourly_avg.keys(), key=lambda x: hourly_avg[x], reverse=True)[:3]
        }
    
    def _analyze_user_behavior(self) -> Dict[str, Any]:
        """Analyze user behavior patterns"""
        user_stats = defaultdict(lambda: {"queries": 0, "avg_time": 0})
        
        for q in self.query_metrics:
            user_stats[q.user_role]["queries"] += 1
            user_stats[q.user_role]["avg_time"] += q.execution_time_ms
        
        # Calculate averages
        for role_stats in user_stats.values():
            if role_stats["queries"] > 0:
                role_stats["avg_time"] /= role_stats["queries"]
        
        return dict(user_stats)
    
    def _generate_recommendations(self) -> List[str]:
        """Generate system optimization recommendations"""
        recommendations = []
        
        if self.query_metrics:
            avg_time = sum(q.execution_time_ms for q in self.query_metrics) / len(self.query_metrics)
            error_rate = (self.error_count / (self.success_count + self.error_count)) * 100
            
            if avg_time > 2000:
                recommendations.append("Consider optimizing slow queries or adding more caching")
            
            if error_rate > 10:
                recommendations.append("High error rate detected - review query validation and pipeline stability")
            
            if len(self.user_sessions) > 50 and not recommendations:
                recommendations.append("System performing well under current load")
        
        return recommendations
    
    def _cleanup_old_data(self):
        """Clean up old analytics data based on retention policy"""
        if not settings.ENABLE_ANALYTICS:
            return
        
        try:
            cutoff_date = datetime.utcnow() - timedelta(days=settings.ANALYTICS_RETENTION_DAYS)
            cutoff_str = cutoff_date.isoformat()
            
            # Remove old query metrics
            self.query_metrics = [
                q for q in self.query_metrics 
                if q.timestamp >= cutoff_str
            ]
            
            # Remove old user sessions
            for user_id in list(self.user_sessions.keys()):
                session = self.user_sessions[user_id]
                if session.last_activity < cutoff_str:
                    del self.user_sessions[user_id]
            
            logger.debug(f"Cleaned up analytics data older than {settings.ANALYTICS_RETENTION_DAYS} days")
            
        except Exception as e:
            logger.error(f"Failed to cleanup old analytics data: {e}")

# Global analytics instance
analytics_service = AnalyticsService()

def get_analytics_service() -> AnalyticsService:
    """Dependency to get analytics service"""
    return analytics_service 