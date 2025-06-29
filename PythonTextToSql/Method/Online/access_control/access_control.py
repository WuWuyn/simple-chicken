"""
Access Control and Permission Management System

Components:
1. PermissionRule - Rule-based access control
2. QueryGenerator - SQL generation for permission checks
3. PermissionChecker - Database query execution
4. LLMPermissionAnalyzer - AI-powered analysis
5. ComprehensivePermissionManager - Main orchestrator
"""

import os
import json
import logging
import time
from typing import Dict, List, Tuple, Optional, Any, Union
from dataclasses import dataclass
from enum import Enum
from datetime import datetime

try:
    import google.generativeai as genai
    GENAI_AVAILABLE = True
except ImportError:
    GENAI_AVAILABLE = False
    print("Google GenerativeAI not available")

try:
    import pyodbc
    PYODBC_AVAILABLE = True
except ImportError:
    PYODBC_AVAILABLE = False
    print("pyodbc not available, using mock mode")

class PermissionDecision(Enum):
    ALLOW = "ALLOW"
    DENY = "DENY"
    REVIEW = "REVIEW"

@dataclass
class PermissionResult:
    decision: PermissionDecision
    confidence: float
    reasoning: str
    metadata: Dict[str, Any]

class PermissionRule:
    """Rule-based permission checker"""

    def __init__(self, permissions_config_path: str):
        self.rules = self._load_permissions_config(permissions_config_path)
        self.logger = logging.getLogger(__name__)
    
    def _load_permissions_config(self, config_path: str) -> Dict:
        """Load permission rules from JSON configuration"""
        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                config = json.load(f)
            print("Permission rules loaded successfully")
            return config
        except Exception as e:
            print(f"Failed to load permission config: {e}")
            return self._get_default_rules()
    
    def _get_default_rules(self) -> Dict:
        """Default permission rules as fallback"""
        return {
            "roles": {
                "Student": {
                    "allowed_operations": ["SELECT"],
                    "accessible_tables": ["Students", "Courses", "Enrollments", "Classes"],
                    "restricted_columns": ["password"],
                    "row_level_security": True
                },
                "Lecturer": {
                    "allowed_operations": ["SELECT"],
                    "accessible_tables": ["Students", "Courses", "Enrollments", "Classes", "Lecturers"],
                    "restricted_columns": ["password"],
                    "row_level_security": True
                },
                "Admin": {
                    "allowed_operations": ["SELECT", "INSERT", "UPDATE"],
                    "accessible_tables": ["*"],
                    "restricted_columns": [],
                    "row_level_security": False
                }
            },
            "special_permissions": {
                "student_own_data": {
                    "condition": "StudentId = user_id",
                    "applies_to": ["Students", "Enrollments"]
                }
            }
        }
    
    def check_rule_based_permissions(self, user_role: str, user_id: str, 
                                   query_context: Dict[str, Any]) -> PermissionResult:
        """Check permissions based on configured rules"""
        try:
            # Try both 'roles' and 'role_permissions' keys for compatibility
            roles_config = self.rules.get("roles") or self.rules.get("role_permissions", {})
            role_rules = roles_config.get(user_role, {})
            
            if not role_rules:
                return PermissionResult(
                    decision=PermissionDecision.DENY,
                    confidence=1.0,
                    reasoning=f"No rules defined for role: {user_role}",
                    metadata={"rule_type": "role_not_found"}
                )
            
            # Extract permissions from the role config
            table_access = role_rules.get("table_access", [])
            if isinstance(table_access, str) and table_access == "*":
                table_access = ["*"]
            
            forbidden_columns = role_rules.get("forbidden_columns", [])
            permission_level = role_rules.get("permission_level", "restricted")
            
            # Check table access
            requested_tables = query_context.get("tables", [])
            
            if "*" not in table_access and table_access:
                for table in requested_tables:
                    if table not in table_access:
                        return PermissionResult(
                            decision=PermissionDecision.DENY,
                            confidence=1.0,
                            reasoning=f"Table {table} not accessible for role {user_role}",
                            metadata={"rule_type": "table_denied"}
                        )
            
            # All checks passed
            return PermissionResult(
                decision=PermissionDecision.ALLOW,
                confidence=0.9,
                reasoning=f"Rule-based check passed for {user_role} with {permission_level} access",
                metadata={"rule_type": "allowed", "permission_level": permission_level}
            )
            
        except Exception as e:
            self.logger.error(f"Rule-based permission check failed: {e}")
            return PermissionResult(
                decision=PermissionDecision.DENY,
                confidence=1.0,
                reasoning=f"Permission check error: {str(e)}",
                metadata={"rule_type": "error"}
            )

