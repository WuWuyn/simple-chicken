/**
 * Chat Interface Component - Phase 2: Real-time Chat with Text-to-SQL Integration
 */

import React, { useState, useEffect, useRef } from 'react';
import {
  Box,
  AppBar,
  Toolbar,
  Typography,
  Button,
  TextField,
  IconButton,
  List,
  ListItem,
  Card,
  CardContent,
  Chip,
  Alert,
  CircularProgress,
  Avatar,
  Container
} from '@mui/material';
import {
  Send as SendIcon,
  Person as UserIcon,
  Psychology as BotIcon,
  Refresh as RefreshIcon,
  Logout as LogoutIcon,
  Chat as ChatIcon
} from '@mui/icons-material';
import { styled } from '@mui/material/styles';
import { format } from 'date-fns';

import { getWebSocketUrl } from '../../services/api';
import { ChatMessage } from '../../types/chat';
import { UserInfo } from '../../types/auth';

// Styled components
const ChatContainer = styled(Box)(({ theme }) => ({
  height: 'calc(100vh - 64px)', // Subtract AppBar height
  display: 'flex',
  flexDirection: 'column',
}));

const MessagesContainer = styled(Box)(({ theme }) => ({
  flex: 1,
  overflow: 'auto',
  padding: theme.spacing(1),
  '&::-webkit-scrollbar': {
    width: '8px',
  },
  '&::-webkit-scrollbar-track': {
    background: theme.palette.grey[100],
  },
  '&::-webkit-scrollbar-thumb': {
    background: theme.palette.grey[400],
    borderRadius: '4px',
  },
}));

const MessageBubble = styled(Card)<{ sender: 'user' | 'assistant' | 'system' | 'error' }>(({ theme, sender }) => ({
  marginBottom: theme.spacing(1),
  maxWidth: '85%',
  alignSelf: sender === 'user' ? 'flex-end' : 'flex-start',
  marginLeft: sender === 'user' ? 'auto' : 0,
  marginRight: sender === 'user' ? 0 : 'auto',
  backgroundColor: 
    sender === 'user' ? theme.palette.primary.main :
    sender === 'system' ? theme.palette.info.light :
    sender === 'error' ? theme.palette.error.light :
    theme.palette.grey[100],
  color: sender === 'user' ? theme.palette.primary.contrastText : 'inherit',
}));

const InputContainer = styled(Box)(({ theme }) => ({
  display: 'flex',
  gap: theme.spacing(1),
  alignItems: 'flex-end',
  padding: theme.spacing(2),
  backgroundColor: theme.palette.background.paper,
  borderTop: `1px solid ${theme.palette.divider}`,
}));

interface ChatInterfaceProps {
  user: UserInfo;
  onLogout: () => void;
}

