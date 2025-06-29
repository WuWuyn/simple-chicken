"""
Health check endpoints for Text-to-SQL Chatbot API
"""

import sys
import os
from datetime import datetime
from fastapi import APIRouter, HTTPException, status
import pyodbc
import logging

from ...models.schemas import HealthCheckResponse, APIResponse
from ...core.config import settings
from ...utils.analytics import get_analytics_service
from ...utils.query_cache import get_query_cache
from ...middleware.rate_limiter import get_rate_limiter_stats

# Setup logging
logger = logging.getLogger(__name__)

# Create router
router = APIRouter(prefix="/health", tags=["Health Check"])

def check_database_connection() -> str:
    """Check MS SQL Server database connection"""
    try:
        connection_string = (
            f"DRIVER={{{settings.DB_DRIVER}}};"
            f"SERVER={settings.DB_SERVER};"
            f"DATABASE={settings.DB_NAME};"
            f"UID={settings.DB_USERNAME};"
            f"PWD={settings.DB_PASSWORD};"
            "TrustServerCertificate=yes;"
        )
        
        conn = pyodbc.connect(connection_string, timeout=5)
        cursor = conn.cursor()
        cursor.execute("SELECT 1")
        cursor.fetchone()
        conn.close()
        
        return "healthy"
        
    except Exception as e:
        logger.error(f"Database health check failed: {e}")
        return f"unhealthy: {str(e)}"

def check_redis_connection() -> str:
    """Check Redis connection - Disabled for demo"""
    # Redis removed for demo - using in-memory storage instead
    return "disabled_for_demo"

def check_pipeline_status() -> str:
    """Check Text-to-SQL pipeline availability"""
    try:
        # Try to import pipeline components
        pipeline_path = os.path.join(os.path.dirname(__file__), "..", "..", "..", "..", "Method")
        if pipeline_path not in sys.path:
            sys.path.append(pipeline_path)
        
        # Test import of main pipeline
        from main_pipeline import TextToSQLPipeline
        return "healthy"
        
    except ImportError as e:
        logger.error(f"Pipeline import failed: {e}")
        return f"unhealthy: pipeline not available - {str(e)}"
    except Exception as e:
        logger.error(f"Pipeline health check failed: {e}")
        return f"unhealthy: {str(e)}"

@router.get("/", response_model=HealthCheckResponse)
async def health_check():
    """
    Comprehensive health check endpoint
    
    Checks:
    - API server status
    - Database connectivity
    - Text-to-SQL pipeline availability
    (Redis disabled for demo)
    """
    
    # Check database
    db_status = check_database_connection()
    
    # Check Redis
    redis_status = check_redis_connection()
    
    # Check pipeline
    pipeline_status = check_pipeline_status()
    
    # Determine overall status (excluding Redis for demo)
    overall_status = "healthy"
    if "unhealthy" in [db_status, pipeline_status]:
        overall_status = "degraded"
    
    return HealthCheckResponse(
        status=overall_status,
        app_name=settings.APP_NAME,
        version=settings.APP_VERSION,
        timestamp=datetime.utcnow(),
        database_status=db_status,
        redis_status=redis_status,
        pipeline_status=pipeline_status
    )

@router.get("/ping", response_model=APIResponse)
async def ping():
    """
    Simple ping endpoint for basic availability check
    """
    return APIResponse(
        success=True,
        message="pong",
        data={
            "app_name": settings.APP_NAME,
            "version": settings.APP_VERSION,
            "environment": settings.ENVIRONMENT
        },
        timestamp=datetime.utcnow()
    )

@router.get("/database", response_model=APIResponse)
async def database_health():
    """
    Detailed database health check
    """
    db_status = check_database_connection()
    
    if "unhealthy" in db_status:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Database is unhealthy: {db_status}"
        )
    
    return APIResponse(
        success=True,
        message="Database is healthy",
        data={
            "status": db_status,
            "database": settings.DB_NAME,
            "server": settings.DB_SERVER
        },
        timestamp=datetime.utcnow()
    )

