/**
 * Authentication types for Text-to-SQL Chatbot Frontend
 */

export interface UserInfo {
  user_id: string;
  username: string;
  fullname: string;
  user_role: string;
  user_gender?: string;
  user_dob?: string;
  user_address?: string;
}

export interface LoginRequest {
  username: string;
  password: string;
}

export interface TokenResponse {
  access_token: string;
  refresh_token: string;
  token_type: string;
  expires_in: number;
  user_info: UserInfo;
}

export interface AuthState {
  isAuthenticated: boolean;
  user: UserInfo | null;
  token: string | null;
  refreshToken: string | null;
  expiresAt: Date | null;
}

export interface LoginError {
  message: string;
  code?: string;
} 