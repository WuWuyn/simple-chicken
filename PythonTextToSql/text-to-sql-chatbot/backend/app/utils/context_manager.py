"""
Conversation Context Manager for Chat History
"""

import json
from typing import Dict, List, Any, Optional
from datetime import datetime
import logging

# Setup logging
logger = logging.getLogger(__name__)

class ConversationContextManager:
    """
    Manages conversation context and history for users
    In production, this would use a database like Redis or PostgreSQL
    For now, using in-memory storage for simplicity
    """
    
    def __init__(self):
        # In-memory storage: user_id -> messages
        self.conversations: Dict[str, List[Dict[str, Any]]] = {}
        self.max_history_per_user = 100  # Maximum messages to keep per user
    
    async def add_message(
        self, 
        user_id: str, 
        message_type: str, 
        content: str, 
        metadata: Optional[Dict[str, Any]] = None
    ):
        """
        Add a message to user's conversation history
        
        Args:
            user_id: User identifier
            message_type: 'user' or 'assistant'
            content: Message content
            metadata: Additional message metadata
        """
        if user_id not in self.conversations:
            self.conversations[user_id] = []
        
        message = {
            "timestamp": datetime.utcnow().isoformat(),
            "type": message_type,
            "content": content,
            "metadata": metadata or {}
        }
        
        self.conversations[user_id].append(message)
        
        # Keep only the latest messages
        if len(self.conversations[user_id]) > self.max_history_per_user:
            self.conversations[user_id] = self.conversations[user_id][-self.max_history_per_user:]
        
        logger.debug(f"Added message for user {user_id}: {message_type}")
    
    async def get_conversation_history(
        self, 
        user_id: str, 
        limit: int = 50
    ) -> List[Dict[str, Any]]:
        """
        Get conversation history for a user
        
        Args:
            user_id: User identifier
            limit: Maximum number of messages to return
            
        Returns:
            List of messages in chronological order
        """
        if user_id not in self.conversations:
            return []
        
        messages = self.conversations[user_id]
        return messages[-limit:] if limit > 0 else messages
    
    async def clear_conversation(self, user_id: str):
        """
        Clear conversation history for a user
        
        Args:
            user_id: User identifier
        """
        if user_id in self.conversations:
            del self.conversations[user_id]
            logger.info(f"Cleared conversation history for user {user_id}")
    
    async def get_context_for_query(
        self, 
        user_id: str, 
        include_last_n: int = 5
    ) -> Dict[str, Any]:
        """
        Get recent conversation context for query processing
        
        Args:
            user_id: User identifier
            include_last_n: Number of recent messages to include
            
        Returns:
            Context dictionary with recent messages
        """
        recent_messages = await self.get_conversation_history(user_id, include_last_n)
        
        context = {
            "recent_messages": recent_messages,
            "conversation_length": len(self.conversations.get(user_id, [])),
            "last_activity": recent_messages[-1]["timestamp"] if recent_messages else None
        }
        
        return context
    
    def get_stats(self) -> Dict[str, Any]:
        """Get statistics about conversations"""
        total_users = len(self.conversations)
        total_messages = sum(len(messages) for messages in self.conversations.values())
        
        return {
            "total_users": total_users,
            "total_messages": total_messages,
            "average_messages_per_user": total_messages / total_users if total_users > 0 else 0
        }

# Global context manager instance
context_manager = ConversationContextManager()

def get_context_manager() -> ConversationContextManager:
    """Dependency to get context manager"""
    return context_manager 