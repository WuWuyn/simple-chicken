"""
JWT Authentication utilities for Text-to-SQL Chatbot
"""

import os
import sys
from datetime import datetime, timedelta
from typing import Optional, Dict, Any
import jwt
from passlib.context import CryptContext
from fastapi import HTTPException, status, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import pyodbc
import logging

from ..core.config import settings
from ..models.schemas import UserInfo, TokenData

# Logging setup
logger = logging.getLogger(__name__)

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# JWT token scheme
security = HTTPBearer()

class AuthenticationError(Exception):
    """Custom authentication error"""
    pass

class MockAuthenticator:
    """Mock authentication for testing/demo when database is not available"""
    
    def __init__(self):
        # Test users
        self.test_users = {
            "he00001_user": {
                "user_id": "HE00001",
                "username": "he00001_user", 
                "password": "password",
                "fullname": "Nguyen Van A",
                "user_role": "Student",
                "user_gender": "Male",
                "user_dob": "2000-01-01",
                "user_address": "Ho Chi Minh City"
            },
            "lec001_user": {
                "user_id": "LEC001",
                "username": "lec001_user",
                "password": "password", 
                "fullname": "Dr. Tran Thi B",
                "user_role": "Lecturer",
                "user_gender": "Female",
                "user_dob": "1980-05-15",
                "user_address": "Ha Noi"
            },
            "tm001_user": {
                "user_id": "TM001",
                "username": "tm001_user",
                "password": "password",
                "fullname": "Le Van C", 
                "user_role": "Training Manager",
                "user_gender": "Male",
                "user_dob": "1975-12-10",
                "user_address": "Da Nang"
            }
        }
    
    async def authenticate_user(self, username: str, password: str) -> Optional[UserInfo]:
        """Mock authentication"""
        logger.info(f"🔍 Mock authentication attempt: {username}")
        
        if username not in self.test_users:
            logger.warning(f"❌ User not found: {username}")
            return None
        
        user_data = self.test_users[username]
        
        if password != user_data["password"]:
            logger.warning(f"❌ Invalid password for user: {username}")
            return None
        
        # Create UserInfo object
        user_info = UserInfo(
            user_id=user_data["user_id"],
            username=user_data["username"],
            fullname=user_data["fullname"], 
            user_role=user_data["user_role"],
            user_gender=user_data["user_gender"],
            user_dob=user_data["user_dob"],
            user_address=user_data["user_address"]
        )
        
        logger.info(f"✅ Mock authentication successful: {username} ({user_data['user_id']})")
        return user_info

class DatabaseAuthenticator:
    """Database-based authentication using existing MS SQL Server"""
    
    def __init__(self):
        self.connection_string = self._build_connection_string()
    
    def _build_connection_string(self) -> str:
        """Build MS SQL Server connection string"""
        return (
            f"DRIVER={{{settings.DB_DRIVER}}};"
            f"SERVER={settings.DB_SERVER};"
            f"DATABASE={settings.DB_NAME};"
            f"UID={settings.DB_USERNAME};"
            f"PWD={settings.DB_PASSWORD};"
            "TrustServerCertificate=yes;"
        )
    
    async def authenticate_user(self, username: str, password: str) -> Optional[UserInfo]:
        """
        Authenticate user against existing database
        
        Args:
            username: User's username
            password: Plain text password
            
        Returns:
            UserInfo if authenticated, None otherwise
        """
        try:
            # Connect to database
            conn = pyodbc.connect(self.connection_string)
            cursor = conn.cursor()
            
            # Query user information with role
            query = """
            SELECT 
                u.user_id,
                u.username,
                u.password,
                u.fullname,
                u.user_gender,
                u.user_dob,
                u.user_address,
                r.role_name
            FROM Users u
            LEFT JOIN UserRole ur ON u.user_id = ur.user_id
            LEFT JOIN Roles r ON ur.role_id = r.role_id
            WHERE u.username = ?
            """
            
            cursor.execute(query, (username,))
            user_data = cursor.fetchone()
            
            if not user_data:
                logger.warning(f"User not found: {username}")
                return None
            
            # Extract user information
            (user_id, db_username, db_password, fullname, 
             user_gender, user_dob, user_address, role_name) = user_data
            
            # Verify password (assuming plain text for demo - in production use hashed passwords)
            if not self._verify_password(password, db_password):
                logger.warning(f"Invalid password for user: {username}")
                return None
            
            # Convert date to string if present
            user_dob_str = user_dob.strftime("%Y-%m-%d") if user_dob else None
            
            # Create UserInfo object
            user_info = UserInfo(
                user_id=user_id,
                username=db_username,
                fullname=fullname,
                user_role=role_name or "Student",  # Default role
                user_gender=user_gender,
                user_dob=user_dob_str,
                user_address=user_address
            )
            
            logger.info(f"User authenticated successfully: {username} ({user_id})")
            return user_info
            
        except pyodbc.Error as e:
            logger.error(f"Database error during authentication: {e}")
            return None
        except Exception as e:
            logger.error(f"Unexpected error during authentication: {e}")
            return None
        finally:
            if 'conn' in locals():
                conn.close()
    
    def _verify_password(self, plain_password: str, hashed_password: str) -> bool:
        """
        Verify password. For demo purposes, using plain text comparison.
        In production, use proper password hashing.
        """
        # For demo - assuming passwords are stored as plain text
        # In production: return pwd_context.verify(plain_password, hashed_password)
        return plain_password == hashed_password

