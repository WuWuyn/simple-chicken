"""
Access Control and Permission Management System

Components:
1. QueryGenerator - SQL generation for permission checks (Optional validation)
2. PermissionChecker - Database query execution (Optional validation)  
3. LLMPermissionAnalyzer - AI-powered primary security analysis
4. ComprehensivePermissionManager - Main orchestrator (LLM-driven)
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
    from google.generativeai.client import configure
    from google.generativeai.generative_models import GenerativeModel
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

class QueryGenerator:
    """Generates optional validation queries for additional security checks"""
    
    def __init__(self, schema_info: str = ""):
        self.schema_info = schema_info
        self.logger = logging.getLogger(__name__)
    
    def generate_validation_queries(self, user_role: str, user_id: str, 
                                  query_context: Dict[str, Any]) -> List[Tuple[str, List[Any]]]:
        """Generate optional SQL queries for additional validation"""
        queries = []
        
        try:
            # Basic user existence validation
            if user_role == "Student":
                user_check_query = "SELECT COUNT(*) as user_exists FROM Students WHERE StudentId = ?"
                queries.append((user_check_query, [user_id]))
            elif user_role == "Lecturer":
                user_check_query = "SELECT COUNT(*) as user_exists FROM Lecturers WHERE LecturerId = ?"
                queries.append((user_check_query, [user_id]))
            
        except Exception as e:
            self.logger.error(f"Validation query generation failed: {e}")
        
        return queries

class PermissionChecker:
    """Executes optional validation queries"""
    
    def __init__(self, db_connection_string: str, mock_mode: bool = False):
        self.db_connection = db_connection_string
        self.mock_mode = mock_mode or db_connection_string in [":memory:", "mock", ""]
        self.logger = logging.getLogger(__name__)
        
        if self.mock_mode:
            self.logger.info("PermissionChecker running in MOCK MODE")
    
    def execute_validation_queries(self, queries: List[Tuple[str, List[Any]]]) -> List[Dict[str, Any]]:
        """Execute optional validation queries"""
        
        results = []
        
        if not queries:
            return results
        
        if self.mock_mode:
            # Mock results for testing
            for query, params in queries:
                mock_result = {"mock": True, "user_exists": 1}
                results.append(mock_result)
        else:
            try:
                if PYODBC_AVAILABLE:
                    conn = pyodbc.connect(self.db_connection)
                    cursor = conn.cursor()
                    
                    for query, params in queries:
                        cursor.execute(query, params)
                        rows = cursor.fetchall()
                        
                        columns = [column[0] for column in cursor.description]
                        result_dicts = []
                        for row in rows:
                            result_dicts.append(dict(zip(columns, row)))
                        
                        results.append({"query_result": result_dicts})
                    
                    conn.close()
                else:
                    self.logger.warning("pyodbc not available, using mock results")
                    for query, params in queries:
                        mock_result = {"mock": True, "user_exists": 1}
                        results.append(mock_result)
                        
            except Exception as e:
                self.logger.error(f"Validation query execution failed: {e}")
                for query, params in queries:
                    error_result = {"error": str(e), "user_exists": 1}
                    results.append(error_result)
        
        return results

class LLMPermissionAnalyzer:
    """Enhanced LLM Permission Analyzer - Primary Security Decision Maker"""
    
    def __init__(self, api_key: Optional[str] = None, fallback_mode: bool = False, schema_info: str = ""):
        self.fallback_mode = fallback_mode
        self.schema_info = schema_info
        self.logger = logging.getLogger(__name__)
        
        if not GENAI_AVAILABLE:
            self.logger.warning("Google GenerativeAI not available, using fallback mode")
            self.fallback_mode = True
            return
            
        if api_key is None:
            api_key = os.getenv("GEMINI_API_KEY")
        
        if not api_key:
            self.logger.warning("GEMINI_API_KEY not found, using fallback mode")
            self.fallback_mode = True
            return
        
        try:
            configure(api_key=api_key)
            self.model = GenerativeModel('gemini-2.0-flash')
            self.llm_enabled = True
            print("Enhanced LLM Permission Analyzer initialized")
        except Exception as e:
            self.logger.error(f"LLM initialization failed: {e}")
            self.fallback_mode = True
    
    def _create_enhanced_security_prompt(self, user_question: str, user_role: str, 
                                       user_id: str) -> str:
        """Create comprehensive security analysis prompt"""
        return f"""
You are an ADVANCED DATABASE SECURITY ANALYZER for a University Management System.

