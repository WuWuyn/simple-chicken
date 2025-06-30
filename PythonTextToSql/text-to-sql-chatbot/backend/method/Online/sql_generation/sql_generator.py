"""
SQL Generation Module for Text-to-SQL System

Components:
1. GeminiSQLGenerator - Uses Gemini AI for SQL generation
2. DatabaseConnection - Handles database connectivity and execution
3. ComprehensiveSQLGenerator - Main orchestrator
"""

import os
import time
import logging
import sqlite3
from typing import Dict, Any, Optional, Tuple, List
from dataclasses import dataclass

# Import demo time utilities
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '..', 'app'))
try:
    from app.utils.demo_time import get_demo_timestamp, DEMO_TIMESTAMP
except ImportError:
    # Fallback for standalone execution
    DEMO_TIMESTAMP = "22:00 15/6/2024"
    def get_demo_timestamp() -> str:
        return DEMO_TIMESTAMP

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
    print("pyodbc not available, using SQLite only")

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class SQLGenerationRequest:
    """Request structure for SQL generation"""
    user_question: str
    user_id: str
    user_role: str
    timestamp: str
    enriched_context: Dict[str, Any]
    permission_check_passed: bool

@dataclass
class SQLGenerationResult:
    """Result structure for SQL generation"""
    success: bool
    generated_sql: Optional[str]
    execution_result: Optional[Any]
    error_message: Optional[str]
    execution_time_ms: float
    confidence_score: float
    metadata: Dict[str, Any]

