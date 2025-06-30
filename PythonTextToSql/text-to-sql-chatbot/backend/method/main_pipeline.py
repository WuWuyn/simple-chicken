"""
Text-to-SQL Pipeline System

Main orchestrator that coordinates:
1. Security Validation (pre_checking)
2. Value Retrieval (value_retrieval) 
3. Access Control (access_control)
4. SQL Generation (sql_generation)
"""

import os
import sys
import time
import logging
from typing import Dict, Any, Optional, List
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from dotenv import load_dotenv

load_dotenv()
# Import pipeline modules
try:
    from .Online.pre_checking.pre_checking import AdvancedSecurityChecker
    from .Online.value_retrieval.value_retrieval import ValueRetrievalSystem, ValueRetrievalResult
    from .Online.access_control.access_control import ComprehensivePermissionManager, PermissionResult, PermissionDecision
    from .Online.sql_generation.sql_generator import ComprehensiveSQLGenerator, SQLGenerationRequest, SQLGenerationResult
except ImportError:
    # Fallback for direct execution
    sys.path.append(os.path.dirname(os.path.abspath(__file__)))
    from Online.pre_checking.pre_checking import AdvancedSecurityChecker
    from Online.value_retrieval.value_retrieval import ValueRetrievalSystem, ValueRetrievalResult
    from Online.access_control.access_control import ComprehensivePermissionManager, PermissionResult, PermissionDecision
    from Online.sql_generation.sql_generator import ComprehensiveSQLGenerator, SQLGenerationRequest, SQLGenerationResult

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class PipelineStatus(Enum):
    """Pipeline execution status"""
    SUCCESS = "success"
    BLOCKED_SECURITY = "blocked_security"
    BLOCKED_PERMISSION = "blocked_permission"
    ERROR = "error"

@dataclass
class PipelineRequest:
    """Input request for the pipeline"""
    user_question: str
    user_id: str
    user_role: str
    timestamp: str
    additional_context: Dict[str, Any] = field(default_factory=dict)

@dataclass
class SecurityResult:
    """Security check result"""
    is_safe: bool
    violations: List[str]
    details: Dict[str, Any]

@dataclass
class PipelineResult:
    """Complete pipeline execution result"""
    status: PipelineStatus
    success: bool
    
    # Results from each step
    security_result: Optional[SecurityResult] = None
    value_retrieval_result: Optional[ValueRetrievalResult] = None
    permission_result: Optional[PermissionResult] = None
    sql_result: Optional[SQLGenerationResult] = None
    
    # Execution metadata
    execution_time_ms: float = 0.0
    blocked_at_step: Optional[str] = None
    error_message: Optional[str] = None
    detailed_results: Dict[str, Any] = field(default_factory=dict)