class JWTManager:
    """JWT token management"""
    
    @staticmethod
    def create_access_token(data: Dict[str, Any], expires_delta: Optional[timedelta] = None) -> str:
        """Create JWT access token"""
        to_encode = data.copy()
        
        if expires_delta:
            expire = datetime.utcnow() + expires_delta
        else:
            expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
        
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
        return encoded_jwt
    
    @staticmethod
    def create_refresh_token(data: Dict[str, Any]) -> str:
        """Create JWT refresh token"""
        to_encode = data.copy()
        expire = datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
        to_encode.update({"exp": expire, "type": "refresh"})
        encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
        return encoded_jwt
    
    @staticmethod
    def verify_token(token: str) -> TokenData:
        """Verify and decode JWT token"""
        try:
            payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
            
            user_id: str = payload.get("user_id")
            user_role: str = payload.get("user_role")
            username: str = payload.get("username")
            exp: datetime = datetime.fromtimestamp(payload.get("exp"))
            
            if user_id is None or user_role is None:
                raise AuthenticationError("Invalid token payload")
            
            return TokenData(
                user_id=user_id,
                user_role=user_role,
                username=username,
                exp=exp
            )
            
        except jwt.ExpiredSignatureError:
            raise AuthenticationError("Token has expired")
        except jwt.JWTError:
            raise AuthenticationError("Invalid token")

# Global instances - Use Database for real authentication
# Check if user wants to use mock mode via environment variable
use_mock_auth = os.getenv("USE_MOCK_AUTH", "false").lower() in ('true', '1', 'yes', 'on')

if use_mock_auth:
    logger.info("🧪 Using MockAuthenticator (USE_MOCK_AUTH=true)")
    db_auth = MockAuthenticator()
else:
    logger.info("🔒 Using DatabaseAuthenticator for real users")
    db_auth = DatabaseAuthenticator()

jwt_manager = JWTManager()

# FastAPI Dependencies
async def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)) -> TokenData:
    """
    FastAPI dependency to get current authenticated user from JWT token
    """
    try:
        token = credentials.credentials
        token_data = jwt_manager.verify_token(token)
        return token_data
    except AuthenticationError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e),
            headers={"WWW-Authenticate": "Bearer"},
        )

async def get_current_active_user(current_user: TokenData = Depends(get_current_user)) -> TokenData:
    """
    FastAPI dependency to get current active user
    """
    # Additional checks can be added here (user active status, etc.)
    return current_user

# Utility functions
def hash_password(password: str) -> str:
    """Hash password using bcrypt"""
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify password against hash"""
    return pwd_context.verify(plain_password, hashed_password)

def create_user_tokens(user_info: UserInfo) -> Dict[str, Any]:
    """Create both access and refresh tokens for user"""
    
    token_data = {
        "user_id": user_info.user_id,
        "user_role": user_info.user_role,
        "username": user_info.username
    }
    
    access_token = jwt_manager.create_access_token(data=token_data)
    refresh_token = jwt_manager.create_refresh_token(data=token_data)
    
    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer",
        "expires_in": settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60,  # seconds
        "user_info": user_info
    } 