@router.get("/pipeline", response_model=APIResponse)
async def pipeline_health():
    """
    Detailed Text-to-SQL pipeline health check
    """
    pipeline_status = check_pipeline_status()
    
    if "unhealthy" in pipeline_status:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Pipeline is unhealthy: {pipeline_status}"
        )
    
    return APIResponse(
        success=True,
        message="Pipeline is healthy",
        data={
            "status": pipeline_status,
            "pipeline_path": settings.PIPELINE_PATH
        },
        timestamp=datetime.utcnow()
    )

@router.get("/ready", response_model=APIResponse)
async def readiness_check():
    """
    Readiness check - indicates if the service is ready to handle requests
    """
    db_status = check_database_connection()
    pipeline_status = check_pipeline_status()
    
    # Service is ready if database and pipeline are healthy
    ready = "healthy" in db_status and "healthy" in pipeline_status
    
    if not ready:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Service is not ready"
        )
    
    return APIResponse(
        success=True,
        message="Service is ready",
        data={
            "database_status": db_status,
            "pipeline_status": pipeline_status
        },
        timestamp=datetime.utcnow()
    )

@router.get("/live", response_model=APIResponse)  
async def liveness_check():
    """
    Liveness check - indicates if the service is alive
    """
    return APIResponse(
        success=True,
        message="Service is alive",
        data={
            "uptime": "unknown",  # Could implement uptime tracking
            "memory_usage": "unknown"  # Could implement memory monitoring
        },
        timestamp=datetime.utcnow()
    )

# Phase 3: Advanced Monitoring Endpoints

@router.get("/analytics", response_model=APIResponse)
async def analytics_health():
    """
    Analytics service health check
    """
    try:
        analytics = get_analytics_service()
        stats = analytics.get_system_analytics(hours=1)
        
        return APIResponse(
            success=True,
            message="Analytics service is healthy",
            data={
                "service_status": "healthy",
                "total_queries": stats.get("total_queries", 0),
                "success_rate": stats.get("success_rate", 0),
                "avg_response_time": stats.get("avg_execution_time_ms", 0)
            },
            timestamp=datetime.utcnow()
        )
    except Exception as e:
        logger.error(f"Analytics health check failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Analytics service is unhealthy: {str(e)}"
        )

@router.get("/cache", response_model=APIResponse)
async def cache_health():
    """
    Query cache service health check
    """
    if not settings.ENABLE_QUERY_CACHING:
        return APIResponse(
            success=True,
            message="Cache service is disabled for demo",
            data={
                "service_status": "disabled",
                "hit_rate": 0,
                "total_entries": 0,
                "cache_size_mb": 0,
                "avg_time_saved": 0,
                "note": "Caching disabled for demo purposes"
            },
            timestamp=datetime.utcnow()
        )
    
    try:
        cache = get_query_cache()
        cache_stats = cache.get_cache_stats()
        
        # Consider cache healthy if hit rate is reasonable or if it's just starting up
        is_healthy = cache_stats.hit_rate >= 30 or (cache_stats.cache_hits + cache_stats.cache_misses) < 10
        
        return APIResponse(
            success=True,
            message="Cache service is healthy",
            data={
                "service_status": "healthy" if is_healthy else "degraded",
                "hit_rate": cache_stats.hit_rate,
                "total_entries": cache_stats.total_entries,
                "cache_size_mb": cache_stats.total_size_mb,
                "avg_time_saved": cache_stats.avg_execution_time_saved
            },
            timestamp=datetime.utcnow()
        )
    except Exception as e:
        logger.error(f"Cache health check failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Cache service is unhealthy: {str(e)}"
        )