class TextToSQLPipeline:
    """Main Text-to-SQL Pipeline Orchestrator"""
    
    def __init__(self, config: Optional[Dict[str, Any]] = None):
        """Initialize the complete pipeline"""
        self.start_time = time.time()
        self.config = config or {}
        
        print("Initializing Text-to-SQL Pipeline...")
        
        # Initialize all modules
        self._init_security_checker()
        self._init_value_retrieval()
        self._init_access_control()
        self._init_sql_generator()
        
        initialization_time = (time.time() - self.start_time) * 1000
        print(f"Pipeline initialization completed in {initialization_time:.2f}ms")

    def _init_security_checker(self):
        """Initialize security checking module"""
        try:
            self.security_checker = AdvancedSecurityChecker()
            print("Security checker module loaded")
        except Exception as e:
            logger.error(f"Failed to initialize security checker: {e}")
            self.security_checker = None

    def _init_value_retrieval(self):
        """Initialize value retrieval module"""
        try:
            self.value_retrieval = ValueRetrievalSystem()
            print("Value retrieval module loaded")
        except Exception as e:
            logger.error(f"Failed to initialize value retrieval: {e}")
            self.value_retrieval = None

    def _init_access_control(self):
        """Initialize access control module"""
        try:
            # Build MS SQL Server connection string (same as SQL generator)
            db_connection_string = (
                f"DRIVER={{ODBC Driver 17 for SQL Server}};"
                f"SERVER=localhost;"
                f"DATABASE=text_to_sql_final;"
                f"UID=sa;"
                f"PWD=123456"
            )
            
            permissions_config_path = os.path.join(
                os.path.dirname(__file__), 
                "Online", "access_control", "permissions.json"
            )
            
            self.access_control = ComprehensivePermissionManager(
                db_connection_string=db_connection_string,
                permissions_config_path=permissions_config_path,
                mock_mode=True  # Still use mock mode for permissions
            )
            print("Access control module loaded with MS SQL Server connection")
        except Exception as e:
            logger.error(f"Failed to initialize access control: {e}")
            self.access_control = None

    def _init_sql_generator(self):
        """Initialize SQL generation module"""
        try:
            # Try MS SQL Server first, fallback to SQLite if needed
            # Check for environment variables or use defaults
            db_server = os.getenv('DB_SERVER', 'localhost')
            db_name = os.getenv('DB_NAME', 'text_to_sql_final')
            db_username = os.getenv('DB_USERNAME', 'sa')
            db_password = os.getenv('DB_PASSWORD', '123456')
            
            # Build MS SQL Server connection string
            mssql_connection_string = (
                f"DRIVER={{ODBC Driver 17 for SQL Server}};"
                f"SERVER={db_server};"
                f"DATABASE={db_name};"
                f"UID={db_username};"
                f"PWD={db_password}"
            )
            
            print(f"Attempting MS SQL Server connection to {db_server}/{db_name}...")
            
            self.sql_generator = ComprehensiveSQLGenerator(
                db_connection_string=mssql_connection_string
            )
            print("✅ SQL generator module loaded with MS SQL Server connection")
            
        except Exception as e:
            logger.error(f"Failed to initialize SQL generator with MS SQL Server: {e}")
            
            # Fallback to SQLite with sample data
            print("⚠️  Falling back to SQLite in-memory database for demo...")
            try:
                self.sql_generator = ComprehensiveSQLGenerator(
                    db_connection_string=":memory:"
                )
                print("✅ SQL generator module loaded with SQLite fallback")
            except Exception as fallback_error:
                logger.error(f"Failed to initialize SQL generator with SQLite fallback: {fallback_error}")
                self.sql_generator = None

    def process_query(self, 
                     user_question: str,
                     user_id: str, 
                     user_role: str,
                     timestamp: str,
                     **kwargs) -> PipelineResult:
        """Main pipeline execution method"""
        
        execution_start = time.time()
        
        # Create pipeline request
        request = PipelineRequest(
            user_question=user_question,
            user_id=user_id,
            user_role=user_role,
            timestamp=timestamp,
            additional_context=kwargs
        )
        
        logger.info(f"Processing query: {user_question} (User: {user_id}, Role: {user_role})")
        
        try:
            # Step 1: Security Check
            print("Step 1: Security validation...")
            security_result = self._step1_security_check(request)
            
            if not security_result.is_safe:
                total_time = (time.time() - execution_start) * 1000
                return PipelineResult(
                    status=PipelineStatus.BLOCKED_SECURITY,
                    success=False,
                    security_result=security_result,
                    execution_time_ms=total_time,
                    blocked_at_step="security_check",
                    error_message=f"Security violations: {', '.join(security_result.violations)}"
                )
            
            # Step 2: Value Retrieval
            print("Step 2: Value retrieval...")
            value_result = self._step2_value_retrieval(request)
            
            # Step 3: Access Control
            print("Step 3: Access control...")
            permission_result = self._step3_access_control(request, value_result)
            
            if permission_result and permission_result.decision == PermissionDecision.DENY:
                total_time = (time.time() - execution_start) * 1000
                return PipelineResult(
                    status=PipelineStatus.BLOCKED_PERMISSION,
                    success=False,
                    security_result=security_result,
                    value_retrieval_result=value_result,
                    permission_result=permission_result,
                    execution_time_ms=total_time,
                    blocked_at_step="access_control",
                    error_message=permission_result.reasoning
                )
            
            # Step 4: SQL Generation
            print("Step 4: SQL generation and execution...")
            sql_result = self._step4_sql_generation(request, value_result, permission_result)
            
            # Success case
            total_time = (time.time() - execution_start) * 1000
            
            return PipelineResult(
                status=PipelineStatus.SUCCESS,
                success=True,
                security_result=security_result,
                value_retrieval_result=value_result,
                permission_result=permission_result,
                sql_result=sql_result,
                execution_time_ms=total_time,
                detailed_results={
                    "steps_completed": 4,
                    "final_status": "completed_successfully"
                }
            )
            
        except Exception as e:
            total_time = (time.time() - execution_start) * 1000
            error_message = f"Pipeline execution failed: {str(e)}"
            logger.error(error_message)
            
            return PipelineResult(
                status=PipelineStatus.ERROR,
                success=False,
                execution_time_ms=total_time,
                error_message=error_message
            )

    def _step1_security_check(self, request: PipelineRequest) -> SecurityResult:
        """Step 1: Security validation"""
        if not self.security_checker:
            logger.warning("Security checker not available, skipping validation")
            return SecurityResult(
                is_safe=True,
                violations=[],
                details={"warning": "security_checker_not_available"}
            )
        
        # Prepare security check data
        security_data = {
            "Query": request.user_question,
            "Id": request.user_id,
            "Role": request.user_role,
            "Time": request.timestamp
        }
        
        # Execute security check
        security_response = self.security_checker.main_security_check(security_data)
        
        # Convert to standardized result
        is_safe = security_response.get("status") == "SAFE"
        violations = security_response.get("violations", [])
        
        return SecurityResult(
            is_safe=is_safe,
            violations=violations,
            details=security_response.get("details", {})
        )

    def _step2_value_retrieval(self, request: PipelineRequest) -> Optional[ValueRetrievalResult]:
        """Step 2: Value retrieval"""
        if not self.value_retrieval:
            logger.warning("Value retrieval module not available")
            return None
        
        # Execute value retrieval
        result = self.value_retrieval.process_query(
            query=request.user_question,
            user_info={
                "user_id": request.user_id,
                "user_role": request.user_role,
                "timestamp": request.timestamp
            }
        )
        
        return result

    def _step3_access_control(self, 
                             request: PipelineRequest, 
                             value_result: Optional[ValueRetrievalResult]) -> Optional[PermissionResult]:
        """Step 3: Access control"""
        if not self.access_control:
            logger.warning("Access control module not available")
            return None
        
        # Create context from value retrieval results
        context = {
            "operation": "SELECT",
            "tables": ["Students", "Courses", "Enrollments"],  # Default tables
            "columns": []
        }
        
        if value_result:
            # Extract table information from entity matches
            tables = set()
            for entity in value_result.entity_matches:
                tables.add(entity.table_name)
            
            if tables:
                context["tables"] = list(tables)
        
        # Execute permission check
        permission_result = self.access_control.check_comprehensive_permissions(
            user_question=request.user_question,
            user_role=request.user_role,
            user_id=request.user_id,
            query_context=context
        )
        
        return permission_result
    
    def _step4_sql_generation(self, 
                             request: PipelineRequest,
                             value_result: Optional[ValueRetrievalResult],
                             permission_result: Optional[PermissionResult]) -> Optional[SQLGenerationResult]:
        """Step 4: Generate and execute SQL"""
        if not self.sql_generator:
            logger.warning("SQL generator module not available")
            return None
        
        # Create enriched context from previous steps
        enriched_context = {
            "entities": {},
            "relevant_tables": [],
            "semantic_context": request.user_question
        }
        
        if value_result:
            # Add entity information
            for entity in value_result.entity_matches:
                entity_type = f"{entity.column_name}_identifier"
                if entity_type not in enriched_context["entities"]:
                    enriched_context["entities"][entity_type] = []
                enriched_context["entities"][entity_type].append(entity.original_value)
            
            # Add relevant tables
            enriched_context["relevant_tables"] = list(set(
                entity.table_name for entity in value_result.entity_matches
            ))
            
            # Add formatted context
            if value_result.formatted_context:
                enriched_context["semantic_context"] = value_result.formatted_context
        
        # Create SQL generation request
        sql_request = SQLGenerationRequest(
            user_question=request.user_question,
            user_id=request.user_id,
            user_role=request.user_role,
            timestamp=request.timestamp,
            enriched_context=enriched_context,
            permission_check_passed=True  # Already validated in step 3
        )
        
        # Generate and execute SQL
        result = self.sql_generator.generate_and_execute_sql(sql_request)
        
        return result
    
    def get_pipeline_status(self) -> Dict[str, Any]:
        """Get current status of all pipeline modules"""
        return {
            "pipeline_version": "1.0.0",
            "modules": {
                "security_checker": "READY" if self.security_checker else "NOT AVAILABLE",
                "value_retrieval": "READY" if self.value_retrieval else "NOT AVAILABLE",
                "access_control": "READY" if self.access_control else "NOT AVAILABLE", 
                "sql_generator": "READY" if self.sql_generator else "NOT AVAILABLE"
            },
            "initialization_time": f"{(time.time() - self.start_time) * 1000:.2f}ms",
            "ready": all([
                self.security_checker is not None,
                self.value_retrieval is not None,
                self.access_control is not None,
                self.sql_generator is not None
            ])
        }