class DatabaseConnection:
    """Database connection handler with SQLite fallback"""
    
    def __init__(self, connection_string: Optional[str] = None):
        self.connection_string = connection_string or ":memory:"
        self.connection = None
        self.database_type = None  # Will be set during connection
    
    def connect(self) -> bool:
        """Establish database connection"""
        try:
            if self.connection_string == ":memory:" or self.connection_string.endswith('.db'):
                # SQLite connection
                self.connection = sqlite3.connect(self.connection_string)
                self.connection.row_factory = sqlite3.Row
                self.database_type = "sqlite"
                
                if self.connection_string == ":memory:":
                    self._create_sample_tables()
                    print("Connected to in-memory SQLite database with sample data")
                
                return True
                
            elif PYODBC_AVAILABLE:
                # SQL Server connection
                self.connection = pyodbc.connect(self.connection_string)
                self.database_type = "mssql"
                print("Connected to SQL Server database")
                return True
            else:
                print("pyodbc not available for SQL Server connection")
                return False
                
        except Exception as e:
            print(f"Database connection failed: {e}")
            return False

    def _create_sample_tables(self):
        """Create sample tables for testing - simulating MS SQL Server structure"""
        if not self.connection:
            return
        cursor = self.connection.cursor()
        
        # Create Users table (master user table)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Users (
                username TEXT PRIMARY KEY,
                password TEXT,
                user_id TEXT UNIQUE,
                fullname TEXT,
                user_gender TEXT,
                user_dob TEXT,
                user_address TEXT
            )
        """)
        
        # Create Students table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Students (
                student_id TEXT PRIMARY KEY,
                major_id TEXT,
                start_date TEXT,
                start_semester TEXT,
                FOREIGN KEY (student_id) REFERENCES Users(user_id)
            )
        """)
        
        # Create Courses table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Courses (
                course_id TEXT PRIMARY KEY,
                course_name TEXT,
                no_credit INTEGER,
                description TEXT
            )
        """)
        
        # Create Classes table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Classes (
                class_id TEXT PRIMARY KEY,
                class_name TEXT
            )
        """)
        
        # Create Lecturers table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Lecturers (
                lecturer_id TEXT PRIMARY KEY,
                dep_id TEXT,
                FOREIGN KEY (lecturer_id) REFERENCES Users(user_id)
            )
        """)
        
        # Create ClassCourse table (bridge table)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS ClassCourse (
                class_course_id TEXT PRIMARY KEY,
                class_id TEXT,
                course_id TEXT,
                lecturer_id TEXT,
                semester TEXT,
                FOREIGN KEY (class_id) REFERENCES Classes(class_id),
                FOREIGN KEY (course_id) REFERENCES Courses(course_id),
                FOREIGN KEY (lecturer_id) REFERENCES Lecturers(lecturer_id)
            )
        """)
        
        # Create Enrollments table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Enrollments (
                enrollment_id TEXT PRIMARY KEY,
                student_id TEXT,
                class_course_id TEXT,
                average REAL,
                status TEXT,
                FOREIGN KEY (student_id) REFERENCES Students(student_id),
                FOREIGN KEY (class_course_id) REFERENCES ClassCourse(class_course_id)
            )
        """)
        
        # Insert sample data
        sample_users = [
            ('he00001_user', 'hashed_password', 'HE00001', 'Nguyen Van An', 'male', '2003-01-10', 'Ha Noi'),
            ('he00002_user', 'hashed_password', 'HE00002', 'Tran Thi Binh', 'female', '2003-02-15', 'Ho Chi Minh'),
            ('lec001_user', 'hashed_password', 'LEC001', 'Dr. Nguyen Van Cong', 'male', '1980-03-20', 'Ha Noi')
        ]
        
        sample_students = [
            ('HE00001', 'AI', '2023-09-04', 'FA23'),
            ('HE00002', 'SE', '2023-09-04', 'FA23')
        ]
        
        sample_courses = [
            ('AIL301', 'Artificial Intelligence and Machine Learning', 3, 'Core AI concepts and ML algorithms'),
            ('CSD201', 'Data Structures and Algorithms', 3, 'Fundamental data structures and algorithms'),
            ('PRF192', 'Programming Fundamentals', 3, 'Basic programming concepts')
        ]
        
        sample_classes = [
            ('AI_K1_FA23', 'AI Class K1 FA23'),
            ('SE_K1_FA23', 'SE Class K1 FA23')
        ]
        
        sample_lecturers = [
            ('LEC001', 'D01')
        ]
        
        sample_classcourse = [
            ('AI_K1_FA23_AIL301_SU24', 'AI_K1_FA23', 'AIL301', 'LEC001', 'SU24'),
            ('AI_K1_FA23_CSD201_SP24', 'AI_K1_FA23', 'CSD201', 'LEC001', 'SP24'),
            ('SE_K1_FA23_PRF192_SU24', 'SE_K1_FA23', 'PRF192', 'LEC001', 'SU24')
        ]
        
        sample_enrollments = [
            ('HE00001_AI_K1_FA23_AIL301_SU24', 'HE00001', 'AI_K1_FA23_AIL301_SU24', 8.5, 'Studying'),
            ('HE00001_AI_K1_FA23_CSD201_SP24', 'HE00001', 'AI_K1_FA23_CSD201_SP24', 9.0, 'Passed'),
            ('HE00002_SE_K1_FA23_PRF192_SU24', 'HE00002', 'SE_K1_FA23_PRF192_SU24', 7.5, 'Studying')
        ]
        
        cursor.executemany("INSERT OR IGNORE INTO Users VALUES (?, ?, ?, ?, ?, ?, ?)", sample_users)
        cursor.executemany("INSERT OR IGNORE INTO Students VALUES (?, ?, ?, ?)", sample_students)
        cursor.executemany("INSERT OR IGNORE INTO Courses VALUES (?, ?, ?, ?)", sample_courses)
        cursor.executemany("INSERT OR IGNORE INTO Classes VALUES (?, ?)", sample_classes)
        cursor.executemany("INSERT OR IGNORE INTO Lecturers VALUES (?, ?)", sample_lecturers)
        cursor.executemany("INSERT OR IGNORE INTO ClassCourse VALUES (?, ?, ?, ?, ?)", sample_classcourse)
        cursor.executemany("INSERT OR IGNORE INTO Enrollments VALUES (?, ?, ?, ?, ?)", sample_enrollments)
        
        if self.connection:
            self.connection.commit()

    def execute_query(self, sql_query: str) -> Tuple[bool, Any, str]:
        """Execute SQL query and return results"""
        if not self.connection:
            return False, None, "No database connection"
        
        try:
            cursor = self.connection.cursor()
            cursor.execute(sql_query)
            
            # For SELECT queries, fetch results
            if sql_query.strip().upper().startswith('SELECT'):
                results = cursor.fetchall()
                
                # Convert to list of dictionaries for better readability
                if hasattr(cursor, 'description') and cursor.description:
                    columns = [column[0] for column in cursor.description]
                    result_list = []
                    for row in results:
                        if hasattr(row, 'keys'):  # sqlite3.Row object
                            result_list.append(dict(row))
                        else:  # tuple
                            result_list.append(dict(zip(columns, row)))
                    
                    return True, result_list, f"Query executed successfully, {len(result_list)} rows returned"
                else:
                    return True, results, f"Query executed successfully, {len(results)} rows returned"
            else:
                # For non-SELECT queries
                self.connection.commit()
                return True, cursor.rowcount, f"Query executed successfully, {cursor.rowcount} rows affected"
                
        except Exception as e:
            error_msg = f"Query execution failed: {str(e)}"
            logger.error(error_msg)
            return False, None, error_msg

    def close(self):
        """Close database connection"""
        if self.connection:
            self.connection.close()
            self.connection = None

class GeminiSQLGenerator:
    """SQL Generator using Google Gemini AI"""
    
    def __init__(self, api_key: Optional[str] = None, database_type: Optional[str] = None):
        self.api_key = api_key or os.getenv("GOOGLE_API_KEY") or os.getenv("GEMINI_API_KEY")
        self.database_type = database_type or "mssql"  # Default to MS SQL Server
        
        if not self.api_key:
            print("GOOGLE_API_KEY not found. LLM analysis will use fallback mode.")
            self.llm_enabled = False
        else:
            try:
                if GENAI_AVAILABLE:
                    genai.configure(api_key=self.api_key)  # type: ignore
                    self.model = genai.GenerativeModel('gemini-2.0-flash')  # type: ignore
                    self.llm_enabled = True
                    print(f"Gemini SQL Generator initialized for {self.database_type} database")
                else:
                    self.llm_enabled = False
                    print("GenerativeAI library not available")
            except Exception as e:
                print(f"Gemini initialization failed: {e}")
                self.llm_enabled = False
        
        # Load database schema
        self.schema_info = self._load_schema()
    
    def _get_database_requirements(self) -> str:
        """Get database-specific requirements for SQL generation"""
        if self.database_type == "sqlite":
            return """
