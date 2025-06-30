"""
Value Retrieval System for Text-to-SQL

Main components:
1. Keyword Extraction (LLM + Fallback)
2. Entity Matching (LSH + Re-ranking)  
3. Context Retrieval (Vector Similarity)
4. Format Context for SQL Generation
"""

import os
import pickle
import re
import json
import logging
from typing import List, Dict, Optional, Tuple, Any
from dataclasses import dataclass
from sentence_transformers import SentenceTransformer
from datasketch import MinHash, MinHashLSH
import chromadb
from difflib import SequenceMatcher

try:
    import google.generativeai as genai
    GENAI_AVAILABLE = True
except ImportError:
    GENAI_AVAILABLE = False
    print("Google GenerativeAI not available")

@dataclass
class NumericCondition:
    """Represents a numeric filtering condition (e.g., GPA > 8.5)"""
    operator: str
    value: float
    context_keywords: List[str]

@dataclass
class EntityMatch:
    """Entity match result from LSH"""
    original_value: str
    table_name: str
    column_name: str
    similarity_score: float
    match_type: str

@dataclass
class ContextMatch:
    """Context match result from vector DB"""
    content: str
    source_type: str
    table_name: str
    column_name: Optional[str]
    relevance_score: float

@dataclass
class ValueRetrievalResult:
    """Final result returned by the Value-Retrieval pipeline"""
    keywords: List[str]
    entity_matches: List[EntityMatch]
    context_matches: List[ContextMatch]
    numeric_conditions: List[NumericCondition]
    formatted_context: str
    confidence_score: float

