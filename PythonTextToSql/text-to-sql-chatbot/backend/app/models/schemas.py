"""
Pydantic models for Text-to-SQL Chatbot API
"""

from datetime import datetime
from typing import Optional, List, Dict, Any, Union
from pydantic import BaseModel, Field, validator

# ============================================================================
# Authentication Models
# ============================================================================

class UserLogin(BaseModel):
    """User login request"""
    username: str = Field(..., min_length=3, max_length=50)
    password: str = Field(..., min_length=6, max_length=150)

class UserInfo(BaseModel):
    """User information"""
    user_id: str
    username: str
    fullname: str
    user_role: str
    user_gender: Optional[str] = None
    user_dob: Optional[str] = None
    user_address: Optional[str] = None

class TokenData(BaseModel):
    """JWT Token payload"""
    user_id: str
    user_role: str
    username: str
    exp: datetime

class TokenResponse(BaseModel):
    """Authentication response"""
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int  # seconds
    user_info: UserInfo

# ============================================================================
# Chat Models
# ============================================================================

class ChatMessage(BaseModel):
    """Single chat message"""
    id: str
    user_question: str
    timestamp: datetime
    user_id: str
    user_role: str

class ChatResponse(BaseModel):
    """Response from Text-to-SQL pipeline"""
    success: bool
    generated_sql: Optional[str] = None
    execution_result: Optional[Any] = None
    error_message: Optional[str] = None
    execution_time_ms: float
    confidence_score: Optional[float] = None
    blocked_at_step: Optional[str] = None

class ConversationMessage(BaseModel):
    """Single message in conversation"""
    id: str
    type: str = Field(..., description="'user' or 'assistant'")
    content: str
    timestamp: datetime
    metadata: Optional[Dict[str, Any]] = None

class ConversationHistory(BaseModel):
    """Conversation history"""
    user_id: str
    messages: List[ConversationMessage]
    last_updated: datetime
    total_messages: int

# ============================================================================
# WebSocket Models
# ============================================================================

class WebSocketMessage(BaseModel):
    """WebSocket message structure"""
    type: str = Field(..., description="'chat', 'ping', 'pong', 'error'")
    data: Dict[str, Any]
    timestamp: str = "22:00 15/6/2024"  # Fixed demo timestamp

class ChatWebSocketRequest(BaseModel):
    """Chat message from WebSocket"""
    message: str = Field(..., min_length=1, max_length=1000)
    user_id: str
    user_role: str

class ChatWebSocketResponse(BaseModel):
    """Chat response via WebSocket"""
    type: str = "assistant"  # Changed to match frontend expectations
    message_id: str
    user_message: str
    assistant_response: str
    sql_query: Optional[str] = None
    query_results: Optional[Any] = None
    success: bool
    error_message: Optional[str] = None
    execution_time_ms: float
    timestamp: datetime = Field(default_factory=datetime.utcnow)

# ============================================================================
# API Response Models
# ============================================================================

class APIResponse(BaseModel):
    """Standard API response wrapper"""
    success: bool
    message: str
    data: Optional[Any] = None
    error_code: Optional[str] = None
    timestamp: Union[str, datetime] = "22:00 15/6/2024"  # Fixed demo timestamp
    
    @validator('timestamp', pre=True)
    def convert_timestamp(cls, v):
        if isinstance(v, datetime):
            return v.strftime("%H:%M %d/%m/%Y")
        return v

class HealthCheckResponse(BaseModel):
    """Health check response"""
    status: str
    app_name: str
    version: str
    timestamp: datetime
    database_status: str
    redis_status: str  # Kept for compatibility but will show "disabled_for_demo"
    pipeline_status: str

class UserStatusResponse(BaseModel):
    """User status response"""
    authenticated: bool
    user_info: Optional[UserInfo] = None
    session_expires_at: Optional[datetime] = None

# ============================================================================
# Pipeline Integration Models
# ============================================================================

class PipelineRequest(BaseModel):
    """Request to Text-to-SQL pipeline"""
    user_question: str
    user_id: str
    user_role: str
    timestamp: str = "22:00 15/6/2024"  # Fixed as per requirements
    additional_context: Optional[Dict[str, Any]] = None

class PipelineResponse(BaseModel):
    """Response from Text-to-SQL pipeline"""
    status: str
    success: bool
    security_result: Optional[Dict[str, Any]] = None
    value_retrieval_result: Optional[Dict[str, Any]] = None
    permission_result: Optional[Dict[str, Any]] = None
    sql_result: Optional[Dict[str, Any]] = None
    execution_time_ms: float
    blocked_at_step: Optional[str] = None
    error_message: Optional[str] = None

# ============================================================================
# Validators
# ============================================================================

class ChatMessage(ChatMessage):
    @validator('user_question')
    def validate_user_question(cls, v):
        if not v or not v.strip():
            raise ValueError('User question cannot be empty')
        if len(v.strip()) > 1000:
            raise ValueError('User question too long (max 1000 characters)')
        return v.strip()

class UserLogin(UserLogin):
    @validator('username')
    def validate_username(cls, v):
        if not v or not v.strip():
            raise ValueError('Username cannot be empty')
        return v.strip().lower()
    
    @validator('password')
    def validate_password(cls, v):
        if len(v) < 6:
            raise ValueError('Password must be at least 6 characters')
        return v

# ============================================================================
# Error Models
# ============================================================================

class ErrorDetail(BaseModel):
    """Error detail structure"""
    code: str
    message: str
    details: Optional[Dict[str, Any]] = None

class ValidationError(BaseModel):
    """Validation error response"""
    error: str = "validation_error"
    details: List[ErrorDetail]
    timestamp: datetime = Field(default_factory=datetime.utcnow) 