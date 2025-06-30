"""
Text-to-SQL Pipeline Demo

Simple demonstration of the pipeline functionality.
"""

import time
from main_pipeline import TextToSQLPipeline

def simple_demo():
    """Simple pipeline demonstration"""
    print("Text-to-SQL Pipeline Demo")
    print("=" * 40)
    
    # Initialize pipeline
    pipeline = TextToSQLPipeline()
    
    # Check pipeline status
    status = pipeline.get_pipeline_status()
    print("\nPipeline Status:")
    for module, state in status["modules"].items():
        print(f"  {module}: {state}")
    
    if not status["ready"]:
        print("\nPipeline not fully ready - some modules missing")
        return
    
    # Test query
    print("\nTest Query:")
    test_question = "What is my name?"
    print(f"Question: {test_question}")
    
    # Process query
    result = pipeline.process_query(
        user_question=test_question,
        user_id="HE00001",
        user_role="Student",
        timestamp="10:00 20/6/2024"
    )
    
    # Display results
    print(f"\nResults:")
    print(f"  Status: {result.status.value}")
    print(f"  Success: {result.success}")
    print(f"  Execution Time: {result.execution_time_ms:.2f}ms")
    
    if result.sql_result and result.sql_result.success:
        print(f"  Generated SQL: {result.sql_result.generated_sql}")
        if hasattr(result.sql_result, 'execution_result'):
            print(f"  Result Data: {result.sql_result.execution_result}")
    
    if not result.success:
        print(f"  Error: {result.error_message}")
        if result.blocked_at_step:
            print(f"  Blocked at: {result.blocked_at_step}")

def status_check():
    """Check pipeline module status"""
    print("Pipeline Status Check")
    print("=" * 30)
    
    pipeline = TextToSQLPipeline()
    status = pipeline.get_pipeline_status()
    
    print(f"Pipeline Version: {status['pipeline_version']}")
    print(f"Initialization Time: {status['initialization_time']}")
    print(f"Ready: {status['ready']}")
    print("\nModule Status:")
    
    for module, state in status["modules"].items():
        print(f"  {module}: {state}")

def test_queries():
    """Test sample queries"""
    pipeline = TextToSQLPipeline()
    
    # List of test cases - ADD YOUR QUESTIONS HERE
    test_cases = [
        # {
        #     "question": "What courses am I taking this semester?",
        #     "user_id": "HE00001",
        #     "user_role": "Student",
        #     "timestamp": "10:00 15/6/2024"
        # },
        # {
        #     "question": "What are my grades in course AIL301?",
        #     "user_id": "HE00001",
        #     "user_role": "Student",
        #     "timestamp": "10:30 15/6/2024"
        # },
        # {
        #     "question": "How many students are in class SE04?",
        #     "user_id": "HE00001",
        #     "user_role": "Student",
        #     "timestamp": "11:00 15/6/2024"
        # },
    ]
    
    print("Testing Text-to-SQL Pipeline")
    print("=" * 50)
    
    for i, test in enumerate(test_cases, 1):
        print(f"\nTest {i}: {test['question']}")
        print("-" * 40)
        
        result = pipeline.process_query(
            user_question=test["question"],
            user_id=test["user_id"],
            user_role=test["user_role"], 
            timestamp=test["timestamp"]
        )
        
        # Hiển thị kết quả
        print(f"Status: {result.status.value}")
        print(f"Success: {result.success}")
        print(f"Time: {result.execution_time_ms:.2f}ms")
        
        if result.success and result.sql_result:
            print(f"SQL: {result.sql_result.generated_sql}")
            print(f"Result: {result.sql_result.execution_result}")
        
        if not result.success:
            print(f"Error: {result.error_message}")
            print(f"Blocked at: {result.blocked_at_step}")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        if sys.argv[1] == "--status":
            status_check()
        elif sys.argv[1] == "--demo":
            simple_demo()
        elif sys.argv[1] == "--test":
            if len(sys.argv) > 2:
                # Test specific query
                test_question = sys.argv[2]
                pipeline = TextToSQLPipeline()
                result = pipeline.process_query(
                    user_question=test_question,
                    user_id="HE00001",
                    user_role="Student",
                    timestamp="10:00 20/6/2024"
                )
                print(f"Query: {test_question}")
                print(f"Status: {result.status.value}")
                print(f"Success: {result.success}")
                print(f"Time: {result.execution_time_ms:.2f}ms")
                if result.success and result.sql_result:
                    print(f"SQL: {result.sql_result.generated_sql}")
                if not result.success:
                    print(f"Error: {result.error_message}")
            else:
                test_queries()
        else:
            print("Usage: python demo.py [--status|--demo|--test [query]]")
            print("  --status    : Check pipeline module status")
            print("  --demo      : Run basic demo")
            print("  --test      : Run multiple test queries")
            print("  --test 'query' : Test specific query")
    else:
        simple_demo() 