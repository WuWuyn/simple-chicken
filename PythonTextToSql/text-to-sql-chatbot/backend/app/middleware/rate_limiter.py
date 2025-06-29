"""
Rate Limiting Middleware for Text-to-SQL Chatbot API
Implements request throttling and API protection
"""

import time
import json
from typing import Dict, Any, Optional
from collections import defaultdict, deque
from datetime import datetime, timedelta
import logging

from fastapi import Request, Response, HTTPException, status
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse

from ..core.config import settings

# Setup logging
logger = logging.getLogger(__name__)

class RateLimitStorage:
    """In-memory rate limit storage"""
    
    def __init__(self):
        # Store request timestamps for each client
        self.client_requests: Dict[str, deque] = defaultdict(lambda: deque(maxlen=1000))
        # Store blocked clients with expiry time
        self.blocked_clients: Dict[str, float] = {}
        # Request statistics
        self.stats = {
            "total_requests": 0,
            "blocked_requests": 0,
            "unique_clients": 0
        }
        
    def is_rate_limited(self, client_id: str, max_requests: int, window_seconds: int) -> tuple[bool, Dict[str, Any]]:
        """
        Check if client has exceeded rate limit
        
        Returns:
            (is_limited, rate_limit_info)
        """
        now = time.time()
        
        # Check if client is currently blocked
        if client_id in self.blocked_clients:
            if now < self.blocked_clients[client_id]:
                remaining_time = int(self.blocked_clients[client_id] - now)
                return True, {
                    "blocked": True,
                    "retry_after": remaining_time,
                    "reason": "Client temporarily blocked"
                }
            else:
                # Block expired, remove from blocked list
                del self.blocked_clients[client_id]
        
        # Get client's request history
        requests = self.client_requests[client_id]
        
        # Remove old requests outside the window
        window_start = now - window_seconds
        while requests and requests[0] < window_start:
            requests.popleft()
        
        # Count current requests in window
        current_requests = len(requests)
        
        # Check if limit is exceeded
        if current_requests >= max_requests:
            # Block client for the window duration
            self.blocked_clients[client_id] = now + window_seconds
            self.stats["blocked_requests"] += 1
            
            return True, {
                "blocked": False,
                "current_requests": current_requests,
                "max_requests": max_requests,
                "window_seconds": window_seconds,
                "retry_after": window_seconds,
                "reason": "Rate limit exceeded"
            }
        
        # Record this request
        requests.append(now)
        self.stats["total_requests"] += 1
        
        # Update unique clients count
        if len(requests) == 1:  # First request from this client
            self.stats["unique_clients"] += 1
        
        return False, {
            "blocked": False,
            "current_requests": current_requests + 1,
            "max_requests": max_requests,
            "remaining_requests": max_requests - current_requests - 1,
            "window_seconds": window_seconds,
            "reset_time": int(window_start + window_seconds)
        }
    
    def get_stats(self) -> Dict[str, Any]:
        """Get rate limiting statistics"""
        active_clients = len([
            client_id for client_id, requests in self.client_requests.items()
            if requests  # Has recent requests
        ])
        
        blocked_clients = len(self.blocked_clients)
        
        return {
            "total_requests": self.stats["total_requests"],
            "blocked_requests": self.stats["blocked_requests"],
            "unique_clients": self.stats["unique_clients"],
            "active_clients": active_clients,
            "currently_blocked": blocked_clients,
            "block_rate": (self.stats["blocked_requests"] / max(self.stats["total_requests"], 1)) * 100
        }
    
    def cleanup_expired_data(self):
        """Clean up expired rate limit data"""
        now = time.time()
        
        # Remove expired blocks
        expired_blocks = [
            client_id for client_id, expiry in self.blocked_clients.items()
            if now >= expiry
        ]
        for client_id in expired_blocks:
            del self.blocked_clients[client_id]
        
        # Clean up old request histories
        window_start = now - settings.RATE_LIMIT_WINDOW
        for client_id in list(self.client_requests.keys()):
            requests = self.client_requests[client_id]
            
            # Remove old requests
            while requests and requests[0] < window_start:
                requests.popleft()
            
            # Remove empty queues
            if not requests:
                del self.client_requests[client_id]