class ValueRetrievalSystem:
    """Comprehensive Value Retrieval System"""
    
    def __init__(self):
        # Configuration paths
        self.current_dir = os.path.dirname(os.path.abspath(__file__))
        self.offline_dir = os.path.join(self.current_dir, "..", "..", "Offline")
        
        # Initialize components
        self._init_gemini_llm()
        self._load_lsh_index()
        self._load_vector_database()
        self._load_schema_info()
        
        print("Value Retrieval System initialized successfully")

    def _init_gemini_llm(self):
        """Initialize Gemini LLM for keyword extraction"""
        self.gemini_api_key = os.getenv("GEMINI_API_KEY")
        
        if not self.gemini_api_key:
            print("GOOGLE_API_KEY not found. LLM analysis will use fallback mode.")
            self.llm_enabled = False
        else:
            try:
                genai.configure(api_key=self.gemini_api_key)
                self.model = genai.GenerativeModel('gemini-2.0-flash')
                self.llm_enabled = True
                print("Gemini LLM initialized for keyword extraction")
            except Exception as e:
                print(f"Gemini LLM initialization failed: {e}")
                self.llm_enabled = False

    def _load_lsh_index(self):
        """Load LSH index"""
        lsh_path = os.path.join(self.offline_dir, "build_lsh_index", "full_db_lsh.pkl")
        schema_path = os.path.join(self.offline_dir, "build_lsh_index", "m-schema_final.txt")
        
        try:
            with open(lsh_path, 'rb') as f:
                self.db_lsh = pickle.load(f)
            
            print(f"LSH index loaded - {len(self.db_lsh.keys)} keys in index")
            
        except Exception as e:
            print(f"Failed to load LSH index: {e}")
            self.db_lsh = None

    def _load_vector_database(self):
        """Load ChromaDB vector database"""
        vector_db_path = os.path.join(self.offline_dir, "build_vector_db", "vector_database")
        
        try:
            client = chromadb.PersistentClient(path=vector_db_path)
            self.schema_collection = client.get_collection(name="schema_collection")
            self.sentence_model = SentenceTransformer('all-MiniLM-L6-v2')
            
            doc_count = self.schema_collection.count()
            print(f"Vector database loaded: {doc_count} documents")
            
        except Exception as e:
            print(f"Failed to load vector database: {e}")
            self.schema_collection = None
            self.sentence_model = None

    def _load_schema_info(self):
        """Load schema information"""
        schema_path = os.path.join(self.offline_dir, "build_lsh_index", "m-schema_final.txt")
        
        try:
            with open(schema_path, 'r', encoding='utf-8') as f:
                self.schema_info = f.read()
            print("Schema information loaded")
        except Exception as e:
            print(f"Failed to load schema info: {e}")
            self.schema_info = ""

    def extract_keywords(self, query: str) -> List[str]:
        """Extract keywords using LLM or fallback method"""
        if self.llm_enabled:
            try:
                prompt = f"""
Extract important keywords from this database query:
"{query}"

Return keywords as JSON array: ["keyword1", "keyword2", ...]

Focus on:
- Entity names (student IDs, course codes, class names)
- Attribute names (grades, scores, names)
- Filter conditions (subjects, semesters, departments)
"""
                response = self.model.generate_content(prompt)
                response_text = response.text.strip()
                
                # Extract JSON
                if "```json" in response_text:
                    json_start = response_text.find("```json") + 7
                    json_end = response_text.find("```", json_start)
                    response_text = response_text[json_start:json_end].strip()
                
                keywords = json.loads(response_text)
                
                # Add lowercase variants
                all_keywords = []
                for keyword in keywords:
                    all_keywords.append(keyword)
                    if keyword.lower() != keyword:
                        all_keywords.append(keyword.lower())
                
                return list(set(all_keywords))
                
            except Exception as e:
                print(f"LLM keyword extraction failed: {e}")
                
        return self._extract_keywords_fallback(query)

    def _extract_keywords_fallback(self, query: str) -> List[str]:
        """Fallback keyword extraction using rule-based approach"""
        keywords = []
        
        # Common database entities patterns
        patterns = [
            r'\b[A-Z]{2,3}\d{2,5}\b',  # Course codes (AIL301, SE1800)
            r'\b[A-Z]{2}\d{5}\b',      # Student IDs (HE00001)
            r'\b[A-Z]{2,3}\d{3}\b',    # Lecturer IDs (LEC001)
            r'\b\d+\.?\d*\b',          # Numbers and decimals
            r'\b[A-Z]{2,3}\d{2}\b',    # Class codes (SE04, AI01)
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, query)
            keywords.extend(matches)
        
        # Extract common words (length > 2)
        words = re.findall(r'\b\w{3,}\b', query.lower())
        keywords.extend(words)
        
        # Remove duplicates and common stop words
        stop_words = {'the', 'and', 'for', 'are', 'this', 'that', 'with', 'from', 'how', 'what', 'many'}
        keywords = [k for k in set(keywords) if k.lower() not in stop_words]
        
        return keywords

    def parse_numeric_conditions(self, query: str, keywords: List[str]) -> List[NumericCondition]:
        """Parse numeric filtering conditions from query"""
        conditions = []
        
        # Numeric condition patterns
        numeric_patterns = [
            r'(\w+(?:\s+\w+)*)\s+(greater\s+than|more\s+than|above|\>)\s+(\d+\.?\d*)',
            r'(\w+(?:\s+\w+)*)\s+(less\s+than|below|\<)\s+(\d+\.?\d*)',
            r'(\w+(?:\s+\w+)*)\s+(equals?|is|\=)\s+(\d+\.?\d*)',
            r'(\w+(?:\s+\w+)*)\s+(at\s+least|\>\=)\s+(\d+\.?\d*)',
            r'(\w+(?:\s+\w+)*)\s+(at\s+most|\<\=)\s+(\d+\.?\d*)',
        ]
        
        for pattern in numeric_patterns:
            matches = re.finditer(pattern, query, re.IGNORECASE)
            for match in matches:
                context_text = match.group(1).strip()
                operator_text = match.group(2).strip()
                value_text = match.group(3).strip()
                
                try:
                    value = float(value_text)
                    operator = self._normalize_operator(operator_text)
                    context_keywords = self._extract_context_keywords(context_text, keywords)
                    
                    condition = NumericCondition(
                        operator=operator,
                        value=value,
                        context_keywords=context_keywords
                    )
                    conditions.append(condition)
                    
                except ValueError:
                    continue
        
        return conditions

    def _normalize_operator(self, operator_text: str) -> str:
        """Normalize operator text to standard symbols"""
        operator_map = {
            'greater than': '>',
            'more than': '>',
            'above': '>',
            'less than': '<',
            'below': '<',
            'equals': '=',
            'equal': '=',
            'is': '=',
            'at least': '>=',
            'at most': '<=',
            '>': '>',
            '<': '<',
            '=': '=',
            '>=': '>=',
            '<=': '<='
        }
        return operator_map.get(operator_text.lower(), '=')

    def _extract_context_keywords(self, context_text: str, all_keywords: List[str]) -> List[str]:
        """Extract relevant keywords from context"""
        context_words = context_text.lower().split()
        relevant_keywords = []
        
        for keyword in all_keywords:
            if keyword.lower() in context_words:
                relevant_keywords.append(keyword)
        
        if not relevant_keywords:
            relevant_keywords = context_words
            
        return relevant_keywords

    def retrieve_entity(self, keywords: List[str]) -> List[EntityMatch]:
        """Retrieve entities using LSH and re-ranking"""
        if not self.db_lsh:
            return []
            
        all_matches = []
        
        for keyword in keywords:
            # LSH candidate retrieval
            candidates = self._lsh_candidate_retrieval(keyword)
            
            if candidates:
                # Re-rank candidates
                matches = self._rerank_candidates(keyword, candidates)
                all_matches.extend(matches)
            
        # Deduplicate and return top matches
        deduplicated_matches = self._deduplicate_entities(all_matches)
        return sorted(deduplicated_matches, key=lambda x: x.similarity_score, reverse=True)[:10]

    def _lsh_candidate_retrieval(self, keyword: str) -> List[Tuple[str, str, str]]:
        """Retrieve candidates using LSH"""
        try:
            keyword_lower = keyword.lower()
            minhash = create_enhanced_minhash(keyword_lower)
            
            candidate_keys = self.db_lsh.query(minhash)
            candidates = []
            
            for key in candidate_keys:
                try:
                    parts = key.split(':')
                    if len(parts) >= 3:
                        table = parts[0]
                        column = parts[1]
                        value = parts[2]
                        candidates.append((table, column, value))
                except:
                    continue
                    
            return candidates
            
        except Exception as e:
            print(f"LSH retrieval failed for {keyword}: {e}")
            return []

    def _fuzzy_fallback_search(self, keyword: str) -> List[str]:
        """Fallback fuzzy search when LSH fails"""
        if not self.db_lsh:
            return []
            
        keyword_lower = keyword.lower()
        matches = []
        
        for key in list(self.db_lsh.keys)[:1000]:  # Limit search
            try:
                parts = key.split(':')
                if len(parts) >= 3:
                    value = parts[2].lower()
                    similarity = SequenceMatcher(None, keyword_lower, value).ratio()
                    if similarity > 0.6:
                        matches.append(key)
            except:
                continue
                
        return matches[:10]

    def _rerank_candidates(self, keyword: str, candidates: List[Tuple[str, str, str]]) -> List[EntityMatch]:
        """Re-rank candidates using multiple similarity metrics"""
        matches = []
        
        for table, column, value in candidates:
            # Calculate similarity scores
            jaccard_score = self._calculate_jaccard_similarity(keyword, value)
            edit_score = self._calculate_edit_distance_score(keyword, value)
            semantic_score = self._calculate_semantic_similarity(keyword, value)
            
            # Combine scores
            final_score = self._combine_scores(jaccard_score, edit_score, semantic_score)
            
            if final_score > 0.3:  # Threshold
                match = EntityMatch(
                    original_value=value,
                    table_name=table,
                    column_name=column,
                    similarity_score=final_score,
                    match_type="fuzzy"
                )
                matches.append(match)
        
        return matches

    def _calculate_jaccard_similarity(self, keyword: str, value: str) -> float:
        """Calculate Jaccard similarity between keyword and value"""
        set1 = set(keyword.lower())
        set2 = set(value.lower())
        
        if not set1 or not set2:
            return 0.0
            
        intersection = len(set1.intersection(set2))
        union = len(set1.union(set2))
        
        return intersection / union if union > 0 else 0.0

    def _calculate_edit_distance_score(self, keyword: str, value: str) -> float:
        """Calculate edit distance based similarity"""
        return SequenceMatcher(None, keyword.lower(), value.lower()).ratio()

    def _calculate_semantic_similarity(self, keyword: str, value: str) -> float:
        """Calculate semantic similarity using sentence transformer"""
        if not self.sentence_model:
            return 0.0
            
        try:
            embeddings = self.sentence_model.encode([keyword, value])
            similarity = float(embeddings[0] @ embeddings[1])
            return max(0.0, similarity)
        except:
            return 0.0

    def _combine_scores(self, jaccard: float, edit_distance: float, semantic: float) -> float:
        """Combine multiple similarity scores"""
        weights = {
            'jaccard': 0.3,
            'edit_distance': 0.4,
            'semantic': 0.3
        }
        
        combined_score = (
            weights['jaccard'] * jaccard +
            weights['edit_distance'] * edit_distance +
            weights['semantic'] * semantic
        )
        
        return min(1.0, combined_score)

    def _calculate_similarity(self, keyword: str, value: str) -> float:
        """Calculate overall similarity score"""
        return SequenceMatcher(None, keyword.lower(), value.lower()).ratio()

    def _deduplicate_entities(self, entities: List[EntityMatch]) -> List[EntityMatch]:
        """Remove duplicate entities based on table.column.value"""
        seen = set()
        deduplicated = []
        
        for entity in entities:
            key = f"{entity.table_name}.{entity.column_name}.{entity.original_value}"
            if key not in seen:
                seen.add(key)
                deduplicated.append(entity)
        
        return deduplicated

    def content_retriever(self, query: str, entity_matches: List[EntityMatch]) -> List[ContextMatch]:
        """Retrieve relevant context using vector similarity"""
        if not self.schema_collection or not self.sentence_model:
            return []
        
        try:
            # Create query embedding
            query_embedding = self.sentence_model.encode([query])
            
            # Query vector database
            results = self.schema_collection.query(
                query_embeddings=query_embedding.tolist(),
                n_results=10
            )
            
            context_matches = []
            
            if results['documents'] and results['documents'][0]:
                for i, doc in enumerate(results['documents'][0]):
                    metadata = results['metadatas'][0][i] if results['metadatas'] else {}
                    distance = results['distances'][0][i] if results['distances'] else 1.0
                    
                    # Convert distance to similarity score
                    relevance_score = max(0.0, 1.0 - distance)
                    
                    context_match = ContextMatch(
                        content=doc,
                        source_type=metadata.get('type', 'unknown'),
                        table_name=metadata.get('table_name', ''),
                        column_name=metadata.get('column_name'),
                        relevance_score=relevance_score
                    )
                    context_matches.append(context_match)
            
            return context_matches
            
        except Exception as e:
            print(f"Context retrieval failed: {e}")
            return []

    def format_context(self, query: str, keywords: List[str], 
                      entity_matches: List[EntityMatch], 
                      context_matches: List[ContextMatch],
                      numeric_conditions: List[NumericCondition]) -> str:
        """Format all retrieved information into structured context"""
        context_parts = []
        
        # 1. Original Query
        context_parts.append(f"ORIGINAL QUERY: {query}")
        context_parts.append("")
        
        # 2. Keywords
        if keywords:
            context_parts.append("EXTRACTED KEYWORDS:")
            context_parts.append(", ".join(keywords))
            context_parts.append("")
        
        # 3. Entity Matches
        if entity_matches:
            context_parts.append("ENTITY MATCHES (Values found in database):")
            for entity in entity_matches[:5]:
                context_parts.append(
                    f"- {entity.table_name}.{entity.column_name} = '{entity.original_value}' "
                    f"(similarity: {entity.similarity_score:.2f})"
                )
            context_parts.append("")
        
        # 4. Numeric Conditions
        if numeric_conditions:
            context_parts.append("NUMERIC CONDITIONS (for WHERE clauses):")
            for condition in numeric_conditions:
                context_keywords_str = ", ".join(condition.context_keywords) if condition.context_keywords else "unknown column"
                context_parts.append(f"- {context_keywords_str} {condition.operator} {condition.value}")
            context_parts.append("")

        # 5. Relevant Schema Context
        if context_matches:
            context_parts.append("RELEVANT SCHEMA CONTEXT:")
            for context in context_matches[:5]:
                context_parts.append(f"- {context.source_type}: {context.content}")
                if context.table_name:
                    context_parts.append(f"  Table: {context.table_name}")
                if context.column_name:
                    context_parts.append(f"  Column: {context.column_name}")
                context_parts.append(f"  Relevance: {context.relevance_score:.2f}")
                context_parts.append("")
        
        # 6. Suggested Tables
        suggested_tables = set()
        for entity in entity_matches:
            suggested_tables.add(entity.table_name)
        for context in context_matches:
            if context.table_name:
                suggested_tables.add(context.table_name)
        
        if suggested_tables:
            context_parts.append("SUGGESTED TABLES:")
            for table in sorted(suggested_tables):
                context_parts.append(f"- {table}")
            context_parts.append("")
        
        return "\n".join(context_parts)

    def process_query(self, query: str, user_info: Optional[dict] = None) -> ValueRetrievalResult:
        """Main method to process query through 4-step Value Retrieval"""
        print("\n" + "="*70)
        print("🔍 VALUE RETRIEVAL PROCESS")
        print("="*70)
        print(f"📝 Query: {query}")
        if user_info:
            print(f"👤 User: {user_info.get('user_id', 'N/A')} ({user_info.get('user_role', 'N/A')})")
        print("-"*70)
        
        # Step 1: Extract Keywords
        print("🔤 Step 1: Extracting keywords...")
        keywords = self.extract_keywords(query)
        print(f"   ✅ Found {len(keywords)} keywords: {keywords[:10]}{'...' if len(keywords) > 10 else ''}")
        
        # Step 1.5: Parse Numeric Conditions
        print("🔢 Step 1.5: Parsing numeric conditions...")
        numeric_conditions = self.parse_numeric_conditions(query, keywords)
        if numeric_conditions:
            print(f"   ✅ Found {len(numeric_conditions)} numeric conditions")
            for condition in numeric_conditions[:3]:
                print(f"      • {condition.context_keywords} {condition.operator} {condition.value}")
        else:
            print(f"   ℹ️  Found 0 numeric conditions")
        
        # Step 2: Retrieve Entity  
        print("🎯 Step 2: Retrieving entities...")
        entity_matches = self.retrieve_entity(keywords)
        if entity_matches:
            print(f"   ✅ Found {len(entity_matches)} entity matches")
            for entity in entity_matches[:3]:
                print(f"      • {entity.table_name}.{entity.column_name} = '{entity.original_value}' (score: {entity.similarity_score:.2f})")
            if len(entity_matches) > 3:
                print(f"      ... and {len(entity_matches)-3} more")
        else:
            print(f"   ℹ️  Found 0 entity matches")
        
        # Step 3: Content Retriever
        print("📚 Step 3: Retrieving context...")
        context_matches = self.content_retriever(query, entity_matches)
        if context_matches:
            print(f"   ✅ Found {len(context_matches)} context matches")
            for context in context_matches[:2]:
                print(f"      • {context.source_type}: {context.content[:50]}... (score: {context.relevance_score:.2f})")
            if len(context_matches) > 2:
                print(f"      ... and {len(context_matches)-2} more")
        else:
            print(f"   ℹ️  Found 0 context matches")
        
        # Step 4: Format Context
        print("📋 Step 4: Formatting context...")
        formatted_context = self.format_context(query, keywords, entity_matches, context_matches, numeric_conditions)
        
        # Calculate confidence score
        confidence_score = self._calculate_confidence(keywords, entity_matches, context_matches)
        
        result = ValueRetrievalResult(
            keywords=keywords,
            entity_matches=entity_matches,
            context_matches=context_matches,
            numeric_conditions=numeric_conditions,
            formatted_context=formatted_context,
            confidence_score=confidence_score
        )
        
        print(f"   ✅ Context formatted successfully")
        print(f"\n🎉 VALUE RETRIEVAL COMPLETED!")
        print(f"📊 Overall Confidence Score: {confidence_score:.2f}")
        print(f"📈 Performance Metrics:")
        print(f"   • Keywords: {len(keywords)}")
        print(f"   • Entity Matches: {len(entity_matches)}")
        print(f"   • Context Matches: {len(context_matches)}")
        print(f"   • Numeric Conditions: {len(numeric_conditions)}")
        print("="*70 + "\n")
        
        return result

    def _calculate_confidence(self, keywords: List[str], 
                            entity_matches: List[EntityMatch],
                            context_matches: List[ContextMatch]) -> float:
        """Calculate overall confidence score"""
        score = 0.0
        
        # Keywords found (10%)
        if keywords:
            score += 0.1
        
        # Entity matches (50%)  
        if entity_matches:
            avg_entity_score = sum(e.similarity_score for e in entity_matches) / len(entity_matches)
            score += 0.5 * avg_entity_score
        
        # Context matches (40%)
        if context_matches:
            avg_context_score = sum(c.relevance_score for c in context_matches) / len(context_matches)
            score += 0.4 * avg_context_score
            
        return min(1.0, score)

def create_enhanced_minhash(value: str, num_perm: int = 128) -> MinHash:
    """Create enhanced MinHash for short strings using character-level features"""
    m = MinHash(num_perm=num_perm)
    value_lower = value.lower().strip()
    
    # Add original value
    m.update(value_lower.encode('utf8'))
    
    # Add character-level bigrams and trigrams
    for n in [2, 3]:
        if len(value_lower) >= n:
            for i in range(len(value_lower) - n + 1):
                ngram = value_lower[i:i+n]
                m.update(ngram.encode('utf8'))
    
    # Add prefix/suffix patterns for ID codes
    if len(value_lower) >= 2:
        prefix = value_lower[:2]
        m.update(f"PREFIX_{prefix}".encode('utf8'))
        
        if len(value_lower) >= 3:
            suffix = value_lower[-2:]
            m.update(f"SUFFIX_{suffix}".encode('utf8'))
    
    # Add character type patterns
    pattern = ""
    for char in value_lower:
        if char.isalpha():
            pattern += "L"
        elif char.isdigit():
            pattern += "D"
        else:
            pattern += "S"
    m.update(f"PATTERN_{pattern}".encode('utf8'))
    
    return m