CRITICAL SECURITY CONTEXT:
- User Role: {user_role}
- User ID: {user_id}
- System: Educational Database with sensitive student/faculty data

DATABASE SCHEMA INFORMATION:
{self.schema_info}

SECURITY POLICY ENFORCEMENT:

🎓 STUDENT ROLE ({user_role == 'Student'}):
   ✅ ALLOWED ACCESS:
   - Own personal data (StudentId = {user_id})
   - Own enrollment records and grades
   - Course information (descriptions, schedules, credits)
   - Own class schedules and assignments
   
   ❌ FORBIDDEN ACCESS:
   - Other students' personal data, grades, or records
   - Faculty personal information or salaries
   - Administrative functions or system tables
   - Financial records or payment information
   - Other users' login credentials or sensitive data

👨‍🏫 LECTURER ROLE ({user_role == 'Lecturer'}):
   ✅ ALLOWED ACCESS:
   - Students enrolled in their assigned courses only
   - Grades and attendance for their courses
   - Course materials and schedules they teach
   - Class rosters for their sections
   
   ❌ FORBIDDEN ACCESS:
   - Students not in their classes
   - Other lecturers' personal information
   - Administrative or financial data
   - System configuration or user management

👑 ADMIN ROLE ({user_role == 'Admin'}):
   ✅ ALLOWED ACCESS:
   - Broad system access with audit requirements
   - User management functions
   - Academic records management
   - System configuration (with proper justification)
   
   ❌ FORBIDDEN ACCESS:
   - Direct password/authentication data
   - Destructive operations without approval
   - Financial transactions without authorization

SECURITY THREAT DETECTION:
🚨 Analyze for these attack patterns:
   - SQL Injection: Keywords like DROP, DELETE, UNION, '; --, /*
   - Privilege Escalation: Attempts to access admin functions
   - Data Harvesting: Requests for bulk user data
   - Cross-User Access: Attempts to access other users' data
   - System Probing: Requests for schema/system information
   - Encoding Attacks: %27, %20, hex patterns

USER QUESTION TO ANALYZE:
"{user_question}"

SECURITY ANALYSIS REQUIREMENTS:
1. Is this question legitimate for the user's role and permissions?
2. Does the question attempt unauthorized data access?
3. Are there any injection or manipulation patterns?
4. What specific data constraints should be applied?
5. What is the appropriate audit level for this request?

RESPOND WITH STRICT JSON FORMAT:
{{
    "decision": "ALLOW|DENY|REVIEW",
    "confidence": 0.0-1.0,
    "reasoning": "detailed security analysis and justification",
    "risk_factors": ["list", "of", "identified", "security", "risks"],
    "required_tables": ["minimum", "tables", "needed", "for", "legitimate", "query"],
    "row_level_constraints": ["WHERE StudentId = '{user_id}'", "other constraints"],
    "audit_level": "LOW|MEDIUM|HIGH",
    "injection_risk": "NONE|LOW|MEDIUM|HIGH",
    "data_sensitivity": "PUBLIC|INTERNAL|CONFIDENTIAL|RESTRICTED"
}}

DECISION EXAMPLES:

✅ ALLOW - Safe student query:
Question: "What are my current course grades?"
- Accesses only own data (StudentId = {user_id})
- Legitimate educational purpose
- No security risks

❌ DENY - Unauthorized access attempt:
Question: "Show me all students' grades in the database"
- Attempts bulk data access
- Violates privacy boundaries
- Potential data harvesting

⚠️ REVIEW - Suspicious or unclear:
Question: "What is the database structure?"
- Could be legitimate research or malicious probing
- Requires human judgment

