"""
Demo Time Management Utility

Provides consistent fixed timestamp for demo purposes.
All components should use this instead of real datetime.
"""

import os
from datetime import datetime, timedelta
from typing import Optional

class DemoTimeManager:
    """Manages fixed timestamp for demo consistency"""
    
    # Fixed demo timestamp: 22:00 15/6/2024
    DEMO_TIMESTAMP = "22:00 15/6/2024"
    DEMO_DATE_FORMAT = "%H:%M %d/%m/%Y"
    
    @classmethod
    def _parse_demo_datetime(cls) -> datetime:
        """Parse demo timestamp string to datetime object"""
        try:
            return datetime.strptime(cls.DEMO_TIMESTAMP, cls.DEMO_DATE_FORMAT)
        except ValueError:
            # Fallback to a fixed datetime if parsing fails
            return datetime(2024, 6, 15, 22, 0, 0)
    
    @classmethod
    def get_demo_datetime(cls) -> datetime:
        """Get fixed demo datetime object"""
        return cls._parse_demo_datetime()
    
    @classmethod
    def get_demo_timestamp_string(cls) -> str:
        """Get fixed demo timestamp string"""
        return cls.DEMO_TIMESTAMP
    
    @classmethod
    def get_demo_iso_string(cls) -> str:
        """Get fixed demo timestamp in ISO format"""
        return cls.get_demo_datetime().isoformat()
    
    @classmethod
    def get_demo_timestamp_plus(cls, **kwargs) -> datetime:
        """
        Get demo timestamp plus specified time delta
        
        Args:
            **kwargs: Arguments for timedelta (days, hours, minutes, seconds)
            
        Returns:
            datetime: Demo timestamp + delta
        """
        base_time = cls.get_demo_datetime()
        delta = timedelta(**kwargs)
        return base_time + delta
    
    @classmethod
    def get_demo_timestamp_minus(cls, **kwargs) -> datetime:
        """
        Get demo timestamp minus specified time delta
        
        Args:
            **kwargs: Arguments for timedelta (days, hours, minutes, seconds)
            
        Returns:
            datetime: Demo timestamp - delta
        """
        base_time = cls.get_demo_datetime()
        delta = timedelta(**kwargs)
        return base_time - delta
    
    @classmethod
    def is_demo_mode(cls) -> bool:
        """Check if system is in demo mode"""
        return os.getenv("DEMO_MODE", "true").lower() == "true"
    
    @classmethod
    def get_current_time(cls) -> datetime:
        """
        Get current time - demo time if in demo mode, real time otherwise
        """
        if cls.is_demo_mode():
            return cls.get_demo_datetime()
        else:
            return datetime.utcnow()
    
    @classmethod
    def get_current_iso_string(cls) -> str:
        """
        Get current time as ISO string - demo time if in demo mode
        """
        return cls.get_current_time().isoformat()

# Convenience functions for easy import
def get_demo_time() -> datetime:
    """Get fixed demo datetime"""
    return DemoTimeManager.get_demo_datetime()

def get_demo_timestamp() -> str:
    """Get fixed demo timestamp string"""
    return DemoTimeManager.get_demo_timestamp_string()

def get_demo_iso() -> str:
    """Get fixed demo timestamp in ISO format"""
    return DemoTimeManager.get_demo_iso_string()

def get_current_time() -> datetime:
    """Get current time (demo or real based on mode)"""
    return DemoTimeManager.get_current_time()

def get_current_iso() -> str:
    """Get current time as ISO string (demo or real based on mode)"""
    return DemoTimeManager.get_current_iso_string()

# Constants for easy access
DEMO_TIMESTAMP = DemoTimeManager.DEMO_TIMESTAMP
DEMO_DATETIME = DemoTimeManager.get_demo_datetime()
DEMO_ISO = DemoTimeManager.get_demo_iso_string()