SQLITE SPECIFIC REQUIREMENTS:
1. Generate ONLY valid SQLite SQL query
2. Use SQLite syntax and functions
3. Use LIMIT N instead of TOP N for row limiting
4. Use TEXT/VARCHAR data types appropriately
5. Use proper SQLite JOIN syntax
6. Handle text data as UTF-8 (no special prefix needed)
7. Use SQLite date/time functions (datetime(), date(), etc.)
8. Use appropriate SQLite aggregate functions
9. Return results in meaningful column names with proper aliases

SQLITE SYNTAX RULES:
- Use LIMIT instead of TOP: SELECT * FROM table LIMIT 10
- String literals: 'Nguyễn Văn A' (UTF-8 encoded)
- Date format: 'YYYY-MM-DD' or use date() function
- Boolean values: 1 for TRUE, 0 for FALSE
- Column names in quotes for special characters: "column name"
- SQLite is case-insensitive for table/column names
- Use SQLite built-in functions and expressions
            """
        else:
            return """
MICROSOFT SQL SERVER SPECIFIC REQUIREMENTS:
1. Generate ONLY valid MS SQL Server T-SQL query
2. Use MS SQL Server syntax and functions
3. Use TOP N instead of LIMIT N for row limiting
4. Use NVARCHAR/VARCHAR data types appropriately
5. Use proper MS SQL Server JOIN syntax
6. Handle Vietnamese Unicode text with NVARCHAR
7. Use MS SQL Server date/time functions (GETDATE(), DATEADD(), etc.)
8. Use appropriate MS SQL Server aggregate functions
9. Return results in meaningful column names with proper aliases

