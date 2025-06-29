"""
Text-to-SQL Pipeline Wrapper for FastAPI Integration
"""

import os
import sys
import time
import logging
import uuid
from typing import Dict, Any, Optional
from pathlib import Path

from ..models.schemas import PipelineRequest, PipelineResponse
from ..core.config import settings
from .analytics import get_analytics_service, QueryMetrics
from .query_cache import get_query_cache

# Setup logging
logger = logging.getLogger(__name__)

class PipelineIntegrationError(Exception):
    """Custom pipeline integration error"""
    pass

class TextToSQLPipelineWrapper:
    """
    Wrapper class to integrate existing Text-to-SQL pipeline with FastAPI
    """
    
    def __init__(self):
        self.pipeline = None
        self.pipeline_ready = False
        self._setup_pipeline_path()
        self._initialize_pipeline()
    
    def _setup_pipeline_path(self):
        """Setup Python path to include Text-to-SQL pipeline"""
        try:
            # Get the path to the Method directory
            # From: backend/app/utils/pipeline_wrapper.py
            # To:   ../../Method (need 5 levels up to reach PythonTextToSql/)
            current_dir = Path(__file__).parent.parent.parent.parent.parent
            pipeline_path = current_dir / "Method"
            
            if pipeline_path.exists():
                pipeline_path_str = str(pipeline_path.absolute())
                if pipeline_path_str not in sys.path:
                    sys.path.insert(0, pipeline_path_str)
                logger.info(f"Added pipeline path: {pipeline_path_str}")
            else:
                logger.warning(f"Pipeline path not found: {pipeline_path}")
                
        except Exception as e:
            logger.error(f"Failed to setup pipeline path: {e}")
    
    def _initialize_pipeline(self):
        """Initialize the Text-to-SQL pipeline with fallback modes"""
        try:
            # Try to import the main pipeline and config
            try:
                from main_pipeline import TextToSQLPipeline
                from pipeline_config import get_config_for_environment, resolve_paths
                logger.info("✅ Successfully imported Method pipeline components")
            except ImportError as import_err:
                logger.error(f"Failed to import Method pipeline: {import_err}")
                raise import_err
            
            # Get proper Method pipeline configuration
            method_config = get_config_for_environment(
                env="production" if not settings.DEBUG else "development"
            )
            
            # Resolve paths relative to Method directory
            method_config = resolve_paths(method_config)
            
            # Override with chatbot-specific settings
            if settings.PIPELINE_MOCK_MODE:
                # Use testing config for mock mode
                from pipeline_config import get_testing_config
                method_config = get_testing_config()
            
            # Add chatbot enhancements
            method_config.enable_caching = settings.ENABLE_QUERY_CACHING
            method_config.query_timeout_seconds = settings.QUERY_TIMEOUT_SECONDS
            method_config.log_level = settings.LOG_LEVEL
            
            logger.info(f"Initializing Method pipeline with config: {method_config}")
            self.pipeline = TextToSQLPipeline(config=method_config)
            
            # Enhanced pipeline readiness check
            status = self.pipeline.get_pipeline_status()
            self.pipeline_ready = status.get("ready", False)
            
            if self.pipeline_ready:
                logger.info("Text-to-SQL pipeline initialized successfully")
                logger.info(f"Pipeline modules: {status.get('modules', {})}")
            else:
                logger.warning("Text-to-SQL pipeline initialized but not fully ready")
                logger.info(f"Pipeline status: {status}")
                # Try fallback to testing/mock mode
                if not getattr(method_config, 'use_gemini_llm', True):
                    self.pipeline_ready = True  # Already in testing mode
                else:
                    logger.info("Falling back to testing configuration")
                    from pipeline_config import get_testing_config
                    fallback_config = get_testing_config()
                    self.pipeline = TextToSQLPipeline(config=fallback_config)
                    self.pipeline_ready = True
                
        except ImportError as e:
            logger.error(f"Failed to import pipeline: {e}")
            logger.info("Using built-in mock pipeline")
            self.pipeline_ready = True  # Use built-in mock
            self.pipeline = None
        except Exception as e:
            logger.error(f"Failed to initialize pipeline: {e}")
            logger.info("Falling back to built-in mock pipeline")
            self.pipeline_ready = True  # Use built-in mock
            self.pipeline = None
    
    def is_ready(self) -> bool:
        """Check if pipeline is ready"""
        return self.pipeline_ready and self.pipeline is not None
    
    def get_status(self) -> Dict[str, Any]:
        """Get pipeline status information"""
        if not self.pipeline:
            return {
                "ready": False,
                "error": "Pipeline not initialized",
                "modules": {}
            }
        
        try:
            return self.pipeline.get_pipeline_status()
        except Exception as e:
            logger.error(f"Failed to get pipeline status: {e}")
            return {
                "ready": False,
                "error": str(e),
                "modules": {}
            }
    
    async def process_query(self, request: PipelineRequest) -> PipelineResponse:
        """
        Process a user query through the Text-to-SQL pipeline with analytics and caching
        
        Args:
            request: PipelineRequest containing user question and context
            
        Returns:
            PipelineResponse with results or error information
        """
        if not self.is_ready():
            return PipelineResponse(
                status="error",
                success=False,
                execution_time_ms=0.0,
                error_message="Pipeline not ready or not initialized"
            )
        
        start_time = time.time()
        query_id = str(uuid.uuid4())
        
        # Get analytics and cache services
        analytics = get_analytics_service()
        cache = get_query_cache()
        
        try:
            logger.info(f"Processing query for user {request.user_id}: {request.user_question}")
            
            # Check cache first
            cached_entry = cache.get(
                user_role=request.user_role,
                question=request.user_question,
                user_id=request.user_id,
                context=request.additional_context
            )
            
            if cached_entry:
                # Cache hit - return cached result
                analytics.track_cache_hit()
                execution_time = (time.time() - start_time) * 1000
                
                logger.info(f"Cache hit for query {query_id} in {execution_time:.2f}ms")
                
                # Track analytics for cache hit
                analytics.track_query(QueryMetrics(
                    query_id=query_id,
                    user_id=request.user_id,
                    user_role=request.user_role,
                    question=request.user_question,
                    sql_query=cached_entry.sql_query,
                    execution_time_ms=execution_time,
                    success=True,
                    result_count=len(cached_entry.results) if isinstance(cached_entry.results, list) else 1,
                    confidence_score=cached_entry.confidence_score
                ))
                
                # Return cached response
                return PipelineResponse(
                    status="success",
                    success=True,
                    execution_time_ms=execution_time,
                    sql_result={
                        "success": True,
                        "generated_sql": cached_entry.sql_query,
                        "execution_result": cached_entry.results,
                        "confidence_score": cached_entry.confidence_score,
                        "execution_time_ms": cached_entry.execution_time_ms
                    }
                )
            
            # Cache miss - process through pipeline
            analytics.track_cache_miss()
            
            # Process query through pipeline
            result = self.pipeline.process_query(
                user_question=request.user_question,
                user_id=request.user_id,
                user_role=request.user_role,
                timestamp=request.timestamp,
                **request.additional_context or {}
            )
            
            execution_time = (time.time() - start_time) * 1000
            
            # Convert pipeline result to our response format
            pipeline_response = PipelineResponse(
                status=result.status.value if hasattr(result.status, 'value') else str(result.status),
                success=result.success,
                execution_time_ms=execution_time,
                error_message=result.error_message,
                blocked_at_step=result.blocked_at_step
            )
            
            # Add detailed results if available
            if result.security_result:
                pipeline_response.security_result = {
                    "is_safe": result.security_result.is_safe,
                    "violations": result.security_result.violations,
                    "details": result.security_result.details
                }
            
            if result.value_retrieval_result:
                pipeline_response.value_retrieval_result = {
                    "keywords": getattr(result.value_retrieval_result, 'keywords', []),
                    "entity_matches": len(getattr(result.value_retrieval_result, 'entity_matches', [])),
                    "confidence_score": getattr(result.value_retrieval_result, 'confidence_score', 0.0)
                }
            
            if result.permission_result:
                pipeline_response.permission_result = {
                    "decision": str(result.permission_result.decision) if hasattr(result.permission_result.decision, 'value') else str(result.permission_result.decision),
                    "reasoning": result.permission_result.reasoning
                }
            
            if result.sql_result:
                pipeline_response.sql_result = {
                    "success": result.sql_result.success,
                    "generated_sql": result.sql_result.generated_sql,
                    "execution_result": result.sql_result.execution_result,
                    "confidence_score": result.sql_result.confidence_score,
                    "execution_time_ms": result.sql_result.execution_time_ms
                }
            
            # Track analytics for this query
            analytics.track_query(QueryMetrics(
                query_id=query_id,
                user_id=request.user_id,
                user_role=request.user_role,
                question=request.user_question,
                sql_query=result.sql_result.generated_sql if result.sql_result else "",
                execution_time_ms=execution_time,
                success=result.success,
                error_message=result.error_message,
                blocked_at_step=result.blocked_at_step,
                result_count=len(result.sql_result.execution_result) if result.sql_result and isinstance(result.sql_result.execution_result, list) else 0,
                confidence_score=result.sql_result.confidence_score if result.sql_result else 0.0
            ))
            
            # Cache successful results for future use
            if result.success and result.sql_result and result.sql_result.success:
                cache.put(
                    user_role=request.user_role,
                    question=request.user_question,
                    user_id=request.user_id,
                    sql_query=result.sql_result.generated_sql,
                    results=result.sql_result.execution_result,
                    execution_time_ms=execution_time,
                    confidence_score=result.sql_result.confidence_score,
                    context=request.additional_context
                )
                logger.debug(f"Cached successful query result for user {request.user_id}")
            
            logger.info(f"Query processed successfully in {execution_time:.2f}ms")
            return pipeline_response
            
        except Exception as e:
            execution_time = (time.time() - start_time) * 1000
            error_message = f"Pipeline processing failed: {str(e)}"
            logger.error(error_message)
            
            # Track analytics for failed query
            analytics.track_query(QueryMetrics(
                query_id=query_id,
                user_id=request.user_id,
                user_role=request.user_role,
                question=request.user_question,
                sql_query="",
                execution_time_ms=execution_time,
                success=False,
                error_message=error_message,
                blocked_at_step="pipeline_exception"
            ))
            
            return PipelineResponse(
                status="error",
                success=False,
                execution_time_ms=execution_time,
                error_message=error_message
            )
    
    def create_mock_response(self, request: PipelineRequest) -> PipelineResponse:
        """
        Create a mock response for testing purposes
        """
        mock_sql = f"""
        SELECT c.course_name, e.average, e.status
        FROM Enrollments e 
        JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
        JOIN Courses c ON cc.course_id = c.course_id 
        WHERE e.student_id = '{request.user_id}' 
        AND cc.semester = 'SU24'
        ORDER BY c.course_name;
        """
        
        mock_results = [
            {
                "course_name": "Artificial Intelligence and Machine Learning",
                "average": 8.5,
                "status": "Studying"
            },
            {
                "course_name": "Data Structures and Algorithms", 
                "average": 9.0,
                "status": "Passed"
            }
        ]
        
        return PipelineResponse(
            status="success",
            success=True,
            execution_time_ms=45.2,
            sql_result={
                "success": True,
                "generated_sql": mock_sql.strip(),
                "execution_result": mock_results,
                "confidence_score": 0.85,
                "execution_time_ms": 23.1
            }
        )

# Global pipeline instance
pipeline_wrapper = TextToSQLPipelineWrapper()

def get_pipeline() -> TextToSQLPipelineWrapper:
    """Dependency to get pipeline wrapper"""
    return pipeline_wrapper 