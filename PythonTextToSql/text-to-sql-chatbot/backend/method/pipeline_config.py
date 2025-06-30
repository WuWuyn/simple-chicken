"""
Pipeline Configuration
Centralized configuration management for Text-to-SQL Pipeline
"""

import os
from dataclasses import dataclass
from typing import Dict, Any, Optional

@dataclass
class PipelineConfig:
    """Configuration settings for the Text-to-SQL Pipeline"""
    
    # Module paths (relative to Method directory)
    lsh_index_path: str = "Offline/build_lsh_index/full_db_lsh.pkl"
    vector_db_path: str = "Offline/build_vector_db/vector_database"
    schema_file_path: str = "Offline/build_lsh_index/m-schema_final.txt"
    permissions_config_path: str = "Online/access_control/permissions.json"
    
    # Database configuration
    db_connection_string: str = ":memory:"  # SQLite in-memory for testing
    
    # API configuration
    use_gemini_llm: bool = True
    gemini_model_name: str = "gemini-2.0-flash"
    
    # Security settings
    enable_security_check: bool = True
    default_security_mode: str = "strict"  # "strict" or "permissive"
    
    # Value retrieval settings
    enable_lsh_search: bool = True
    enable_vector_search: bool = True
    similarity_threshold: float = 0.7
    max_entity_matches: int = 10
    max_context_matches: int = 5
    
    # Access control settings
    enable_permission_check: bool = True
    default_access_mode: str = "deny"  # "allow" or "deny"
    
    # Performance settings
    query_timeout_seconds: int = 30
    max_sql_execution_time: int = 10
    enable_caching: bool = False
    
    # Logging configuration
    log_level: str = "INFO"
    enable_detailed_logging: bool = True
    log_file_path: Optional[str] = None

def get_default_config() -> PipelineConfig:
    """Get default pipeline configuration"""
    return PipelineConfig()

def get_production_config() -> PipelineConfig:
    """Get production-ready configuration"""
    config = PipelineConfig()
    
    # Production database connection
    config.db_connection_string = os.getenv(
        'DATABASE_CONNECTION_STRING', 
        'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=TextToSQL;UID=user;PWD=password'
    )
    
    # Enhanced security
    config.default_security_mode = "strict"
    config.enable_security_check = True
    config.enable_permission_check = True
    
    # Performance optimization
    config.query_timeout_seconds = 15
    config.enable_caching = False
    
    # Production logging
    config.log_level = "WARNING"
    config.enable_detailed_logging = False
    config.log_file_path = "logs/pipeline.log"
    
    return config

def get_development_config() -> PipelineConfig:
    """Get development configuration with verbose logging"""
    config = PipelineConfig()
    
    # Development settings
    config.enable_detailed_logging = True
    config.log_level = "DEBUG"
    
    # More permissive for testing
    config.similarity_threshold = 0.5
    config.query_timeout_seconds = 60
    
    return config

def get_testing_config() -> PipelineConfig:
    """Get testing configuration with minimal dependencies"""
    config = PipelineConfig()
    
    # Testing overrides
    config.use_gemini_llm = False  # Use mock LLM for testing
    config.enable_lsh_search = False  # Use simple search
    config.enable_vector_search = False  # Use simple search
    config.enable_caching = False  # No caching for demo
    
    # Fast execution
    config.query_timeout_seconds = 5
    config.max_sql_execution_time = 2
    
    return config

# Environment-based configuration selector
def get_config_for_environment(env: str = None) -> PipelineConfig:
    """Get configuration based on environment"""
    if not env:
        env = os.getenv('PIPELINE_ENV', 'development')
    
    env = env.lower()
    
    if env == 'production':
        return get_production_config()
    elif env == 'testing':
        return get_testing_config()
    else:  # development
        return get_development_config()

# Path resolution utilities
def resolve_paths(config: PipelineConfig, base_dir: str = None) -> PipelineConfig:
    """Resolve relative paths to absolute paths"""
    if not base_dir:
        base_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Update paths to be absolute
    config.lsh_index_path = os.path.normpath(os.path.join(base_dir, config.lsh_index_path))
    config.vector_db_path = os.path.normpath(os.path.join(base_dir, config.vector_db_path))
    config.schema_file_path = os.path.normpath(os.path.join(base_dir, config.schema_file_path))
    config.permissions_config_path = os.path.normpath(os.path.join(base_dir, config.permissions_config_path))
    
    return config

# Configuration validation
def validate_config(config: PipelineConfig) -> Dict[str, Any]:
    """Validate configuration and return status"""
    validation_result = {
        "valid": True,
        "warnings": [],
        "errors": [],
        "missing_files": []
    }
    
    # Check file existence
    files_to_check = [
        ("LSH Index", config.lsh_index_path),
        ("Vector DB", config.vector_db_path), 
        ("Schema File", config.schema_file_path),
        ("Permissions Config", config.permissions_config_path)
    ]
    
    for name, path in files_to_check:
        if not os.path.exists(path):
            validation_result["missing_files"].append(f"{name}: {path}")
            validation_result["warnings"].append(f"Missing {name} at {path}")
    
    # Check environment variables
    if config.use_gemini_llm and not os.getenv('GOOGLE_API_KEY'):
        validation_result["warnings"].append("GOOGLE_API_KEY not found - LLM features may not work")
    
    # Validate thresholds
    if not 0 <= config.similarity_threshold <= 1:
        validation_result["errors"].append("similarity_threshold must be between 0 and 1")
        validation_result["valid"] = False
    
    if config.query_timeout_seconds <= 0:
        validation_result["errors"].append("query_timeout_seconds must be positive")
        validation_result["valid"] = False
    
    return validation_result

# Usage examples
if __name__ == "__main__":
    print("🔧 Pipeline Configuration Examples")
    print("=" * 50)
    
    # Show different configurations
    configs = {
        "Development": get_development_config(),
        "Production": get_production_config(), 
        "Testing": get_testing_config()
    }
    
    for name, config in configs.items():
        print(f"\n📋 {name} Configuration:")
        print(f"   Security Mode: {config.default_security_mode}")
        print(f"   Use Gemini LLM: {config.use_gemini_llm}")
        print(f"   Similarity Threshold: {config.similarity_threshold}")
        print(f"   Query Timeout: {config.query_timeout_seconds}s")
        print(f"   Log Level: {config.log_level}")
    
    # Validate current environment config
    current_config = get_config_for_environment()
    current_config = resolve_paths(current_config)
    
    print(f"\n🔍 Current Environment Configuration Validation:")
    validation = validate_config(current_config)
    
    print(f"Valid: {validation['valid']}")
    if validation['warnings']:
        print("Warnings:")
        for warning in validation['warnings']:
            print(f"  ⚠️ {warning}")
    
    if validation['errors']:
        print("Errors:")
        for error in validation['errors']:
            print(f"  ❌ {error}") 