MS SQL SERVER SYNTAX RULES:
- Use TOP instead of LIMIT: SELECT TOP 10 * FROM table
- String literals with N prefix for Unicode: N'Nguyễn Văn A'
- Date format: 'YYYY-MM-DD' or use CONVERT function
- Boolean values: 1 for TRUE, 0 for FALSE
- Use square brackets for identifiers with spaces: [column name]
- Case sensitivity depends on collation settings
- Use MS SQL Server system functions and built-ins
            """

    def _load_schema(self) -> str:
        """Load database schema information"""
        try:
            current_dir = os.path.dirname(os.path.abspath(__file__))
            schema_path = os.path.join(current_dir, "..", "..", "Offline", "build_lsh_index", "m-schema_final.txt")
            
            with open(schema_path, 'r', encoding='utf-8') as f:
                schema_content = f.read()
            
            print("Database schema loaded for SQL generation")
            return schema_content
            
        except Exception as e:
            print(f"Failed to load schema: {e}")
            # Fallback schema - MS SQL Server real database structure
            return """
DATABASE: text_to_sql_final (MS SQL Server)
🎭 DEMO TIME CONTEXT: June 15, 2024 22:00 (Saturday Evening)

CORE TABLES:
- Users: Master user table (username, user_id, fullname, etc.)
- Students: student_id (FK to Users), major_id, start_date, start_semester
- Lecturers: lecturer_id (FK to Users), dep_id
- Courses: course_id, course_name, no_credit, description
- Classes: class_id, class_name
- ClassCourse: class_course_id, class_id, course_id, lecturer_id, semester (BRIDGE TABLE)
- Enrollments: enrollment_id, student_id, class_course_id, average, status

IMPORTANT RELATIONSHIPS:
1. Students -> Enrollments -> ClassCourse -> Courses (to get student courses)
2. ClassCourse links: Classes + Courses + Lecturers + Semester
3. Schedules: Contains timetable for each ClassCourse
4. Attendance: Tracks student attendance per schedule

SAMPLE QUERIES (Demo Time Context: June 15, 2024 22:00):
- Student courses: JOIN Enrollments->ClassCourse->Courses
- Student schedule: JOIN Enrollments->ClassCourse->Schedules  
- Student grades: Use Enrollments.average field
- Current semester: 'SU24' (Summer 2024 - matches demo time)
- Today's schedule: Filter by day_of_week = 'Saturday' (demo date)
- This week: Week containing June 15, 2024

MS SQL SERVER SYNTAX:
- Use TOP instead of LIMIT
- VARCHAR/NVARCHAR data types
- DATETIME format
- Primary/Foreign key constraints

KEY FIELDS:
- student_id: 'HE00001', 'HE00002' 
- course_id: 'AIL301', 'CSD201', 'PRF192'
- class_id: 'AI_K1_FA23', 'IA_K2_SU24'
- semester: 'SU24', 'SP24', 'FA23'
- enrollment status: 'Studying', 'Passed', 'Failed'
            """

    def _mock_sql_generation(self, request: SQLGenerationRequest) -> str:
        """Generate mock SQL for fallback mode - MS SQL Server compatible with demo time context"""
        question = request.user_question.lower()
        demo_time = get_demo_timestamp()
        
        # Add demo time context comment to all mock queries
        demo_comment = f"-- Demo Time Context: {demo_time} (June 15, 2024, 22:00)\n"
        
        if "students" in question and "class" in question:
            # Query for student count in a class
            return demo_comment + """