SECURITY PRIORITY: When in doubt, prioritize data protection. 
Better to deny a legitimate request than allow a security breach.
"""

    def _detect_injection_patterns(self, user_question: str) -> Dict[str, Any]:
        """Detect potential SQL injection patterns"""
        injection_keywords = [
            'DROP', 'DELETE', 'INSERT', 'UPDATE', 'UNION', 'SELECT *',
            '--', '/*', '*/', 'xp_', 'sp_', '@@', 'EXEC', 'EXECUTE',
            'SLEEP', 'WAITFOR', 'DELAY', 'BENCHMARK', 'OR 1=1', 'AND 1=1',
            'CHAR(', 'ASCII(', 'SUBSTRING(', 'CAST(', 'CONVERT('
        ]
        
        question_upper = user_question.upper()
        detected_patterns = []
        
        for keyword in injection_keywords:
            if keyword in question_upper:
                detected_patterns.append(keyword)
        
        # Check for suspicious characters
        suspicious_chars = ["'", ";", "%27", "%20", "0x"]
        for char in suspicious_chars:
            if char in user_question:
                detected_patterns.append(f"suspicious_char:{char}")
        
        risk_level = "NONE"
        if len(detected_patterns) > 0:
            if len(detected_patterns) >= 3:
                risk_level = "HIGH"
            elif len(detected_patterns) >= 2:
                risk_level = "MEDIUM"
            else:
                risk_level = "LOW"
        
        return {
            "injection_risk": risk_level,
            "detected_patterns": detected_patterns
        }

    def comprehensive_security_analysis(self, user_question: str, user_role: str, 
                                      user_id: str, context: Dict[str, Any]) -> PermissionResult:
        """Comprehensive security analysis using enhanced LLM"""
        
        if self.fallback_mode:
            # Enhanced fallback logic with basic security checks
            injection_check = self._detect_injection_patterns(user_question)
            
            if injection_check["injection_risk"] in ["MEDIUM", "HIGH"]:
                return PermissionResult(
                    decision=PermissionDecision.DENY,
                    confidence=0.9,
                    reasoning=f"Potential injection attack detected: {injection_check['detected_patterns']}",
                    metadata={"analysis_type": "fallback_security", "injection_check": injection_check}
                )
            
            # Basic role-based fallback
            if user_role in ["Student", "Lecturer"]:
                return PermissionResult(
                    decision=PermissionDecision.ALLOW,
                    confidence=0.6,
                    reasoning="Fallback mode: Basic approval for standard user roles",
                    metadata={"analysis_type": "fallback_basic"}
                )
            else:
                return PermissionResult(
                    decision=PermissionDecision.REVIEW,
                    confidence=0.5,
                    reasoning="Fallback mode: Admin role requires review",
                    metadata={"analysis_type": "fallback_admin"}
                )
        
        try:
            # Step 1: Pre-analysis injection detection
            injection_check = self._detect_injection_patterns(user_question)
            
            if injection_check["injection_risk"] == "HIGH":
                return PermissionResult(
                    decision=PermissionDecision.DENY,
                    confidence=0.95,
                    reasoning=f"High injection risk detected: {injection_check['detected_patterns']}",
                    metadata={"analysis_type": "injection_blocked", "injection_check": injection_check}
                )
            
            # Step 2: Enhanced LLM analysis
            prompt = self._create_enhanced_security_prompt(user_question, user_role, user_id)
            
            response = self.model.generate_content(prompt)
            response_text = response.text.strip()
            
            # Extract JSON from response
            if "```json" in response_text:
                json_start = response_text.find("```json") + 7
                json_end = response_text.find("```", json_start)
                response_text = response_text[json_start:json_end].strip()
            elif "{" in response_text and "}" in response_text:
                json_start = response_text.find("{")
                json_end = response_text.rfind("}") + 1
                response_text = response_text[json_start:json_end]
            
            analysis = json.loads(response_text)
            
            # Parse LLM response
            decision_str = analysis.get("decision", "REVIEW")
            decision = PermissionDecision(decision_str)
            confidence = float(analysis.get("confidence", 0.5))
            reasoning = analysis.get("reasoning", "LLM security analysis completed")
            
            # Combine with injection check results
            metadata = {
                "analysis_type": "enhanced_llm",
                "risk_factors": analysis.get("risk_factors", []),
                "required_tables": analysis.get("required_tables", []),
                "row_level_constraints": analysis.get("row_level_constraints", []),
                "audit_level": analysis.get("audit_level", "MEDIUM"),
                "injection_risk": analysis.get("injection_risk", injection_check["injection_risk"]),
                "data_sensitivity": analysis.get("data_sensitivity", "INTERNAL"),
                "pre_injection_check": injection_check
            }
            
            # Apply additional security logic
            if injection_check["injection_risk"] in ["MEDIUM", "HIGH"] and decision == PermissionDecision.ALLOW:
                decision = PermissionDecision.REVIEW
                reasoning += f" | ESCALATED: Injection patterns detected: {injection_check['detected_patterns']}"
                confidence = min(confidence, 0.7)
            
            return PermissionResult(
                decision=decision,
                confidence=confidence,
                reasoning=reasoning,
                metadata=metadata
            )
            
        except Exception as e:
            self.logger.error(f"Enhanced LLM security analysis failed: {e}")
            return PermissionResult(
                decision=PermissionDecision.DENY,
                confidence=0.9,
                reasoning=f"Security analysis failed, defaulting to DENY: {str(e)}",
                metadata={"analysis_type": "error", "error": str(e)}
            )

class ComprehensivePermissionManager:
    """LLM-Driven Permission Manager - Removed Rule-based Dependencies"""
    
    def __init__(self, db_connection_string: str = "", 
                 permissions_config_path: str = "",
                 api_key: Optional[str] = None,
                 mock_mode: bool = False,
                 schema_info: str = ""):
        
        self.logger = logging.getLogger(__name__)
        
        # Auto-detect mock mode
        auto_mock = db_connection_string in [":memory:", "mock", ""] or mock_mode
        
        # Initialize components - LLM is now primary
        self.query_generator = QueryGenerator(schema_info)
        self.permission_checker = PermissionChecker(db_connection_string, auto_mock)
        self.llm_analyzer = LLMPermissionAnalyzer(api_key, fallback_mode=auto_mock, schema_info=schema_info)
        
        print(f"🚀 LLM-Driven Permission Manager initialized (mock_mode: {auto_mock})")
        print("✅ Rule-based checking REMOVED - Pure LLM security analysis")
    
    def check_comprehensive_permissions(self, user_question: str, user_role: str, 
                                      user_id: str, query_context: Dict[str, Any]) -> PermissionResult:
        """LLM-driven comprehensive permission check"""
        
        print("\n" + "="*70)
        print("🤖 LLM-DRIVEN ACCESS CONTROL")
        print("="*70)
        print(f"📝 Question: {user_question[:60]}...")
        print(f"👤 User: {user_id} ({user_role})")
        print(f"🎯 Context: {query_context}")
        print("-"*70)
        
        start_time = time.time()
        
        try:
            # Primary: Enhanced LLM Security Analysis
            print("🧠 PRIMARY: Enhanced LLM Security Analysis...")
            llm_result = self.llm_analyzer.comprehensive_security_analysis(
                user_question, user_role, user_id, query_context
            )
            
            print(f"🔍 LLM Decision: {llm_result.decision.value}")
            print(f"📊 Confidence: {llm_result.confidence:.2f}")
            print(f"💭 Reasoning: {llm_result.reasoning}")
            
            # Optional: Additional validation for high-risk scenarios
            if llm_result.metadata.get("audit_level") == "HIGH" or llm_result.confidence < 0.8:
                print("🔬 OPTIONAL: Additional Database Validation...")
                validation_queries = self.query_generator.generate_validation_queries(
                    user_role, user_id, query_context
                )
                
                if validation_queries:
                    validation_results = self.permission_checker.execute_validation_queries(
                        validation_queries
                    )
                    print(f"   ✅ Validation queries completed: {len(validation_results)} results")
                    
                    # Update metadata with validation results
                    llm_result.metadata["validation_results"] = validation_results
                else:
                    print("   ℹ️  No additional validation needed")
            
            execution_time = (time.time() - start_time) * 1000
            llm_result.metadata["execution_time_ms"] = execution_time
            
            # Final logging
            print(f"\n🎉 LLM ACCESS CONTROL COMPLETED!")
            print(f"🔑 Final Decision: {llm_result.decision.value}")
            print(f"📊 Final Confidence: {llm_result.confidence:.2f}")
            print(f"🛡️  Security Level: {llm_result.metadata.get('data_sensitivity', 'UNKNOWN')}")
            print(f"🚨 Injection Risk: {llm_result.metadata.get('injection_risk', 'UNKNOWN')}")
            if llm_result.metadata.get("required_tables"):
                print(f"📋 Required Tables: {llm_result.metadata['required_tables']}")
            if llm_result.metadata.get("row_level_constraints"):
                print(f"🔒 Security Constraints: {llm_result.metadata['row_level_constraints']}")
            print(f"⏱️  Total Execution Time: {execution_time:.2f}ms")
            print("="*70 + "\n")
            
            return llm_result
            
        except Exception as e:
            execution_time = (time.time() - start_time) * 1000
            print(f"❌ ERROR: LLM access control failed")
            print(f"   Error: {str(e)}")
            print(f"   Time: {execution_time:.2f}ms")
            print("="*70 + "\n")
            
            self.logger.error(f"LLM-driven permission check failed: {e}")
            return PermissionResult(
                decision=PermissionDecision.DENY,
                confidence=1.0,
                reasoning=f"Permission system error, defaulting to DENY: {str(e)}",
                metadata={"error": str(e), "execution_time_ms": execution_time}
            ) 