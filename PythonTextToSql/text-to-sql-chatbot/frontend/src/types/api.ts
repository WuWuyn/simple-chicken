/**
 * API response types for Text-to-SQL Chatbot Frontend
 */

export interface APIResponse<T = any> {
  success: boolean;
  message: string;
  data?: T;
  error_code?: string;
  timestamp: string;
}

export interface HealthCheckResponse {
  status: string;
  app_name: string;
  version: string;
  timestamp: string;
  database_status: string;
  redis_status: string; // Always "disabled_for_demo" now
  pipeline_status: string;
}

export interface ValidationError {
  error: string;
  details: Array<{
    code: string;
    message: string;
    details?: any;
  }>;
  timestamp: string;
}

export interface HTTPError {
  error: string;
  message: string;
  status_code: number;
} 