SELECT COUNT(*) as student_count 
FROM Enrollments e 
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id 
WHERE cc.class_id = 'AI_K1_FA23';
            """.strip()
        
        elif "courses" in question and ("taking" in question or "enrolled" in question) and "semester" in question:
            # Query for courses a student is taking this semester (SU24 based on demo time)
            if request.user_id:
                return demo_comment + f"""
SELECT c.course_name, cc.semester, e.status
FROM Enrollments e 
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
JOIN Courses c ON cc.course_id = c.course_id 
WHERE e.student_id = '{request.user_id}' 
  AND cc.semester = 'SU24'  -- Current semester based on demo time (June 2024)
  AND e.status = 'Studying';
                """.strip()
            else:
                if self.database_type == "sqlite":
                    return "SELECT * FROM Courses LIMIT 10;"
                else:
                    return "SELECT TOP 10 * FROM Courses;"
        
        elif "grades" in question or "average" in question:
            # Query for student grades/average
            if request.user_id:
                return f"""
SELECT c.course_name, e.average, e.status, cc.semester
FROM Enrollments e 
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
JOIN Courses c ON cc.course_id = c.course_id 
WHERE e.student_id = '{request.user_id}'
ORDER BY cc.semester DESC;
                """.strip()
            else:
                return "SELECT AVG(average) as overall_average FROM Enrollments WHERE status = 'Passed';"
        
        elif "schedule" in question or "timetable" in question:
            # Query for class schedule (considering demo time is Saturday 22:00)
            if request.user_id:
                time_context = ""
                if "today" in question or "now" in question:
                    time_context = "  AND s.day_of_week = 'Saturday'  -- Demo time: Saturday June 15, 2024\n"
                elif "this week" in question:
                    time_context = "  -- Demo time context: Week of June 15, 2024\n"
                
                return demo_comment + f"""
SELECT c.course_name, s.start_time, s.end_time, s.room, s.slot, s.day_of_week
FROM Enrollments e 
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
JOIN Courses c ON cc.course_id = c.course_id
JOIN Schedules s ON cc.class_course_id = s.class_course_id
WHERE e.student_id = '{request.user_id}' 
  AND cc.semester = 'SU24'  -- Current semester based on demo time
  AND e.status = 'Studying'
{time_context}ORDER BY s.day_of_week, s.start_time;
                """.strip()
            else:
                if self.database_type == "sqlite":
                    return "SELECT * FROM Schedules LIMIT 10;"
                else:
                    return "SELECT TOP 10 * FROM Schedules;"
        
        elif "attendance" in question:
            # Query for attendance
            if request.user_id:
                return f"""
SELECT c.course_name, s.start_time, a.status
FROM Attendance a
JOIN Enrollments e ON a.enrollment_id = e.enrollment_id
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
JOIN Courses c ON cc.course_id = c.course_id
JOIN Schedules s ON a.schedule_id = s.schedule_id
WHERE e.student_id = '{request.user_id}'
  AND cc.semester = 'SU24'
ORDER BY s.start_time DESC;
                """.strip()
        
        elif "lecturer" in question or "teacher" in question:
            # Query for lecturers
            if request.user_id:
                return f"""
SELECT DISTINCT u.fullname as lecturer_name, c.course_name, cc.semester
FROM Enrollments e 
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
JOIN Courses c ON cc.course_id = c.course_id
JOIN Lecturers l ON cc.lecturer_id = l.lecturer_id
JOIN Users u ON l.lecturer_id = u.user_id
WHERE e.student_id = '{request.user_id}' AND cc.semester = 'SU24';
                """.strip()
        
        elif "course" in question or "courses" in question:
            if request.user_id:
                return f"""
