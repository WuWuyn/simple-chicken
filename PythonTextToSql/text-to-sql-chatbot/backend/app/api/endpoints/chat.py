"""
Chat endpoints for Text-to-SQL Chatbot API
"""

import json
import uuid
from datetime import datetime
from typing import Dict, Any, List, Optional
from fastapi import APIRouter, WebSocket, WebSocketDisconnect, Depends, HTTPException, status
import logging

from ...models.schemas import (
    PipelineRequest, PipelineResponse, APIResponse,
    ChatWebSocketRequest, ChatWebSocketResponse, ConversationHistory
)
from ...utils.auth import get_current_active_user, TokenData, jwt_manager, AuthenticationError
from ...utils.pipeline_wrapper import get_pipeline, TextToSQLPipelineWrapper
from ...utils.context_manager import get_context_manager, ConversationContextManager
from ...utils.smart_response_formatter import get_smart_formatter
from ...utils.demo_time import get_current_iso, get_demo_timestamp, DEMO_ISO
from ...core.config import settings

# Setup logging
logger = logging.getLogger(__name__)

# Create router
router = APIRouter(prefix="/chat", tags=["Chat"])

class ConnectionManager:
    """WebSocket connection manager"""
    
    def __init__(self):
        self.active_connections: Dict[str, WebSocket] = {}
        self.user_connections: Dict[str, str] = {}  # user_id -> connection_id
    
    async def connect(self, websocket: WebSocket, user_id: str) -> str:
        """Accept WebSocket connection and register user"""
        await websocket.accept()
        
        connection_id = str(uuid.uuid4())
        self.active_connections[connection_id] = websocket
        self.user_connections[user_id] = connection_id
        
        logger.info(f"WebSocket connected: {user_id} ({connection_id})")
        return connection_id
    
    def disconnect(self, connection_id: str, user_id: str = None):
        """Remove WebSocket connection"""
        if connection_id in self.active_connections:
            del self.active_connections[connection_id]
        
        if user_id and user_id in self.user_connections:
            del self.user_connections[user_id]
        
        logger.info(f"WebSocket disconnected: {user_id} ({connection_id})")
    
    async def send_personal_message(self, message: Dict[str, Any], user_id: str):
        """Send message to specific user"""
        if user_id in self.user_connections:
            connection_id = self.user_connections[user_id]
            if connection_id in self.active_connections:
                websocket = self.active_connections[connection_id]
                try:
                    # Check WebSocket state before sending
                    if websocket.client_state.name == "CONNECTED":
                        await websocket.send_text(json.dumps(message, default=str))
                        logger.debug(f"Message sent successfully to {user_id}")
                    else:
                        logger.warning(f"WebSocket not connected for {user_id}, removing connection")
                        self.disconnect(connection_id, user_id)
                except Exception as e:
                    logger.error(f"Failed to send message to {user_id}: {e}")
                    self.disconnect(connection_id, user_id)

# Global connection manager
manager = ConnectionManager()

async def authenticate_websocket_token(token: str) -> TokenData:
    """Authenticate WebSocket connection using JWT token"""
    try:
        token_data = jwt_manager.verify_token(token)
        return token_data
    except AuthenticationError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )

@router.websocket("/ws")
async def websocket_endpoint(
    websocket: WebSocket,
    token: str,
    pipeline: TextToSQLPipelineWrapper = Depends(get_pipeline),
    context_manager: ConversationContextManager = Depends(get_context_manager)
):
    """
    WebSocket endpoint for real-time chat
    
    Query parameters:
    - token: JWT access token for authentication
    """
    connection_id = None
    user_data = None
    
    try:
        # Authenticate user
        user_data = await authenticate_websocket_token(token)
        
        # Accept connection
        connection_id = await manager.connect(websocket, user_data.user_id)
        
        # Send welcome message
        welcome_message = {
            "type": "system",
            "message": f"Welcome {user_data.user_id}! How can I help you with your academic queries?",
            "timestamp": get_current_iso(),
            "metadata": {
                "user_role": user_data.user_role,
                "pipeline_ready": pipeline.is_ready(),
                "demo_mode": True,
                "fixed_time": get_demo_timestamp()
            }
        }
        await manager.send_personal_message(welcome_message, user_data.user_id)
        
        # Main message loop
        while True:
            try:
                # Check if WebSocket is still connected
                if websocket.client_state.name != "CONNECTED":
                    logger.info(f"WebSocket not connected for {user_data.user_id}, breaking loop")
                    break
                
                # Receive message from WebSocket
                data = await websocket.receive_text()
                message_data = json.loads(data)
                
                # Validate message format
                if "message" not in message_data:
                    error_response = {
                        "type": "error",
                        "message": "Invalid message format. 'message' field required.",
                        "timestamp": get_current_iso()
                    }
                    await manager.send_personal_message(error_response, user_data.user_id)
                    continue
                
                user_message = message_data["message"].strip()
                if not user_message:
                    continue
                
                message_id = str(uuid.uuid4())
                logger.info(f"Processing message from {user_data.user_id}: {user_message}")
                
                # Send typing indicator
                typing_response = {
                    "type": "typing",
                    "message": "Processing your question...",
                    "timestamp": get_current_iso()
                }
                await manager.send_personal_message(typing_response, user_data.user_id)
                
                # Send progress updates during processing
                progress_messages = [
                    "🛡️ Checking security...",
                    "🔍 Analyzing your question...", 
                    "🔐 Verifying permissions...",
                    "🤖 Generating SQL query...",
                    "📊 Executing query..."
                ]
                
                # Process through pipeline
                pipeline_request = PipelineRequest(
                    user_question=user_message,
                    user_id=user_data.user_id,
                    user_role=user_data.user_role,
                    timestamp=get_demo_timestamp(),  # Use demo timestamp consistently
                    additional_context={}
                )
                
                # Get pipeline response with progress updates
                if pipeline.is_ready():
                    # Send progress updates during processing
                    import asyncio
                    
                    async def send_progress():
                        """Send progress updates every 1 second"""
                        for i, msg in enumerate(progress_messages):
                            await asyncio.sleep(0.8)  # Stagger the messages
                            if websocket.client_state.name == "CONNECTED":
                                progress_response = {
                                    "type": "progress",
                                    "message": msg,
                                    "step": i + 1,
                                    "total_steps": len(progress_messages),
                                    "timestamp": get_current_iso()
                                }
                                await manager.send_personal_message(progress_response, user_data.user_id)
                            else:
                                break
                    
                    # Start progress updates in background
                    progress_task = asyncio.create_task(send_progress())
                    
                    try:
                        # Process with timeout
                        pipeline_response = await asyncio.wait_for(
                            pipeline.process_query(pipeline_request),
                            timeout=30.0  # 30 second timeout
                        )
                    except asyncio.TimeoutError:
                        progress_task.cancel()
                        raise Exception("Query processing timeout after 30 seconds")
                    finally:
                        progress_task.cancel()
                        
                else:
                    # Use mock response for demo
                    pipeline_response = pipeline.create_mock_response(pipeline_request)
                
                # Store conversation context
                await context_manager.add_message(
                    user_id=user_data.user_id,
                    message_type="user",
                    content=user_message,
                    metadata={}
                )
                
                # Format assistant response
                if pipeline_response.success:
                    if pipeline_response.sql_result and pipeline_response.sql_result.get("success"):
                        sql_query = pipeline_response.sql_result.get("generated_sql", "")
                        results = pipeline_response.sql_result.get("execution_result", [])
                        
                        # Use Smart Response Formatter for human-friendly responses
                        smart_formatter = get_smart_formatter()
                        response_message = smart_formatter.format_response(
                            user_question=user_message,
                            results=results if isinstance(results, list) else [],
                            user_id=user_data.user_id,
                            user_role=user_data.user_role,
                            execution_time_ms=pipeline_response.execution_time_ms
                        )
                        
                        # Create chat response
                        chat_response = ChatWebSocketResponse(
                            message_id=message_id,
                            user_message=user_message,
                            assistant_response=response_message,
                            sql_query=sql_query,
                            query_results=results,
                            success=True,
                            execution_time_ms=pipeline_response.execution_time_ms
                        )
                    else:
                        # Handle failed SQL execution
                        response_message = "I understand your question, but I couldn't execute the query successfully."
                        
                        chat_response = ChatWebSocketResponse(
                            message_id=message_id,
                            user_message=user_message,
                            assistant_response=response_message,
                            success=False,
                            error_message="Failed to execute the generated SQL query.",
                            execution_time_ms=pipeline_response.execution_time_ms
                        )
                else:
                    # Handle blocked or failed queries using the safe formatter
                    smart_formatter = get_smart_formatter()
                    response_message = smart_formatter.format_security_response(
                        user_question=user_message,
                        blocked_step=str(pipeline_response.blocked_at_step or "general_error"),
                        error_message=str(pipeline_response.error_message or ""),
                        user_id=user_data.user_id,
                        user_role=user_data.user_role
                    )
                    
                    chat_response = ChatWebSocketResponse(
                        message_id=message_id,
                        user_message=user_message,
                        assistant_response=response_message,
                        success=False,
                        error_message=response_message,  # Use the safe, formatted message
                        execution_time_ms=pipeline_response.execution_time_ms
                    )
                
                # Store assistant response in context
                await context_manager.add_message(
                    user_id=user_data.user_id,
                    message_type="assistant",
                    content=chat_response.assistant_response,
                    metadata={
                        "sql_query": chat_response.sql_query,
                        "query_results": chat_response.query_results,
                        "execution_time_ms": chat_response.execution_time_ms,
                        "success": chat_response.success
                    }
                )
                
                # Send response (check connection first)
                if websocket.client_state.name == "CONNECTED":
                    response_dict = chat_response.dict()
                    # Ensure response has correct type field for frontend
                    response_dict["type"] = "assistant"
                    await manager.send_personal_message(response_dict, user_data.user_id)
                    logger.info(f"Response sent to {user_data.user_id} for message: {user_message[:50]}...")
                else:
                    logger.warning(f"Cannot send response to {user_data.user_id}, WebSocket disconnected")
                
            except json.JSONDecodeError:
                error_response = {
                    "type": "error",
                    "message": "Invalid JSON format",
                    "timestamp": get_current_iso()
                }
                await manager.send_personal_message(error_response, user_data.user_id)
                
            except asyncio.TimeoutError:
                logger.error(f"Query processing timeout for {user_data.user_id}")
                if websocket.client_state.name == "CONNECTED":
                    timeout_response = {
                        "type": "error",
                        "message": "⏰ Query processing took too long and was stopped. Please try a simpler question.",
                        "timestamp": get_current_iso()
                    }
                    await manager.send_personal_message(timeout_response, user_data.user_id)
                    
            except Exception as e:
                logger.error(f"Error processing WebSocket message: {e}")
                # Only send error response if WebSocket is still connected
                if websocket.client_state.name == "CONNECTED":
                    error_response = {
                        "type": "error",
                        "message": "An error occurred while processing your message",
                        "timestamp": get_current_iso()
                    }
                    await manager.send_personal_message(error_response, user_data.user_id)
                else:
                    logger.info(f"WebSocket disconnected for {user_data.user_id}, skipping error response")
                
    except WebSocketDisconnect:
        logger.info(f"WebSocket disconnected normally for user {user_data.user_id if user_data else 'unknown'}")
        if connection_id and user_data:
            manager.disconnect(connection_id, user_data.user_id)
    except Exception as e:
        logger.error(f"WebSocket connection error: {e}")
        if connection_id and user_data:
            manager.disconnect(connection_id, user_data.user_id)
        # Try to send error message if possible
        try:
            if user_data and websocket.client_state.name == "CONNECTED":
                error_message = {
                    "type": "error",
                    "message": "Connection error occurred. Please refresh and try again.",
                    "timestamp": get_current_iso()
                }
                await websocket.send_text(json.dumps(error_message, default=str))
        except:
            pass  # Already disconnected, ignore

