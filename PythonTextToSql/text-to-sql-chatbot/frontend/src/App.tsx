/**
 * Main App Component
 */

import React, { useState, useEffect } from 'react';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import { CssBaseline, Box, CircularProgress } from '@mui/material';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';

import LoginForm from './components/Login/LoginForm';
import ChatInterface from './components/Chat/ChatInterface';
import { apiClient } from './services/api';
import { AuthState, LoginRequest, LoginError, UserInfo } from './types/auth';

// Material-UI Theme
const theme = createTheme({
  palette: {
    primary: {
      main: '#1976d2',
      light: '#42a5f5',
      dark: '#1565c0',
    },
    secondary: {
      main: '#dc004e',
    },
    background: {
      default: '#f5f5f5',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
    h4: {
      fontWeight: 600,
    },
    h5: {
      fontWeight: 500,
    },
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
          borderRadius: 8,
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 12,
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
        },
      },
    },
  },
});

const App: React.FC = () => {
  const [authState, setAuthState] = useState<AuthState>({
    isAuthenticated: false,
    user: null,
    token: null,
    refreshToken: null,
    expiresAt: null,
  });

  const [loginLoading, setLoginLoading] = useState(false);
  const [loginError, setLoginError] = useState<LoginError | null>(null);
  const [appLoading, setAppLoading] = useState(true);

  // Initialize app - check for existing auth
  useEffect(() => {
    const initializeApp = async () => {
      try {
        const storedToken = localStorage.getItem('access_token');
        const storedUserInfo = localStorage.getItem('user_info');

        if (storedToken && storedUserInfo) {
          // Validate token
          const isValid = await apiClient.validateToken();
          
          if (isValid) {
            const user: UserInfo = JSON.parse(storedUserInfo);
            setAuthState({
              isAuthenticated: true,
              user,
              token: storedToken,
              refreshToken: localStorage.getItem('refresh_token'),
              expiresAt: null, // Would need to parse from token
            });
          } else {
            // Token invalid, clear storage
            localStorage.removeItem('access_token');
            localStorage.removeItem('refresh_token');
            localStorage.removeItem('user_info');
          }
        }
      } catch (error) {
        console.error('App initialization error:', error);
        // Clear invalid auth data
        localStorage.removeItem('access_token');
        localStorage.removeItem('refresh_token');
        localStorage.removeItem('user_info');
      } finally {
        setAppLoading(false);
      }
    };

    initializeApp();
  }, []);

  // Handle login
  const handleLogin = async (credentials: LoginRequest) => {
    setLoginLoading(true);
    setLoginError(null);

    try {
      const tokenResponse = await apiClient.login(credentials);
      
      setAuthState({
        isAuthenticated: true,
        user: tokenResponse.user_info,
        token: tokenResponse.access_token,
        refreshToken: tokenResponse.refresh_token,
        expiresAt: new Date(Date.now() + tokenResponse.expires_in * 1000),
      });

      console.log('Login successful:', tokenResponse.user_info);
    } catch (error: any) {
      console.error('Login failed:', error);
      setLoginError({
        message: error.message || 'Login failed. Please try again.',
        code: error.code,
      });
    } finally {
      setLoginLoading(false);
    }
  };

  // Handle logout
  const handleLogout = async () => {
    try {
      await apiClient.logout();
    } catch (error) {
      console.error('Logout error:', error);
    } finally {
      setAuthState({
        isAuthenticated: false,
        user: null,
        token: null,
        refreshToken: null,
        expiresAt: null,
      });
    }
  };

  // Show loading spinner during app initialization
  if (appLoading) {
    return (
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <Box
          sx={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            minHeight: '100vh',
            bgcolor: 'background.default',
          }}
        >
          <CircularProgress size={40} />
        </Box>
      </ThemeProvider>
    );
  }

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Router>
        <Box sx={{ minHeight: '100vh', bgcolor: 'background.default' }}>
          <Routes>
            {/* Public Routes */}
            <Route
              path="/login"
              element={
                authState.isAuthenticated ? (
                  <Navigate to="/chat" replace />
                ) : (
                  <LoginForm
                    onLogin={handleLogin}
                    loading={loginLoading}
                    error={loginError}
                  />
                )
              }
            />

            {/* Protected Routes */}
            <Route
              path="/chat"
              element={
                authState.isAuthenticated ? (
                  <ChatInterface
                    user={authState.user!}
                    onLogout={handleLogout}
                  />
                ) : (
                  <Navigate to="/login" replace />
                )
              }
            />

            {/* Default Route */}
            <Route
              path="/"
              element={
                <Navigate
                  to={authState.isAuthenticated ? "/chat" : "/login"}
                  replace
                />
              }
            />

            {/* Catch all route */}
            <Route
              path="*"
              element={
                <Navigate
                  to={authState.isAuthenticated ? "/chat" : "/login"}
                  replace
                />
              }
            />
          </Routes>
        </Box>
      </Router>
    </ThemeProvider>
  );
};

export default App; 