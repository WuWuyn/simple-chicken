/**
 * Chat types for Text-to-SQL Chatbot Frontend
 */

export interface ChatMessage {
  id: string;
  type: 'user' | 'assistant' | 'system' | 'error';
  content: string;
  timestamp: string;
  metadata?: {
    sqlQuery?: string;
    queryResults?: any[];
    executionTime?: number;
    success?: boolean;
    confidence_score?: number;
    error_message?: string;
    blocked_at_step?: string;
    isProgress?: boolean;  // For progress indicators
  };
}

export interface ChatRequest {
  message: string;
  user_id: string;
  user_role: string;
}

export interface ChatResponse {
  type: string;
  message_id: string;
  user_message: string;
  assistant_response: string;
  sql_query?: string;
  query_results?: any;
  success: boolean;
  error_message?: string;
  execution_time_ms: number;
  timestamp: string;
}

export interface ConversationHistory {
  user_id: string;
  messages: ChatMessage[];
  last_updated: Date;
  total_messages: number;
}

export interface WebSocketMessage {
  type: 'chat' | 'ping' | 'pong' | 'error';
  data: any;
  timestamp: string;
}

export interface ChatState {
  messages: ChatMessage[];
  isLoading: boolean;
  isConnected: boolean;
  error: string | null;
} 