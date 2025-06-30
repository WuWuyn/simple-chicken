"""
Query Caching Service for Text-to-SQL Chatbot
Implements intelligent caching for query results and SQL generation
"""

import json
import hashlib
import time
from typing import Dict, Any, Optional, Tuple
from datetime import datetime, timedelta
from dataclasses import dataclass, asdict
import logging

from ..core.config import settings

# Setup logging
logger = logging.getLogger(__name__)

@dataclass
class CacheEntry:
    """Cache entry structure"""
    key: str
    user_id: str
    user_role: str
    question: str
    sql_query: str
    results: Any
    execution_time_ms: float
    confidence_score: float
    created_at: str
    expires_at: str
    hit_count: int = 0
    last_accessed: str = ""
    
    def __post_init__(self):
        if not self.last_accessed:
            self.last_accessed = self.created_at

@dataclass
class CacheStats:
    """Cache statistics"""
    total_entries: int
    cache_hits: int
    cache_misses: int
    hit_rate: float
    total_size_mb: float
    avg_execution_time_saved: float

class QueryCacheService:
    """
    Intelligent query caching service with:
    - Role-based cache isolation
    - Query similarity detection
    - LRU eviction policy
    - Performance optimization
    """
    
    def __init__(self):
        # Cache storage
        self.cache: Dict[str, CacheEntry] = {}
        
        # Cache statistics
        self.stats = {
            "hits": 0,
            "misses": 0,
            "evictions": 0,
            "total_saved_time": 0.0,
        }
        
        # LRU tracking
        self.access_order = []  # Most recently used last
        
        # Cache configuration
        self.max_entries = 1000
        self.default_ttl = settings.QUERY_CACHE_TTL
        self.enabled = settings.ENABLE_QUERY_CACHING
        
        logger.info(f"Query cache service initialized (enabled: {self.enabled})")
    
    def generate_cache_key(self, user_role: str, question: str, context: Optional[Dict] = None) -> str:
        """
        Generate cache key for query
        
        Keys are role-specific to prevent data leakage between user roles
        """
        # Normalize question for consistent caching
        normalized_question = self._normalize_question(question)
        
        # Include user role for isolation
        key_data = {
            "role": user_role,
            "question": normalized_question,
            "context": context or {}
        }
        
        # Create hash of the key data
        key_json = json.dumps(key_data, sort_keys=True)
        cache_key = hashlib.md5(key_json.encode()).hexdigest()
        
        return f"{user_role}:{cache_key}"
    
    def get(self, user_role: str, question: str, user_id: str, context: Optional[Dict] = None) -> Optional[CacheEntry]:
        """
        Get cached query result
        
        Returns cached entry if available and not expired
        """
        if not self.enabled:
            return None
        
        cache_key = self.generate_cache_key(user_role, question, context)
        
        if cache_key not in self.cache:
            self.stats["misses"] += 1
            logger.debug(f"Cache miss for key: {cache_key}")
            return None
        
        entry = self.cache[cache_key]
        
        # Check if entry has expired
        if self._is_expired(entry):
            self._remove_entry(cache_key)
            self.stats["misses"] += 1
            logger.debug(f"Cache entry expired for key: {cache_key}")
            return None
        
        # Update access tracking
        entry.hit_count += 1
        entry.last_accessed = datetime.utcnow().isoformat()
        self._update_access_order(cache_key)
        
        self.stats["hits"] += 1
        self.stats["total_saved_time"] += entry.execution_time_ms
        
        logger.debug(f"Cache hit for key: {cache_key} (hit count: {entry.hit_count})")
        return entry
    
    def put(
        self, 
        user_role: str, 
        question: str, 
        user_id: str,
        sql_query: str,
        results: Any,
        execution_time_ms: float,
        confidence_score: float = 0.0,
        context: Optional[Dict] = None,
        ttl: Optional[int] = None
    ) -> str:
        """
        Store query result in cache
        
        Returns the cache key
        """
        if not self.enabled:
            return ""
        
        cache_key = self.generate_cache_key(user_role, question, context)
        
        # Calculate expiry time
        ttl = ttl or self.default_ttl
        created_at = datetime.utcnow()
        expires_at = created_at + timedelta(seconds=ttl)
        
        # Create cache entry
        entry = CacheEntry(
            key=cache_key,
            user_id=user_id,
            user_role=user_role,
            question=question,
            sql_query=sql_query,
            results=results,
            execution_time_ms=execution_time_ms,
            confidence_score=confidence_score,
            created_at=created_at.isoformat(),
            expires_at=expires_at.isoformat(),
            hit_count=0
        )
        
        # Check if we need to evict entries
        if len(self.cache) >= self.max_entries:
            self._evict_lru_entries()
        
        # Store entry
        self.cache[cache_key] = entry
        self._update_access_order(cache_key)
        
        logger.debug(f"Cached query result for key: {cache_key}")
        return cache_key
    
    def invalidate_user_cache(self, user_id: str):
        """Invalidate all cache entries for a specific user"""
        keys_to_remove = [
            key for key, entry in self.cache.items()
            if entry.user_id == user_id
        ]
        
        for key in keys_to_remove:
            self._remove_entry(key)
        
        logger.info(f"Invalidated {len(keys_to_remove)} cache entries for user {user_id}")
    
    def invalidate_role_cache(self, user_role: str):
        """Invalidate all cache entries for a specific role"""
        keys_to_remove = [
            key for key, entry in self.cache.items()
            if entry.user_role == user_role
        ]
        
        for key in keys_to_remove:
            self._remove_entry(key)
        
        logger.info(f"Invalidated {len(keys_to_remove)} cache entries for role {user_role}")
    
    def clear_cache(self):
        """Clear all cache entries"""
        entry_count = len(self.cache)
        self.cache.clear()
        self.access_order.clear()
        
        logger.info(f"Cleared {entry_count} cache entries")
    
    def get_cache_stats(self) -> CacheStats:
        """Get comprehensive cache statistics"""
        total_requests = self.stats["hits"] + self.stats["misses"]
        hit_rate = (self.stats["hits"] / total_requests * 100) if total_requests > 0 else 0
        
        # Calculate cache size (approximate)
        total_size_mb = len(json.dumps([asdict(entry) for entry in self.cache.values()])) / (1024 * 1024)
        
        # Calculate average execution time saved
        avg_time_saved = (self.stats["total_saved_time"] / self.stats["hits"]) if self.stats["hits"] > 0 else 0
        
        return CacheStats(
            total_entries=len(self.cache),
            cache_hits=self.stats["hits"],
            cache_misses=self.stats["misses"],
            hit_rate=round(hit_rate, 2),
            total_size_mb=round(total_size_mb, 2),
            avg_execution_time_saved=round(avg_time_saved, 2)
        )
    
    def get_cache_entries_info(self, limit: int = 20) -> list[Dict[str, Any]]:
        """Get information about cache entries (for debugging/monitoring)"""
        entries_info = []
        
        # Sort by hit count and last accessed
        sorted_entries = sorted(
            self.cache.values(),
            key=lambda x: (x.hit_count, x.last_accessed),
            reverse=True
        )
        
        for entry in sorted_entries[:limit]:
            entries_info.append({
                "key": entry.key[:16] + "...",  # Truncate for display
                "user_role": entry.user_role,
                "question": entry.question[:50] + "..." if len(entry.question) > 50 else entry.question,
                "hit_count": entry.hit_count,
                "execution_time_ms": entry.execution_time_ms,
                "confidence_score": entry.confidence_score,
                "created_at": entry.created_at,
                "last_accessed": entry.last_accessed,
                "expires_at": entry.expires_at
            })
        
        return entries_info
    
    def find_similar_queries(self, question: str, user_role: str, threshold: float = 0.8) -> list[CacheEntry]:
        """
        Find similar cached queries using simple text similarity
        Useful for query suggestion and optimization
        """
        similar_entries = []
        normalized_question = self._normalize_question(question).lower()
        
        for entry in self.cache.values():
            if entry.user_role != user_role:
                continue
            
            # Simple similarity calculation using word overlap
            similarity = self._calculate_similarity(
                normalized_question,
                self._normalize_question(entry.question).lower()
            )
            
            if similarity >= threshold:
                similar_entries.append(entry)
        
        # Sort by similarity (hit count as tiebreaker)
        similar_entries.sort(key=lambda x: x.hit_count, reverse=True)
        
        return similar_entries[:5]  # Return top 5 similar queries
    
    def _normalize_question(self, question: str) -> str:
        """Normalize question text for consistent caching"""
        import re
        
        # Convert to lowercase
        normalized = question.lower().strip()
        
        # Replace multiple spaces with single space
        normalized = re.sub(r'\s+', ' ', normalized)
        
        # Remove punctuation except important SQL-related characters
        normalized = re.sub(r'[^\w\s\-_\.\?]', '', normalized)
        
        # Replace common patterns for better cache hits
        # Replace specific values with placeholders
        normalized = re.sub(r'\b\d{4}-\d{2}-\d{2}\b', '[DATE]', normalized)  # Dates
        normalized = re.sub(r'\b\d+\b', '[NUMBER]', normalized)  # Numbers
        normalized = re.sub(r'\b[a-z]+\d+[a-z]*\b', '[ID]', normalized)  # IDs like "he00001"
        
        return normalized.strip()
    
    def _calculate_similarity(self, text1: str, text2: str) -> float:
        """Calculate simple word-based similarity between two texts"""
        words1 = set(text1.split())
        words2 = set(text2.split())
        
        if not words1 or not words2:
            return 0.0
        
        intersection = words1.intersection(words2)
        union = words1.union(words2)
        
        # Jaccard similarity
        return len(intersection) / len(union)
    
    def _is_expired(self, entry: CacheEntry) -> bool:
        """Check if cache entry has expired"""
        now = datetime.utcnow()
        expires_at = datetime.fromisoformat(entry.expires_at.replace('Z', '+00:00'))
        return now > expires_at
    
    def _update_access_order(self, cache_key: str):
        """Update LRU access order"""
        if cache_key in self.access_order:
            self.access_order.remove(cache_key)
        self.access_order.append(cache_key)
    
    def _remove_entry(self, cache_key: str):
        """Remove entry from cache and access order"""
        if cache_key in self.cache:
            del self.cache[cache_key]
        
        if cache_key in self.access_order:
            self.access_order.remove(cache_key)
    
    def _evict_lru_entries(self, count: int = 1):
        """Evict least recently used entries"""
        for _ in range(min(count, len(self.access_order))):
            if self.access_order:
                lru_key = self.access_order.pop(0)  # Remove oldest
                if lru_key in self.cache:
                    del self.cache[lru_key]
                    self.stats["evictions"] += 1
                    logger.debug(f"Evicted LRU cache entry: {lru_key}")
    
    def cleanup_expired_entries(self):
        """Remove all expired cache entries"""
        expired_keys = [
            key for key, entry in self.cache.items()
            if self._is_expired(entry)
        ]
        
        for key in expired_keys:
            self._remove_entry(key)
        
        if expired_keys:
            logger.info(f"Cleaned up {len(expired_keys)} expired cache entries")

# Global cache instance
query_cache = QueryCacheService()

def get_query_cache() -> QueryCacheService:
    """Dependency to get query cache service"""
    return query_cache 