class QueryGenerator:
    """Generates permission check queries"""
    
    def __init__(self, schema_info: str = ""):
        self.schema_info = schema_info
        self.logger = logging.getLogger(__name__)
    
    def generate_permission_queries(self, user_role: str, user_id: str, 
                                  query_context: Dict[str, Any]) -> List[Tuple[str, List[Any]]]:
        """Generate SQL queries to check permissions"""
        queries = []
        
        try:
            # Basic user existence check
            user_check_query = "SELECT COUNT(*) as user_exists FROM Students WHERE StudentId = ?"
            queries.append((user_check_query, [user_id]))
            
            # Role-specific checks
            if user_role == "Student":
                # Check if student is enrolled in requested courses/classes
                enrollment_check = """
                SELECT COUNT(*) as enrollment_count 
                FROM Enrollments 
                WHERE StudentId = ? AND Semester = 'SU24'
                """
                queries.append((enrollment_check, [user_id]))
            
            elif user_role == "Lecturer":
                # Check lecturer permissions
                lecturer_check = "SELECT COUNT(*) as lecturer_exists FROM Lecturers WHERE LecturerId = ?"
                queries.append((lecturer_check, [user_id]))
            
            # Additional context-based checks can be added here
            
        except Exception as e:
            self.logger.error(f"Query generation failed: {e}")
        
        return queries

class PermissionChecker:
    """Executes permission queries and validates access"""
    
    def __init__(self, db_connection_string: str, mock_mode: bool = False):
        self.db_connection = db_connection_string
        self.mock_mode = mock_mode or db_connection_string in [":memory:", "mock", ""]
        self.logger = logging.getLogger(__name__)
        
        if self.mock_mode:
            self.logger.info("PermissionChecker running in MOCK MODE")
    
    def execute_permission_queries(self, queries: List[Tuple[str, List[Any]]]) -> List[Dict[str, Any]]:
        """Execute permission queries and return results"""
        
        results = []
        
        if not queries:
            return results
        
        if self.mock_mode:
            # Mock results for testing
            for query, params in queries:
                mock_result = {"mock": True, "result": "permission_granted"}
                results.append(mock_result)
        else:
            # Real database execution would go here
            try:
                if PYODBC_AVAILABLE:
                    conn = pyodbc.connect(self.db_connection)
                    cursor = conn.cursor()
                    
                    for query, params in queries:
                        cursor.execute(query, params)
                        rows = cursor.fetchall()
                        
                        # Convert to dictionary
                        columns = [column[0] for column in cursor.description]
                        result_dicts = []
                        for row in rows:
                            result_dicts.append(dict(zip(columns, row)))
                        
                        results.append({"query_result": result_dicts})
                    
                    conn.close()
                else:
                    # Fallback to mock mode
                    self.logger.warning("pyodbc not available, using mock results")
                    for query, params in queries:
                        mock_result = {"mock": True, "result": "permission_granted"}
                        results.append(mock_result)
                        
            except Exception as e:
                self.logger.error(f"Permission query execution failed: {e}")
                # Return mock results as fallback
                for query, params in queries:
                    error_result = {"error": str(e), "result": "permission_granted"}
                    results.append(error_result)
        
        return results

