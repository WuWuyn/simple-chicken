"""
Configuration settings for Text-to-SQL Chatbot Backend
"""

import os
from typing import Optional, List
from pydantic_settings import BaseSettings

# Try to use environment variables directly
def config(key: str, default=None, cast=None):
    """Simple config function using os.environ"""
    value = os.getenv(key)
    if value is None:
        return default
    if cast and cast == bool:
        if isinstance(value, bool):
            return value
        return str(value).lower() in ('true', '1', 'yes', 'on')
    if cast:
        return cast(value)
    return value

class Settings(BaseSettings):
    """Application settings"""
    
    # App Info
    APP_NAME: str = "Text-to-SQL Chatbot API"
    APP_VERSION: str = "1.0.0"
    APP_DESCRIPTION: str = "Academic Management Chatbot with Text-to-SQL Integration"
    
    # Environment
    ENVIRONMENT: str = config("ENVIRONMENT", default="development")
    DEBUG: bool = config("DEBUG", default=True, cast=bool)
    
    # API Settings
    API_V1_STR: str = "/api/v1"
    HOST: str = config("HOST", default="0.0.0.0")
    PORT: int = config("PORT", default=8000, cast=int)
    
    # Security & JWT
    SECRET_KEY: str = config("SECRET_KEY", default="your-super-secret-key-change-this-in-production-123456789")
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = config("ACCESS_TOKEN_EXPIRE_MINUTES", default=30, cast=int)
    REFRESH_TOKEN_EXPIRE_DAYS: int = config("REFRESH_TOKEN_EXPIRE_DAYS", default=7, cast=int)
    
    # CORS
    ALLOWED_HOSTS: List[str] = ["*"]  # In production, specify exact origins
    ALLOWED_ORIGINS: List[str] = [
        "http://localhost:3000",  # React development server
        "http://localhost:3001",
        "http://127.0.0.1:3000"
    ]
    
    # Database - MS SQL Server (existing)
    DB_SERVER: str = config("DB_SERVER", default="localhost")
    DB_NAME: str = config("DB_NAME", default="text_to_sql_final")
    DB_USERNAME: str = config("DB_USERNAME", default="sa")
    DB_PASSWORD: str = config("DB_PASSWORD", default="123456")
    DB_DRIVER: str = config("DB_DRIVER", default="ODBC Driver 17 for SQL Server")
    
    # Session management (in-memory for demo)
    # Redis removed - using in-memory storage for demo purposes
    
    # Text-to-SQL Pipeline Integration
    PIPELINE_PATH: str = config("PIPELINE_PATH", default="../Method")
    PIPELINE_MOCK_MODE: bool = config("PIPELINE_MOCK_MODE", default=True, cast=bool)
    FIXED_TIMESTAMP: str = "22:00 15/6/2024"  # As per requirements
    
    # Conversation Context
    MAX_CONVERSATION_HISTORY: int = 50
    CONTEXT_EXPIRY_HOURS: int = 24
    
    # WebSocket
    WS_HEARTBEAT_INTERVAL: int = 30
    WS_MESSAGE_MAX_SIZE: int = 1024 * 1024  # 1MB
    
    # Phase 3: Advanced Features
    # Rate Limiting
    RATE_LIMIT_REQUESTS: int = config("RATE_LIMIT_REQUESTS", default=100, cast=int)  # requests per minute
    RATE_LIMIT_WINDOW: int = config("RATE_LIMIT_WINDOW", default=60, cast=int)  # seconds
    
    # Analytics & Monitoring
    ENABLE_ANALYTICS: bool = config("ENABLE_ANALYTICS", default=True, cast=bool)
    ANALYTICS_RETENTION_DAYS: int = config("ANALYTICS_RETENTION_DAYS", default=30, cast=int)
    
    # Query Management
    MAX_QUERY_LENGTH: int = config("MAX_QUERY_LENGTH", default=1000, cast=int)
    QUERY_TIMEOUT_SECONDS: int = config("QUERY_TIMEOUT_SECONDS", default=30, cast=int)
    ENABLE_QUERY_CACHING: bool = config("ENABLE_QUERY_CACHING", default=False, cast=bool)
    QUERY_CACHE_TTL: int = config("QUERY_CACHE_TTL", default=300, cast=int)  # Not used in demo
    
    # Export Features
    EXPORT_MAX_RECORDS: int = config("EXPORT_MAX_RECORDS", default=10000, cast=int)
    EXPORT_FORMATS: List[str] = ["csv", "json", "xlsx"]
    
    # Multi-language Support
    DEFAULT_LANGUAGE: str = config("DEFAULT_LANGUAGE", default="en")
    SUPPORTED_LANGUAGES: List[str] = ["en", "vi"]
    
    # Logging
    LOG_LEVEL: str = config("LOG_LEVEL", default="INFO")
    LOG_FORMAT: str = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    
    @property
    def database_url(self) -> str:
        """MS SQL Server connection string"""
        return f"mssql+pyodbc://{self.DB_USERNAME}:{self.DB_PASSWORD}@{self.DB_SERVER}/{self.DB_NAME}?driver={self.DB_DRIVER.replace(' ', '+')}"
    
    # Redis connection removed for demo
    # @property
    # def redis_url(self) -> str:
    #     """Redis connection string - removed for demo"""
    #     return ""
    
    class Config:
        env_file = ".env"
        case_sensitive = True

# Global settings instance
settings = Settings()

# Development settings
def get_settings() -> Settings:
    """Dependency to get settings"""
    return settings 