class RateLimitMiddleware(BaseHTTPMiddleware):
    """
    Rate limiting middleware for FastAPI
    """
    
    def __init__(self, app, storage: Optional[RateLimitStorage] = None):
        super().__init__(app)
        self.storage = storage or RateLimitStorage()
        self.last_cleanup = time.time()
        
        # Rate limit configurations
        self.rate_limits = {
            # Default rate limit
            "default": {
                "max_requests": settings.RATE_LIMIT_REQUESTS,
                "window_seconds": settings.RATE_LIMIT_WINDOW
            },
            # Specific endpoint rate limits
            "chat": {
                "max_requests": 30,  # Lower limit for chat endpoints
                "window_seconds": 60
            },
            "auth": {
                "max_requests": 10,  # Very low for auth endpoints
                "window_seconds": 60
            },
            "analytics": {
                "max_requests": 20,  # Moderate for analytics
                "window_seconds": 60
            }
        }
        
        logger.info("Rate limiting middleware initialized")
    
    async def dispatch(self, request: Request, call_next) -> Response:
        """Process request with rate limiting"""
        
        # Skip rate limiting for health checks and static files
        if self._should_skip_rate_limiting(request):
            return await call_next(request)
        
        # Periodic cleanup
        await self._periodic_cleanup()
        
        # Get client identifier
        client_id = self._get_client_id(request)
        
        # Determine rate limit configuration
        rate_limit_config = self._get_rate_limit_config(request)
        
        # Check rate limit
        is_limited, rate_info = self.storage.is_rate_limited(
            client_id,
            rate_limit_config["max_requests"],
            rate_limit_config["window_seconds"]
        )
        
        if is_limited:
            logger.warning(f"Rate limit exceeded for client {client_id}: {rate_info}")
            
            # Return rate limit error response
            error_response = {
                "error": "Rate limit exceeded",
                "message": rate_info.get("reason", "Too many requests"),
                "retry_after": rate_info.get("retry_after", 60),
                "limit_info": {
                    "max_requests": rate_limit_config["max_requests"],
                    "window_seconds": rate_limit_config["window_seconds"]
                }
            }
            
            headers = {
                "X-RateLimit-Limit": str(rate_limit_config["max_requests"]),
                "X-RateLimit-Window": str(rate_limit_config["window_seconds"]),
                "X-RateLimit-Remaining": "0",
                "Retry-After": str(rate_info.get("retry_after", 60))
            }
            
            return JSONResponse(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                content=error_response,
                headers=headers
            )
        
        # Process request normally
        response = await call_next(request)
        
        # Add rate limit headers to response
        if not rate_info.get("blocked"):
            response.headers["X-RateLimit-Limit"] = str(rate_limit_config["max_requests"])
            response.headers["X-RateLimit-Window"] = str(rate_limit_config["window_seconds"])
            response.headers["X-RateLimit-Remaining"] = str(rate_info.get("remaining_requests", 0))
            response.headers["X-RateLimit-Reset"] = str(rate_info.get("reset_time", 0))
        
        return response
    
    def _should_skip_rate_limiting(self, request: Request) -> bool:
        """Check if request should skip rate limiting"""
        path = request.url.path
        
        # Skip for health checks
        if path.startswith("/health") or path == "/":
            return True
        
        # Skip for static files
        if path.startswith("/static") or path.startswith("/docs"):
            return True
        
        # Skip for WebSocket connections (handled separately)
        if "websocket" in request.headers.get("connection", "").lower():
            return True
        
        return False
    
    def _get_client_id(self, request: Request) -> str:
        """Get unique client identifier"""
        # Try to get user ID from JWT token if available
        auth_header = request.headers.get("authorization")
        if auth_header and auth_header.startswith("Bearer "):
            try:
                from ..utils.auth import jwt_manager
                token = auth_header.split(" ")[1]
                token_data = jwt_manager.verify_token(token)
                return f"user:{token_data.user_id}"
            except Exception:
                pass
        
        # Fallback to IP address
        forwarded_for = request.headers.get("x-forwarded-for")
        if forwarded_for:
            # Use first IP in the chain
            client_ip = forwarded_for.split(",")[0].strip()
        else:
            client_ip = request.client.host if request.client else "unknown"
        
        return f"ip:{client_ip}"
    
    def _get_rate_limit_config(self, request: Request) -> Dict[str, int]:
        """Get rate limit configuration for request"""
        path = request.url.path
        
        # Check for specific endpoint configurations
        if "/chat/" in path:
            return self.rate_limits["chat"]
        elif "/auth/" in path:
            return self.rate_limits["auth"]
        elif "/analytics/" in path:
            return self.rate_limits["analytics"]
        else:
            return self.rate_limits["default"]
    
    async def _periodic_cleanup(self):
        """Periodic cleanup of expired data"""
        now = time.time()
        if now - self.last_cleanup > 300:  # Cleanup every 5 minutes
            self.storage.cleanup_expired_data()
            self.last_cleanup = now
            logger.debug("Rate limit storage cleanup completed")
    
    def get_stats(self) -> Dict[str, Any]:
        """Get rate limiting statistics"""
        return self.storage.get_stats()

# Global rate limiter instance
rate_limiter_storage = RateLimitStorage()

def get_rate_limiter() -> RateLimitMiddleware:
    """Get rate limiter middleware"""
    return RateLimitMiddleware(None, rate_limiter_storage)

def get_rate_limiter_stats() -> Dict[str, Any]:
    """Get rate limiter statistics"""
    return rate_limiter_storage.get_stats() 