const ChatInterface: React.FC<ChatInterfaceProps> = ({ user, onLogout }) => {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [inputMessage, setInputMessage] = useState('');
  const [isConnected, setIsConnected] = useState(false);
  const [isTyping, setIsTyping] = useState(false);
  const [connectionError, setConnectionError] = useState<string | null>(null);

  
  const wsRef = useRef<WebSocket | null>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const reconnectTimeoutRef = useRef<NodeJS.Timeout | null>(null);

  // Auto-scroll to bottom when new messages arrive
  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  // WebSocket connection management
  const connectWebSocket = () => {
    const token = localStorage.getItem('access_token');
    if (!token) {
      setConnectionError('No authentication token found');
      return;
    }

    try {
      const wsUrl = getWebSocketUrl(token);
      wsRef.current = new WebSocket(wsUrl);

      wsRef.current.onopen = () => {
        console.log('WebSocket connected');
        setIsConnected(true);
        setConnectionError(null);
        
        // Clear any pending reconnection
        if (reconnectTimeoutRef.current) {
          clearTimeout(reconnectTimeoutRef.current);
          reconnectTimeoutRef.current = null;
        }
      };

      wsRef.current.onmessage = (event) => {
        try {
          const data = JSON.parse(event.data);
          console.log('Received WebSocket message:', data); // Debug log
          handleWebSocketMessage(data);
        } catch (error) {
          console.error('Failed to parse WebSocket message:', error, 'Raw data:', event.data);
        }
      };

      wsRef.current.onclose = () => {
        console.log('WebSocket disconnected');
        setIsConnected(false);
        setIsTyping(false);
        
        // Attempt reconnection after 3 seconds
        reconnectTimeoutRef.current = setTimeout(() => {
          connectWebSocket();
        }, 3000);
      };

      wsRef.current.onerror = (error) => {
        console.error('WebSocket error:', error);
        setConnectionError('WebSocket connection failed');
      };

    } catch (error) {
      console.error('Failed to create WebSocket connection:', error);
      setConnectionError('Failed to create WebSocket connection');
    }
  };

  // Handle incoming WebSocket messages
  const handleWebSocketMessage = (data: any) => {
    // Use demo timestamp consistently
    const demoTimestamp = "2024-06-15T22:00:00.000Z";
    const timestamp = data.timestamp || demoTimestamp;

    switch (data.type) {
      case 'system':
        setMessages(prev => [...prev, {
          id: `system-${Date.now()}`,
          type: 'system',
          content: data.message,
          timestamp,
          metadata: data.metadata
        }]);
        break;

      case 'typing':
        setIsTyping(true);
        break;

      case 'progress':
        // Show progress indicator in chat
        setMessages(prev => {
          // Remove previous progress message if exists
          const filtered = prev.filter(msg => !msg.id.startsWith('progress-'));
          return [...filtered, {
            id: `progress-${Date.now()}`,
            type: 'system',
            content: `${data.message} (${data.step}/${data.total_steps})`,
            timestamp,
            metadata: { isProgress: true }
          }];
        });
        break;

      case 'assistant':
        setIsTyping(false);
        setMessages(prev => [...prev, {
          id: data.message_id || `assistant-${Date.now()}`,
          type: 'assistant',
          content: data.assistant_response,
          timestamp,
          metadata: {
            sqlQuery: data.sql_query,
            queryResults: data.query_results,
            executionTime: data.execution_time_ms,
            success: data.success
          }
        }]);
        break;

      case 'error':
        setIsTyping(false);
        setMessages(prev => [...prev, {
          id: `error-${Date.now()}`,
          type: 'error',
          content: data.message,
          timestamp
        }]);
        break;

      default:
        console.log('Unknown message type:', data.type, 'Data:', data);
        // Handle unknown types as regular responses (fallback)
        if (data.assistant_response) {
          setIsTyping(false);
          setMessages(prev => [...prev, {
            id: data.message_id || `assistant-${Date.now()}`,
            type: 'assistant',
            content: data.assistant_response,
            timestamp,
            metadata: {
              sqlQuery: data.sql_query,
              queryResults: data.query_results,
              executionTime: data.execution_time_ms,
              success: data.success
            }
          }]);
        }
    }
  };

  // Connect WebSocket on component mount
  useEffect(() => {
    connectWebSocket();

    return () => {
      if (wsRef.current) {
        wsRef.current.close();
      }
      if (reconnectTimeoutRef.current) {
        clearTimeout(reconnectTimeoutRef.current);
      }
    };
  }, []);

  // Send message
  const sendMessage = () => {
    if (!inputMessage.trim() || !isConnected || !wsRef.current) {
      return;
    }

    // Use demo timestamp for consistency
    const demoTimestamp = "2024-06-15T22:00:00.000Z";
    const userMessage: ChatMessage = {
      id: `user-${Date.now()}`,
      type: 'user',
      content: inputMessage.trim(),
      timestamp: demoTimestamp
    };

    // Add user message to UI immediately
    setMessages(prev => [...prev, userMessage]);

    // Send to WebSocket
    wsRef.current.send(JSON.stringify({
      message: inputMessage.trim()
    }));

    setInputMessage('');
  };

  // Handle Enter key press
  const handleKeyPress = (event: React.KeyboardEvent) => {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      sendMessage();
    }
  };



  // Manual reconnection
  const handleReconnect = () => {
    if (wsRef.current) {
      wsRef.current.close();
    }
    connectWebSocket();
  };

  const getRoleColor = (role: string) => {
    switch (role.toLowerCase()) {
      case 'student':
        return 'primary';
      case 'lecturer':
        return 'secondary';
      case 'training manager':
        return 'success';
      default:
        return 'default';
    }
  };

  return (
    <Box sx={{ flexGrow: 1 }}>
      {/* App Bar */}
      <AppBar position="static" elevation={1}>
        <Toolbar>
          <ChatIcon sx={{ mr: 2 }} />
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Text-to-SQL Chatbot
          </Typography>
          
          {/* Connection Status */}
          <Chip 
            icon={isConnected ? <BotIcon /> : <RefreshIcon />}
            label={isConnected ? 'Connected' : 'Disconnected'}
            color={isConnected ? 'success' : 'error'}
            variant="outlined"
            sx={{ mr: 2, color: 'white', borderColor: 'white' }}
          />
          
          {/* User Info */}
          <Box sx={{ display: 'flex', alignItems: 'center', mr: 2 }}>
            <Avatar sx={{ width: 32, height: 32, mr: 1, bgcolor: 'secondary.main' }}>
              <UserIcon />
            </Avatar>
            <Box sx={{ mr: 2 }}>
              <Typography variant="body2" sx={{ color: 'white' }}>
                {user.fullname || user.username}
              </Typography>
              <Chip
                label={user.user_role}
                size="small"
                color={getRoleColor(user.user_role)}
                sx={{ height: 18, fontSize: '0.7rem' }}
              />
            </Box>
          </Box>

          {/* Reconnect Button */}
          {!isConnected && (
            <IconButton onClick={handleReconnect} size="small" sx={{ mr: 1, color: 'white' }}>
              <RefreshIcon />
            </IconButton>
          )}

          {/* Logout Button */}
          <Button
            color="inherit"
            onClick={onLogout}
            startIcon={<LogoutIcon />}
          >
            Logout
          </Button>
        </Toolbar>
      </AppBar>

      <ChatContainer>
        <Container maxWidth="xl" sx={{ flex: 1, display: 'flex', flexDirection: 'column', p: 0 }}>
          {connectionError && (
            <Alert severity="error" sx={{ m: 2 }}>
              {connectionError}
              <Button onClick={handleReconnect} size="small" sx={{ ml: 1 }}>
                Retry Connection
              </Button>
            </Alert>
          )}

          {/* Messages Container */}
          <MessagesContainer>
            <List sx={{ padding: 0 }}>
              {messages.map((message) => (
                <ListItem key={message.id} sx={{ padding: 0, display: 'flex', flexDirection: 'column', alignItems: 'stretch' }}>
                  <MessageBubble sender={message.type}>
                    <CardContent sx={{ padding: '12px 16px !important' }}>
                      {/* Message Header */}
                      <Box display="flex" alignItems="center" justifyContent="space-between" mb={1}>
                        <Box display="flex" alignItems="center" gap={1}>
                          {message.type === 'user' ? <UserIcon fontSize="small" /> : <BotIcon fontSize="small" />}
                          <Typography variant="caption" sx={{ opacity: 0.7 }}>
                            {message.type === 'user' ? 'You' : 'Assistant'} • {format(new Date(message.timestamp), 'HH:mm')}
                          </Typography>
                        </Box>
                        {message.metadata?.executionTime && (
                          <Chip 
                            label={`${message.metadata.executionTime.toFixed(1)}ms`}
                            size="small"
                            variant="outlined"
                          />
                        )}
                      </Box>

                      {/* Message Content */}
                      <Typography variant="body1" sx={{ whiteSpace: 'pre-wrap', wordBreak: 'break-word' }}>
                        {message.content}
                      </Typography>

                      {/* Technical details (SQL Query and Raw Data) are now completely hidden for clean user experience */}
                    </CardContent>
                  </MessageBubble>
                </ListItem>
              ))}
              
              {/* Typing indicator */}
              {isTyping && (
                <ListItem sx={{ padding: 0 }}>
                  <MessageBubble sender="assistant">
                    <CardContent sx={{ padding: '12px 16px !important' }}>
                      <Box display="flex" alignItems="center" gap={1}>
                        <BotIcon fontSize="small" />
                        <Typography variant="body2">Assistant is typing</Typography>
                        <CircularProgress size={16} />
                      </Box>
                    </CardContent>
                  </MessageBubble>
                </ListItem>
              )}
            </List>
            <div ref={messagesEndRef} />
          </MessagesContainer>

          {/* Input Area */}
          <InputContainer>
            <TextField
              fullWidth
              multiline
              maxRows={4}
              placeholder={isConnected ? "Ask me about your courses, grades, or academic information..." : "Connecting..."}
              value={inputMessage}
              onChange={(e) => setInputMessage(e.target.value)}
              onKeyPress={handleKeyPress}
              disabled={!isConnected}
              variant="outlined"
              size="small"
            />
            <IconButton
              color="primary"
              onClick={sendMessage}
              disabled={!inputMessage.trim() || !isConnected}
              sx={{ 
                alignSelf: 'stretch',
                minWidth: '48px',
                borderRadius: 1
              }}
            >
              <SendIcon />
            </IconButton>
          </InputContainer>
        </Container>
      </ChatContainer>
    </Box>
  );
};

export default ChatInterface; 