@router.post("/query", response_model=APIResponse)
async def process_chat_query(
    request: PipelineRequest,
    current_user: TokenData = Depends(get_current_active_user),
    pipeline: TextToSQLPipelineWrapper = Depends(get_pipeline)
):
    """
    Process a single chat query (REST endpoint alternative to WebSocket)
    """
    try:
        # Override user information from JWT token
        request.user_id = current_user.user_id
        request.user_role = current_user.user_role
        
        # Process through pipeline
        if pipeline.is_ready():
            result = await pipeline.process_query(request)
        else:
            result = pipeline.create_mock_response(request)
        
        return APIResponse(
            success=True,
            message="Query processed successfully",
            data=result.dict(),
            timestamp=get_current_iso()
        )
        
    except Exception as e:
        logger.error(f"Chat query processing error: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to process query"
        )

@router.get("/history", response_model=APIResponse)
async def get_conversation_history(
    limit: int = 50,
    current_user: TokenData = Depends(get_current_active_user),
    context_manager: ConversationContextManager = Depends(get_context_manager)
):
    """
    Get conversation history for current user
    """
    try:
        history = await context_manager.get_conversation_history(
            user_id=current_user.user_id,
            limit=limit
        )
        
        return APIResponse(
            success=True,
            message="Conversation history retrieved", 
            data=history,
            timestamp=get_current_iso()
        )
        
    except Exception as e:
        logger.error(f"Failed to get conversation history: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve conversation history"
        )

@router.delete("/history", response_model=APIResponse)
async def clear_conversation_history(
    current_user: TokenData = Depends(get_current_active_user),
    context_manager: ConversationContextManager = Depends(get_context_manager)
):
    """
    Clear conversation history for current user
    """
    try:
        await context_manager.clear_conversation(current_user.user_id)
        
        return APIResponse(
            success=True,
            message="Conversation history cleared",
            timestamp=get_current_iso()
        )
        
    except Exception as e:
        logger.error(f"Failed to clear conversation history: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to clear conversation history"
        )

@router.get("/status", response_model=APIResponse)
async def get_chat_status(
    pipeline: TextToSQLPipelineWrapper = Depends(get_pipeline),
    current_user: TokenData = Depends(get_current_active_user)
):
    """
    Get chat system status
    """
    try:
        pipeline_status = pipeline.get_status()
        
        status_data = {
            "pipeline_ready": pipeline.is_ready(),
            "pipeline_status": pipeline_status,
            "active_connections": len(manager.active_connections),
            "user_connected": current_user.user_id in manager.user_connections,
            "websocket_url": f"ws://localhost:8000/api/v1/chat/ws?token={{access_token}}"
        }
        
        return APIResponse(
            success=True,
            message="Chat status retrieved",
            data=status_data,
            timestamp=get_current_iso()
        )
        
    except Exception as e:
        logger.error(f"Failed to get chat status: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve chat status"
        ) 