"""
Authentication endpoints for Text-to-SQL Chatbot API
"""

from datetime import datetime
from fastapi import APIRouter, HTTPException, status, Depends
from fastapi.security import HTTPAuthorizationCredentials
import logging

from ...models.schemas import (
    UserLogin, TokenResponse, APIResponse, UserStatusResponse, UserInfo
)
from ...utils.auth import (
    db_auth, jwt_manager, get_current_user, get_current_active_user, 
    create_user_tokens, TokenData, AuthenticationError
)
from ...core.config import settings

# Setup logging
logger = logging.getLogger(__name__)

# Create router
router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/login", response_model=TokenResponse)
async def login(login_data: UserLogin):
    """
    User login endpoint
    
    Authenticates user against MS SQL Server database and returns JWT tokens
    """
    try:
        logger.info(f"Login attempt for username: {login_data.username}")
        
        # Authenticate user
        user_info = await db_auth.authenticate_user(
            username=login_data.username,
            password=login_data.password
        )
        
        if not user_info:
            logger.warning(f"Authentication failed for username: {login_data.username}")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid username or password",
                headers={"WWW-Authenticate": "Bearer"},
            )
        
        # Create tokens
        token_data = create_user_tokens(user_info)
        
        logger.info(f"User logged in successfully: {user_info.username} ({user_info.user_id})")
        
        return TokenResponse(**token_data)
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Login error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Internal server error during authentication"
        )

@router.post("/logout", response_model=APIResponse)
async def logout(current_user: TokenData = Depends(get_current_active_user)):
    """
    User logout endpoint
    
    In a more complex implementation, this would invalidate the token
    """
    try:
        logger.info(f"User logged out: {current_user.username} ({current_user.user_id})")
        
        return APIResponse(
            success=True,
            message="Logged out successfully",
            timestamp=datetime.utcnow()
        )
        
    except Exception as e:
        logger.error(f"Logout error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Internal server error during logout"
        )

@router.get("/me", response_model=UserStatusResponse)
async def get_current_user_info(current_user: TokenData = Depends(get_current_active_user)):
    """
    Get current user information from JWT token
    """
    try:
        # Create UserInfo from TokenData
        user_info = UserInfo(
            user_id=current_user.user_id,
            username=current_user.username,
            fullname="",  # Would need to fetch from database for complete info
            user_role=current_user.user_role
        )
        
        return UserStatusResponse(
            authenticated=True,
            user_info=user_info,
            session_expires_at=current_user.exp
        )
        
    except Exception as e:
        logger.error(f"Get user info error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Error retrieving user information"
        )

@router.post("/refresh", response_model=TokenResponse)
async def refresh_token(refresh_token: str):
    """
    Refresh access token using refresh token
    """
    try:
        # Verify refresh token
        token_data = jwt_manager.verify_token(refresh_token)
        
        # Get user info from database (to ensure user still exists and is active)
        # This is a simplified version - in production, you'd validate the refresh token properly
        
        # Create new tokens
        new_token_data = {
            "user_id": token_data.user_id,
            "user_role": token_data.user_role,
            "username": token_data.username
        }
        
        access_token = jwt_manager.create_access_token(data=new_token_data)
        new_refresh_token = jwt_manager.create_refresh_token(data=new_token_data)
        
        user_info = UserInfo(
            user_id=token_data.user_id,
            username=token_data.username,
            fullname="",
            user_role=token_data.user_role
        )
        
        return TokenResponse(
            access_token=access_token,
            refresh_token=new_refresh_token,
            token_type="bearer",
            expires_in=settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60,
            user_info=user_info
        )
        
    except AuthenticationError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e),
            headers={"WWW-Authenticate": "Bearer"},
        )
    except Exception as e:
        logger.error(f"Token refresh error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Error refreshing token"
        )

@router.get("/validate", response_model=APIResponse)
async def validate_token(current_user: TokenData = Depends(get_current_user)):
    """
    Validate JWT token
    """
    try:
        return APIResponse(
            success=True,
            message="Token is valid",
            data={
                "user_id": current_user.user_id,
                "user_role": current_user.user_role,
                "username": current_user.username,
                "expires_at": current_user.exp.isoformat()
            },
            timestamp=datetime.utcnow()
        )
        
    except Exception as e:
        logger.error(f"Token validation error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Error validating token"
        ) 