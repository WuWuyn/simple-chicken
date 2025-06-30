/**
 * API Client Service for Text-to-SQL Chatbot Frontend
 */

import axios, { AxiosInstance, AxiosRequestConfig, AxiosResponse } from 'axios';
import { LoginRequest, TokenResponse, UserInfo } from '../types/auth';
import { APIResponse, HealthCheckResponse } from '../types/api';

// API Configuration
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';
const API_VERSION = '/api/v1';

class APIClient {
  private client: AxiosInstance;
  private token: string | null = null;

  constructor() {
    this.client = axios.create({
      baseURL: `${API_BASE_URL}${API_VERSION}`,
      timeout: 30000,
      headers: {
        'Content-Type': 'application/json',
      },
    });

    this.setupInterceptors();
    this.loadTokenFromStorage();
  }

  private setupInterceptors() {
    // Request interceptor - add auth token
    this.client.interceptors.request.use(
      (config) => {
        if (this.token && config.headers) {
          config.headers.Authorization = `Bearer ${this.token}`;
        }
        
        console.log(`[API] ${config.method?.toUpperCase()} ${config.url}`);
        return config;
      },
      (error) => {
        console.error('[API] Request error:', error);
        return Promise.reject(error);
      }
    );

    // Response interceptor - handle common errors
    this.client.interceptors.response.use(
      (response: AxiosResponse) => {
        console.log(`[API] Response: ${response.status} ${response.config.url}`);
        return response;
      },
      (error) => {
        console.error('[API] Response error:', error);
        
        if (error.response?.status === 401) {
          this.clearAuth();
          window.location.href = '/login';
        }
        
        return Promise.reject(error);
      }
    );
  }

  private loadTokenFromStorage() {
    const storedToken = localStorage.getItem('access_token');
    if (storedToken) {
      this.token = storedToken;
    }
  }

  private saveTokenToStorage(token: string) {
    localStorage.setItem('access_token', token);
    this.token = token;
  }

  private clearAuth() {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    localStorage.removeItem('user_info');
    this.token = null;
  }

  // ============================================================================
  // Authentication Methods
  // ============================================================================

  async login(credentials: LoginRequest): Promise<TokenResponse> {
    try {
      const response = await this.client.post<TokenResponse>('/auth/login', credentials);
      const tokenData = response.data;
      
      // Store tokens
      this.saveTokenToStorage(tokenData.access_token);
      localStorage.setItem('refresh_token', tokenData.refresh_token);
      localStorage.setItem('user_info', JSON.stringify(tokenData.user_info));
      
      return tokenData;
    } catch (error: any) {
      console.error('Login error:', error);
      
      // Handle different error response formats
      let errorMessage = 'Login failed';
      
      if (error.response?.data) {
        const errorData = error.response.data;
        if (errorData.message) {
          errorMessage = errorData.message;
        } else if (errorData.detail) {
          errorMessage = errorData.detail;
        } else if (errorData.error) {
          errorMessage = errorData.error;
        }
      }
      
      // Set error code for better error handling
      const errorWithCode = new Error(errorMessage);
      (errorWithCode as any).code = error.response?.status || 'NETWORK_ERROR';
      
      throw errorWithCode;
    }
  }

  async logout(): Promise<void> {
    try {
      await this.client.post('/auth/logout');
    } catch (error) {
      console.error('Logout error:', error);
    } finally {
      this.clearAuth();
    }
  }

  async getCurrentUser(): Promise<UserInfo> {
    try {
      const response = await this.client.get<{
        authenticated: boolean;
        user_info: UserInfo;
        session_expires_at: string;
      }>('/auth/me');
      
      return response.data.user_info;
    } catch (error: any) {
      console.error('Get current user error:', error);
      throw new Error(error.response?.data?.detail || 'Failed to get user info');
    }
  }

  async refreshToken(): Promise<TokenResponse> {
    try {
      const refreshToken = localStorage.getItem('refresh_token');
      if (!refreshToken) {
        throw new Error('No refresh token available');
      }

      const response = await this.client.post<TokenResponse>('/auth/refresh', {
        refresh_token: refreshToken,
      });

      const tokenData = response.data;
      this.saveTokenToStorage(tokenData.access_token);
      localStorage.setItem('refresh_token', tokenData.refresh_token);

      return tokenData;
    } catch (error: any) {
      console.error('Refresh token error:', error);
      this.clearAuth();
      throw new Error(error.response?.data?.detail || 'Token refresh failed');
    }
  }

  async validateToken(): Promise<boolean> {
    try {
      await this.client.get('/auth/validate');
      return true;
    } catch (error) {
      console.error('Token validation error:', error);
      return false;
    }
  }

  // ============================================================================
  // Health Check Methods
  // ============================================================================

  async healthCheck(): Promise<HealthCheckResponse> {
    try {
      const response = await this.client.get<HealthCheckResponse>('/health');
      return response.data;
    } catch (error: any) {
      console.error('Health check error:', error);
      throw new Error(error.response?.data?.detail || 'Health check failed');
    }
  }

  async ping(): Promise<APIResponse> {
    try {
      const response = await this.client.get<APIResponse>('/health/ping');
      return response.data;
    } catch (error: any) {
      console.error('Ping error:', error);
      throw new Error(error.response?.data?.detail || 'Ping failed');
    }
  }

  // ============================================================================
  // Utility Methods
  // ============================================================================

  isAuthenticated(): boolean {
    return !!this.token;
  }

  getToken(): string | null {
    return this.token;
  }

  setToken(token: string) {
    this.saveTokenToStorage(token);
  }

  // Generic request method
  async request<T>(config: AxiosRequestConfig): Promise<T> {
    try {
      const response = await this.client.request<T>(config);
      return response.data;
    } catch (error: any) {
      console.error('API request error:', error);
      throw new Error(error.response?.data?.detail || 'Request failed');
    }
  }

  // ============================================================================
  // WebSocket Helper Methods
  // ============================================================================

  getWebSocketUrl(token?: string): string {
    const wsToken = token || this.token;
    if (!wsToken) {
      throw new Error('No authentication token available for WebSocket connection');
    }

    const wsProtocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
    const wsHost = process.env.NODE_ENV === 'production' 
      ? window.location.host 
      : 'localhost:8000';
    
    return `${wsProtocol}//${wsHost}${API_VERSION}/chat/ws?token=${encodeURIComponent(wsToken)}`;
  }
}

// Export singleton instance
export const apiClient = new APIClient();

// Export WebSocket URL helper for convenience
export const getWebSocketUrl = (token?: string): string => {
  return apiClient.getWebSocketUrl(token);
};

// Export for testing or alternative usage
export default APIClient; 