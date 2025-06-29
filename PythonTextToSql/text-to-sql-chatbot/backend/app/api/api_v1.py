"""
API v1 router for Text-to-SQL Chatbot
"""

from fastapi import APIRouter

from .endpoints import auth, health, chat, analytics

# Create main API router
api_router = APIRouter()

# Include all endpoint routers
api_router.include_router(auth.router)
api_router.include_router(health.router)
api_router.include_router(chat.router)
api_router.include_router(analytics.router)

# Health check at root level
@api_router.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "Text-to-SQL Chatbot API",
        "version": "1.0.0",
        "status": "running",
        "docs": "/docs",
        "health": "/api/v1/health"
    } 