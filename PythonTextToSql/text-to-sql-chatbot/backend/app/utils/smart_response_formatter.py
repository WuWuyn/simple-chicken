"""
Smart Response Formatter for Text-to-SQL Chatbot
Generates human-friendly responses instead of technical output
"""

import os
import re
import logging
from typing import Dict, Any, List, Optional, Tuple
from datetime import datetime

try:
    import google.generativeai as genai
    # Test if the required functions are available
    if hasattr(genai, 'configure') and hasattr(genai, 'GenerativeModel'):
        GENAI_AVAILABLE = True
    else:
        GENAI_AVAILABLE = False
        print("Google GenerativeAI version does not support required features")
except ImportError:
    GENAI_AVAILABLE = False
    genai = None
    print("Google GenerativeAI not available for smart formatting")

# Setup logging
logger = logging.getLogger(__name__)

class SmartResponseFormatter:
    """
    Intelligently formats SQL query results into human-friendly responses
    """
    
    def __init__(self, gemini_api_key: Optional[str] = None):
        self.gemini_api_key = gemini_api_key or os.getenv("GOOGLE_API_KEY") or os.getenv("GEMINI_API_KEY")
        self.llm_enabled = False
        
        if self.gemini_api_key and GENAI_AVAILABLE:
            try:
                # Additional safety check
                if genai is not None:
                    genai.configure(api_key=self.gemini_api_key)
                    self.model = genai.GenerativeModel('gemini-2.0-flash')
                    self.llm_enabled = True
                    logger.info("Smart Response Formatter initialized with Gemini")
                else:
                    logger.warning("Gemini module is None despite GENAI_AVAILABLE being True")
            except Exception as e:
                logger.warning(f"Failed to initialize Gemini for response formatting: {e}")
        
        # Pre-defined response patterns for common queries
        self.response_patterns = {
            # Greeting and conversational queries
            'greeting': {
                'keywords': ['hello', 'hi', 'hey', 'good morning', 'good afternoon', 'good evening', 'greetings'],
                'template': lambda data: self._format_greeting_response(data),
                'fallback': "Hello! I'm your academic assistant. How can I help you today?"
            },
            'casual': {
                'keywords': ['how are you', 'thanks', 'thank you', 'bye', 'goodbye', 'see you'],
                'template': lambda data: self._format_casual_response(data),
                'fallback': "Thank you! Is there anything else I can help you with regarding your academic information?"
            },
            # Personal info queries
            'name': {
                'keywords': ['name', 'who am i', 'my name'],
                'template': lambda data: f"Your name is {self._extract_name(data)}.",
                'fallback': "Here's your personal information:"
            },
            'info': {
                'keywords': ['info', 'information', 'profile', 'personal', 'details'],
                'template': lambda data: self._format_personal_info(data),
                'fallback': "Here's your information:"
            },
            # Course queries
            'courses': {
                'keywords': ['course', 'subject', 'class', 'classes', 'study', 'studying'],
                'template': lambda data: self._format_courses_info(data),
                'fallback': "Here are your courses:"
            },
            'schedule': {
                'keywords': ['schedule', 'timetable', 'time', 'when', 'class time'],
                'template': lambda data: self._format_schedule_info(data),
                'fallback': "Here's your schedule:"
            },
            'grades': {
                'keywords': ['grade', 'grades', 'average', 'score', 'result', 'performance'],
                'template': lambda data: self._format_grades_info(data),
                'fallback': "Here are your grades:"
            },
            # General queries
            'count': {
                'keywords': ['how many', 'count', 'number of', 'total'],
                'template': lambda data: self._format_count_info(data),
                'fallback': "Here's the count information:"
            }
        }
    
    def format_response(self, 
                       user_question: str, 
                       results: List[Dict[str, Any]], 
                       user_id: str = "",
                       user_role: str = "",
                       execution_time_ms: float = 0.0) -> str:
        """
        Main method to format response based on user question and results
        """
        try:
            # First, try intelligent LLM-based formatting
            if self.llm_enabled and results:
                llm_response = self._format_with_llm(user_question, results, user_id, user_role)
                if llm_response:
                    return llm_response
            
            # Fallback to rule-based formatting
            return self._format_with_rules(user_question, results, user_id, user_role)
            
        except Exception as e:
            logger.error(f"Error in smart response formatting: {e}")
            # Ultimate fallback
            return self._format_simple_fallback(results)
    
    def _format_with_llm(self, user_question: str, results: List[Dict], user_id: str, user_role: str) -> Optional[str]:
        """Format response using Gemini LLM"""
        try:
            # Prepare context for LLM
            results_text = self._format_results_for_llm(results)
            
            prompt = f"""
You are a friendly academic assistant chatbot. Your main role is to help students with their academic information, but you should also respond naturally to greetings and casual conversation.

USER QUESTION: {user_question}
USER ID: {user_id}
USER ROLE: {user_role}

QUERY RESULTS:
{results_text}

INSTRUCTIONS:
1. If the user is greeting you (hello, hi, etc.) or having casual conversation, respond warmly and offer to help
2. If there are no meaningful results but the user is asking about academic data, apologize politely and suggest what they might ask about
3. For academic data queries, format results naturally and conversationally
4. Use "you" and "your" when referring to the user's data
5. Be concise but informative and friendly
6. Don't mention technical details like "database" or "query results"
7. If it's personal information (name, grades, courses), address the user directly
8. For counts or statistics, present the numbers clearly
9. Use English and keep responses under 200 words
10. Always maintain a helpful and friendly tone

RESPONSE EXAMPLES:
- Greeting: "Hello! I'm your academic assistant. How can I help you today?"
- No data found: "I couldn't find that information right now. You can ask me about your courses, grades, schedule, or personal details."
- Name query: "Your name is John Smith."
- Courses: "You are currently taking 3 courses this semester: AI, Data Structures, and Programming."
- Grades: "Your average grade is 8.5. You're doing well!"

Generate a natural, friendly response:
"""
            
            response = self.model.generate_content(prompt)
            formatted_response = response.text.strip()
            
            # Basic validation
            if len(formatted_response) > 10 and len(formatted_response) < 500:
                return formatted_response
                
        except Exception as e:
            logger.error(f"LLM formatting failed: {e}")
        
        return None
    
    def _format_with_rules(self, user_question: str, results: List[Dict], user_id: str, user_role: str) -> str:
        """Format response using rule-based patterns"""
        # Detect query type first
        query_type = self._detect_query_type(user_question)
        
        # Handle specific query types even with empty results
        if query_type in self.response_patterns:
            pattern = self.response_patterns[query_type]
            
            # For greeting and casual queries, always use fallback (they don't need data)
            if query_type in ['greeting', 'casual']:
                return pattern['fallback']
            
            # For data queries, try template first, then fallback
            if results:
                try:
                    return pattern['template'](results)
                except Exception as e:
                    logger.warning(f"Template formatting failed for {query_type}: {e}")
                    return pattern['fallback'] + "\n" + self._format_simple_results(results)
            else:
                # No results for data query - provide helpful message
                return self._format_no_data_response(query_type, user_question)
        
        # Handle empty results for general queries
        if not results:
            return self._format_no_data_response('general', user_question)
        
        # Default rule-based formatting for non-empty results
        return self._format_simple_results(results)
    
    def _format_no_data_response(self, query_type: str, user_question: str) -> str:
        """Provide helpful responses when no data is found"""
        question_lower = user_question.lower()
        
        # Check if it's a greeting or casual conversation
        greeting_words = ['hello', 'hi', 'hey', 'good morning', 'good afternoon', 'good evening']
        casual_words = ['how are you', 'thanks', 'thank you', 'bye', 'goodbye']
        
        if any(word in question_lower for word in greeting_words):
            return "Hello! I'm your academic assistant. How can I help you today?"
        
        if any(word in question_lower for word in casual_words):
            return "Thank you! Is there anything else I can help you with regarding your academic information?"
        
        # Provide specific suggestions based on query type
        if query_type == 'name' or 'name' in question_lower:
            return "I couldn't find your name information. Please make sure you're logged in correctly."
        elif query_type == 'courses' or any(word in question_lower for word in ['course', 'subject', 'class']):
            return "I couldn't find your course information. You can ask me about your enrolled courses, schedule, or grades."
        elif query_type == 'grades' or any(word in question_lower for word in ['grade', 'score', 'result']):
            return "I couldn't find your grade information. You can ask about your grades for specific courses or your overall average."
        elif query_type == 'schedule' or any(word in question_lower for word in ['schedule', 'time', 'when']):
            return "I couldn't find your schedule information. You can ask about your class schedule or specific course times."
        else:
            return "I couldn't find that information right now. You can ask me about your courses, grades, schedule, or personal details."
    
    def _detect_query_type(self, question: str) -> str:
        """Detect the type of query based on keywords"""
        question_lower = question.lower()
        
        for query_type, pattern in self.response_patterns.items():
            if any(keyword in question_lower for keyword in pattern['keywords']):
                return query_type
        
        return 'general'
    
    def _extract_name(self, results: List[Dict]) -> str:
        """Extract name from results"""
        if not results or not isinstance(results[0], dict):
            return "Unknown"
        
        first_result = results[0]
        
        # Look for name fields
        name_fields = ['fullname', 'full_name', 'name', 'student_name', 'lecturer_name']
        for field in name_fields:
            if field in first_result and first_result[field]:
                return str(first_result[field])
        
        # If no name field found, return first value
        return str(list(first_result.values())[0]) if first_result.values() else "Unknown"
    
    def _format_personal_info(self, results: List[Dict]) -> str:
        """Format personal information"""
        if not results or not isinstance(results[0], dict):
            return "I couldn't retrieve your personal information."
        
        info = results[0]
        response_parts = []
        
        # Name
        if 'fullname' in info or 'full_name' in info:
            name = info.get('fullname') or info.get('full_name')
            response_parts.append(f"Your name is {name}")
        
        # Student ID
        if 'student_id' in info or 'user_id' in info:
            student_id = info.get('student_id') or info.get('user_id')
            response_parts.append(f"your student ID is {student_id}")
        
        # Major
        if 'major_id' in info:
            response_parts.append(f"you're studying {info['major_id']}")
        
        # Gender
        if 'user_gender' in info:
            response_parts.append(f"gender: {info['user_gender']}")
        
        if response_parts:
            # Capitalize first letter and join with proper punctuation
            response = response_parts[0].capitalize()
            if len(response_parts) > 1:
                response += ", " + ", ".join(response_parts[1:-1])
                if len(response_parts) > 2:
                    response += ", and " + response_parts[-1]
                else:
                    response += " and " + response_parts[-1]
            response += "."
            return response
        
        return "Here's your information: " + self._format_simple_results(results)
    
    def _format_courses_info(self, results: List[Dict]) -> str:
        """Format course information"""
        if not results:
            return "You don't have any courses registered."
        
        if len(results) == 1:
            course_name = results[0].get('course_name', 'Unknown Course')
            status = results[0].get('status', '')
            if status:
                return f"You are {status.lower()} {course_name}."
            return f"You are taking {course_name}."
        
        course_names = []
        for result in results[:5]:  # Limit to 5 courses
            course_name = result.get('course_name', 'Unknown Course')
            course_names.append(course_name)
        
        if len(results) <= 5:
            courses_text = ", ".join(course_names[:-1]) + f" and {course_names[-1]}" if len(course_names) > 1 else course_names[0]
            return f"You are taking {len(results)} course{'s' if len(results) > 1 else ''}: {courses_text}."
        else:
            courses_text = ", ".join(course_names[:3])
            return f"You are taking {len(results)} courses including {courses_text} and {len(results)-3} others."
    
    def _format_schedule_info(self, results: List[Dict]) -> str:
        """Format schedule information"""
        if not results:
            return "You don't have any scheduled classes."
        
        if len(results) == 1:
            schedule = results[0]
            course = schedule.get('course_name', 'Unknown Course')
            time = schedule.get('start_time', 'Unknown Time')
            room = schedule.get('room', '')
            
            response = f"You have {course} at {time}"
            if room:
                response += f" in room {room}"
            response += "."
            return response
        
        return f"You have {len(results)} scheduled classes today."
    
    def _format_grades_info(self, results: List[Dict]) -> str:
        """Format grades information"""
        if not results:
            return "No grade information available."
        
        if len(results) == 1:
            grade_info = results[0]
            
            # Single course grade
            if 'course_name' in grade_info and 'average' in grade_info:
                course = grade_info['course_name']
                grade = grade_info['average']
                status = grade_info.get('status', '')
                response = f"Your grade in {course} is {grade}"
                if status:
                    response += f" (status: {status})"
                response += "."
                return response
            
            # Overall average
            if 'average' in grade_info:
                avg = grade_info['average']
                return f"Your average grade is {avg}."
        
        # Multiple grades
        total_avg = 0
        course_count = 0
        for result in results:
            if 'average' in result and result['average']:
                total_avg += float(result['average'])
                course_count += 1
        
        if course_count > 0:
            overall_avg = total_avg / course_count
            return f"You have grades for {len(results)} courses with an overall average of {overall_avg:.1f}."
        
        return f"You have grade records for {len(results)} courses."
    
    def _format_count_info(self, results: List[Dict]) -> str:
        """Format count/statistics information"""
        if not results:
            return "No data found for your query."
        
        if len(results) == 1 and len(results[0]) == 1:
            # Single count result
            value = list(results[0].values())[0]
            if isinstance(value, (int, float)):
                return f"The count is {value}."
        
        return self._format_simple_results(results)
    
    def _format_greeting_response(self, results: List[Dict]) -> str:
        """Format greeting responses"""
        # Check if there's a greeting message in the results
        if results and isinstance(results[0], dict):
            for key, value in results[0].items():
                if 'greeting' in key.lower() or 'hello' in str(value).lower():
                    return str(value)
        
        # Default friendly greeting
        return "Hello! I'm your academic assistant. How can I help you today?"
    
    def _format_casual_response(self, results: List[Dict]) -> str:
        """Format casual conversation responses"""
        # Check if there's a specific response in the results
        if results and isinstance(results[0], dict):
            for key, value in results[0].items():
                if any(word in key.lower() for word in ['response', 'message', 'reply']):
                    return str(value)
        
        # Default friendly response
        return "Thank you! Is there anything else I can help you with regarding your academic information?"
    
    def _format_simple_results(self, results: List[Dict]) -> str:
        """Simple fallback formatting"""
        if not results:
            return "No results found."
        
        if len(results) == 1:
            result = results[0]
            if len(result) == 1:
                key, value = list(result.items())[0]
                return f"The {key.replace('_', ' ')} is {value}."
            else:
                parts = [f"{key.replace('_', ' ')}: {value}" for key, value in result.items()]
                return ", ".join(parts) + "."
        
        return f"Found {len(results)} result{'s' if len(results) > 1 else ''}."
    
    def _format_simple_fallback(self, results: List[Dict]) -> str:
        """Ultimate fallback formatting"""
        if not results:
            return "I couldn't find any information for your question."
        
        return f"I found {len(results)} result{'s' if len(results) > 1 else ''} for your question."
    
    def _format_results_for_llm(self, results: List[Dict]) -> str:
        """Format results for LLM input"""
        if not results:
            return "No results"
        
        formatted_results = []
        for i, result in enumerate(results[:5], 1):  # Limit to 5 results
            if isinstance(result, dict):
                result_text = ", ".join([f"{k}: {v}" for k, v in result.items()])
                formatted_results.append(f"Row {i}: {result_text}")
            else:
                formatted_results.append(f"Row {i}: {result}")
        
        if len(results) > 5:
            formatted_results.append(f"... and {len(results)-5} more rows")
        
        return "\n".join(formatted_results)

    def format_security_response(self, user_question: str, blocked_step: str, error_message: str, user_id: str = "", user_role: str = "") -> str:
        """Format security-blocked responses in a user-friendly way"""
        try:
            # First try with LLM if available
            if self.llm_enabled:
                llm_response = self._format_security_with_llm(user_question, blocked_step, error_message, user_id, user_role)
                if llm_response:
                    return llm_response
            
            # Fallback to rule-based security messages
            return self._format_security_with_rules(user_question, blocked_step, error_message)
            
        except Exception as e:
            logger.error(f"Error in security response formatting: {e}")
            return self._format_security_fallback(user_question)
    
    def _format_security_with_llm(self, user_question: str, blocked_step: str, error_message: str, user_id: str, user_role: str) -> Optional[str]:
        """Format security response using Gemini LLM"""
        try:
            prompt = f"""
You are a friendly academic assistant. A user's query was blocked for security reasons and you need to respond in a helpful, educational way.

USER QUESTION: {user_question}
USER ID: {user_id}
USER ROLE: {user_role}
BLOCKED AT: {blocked_step}
SECURITY ISSUE: {error_message}

INSTRUCTIONS:
1. Be friendly and understanding, not accusatory
2. Explain why the request couldn't be processed in simple terms
3. Suggest what the user CAN ask about instead
4. Keep it educational and helpful
5. Don't mention technical terms like "SQL injection" or "security validation"
6. Focus on what they can do rather than what they can't
7. Keep response under 150 words
8. Use a warm, helpful tone

EXAMPLES:
- For harmful queries: "I can't help with that type of request, but I'd be happy to help you find information about your courses, grades, or schedule!"
- For overly broad queries: "I can only show you information you have access to. Try asking about your specific courses or grades."
- For database modification attempts: "I can help you find information, but I can't make changes to records. What would you like to know about your academic data?"

Generate a helpful response:
"""
            
            response = self.model.generate_content(prompt)
            formatted_response = response.text.strip()
            
            # Basic validation
            if len(formatted_response) > 10 and len(formatted_response) < 300:
                return formatted_response
                
        except Exception as e:
            logger.error(f"LLM security formatting failed: {e}")
        
        return None
    
    def _format_security_with_rules(self, user_question: str, blocked_step: str, error_message: str) -> str:
        """Format security response using rules"""
        error_lower = error_message.lower() if error_message else ""
        question_lower = user_question.lower()
        
        # Handle different types of security violations with friendly messages
        if "sql injection" in error_lower:
            return (
                "I can't process that request as it seems to contain database commands. "
                "Please ask me about your academic information in a natural way, like 'What are my grades?' or 'Show me my courses.'"
            )
        
        elif "prompt injection" in error_lower:
            return (
                "I'm here to help with your academic questions! "
                "Feel free to ask about your courses, grades, schedule, or personal information."
            )
        
        elif "data leaking" in error_lower or "unauthorized access" in error_lower:
            return (
                "I can only show you information you have permission to access. "
                "Try asking about your own courses, grades, or schedule."
            )
        
        elif "role escalation" in error_lower:
            return (
                "I can only provide information appropriate for your role. "
                "You can ask about your own academic data, but I can't access other users' information."
            )
        
        elif "forbidden operation" in error_lower:
            return (
                "I can help you find information, but I can't make changes to records. "
                "What would you like to know about your academic data?"
            )
        
        elif "format validation" in error_lower:
            return (
                "There seems to be an issue with your request. "
                "Please try asking your question in a simple way, like 'What courses am I taking?'"
            )
        
        elif "user behavior" in error_lower or "suspicious" in error_lower:
            return (
                "For security reasons, please stick to asking about your academic information. "
                "I'm here to help with questions about your courses, grades, and schedules!"
            )
        
        else:
            return self._format_security_fallback(user_question)
    
    def _format_security_fallback(self, user_question: str) -> str:
        """Fallback security message"""
        return (
            "I couldn't process that request, but I'm here to help! "
            "Try asking about your courses, grades, schedule, or personal information."
        )

# Singleton instance
_formatter_instance = None

def get_smart_formatter() -> SmartResponseFormatter:
    """Get singleton instance of SmartResponseFormatter"""
    global _formatter_instance
    if _formatter_instance is None:
        _formatter_instance = SmartResponseFormatter()
    return _formatter_instance 