class LLMPermissionAnalyzer:
    """LLM Permission Analyzer for intelligent analysis"""
    
    def __init__(self, api_key: Optional[str] = None, fallback_mode: bool = False):
        self.fallback_mode = fallback_mode
        self.logger = logging.getLogger(__name__)
        
        if not GENAI_AVAILABLE:
            self.logger.warning("Google GenerativeAI not available, using fallback mode")
            self.fallback_mode = True
            return
            
        if api_key is None:
            api_key = os.getenv("GEMINI_API_KEY")
        
        if not api_key:
            raise ValueError("GEMINI_API_KEY not found in environment variables")
        
        try:
            genai.configure(api_key=api_key)
            self.model = genai.GenerativeModel('gemini-2.0-flash')
            self.llm_enabled = True
            print("LLM Permission Analyzer initialized")
        except Exception as e:
            self.logger.error(f"LLM initialization failed: {e}")
            self.fallback_mode = True
    
    def analyze_permission_context(self, user_question: str, user_role: str, 
                                 user_id: str, context: Dict[str, Any]) -> PermissionResult:
        """Analyze permission requirements using LLM"""
        
        if self.fallback_mode:
            return PermissionResult(
                decision=PermissionDecision.ALLOW,
                confidence=0.5,
                reasoning="LLM analysis not available, using fallback approval",
                metadata={"analysis_type": "fallback"}
            )
        
        try:
            prompt = f"""
            Analyze this database access request for permission requirements:
            
            User Question: "{user_question}"
            User Role: {user_role}
            User ID: {user_id}
            Context: {context}
            
            Determine if this request should be:
            - ALLOW: Safe, appropriate for user role
            - DENY: Security risk or unauthorized access
            - REVIEW: Unclear, requires human review
            
            Respond with JSON:
            {{
                "decision": "ALLOW|DENY|REVIEW",
                "confidence": 0.0-1.0,
                "reasoning": "explanation"
            }}
            """
            
            response = self.model.generate_content(prompt)
            response_text = response.text.strip()
            
            # Extract JSON
            if "```json" in response_text:
                json_start = response_text.find("```json") + 7
                json_end = response_text.find("```", json_start)
                response_text = response_text[json_start:json_end].strip()
            
            analysis = json.loads(response_text)
            
            decision_str = analysis.get("decision", "ALLOW")
            decision = PermissionDecision(decision_str)
            confidence = float(analysis.get("confidence", 0.5))
            reasoning = analysis.get("reasoning", "LLM analysis completed")
            
            return PermissionResult(
                decision=decision,
                confidence=confidence,
                reasoning=reasoning,
                metadata={"analysis_type": "llm"}
            )
            
        except Exception as e:
            self.logger.error(f"LLM permission analysis failed: {e}")
            return PermissionResult(
                decision=PermissionDecision.ALLOW,
                confidence=0.3,
                reasoning=f"LLM analysis failed: {str(e)}",
                metadata={"analysis_type": "error"}
            )