SELECT c.course_name, e.average, e.status, cc.semester
FROM Enrollments e 
JOIN ClassCourse cc ON e.class_course_id = cc.class_course_id
JOIN Courses c ON cc.course_id = c.course_id 
WHERE e.student_id = '{request.user_id}'
ORDER BY cc.semester DESC;
                """.strip()
            else:
                if self.database_type == "sqlite":
                    return "SELECT course_name, no_credit FROM Courses LIMIT 10;"
                else:
                    return "SELECT TOP 10 course_name, no_credit FROM Courses;"
        
        # Default fallback
        return demo_comment + f"SELECT 'Mock SQL generated for testing at demo time: {demo_time}' as result;"

    def _create_sql_prompt(self, request: SQLGenerationRequest) -> str:
        """Create prompt for SQL generation with demo time context"""
        if self.database_type == "sqlite":
            db_name = "SQLite (in-memory demo)"
            expert_type = "SQLite developer"
        else:
            db_name = "Microsoft SQL Server (text_to_sql_final)"
            expert_type = "Microsoft SQL Server developer"
            
        # Get demo timestamp for context
        demo_time = get_demo_timestamp()
        
        prompt = f"""
You are an expert {expert_type}. Generate a SQL query specifically for {self.database_type.upper()} based on the user's question and context.

🎭 DEMO MODE CONTEXT:
- CURRENT DEMO TIME: {demo_time} (15th June 2024, 22:00)
- ALL QUERIES run in context of this FIXED timestamp
- When user asks about "current", "today", "now", "this semester" - use this demo time as reference
- Demo database contains data consistent with this timestamp
- Academic context: Evening time (22:00) on June 15th, 2024

DATABASE: {db_name}
DATABASE SCHEMA:
{self.schema_info}

USER QUESTION: {request.user_question}
USER ID: {request.user_id}
USER ROLE: {request.user_role}
QUERY TIMESTAMP: {request.timestamp} (Demo fixed time)

ENRICHED CONTEXT:
{request.enriched_context}

{self._get_database_requirements()}

QUERY CONSTRAINTS:
- Only SELECT queries allowed for security
- Must respect user role permissions (filter by user_id when needed)
- Use proper WHERE clauses for data access control
- Include appropriate error handling in complex queries
- Optimize for {self.database_type.upper()} query execution{"" if self.database_type == "sqlite" else " plans"}

📅 DEMO TIME-AWARE CONTEXT:
- FIXED DEMO DATE: June 15th, 2024 (Saturday)
- FIXED DEMO TIME: 22:00 (10:00 PM - Evening)
- Current academic semester: 'SU24' (Summer 2024)
- Academic year follows: FA (Fall), SP (Spring), SU (Summer)
- When user asks about "current semester" → use 'SU24'
- When user asks about "today's schedule" → consider it's Saturday evening (22:00)
- When user asks about "this week" → week of June 15, 2024
- When user asks about "recent" → relative to June 15, 2024

🎯 DEMO DATABASE CONTEXT:
- Student IDs format: HE##### (e.g., HE00001, HE00002)
- Course IDs format: 3 letters + 3 numbers (e.g., AIL301, CSD201, PRF192)
- Class naming: [Major]_K[num]_[semester] (e.g., AI_K1_FA23, SE_K1_FA23)
- Semester codes: SU24 (current), SP24 (previous), FA23 (earlier)
- Evening time context: Most classes would be finished by 22:00

🔍 TIME-SENSITIVE QUERY GUIDANCE:
- "What classes do I have today?" → Check Saturday schedule for June 15, 2024
- "Current semester courses" → Filter by semester = 'SU24'
- "Recent grades" → Show latest semester results
- "This week's schedule" → Week containing June 15, 2024
- "Upcoming classes" → Classes after 22:00 on June 15 or next days