@router.get("/rate-limit-stats", response_model=APIResponse)
async def rate_limit_health():
    """
    Rate limiting service health check
    """
    try:
        rate_stats = get_rate_limiter_stats()
        
        # Consider rate limiting healthy if block rate is reasonable
        block_rate = rate_stats.get("block_rate", 0)
        is_healthy = block_rate < 10  # Less than 10% blocked requests
        
        return APIResponse(
            success=True,
            message="Rate limiting service is healthy",
            data={
                "service_status": "healthy" if is_healthy else "degraded",
                "total_requests": rate_stats.get("total_requests", 0),
                "blocked_requests": rate_stats.get("blocked_requests", 0),
                "block_rate": block_rate,
                "active_clients": rate_stats.get("active_clients", 0),
                "currently_blocked": rate_stats.get("currently_blocked", 0)
            },
            timestamp=datetime.utcnow()
        )
    except Exception as e:
        logger.error(f"Rate limit health check failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Rate limiting service is unhealthy: {str(e)}"
        )

@router.get("/detailed", response_model=APIResponse)
async def detailed_health_check():
    """
    Comprehensive health check with all Phase 3 services
    """
    try:
        # Check all core services
        db_status = check_database_connection()
        redis_status = check_redis_connection()
        pipeline_status = check_pipeline_status()
        
        # Check Phase 3 services
        analytics = get_analytics_service()
        cache = get_query_cache()
        rate_stats = get_rate_limiter_stats()
        
        # Get service metrics
        analytics_stats = analytics.get_system_analytics(hours=1)
        cache_stats = cache.get_cache_stats()
        
        # Calculate overall health score (excluding Redis for demo)
        health_components = {
            "database": "healthy" in db_status,
            "pipeline": "healthy" in pipeline_status,
            "analytics": True,  # Analytics is always available
            "cache": not settings.ENABLE_QUERY_CACHING or cache_stats.hit_rate >= 30 or (cache_stats.cache_hits + cache_stats.cache_misses) < 10,
            "rate_limiting": rate_stats.get("block_rate", 0) < 10
        }
        
        healthy_count = sum(health_components.values())
        health_score = (healthy_count / len(health_components)) * 100
        
        overall_status = "healthy"
        if health_score < 60:
            overall_status = "critical"
        elif health_score < 80:
            overall_status = "degraded"
        
        return APIResponse(
            success=True,
            message=f"System health check complete - {overall_status}",
            data={
                "overall_status": overall_status,
                "health_score": round(health_score, 1),
                "services": {
                    "database": db_status,
                    "redis": redis_status + " (disabled for demo)",
                    "pipeline": pipeline_status,
                    "analytics": {
                        "status": "healthy",
                        "total_queries": analytics_stats.get("total_queries", 0),
                        "success_rate": analytics_stats.get("success_rate", 0)
                    },
                    "cache": {
                        "status": "disabled" if not settings.ENABLE_QUERY_CACHING else ("healthy" if health_components["cache"] else "degraded"),
                        "hit_rate": cache_stats.hit_rate if settings.ENABLE_QUERY_CACHING else 0,
                        "total_entries": cache_stats.total_entries if settings.ENABLE_QUERY_CACHING else 0,
                        "note": "Disabled for demo" if not settings.ENABLE_QUERY_CACHING else ""
                    },
                    "rate_limiting": {
                        "status": "healthy" if health_components["rate_limiting"] else "degraded",
                        "block_rate": rate_stats.get("block_rate", 0),
                        "active_clients": rate_stats.get("active_clients", 0)
                    }
                },
                "system_info": {
                    "app_name": settings.APP_NAME,
                    "version": settings.APP_VERSION,
                    "environment": settings.ENVIRONMENT,
                    "features": ["analytics", "caching", "rate_limiting", "real_time_chat"]
                }
            },
            timestamp=datetime.utcnow()
        )
    except Exception as e:
        logger.error(f"Detailed health check failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Health check failed: {str(e)}"
        ) 