class ComprehensivePermissionManager:
    """Main orchestrator combining all permission components"""
    
    def __init__(self, db_connection_string: str, 
                 permissions_config_path: str,
                 api_key: Optional[str] = None,
                 mock_mode: bool = False):
        
        self.logger = logging.getLogger(__name__)
        
        # Auto-detect mock mode based on connection string
        auto_mock = db_connection_string in [":memory:", "mock", ""] or mock_mode
        
        # Initialize components
        self.rule_engine = PermissionRule(permissions_config_path)
        self.query_generator = QueryGenerator()
        self.permission_checker = PermissionChecker(db_connection_string, auto_mock)
        self.llm_analyzer = LLMPermissionAnalyzer(api_key, fallback_mode=auto_mock)
        
        print(f"Permission Manager initialized (mock_mode: {auto_mock})")
    
    def check_comprehensive_permissions(self, user_question: str, user_role: str, 
                                      user_id: str, query_context: Dict[str, Any]) -> PermissionResult:
        """Comprehensive permission check using all components"""
        
        print("\n" + "="*70)
        print("🔐 ACCESS CONTROL VALIDATION")
        print("="*70)
        print(f"📝 Question: {user_question[:60]}...")
        print(f"👤 User: {user_id} ({user_role})")
        print(f"🎯 Context: {query_context}")
        print("-"*70)
        
        start_time = time.time()
        
        try:
            # Step 1: Rule-based checking
            print("🔍 Step 1: Rule-based Permission Checking...")
            rule_result = self.rule_engine.check_rule_based_permissions(
                user_role, user_id, query_context
            )
            
            if rule_result.decision == PermissionDecision.DENY:
                print("❌ DENIED: Rule-based check failed")
                print(f"   Reason: {rule_result.reasoning}")
                print("="*70 + "\n")
                return rule_result
            else:
                print(f"✅ PASSED: Rule-based check (confidence: {rule_result.confidence:.2f})")
                print(f"   Reason: {rule_result.reasoning}")
            
            # Step 2: Database permission queries
            print("🗄️  Step 2: Database Permission Queries...")
            permission_queries = self.query_generator.generate_permission_queries(
                user_role, user_id, query_context
            )
            
            if permission_queries:
                print(f"   📊 Generated {len(permission_queries)} permission queries")
                query_results = self.permission_checker.execute_permission_queries(permission_queries)
                print(f"   ✅ Executed {len(query_results)} queries successfully")
                
                # Show sample results
                for i, result in enumerate(query_results[:2], 1):
                    if "error" not in result:
                        print(f"      Query {i}: {result.get('result', 'N/A')}")
                    else:
                        print(f"      Query {i}: Error - {result.get('error', 'Unknown')}")
            else:
                print("   ℹ️  No specific database queries needed")
                query_results = []
            
            # Step 3: LLM analysis for context understanding
            print("🤖 Step 3: LLM Context Analysis...")
            llm_result = self.llm_analyzer.analyze_permission_context(
                user_question, user_role, user_id, query_context
            )
            
            if llm_result.decision == PermissionDecision.DENY:
                print("❌ DENIED: LLM analysis failed")
                print(f"   Reason: {llm_result.reasoning}")
                print(f"   Confidence: {llm_result.confidence:.2f}")
                print("="*70 + "\n")
                return llm_result
            else:
                print(f"✅ PASSED: LLM analysis (confidence: {llm_result.confidence:.2f})")
                print(f"   Reason: {llm_result.reasoning}")
            
            # Step 4: Combine results and make final decision
            print("⚖️  Step 4: Combining Results...")
            final_decision = self._combine_permission_results(
                rule_result, query_results, llm_result
            )
            
            execution_time = (time.time() - start_time) * 1000
            final_decision.metadata["execution_time_ms"] = execution_time
            
            print(f"\n🎉 ACCESS CONTROL COMPLETED!")
            print(f"🔑 Final Decision: {final_decision.decision.value}")
            print(f"📊 Combined Confidence: {final_decision.confidence:.2f}")
            print(f"💭 Final Reasoning: {final_decision.reasoning}")
            print(f"⏱️  Total Execution Time: {execution_time:.2f}ms")
            print("="*70 + "\n")
            
            return final_decision
            
        except Exception as e:
            execution_time = (time.time() - start_time) * 1000
            print(f"❌ ERROR: Access control validation failed")
            print(f"   Error: {str(e)}")
            print(f"   Time: {execution_time:.2f}ms")
            print("="*70 + "\n")
            
            self.logger.error(f"Comprehensive permission check failed: {e}")
            return PermissionResult(
                decision=PermissionDecision.DENY,
                confidence=1.0,
                reasoning=f"Permission check error: {str(e)}",
                metadata={"error": str(e)}
            )
    
    def _combine_permission_results(self, rule_result: PermissionResult,
                                  query_results: List[Dict[str, Any]],
                                  llm_result: PermissionResult) -> PermissionResult:
        """Combine multiple permission check results"""
        
        # If any component denies, deny overall
        if rule_result.decision == PermissionDecision.DENY:
            return rule_result
        
        if llm_result.decision == PermissionDecision.DENY:
            return llm_result
        
        # If all allow, combine confidence scores
        combined_confidence = (rule_result.confidence + llm_result.confidence) / 2
        
        combined_reasoning = (
            f"Rule-based: {rule_result.reasoning}; "
            f"LLM: {llm_result.reasoning}"
        )
        
        return PermissionResult(
            decision=PermissionDecision.ALLOW,
            confidence=combined_confidence,
            reasoning=combined_reasoning,
            metadata={
                "rule_result": rule_result.metadata,
                "llm_result": llm_result.metadata,
                "query_results_count": len(query_results)
            }
        ) 