Generate only the SQL query for {self.database_type.upper()}, considering the demo time context:
"""
        return prompt

    def generate_sql(self, request: SQLGenerationRequest) -> Tuple[bool, str, float, str]:
        """Generate SQL query using Gemini AI"""
        if not self.llm_enabled:
            mock_sql = self._mock_sql_generation(request)
            return True, mock_sql, 0.7, "Generated using fallback mode"
        
        try:
            prompt = self._create_sql_prompt(request)
            
            response = self.model.generate_content(prompt)
            response_text = response.text.strip()
            
            # Extract SQL from response
            sql_query = self._extract_sql_from_response(response_text)
            
            if sql_query:
                confidence = self._calculate_confidence(request, sql_query)
                return True, sql_query, confidence, "SQL generated successfully"
            else:
                fallback_sql = self._mock_sql_generation(request)
                return True, fallback_sql, 0.5, "Used fallback SQL generation"
                
        except Exception as e:
            logger.error(f"Gemini SQL generation failed: {e}")
            fallback_sql = self._mock_sql_generation(request)
            return True, fallback_sql, 0.3, f"Fallback due to error: {str(e)}"

    def _extract_sql_from_response(self, response_text: str) -> Optional[str]:
        """Extract SQL query from AI response"""
        # Remove markdown code blocks
        if "```sql" in response_text:
            start = response_text.find("```sql") + 6
            end = response_text.find("```", start)
            if end != -1:
                return response_text[start:end].strip()
        
        # Look for SQL keywords
        lines = response_text.split('\n')
        for line in lines:
            line = line.strip()
            if line.upper().startswith(('SELECT', 'WITH', 'INSERT', 'UPDATE', 'DELETE')):
                return line
        
        return None

    def _calculate_confidence(self, request: SQLGenerationRequest, sql: str) -> float:
        """Calculate confidence score for generated SQL"""
        confidence = 0.5  # Base confidence
        
        # Check if SQL contains relevant entities from context
        context = request.enriched_context
        
        if isinstance(context, dict):
            entities = context.get('entities', {})
            for entity_type, entity_list in entities.items():
                for entity in entity_list:
                    if entity in sql:
                        confidence += 0.1
        
        # Check for proper SQL structure
        if 'SELECT' in sql.upper():
            confidence += 0.1
        if 'FROM' in sql.upper():
            confidence += 0.1
        if 'WHERE' in sql.upper():
            confidence += 0.1
        
        return min(confidence, 1.0)

class ComprehensiveSQLGenerator:
    """Main SQL Generator orchestrator"""
    
    def __init__(self, gemini_api_key: Optional[str] = None, db_connection_string: Optional[str] = None):
        self.db_connection = DatabaseConnection(db_connection_string)
        
        # Connect to database first to determine type
        if not self.db_connection.connect():
            logger.warning("Database connection failed, results will be simulation only")
            
        # Initialize Gemini generator with database type
        self.gemini_generator = GeminiSQLGenerator(gemini_api_key, self.db_connection.database_type)
    
    def generate_and_execute_sql(self, request: SQLGenerationRequest) -> SQLGenerationResult:
        """Main method to generate and execute SQL"""
        print("\n" + "="*70)
        print("🔧 SQL GENERATION & EXECUTION")
        print("="*70)
        print(f"📝 Question: {request.user_question}")
        print(f"👤 User: {request.user_id} ({request.user_role})")
        print(f"⏰ Timestamp: {request.timestamp}")
        print(f"✅ Permission Passed: {request.permission_check_passed}")
        print("-"*70)
        
        start_time = time.time()
        
        try:
            # Step 1: Generate SQL using Gemini
            print("🤖 Step 1: AI SQL Generation...")
            logger.info(f"Generating SQL for question: {request.user_question}")
            
            success, generated_sql, confidence, message = self.gemini_generator.generate_sql(request)
            
            if not success:
                print("❌ FAILED: SQL generation failed")
                print(f"   Error: {message}")
                print("="*70 + "\n")
                return SQLGenerationResult(
                    success=False,
                    generated_sql=generated_sql,
                    execution_result=None,
                    error_message=message,
                    execution_time_ms=(time.time() - start_time) * 1000,
                    confidence_score=confidence,
                    metadata={"step": "sql_generation", "user_id": request.user_id}
                )
            
            print(f"✅ SQL Generated Successfully!")
            print(f"   📊 Confidence Score: {confidence:.2f}")
            print(f"   💭 Generation Method: {message}")
            print(f"   📝 Generated SQL:")
            for line in generated_sql.split('\n'):
                if line.strip():
                    print(f"      {line}")
            
            logger.info(f"Generated SQL: {generated_sql}")
            
            # Step 2: Execute SQL query
            print("\n🗄️  Step 2: SQL Execution...")
            if self.db_connection.connection:
                print("   🔌 Database connected - executing query...")
                exec_success, result, exec_message = self.db_connection.execute_query(generated_sql)
                
                if exec_success:
                    total_time = (time.time() - start_time) * 1000
                    
                    print("✅ SQL Executed Successfully!")
                    print(f"   📋 Execution Message: {exec_message}")
                    print(f"   📊 Query Results:")
                    if isinstance(result, list) and result:
                        print(f"      • Result Count: {len(result)} rows")
                        if len(result) <= 3:
                            for i, row in enumerate(result, 1):
                                print(f"      • Row {i}: {row}")
                        else:
                            for i, row in enumerate(result[:2], 1):
                                print(f"      • Row {i}: {row}")
                            print(f"      ... and {len(result)-2} more rows")
                    else:
                        print(f"      • Result: {result}")
                    
                    print(f"\n🎉 SQL GENERATION & EXECUTION COMPLETED!")
                    print(f"⏱️  Total Execution Time: {total_time:.2f}ms")
                    print(f"📊 Final Confidence: {confidence:.2f}")
                    print("="*70 + "\n")
                    
                    return SQLGenerationResult(
                        success=True,
                        generated_sql=generated_sql,
                        execution_result=result,
                        error_message=None,
                        execution_time_ms=total_time,
                        confidence_score=confidence,
                        metadata={
                            "step": "sql_execution",
                            "user_id": request.user_id,
                            "sql_generation_message": message,
                            "execution_message": exec_message
                        }
                    )
                else:
                    print("❌ FAILED: SQL execution failed")
                    print(f"   Error: {exec_message}")
                    print("="*70 + "\n")
                    return SQLGenerationResult(
                        success=False,
                        generated_sql=generated_sql,
                        execution_result=None,
                        error_message=f"SQL execution failed: {exec_message}",
                        execution_time_ms=(time.time() - start_time) * 1000,
                        confidence_score=confidence,
                        metadata={"step": "sql_execution", "user_id": request.user_id}
                    )
            else:
                # Database not connected - return simulated result
                total_time = (time.time() - start_time) * 1000
                
                print("⚠️  Database not connected - simulation mode")
                print(f"   💡 SQL would be executed in production environment")
                print(f"\n🎉 SQL GENERATION COMPLETED (SIMULATION)!")
                print(f"⏱️  Total Generation Time: {total_time:.2f}ms")
                print(f"📊 Generation Confidence: {confidence:.2f}")
                print("="*70 + "\n")
                
                return SQLGenerationResult(
                    success=True,
                    generated_sql=generated_sql,
                    execution_result="[Simulated] SQL would be executed in production environment",
                    error_message=None,
                    execution_time_ms=total_time,
                    confidence_score=confidence,
                    metadata={
                        "step": "simulation",
                        "user_id": request.user_id,
                        "message": "Database not connected - simulation mode"
                    }
                )
                
        except Exception as e:
            error_msg = f"SQL generation and execution failed: {str(e)}"
            total_time = (time.time() - start_time) * 1000
            
            print("❌ ERROR: SQL generation and execution failed")
            print(f"   Error: {str(e)}")
            print(f"   Time: {total_time:.2f}ms")
            print("="*70 + "\n")
            
            logger.error(error_msg)
            
            return SQLGenerationResult(
                success=False,
                generated_sql=None,
                execution_result=None,
                error_message=error_msg,
                execution_time_ms=total_time,
                confidence_score=0.0,
                metadata={"step": "error", "user_id": request.user_id}
            )
    
    def __del__(self):
        """Cleanup database connection"""
        if hasattr(self, 'db_connection'):
            self.db_connection.close()