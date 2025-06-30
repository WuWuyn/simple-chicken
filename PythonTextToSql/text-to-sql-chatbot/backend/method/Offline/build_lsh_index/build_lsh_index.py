# -*- coding: utf-8 -*-
"""
build_lsh_index.py

Mục tiêu: Script này sẽ thực hiện các công việc sau:
1.  Đọc tệp `m-schema_final.txt` để xác định các cột có kiểu dữ liệu là văn bản.
2.  Kết nối đến cơ sở dữ liệu MS SQL Server.
3.  Truy vấn tất cả các giá trị duy nhất từ các cột văn bản đã xác định.
4.  Xây dựng một chỉ mục LSH từ các giá trị này bằng `datasketch`.
5.  Lưu chỉ mục đã xây dựng ra một tệp `pickle` để tái sử dụng.
"""

import pyodbc
import pickle
from datasketch import MinHash, MinHashLSH
import re
import os

# --- CONFIGURATION ---
current_dir = os.path.dirname(os.path.abspath(__file__))
method_dir = os.path.join(current_dir, "..", "..")
SCHEMA_FILE_PATH = os.path.normpath(os.path.join(method_dir, "Offline", "build_lsh_index", "m-schema_final.txt"))
LSH_INDEX_PATH = os.path.normpath(os.path.join(method_dir, "Offline", "build_lsh_index", "full_db_lsh.pkl"))
NUM_PERM = 128  # Number of hash functions for MinHash
THRESHOLD = 0.3  # Jaccard similarity threshold (lowered from 0.8 for better recall)

# ⚠️ QUAN TRỌNG: Điền thông tin kết nối đến database của bạn vào đây
DB_CONNECTION_STRING = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=localhost;"  # Vd: 'localhost' hoặc '192.168.1.10'
    "DATABASE=text_to_sql_final;"     # Tên database
    "UID=sa;"              # Tên người dùng
    "PWD=123456;"              # Mật khẩu
)

# --- Hàm Phân tích Schema để xác định Cột Văn bản ---
# Hàm này đọc tệp schema và trả về một danh sách các cặp `(tên_bảng, tên_cột)` 
# cho những cột có kiểu dữ liệu là văn bản (`VARCHAR`, `NVARCHAR`).

def parse_schema_for_text_columns(file_path):
    """
    Parses the schema file to get a list of (table, column) for text-based columns.
    """
    print(f"Đang phân tích schema để xác định các cột văn bản: {file_path}")
    if not os.path.exists(file_path):
        print(f"LỖI: Không tìm thấy tệp {file_path}")
        return []
        
    text_columns = []
    current_table = None
    text_types = ['varchar', 'nvarchar'] # Các kiểu dữ liệu được coi là văn bản
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line.startswith('# Table:'):
                current_table = line.replace('# Table:', '').strip()
            elif current_table and line.startswith('('):
                match = re.search(r'\((?P<name>\w+):(?P<type>[\w\(\)]+)', line)
                if match:
                    col_name = match.group('name')
                    col_type = match.group('type').lower()
                    if any(ttype in col_type for ttype in text_types):
                        text_columns.append((current_table, col_name))
    print(f"Đã tìm thấy {len(text_columns)} cột văn bản để lập chỉ mục.")
    return text_columns

# --- Logic Chính: Kết nối, Truy vấn và Xây dựng Chỉ mục LSH ---
# Phần này sẽ thực hiện toàn bộ quá trình:
# 1.  Khởi tạo đối tượng `MinHashLSH`.
# 2.  Lấy danh sách các cột văn bản.
# 3.  Mở kết nối đến DB.
# 4.  Lặp qua từng cột, truy vấn dữ liệu và thêm vào chỉ mục LSH.
# 5.  Đóng kết nối và lưu chỉ mục ra file.

def create_enhanced_minhash(value: str, num_perm: int = 128) -> MinHash:
    """
    Tạo MinHash được cải thiện cho strings ngắn bằng cách sử dụng:
    1. Character-level shingles (n-grams)
    2. Prefix/suffix patterns
    3. Edit distance approximation
    """
    m = MinHash(num_perm=num_perm)
    value_lower = value.lower().strip()
    
    # 1. Add original value
    m.update(value_lower.encode('utf8'))
    
    # 2. Add character-level bigrams and trigrams
    for n in [2, 3]:
        if len(value_lower) >= n:
            for i in range(len(value_lower) - n + 1):
                ngram = value_lower[i:i+n]
                m.update(ngram.encode('utf8'))
    
    # 3. Add prefix/suffix patterns cho các ID codes
    if len(value_lower) >= 2:
        # Prefix patterns (SE, AI, etc.)
        prefix = value_lower[:2]
        m.update(f"PREFIX_{prefix}".encode('utf8'))
        
        # Suffix patterns (01, 02, FA23, etc.)
        if len(value_lower) >= 3:
            suffix = value_lower[-2:]
            m.update(f"SUFFIX_{suffix}".encode('utf8'))
    
    # 4. Add character type patterns
    pattern = ""
    for char in value_lower:
        if char.isalpha():
            pattern += "L"  # Letter
        elif char.isdigit():
            pattern += "D"  # Digit
        else:
            pattern += "S"  # Symbol
    m.update(f"PATTERN_{pattern}".encode('utf8'))
    
    return m

def main():
    """
    Hàm chính thực thi toàn bộ logic.
    """
    # 1. Khởi tạo LSH
    # ✅ Sửa lỗi: Giảm threshold xuống để có recall tốt hơn
    lsh = MinHashLSH(threshold=THRESHOLD, num_perm=NUM_PERM)

    # 2. Lấy danh sách các cột văn bản
    text_columns = parse_schema_for_text_columns(SCHEMA_FILE_PATH)
    
    if not text_columns:
        print("Không có cột văn bản nào được tìm thấy. Kết thúc chương trình.")
        return

    conn = None
    indexed_value_count = 0
    try:
        # 3. Kết nối Database
        print("Đang kết nối đến cơ sở dữ liệu...")
        conn = pyodbc.connect(DB_CONNECTION_STRING)
        cursor = conn.cursor()
        print("Kết nối cơ sở dữ liệu thành công.")

        # 4. Lặp qua từng cột, truy vấn và lập chỉ mục
        for i, (table_name, column_name) in enumerate(text_columns):
            print(f"  ({i+1}/{len(text_columns)}) Đang lập chỉ mục cho {table_name}.{column_name}...")
            
            sql_query = f"SELECT DISTINCT [{column_name}] FROM [{table_name}] WHERE [{column_name}] IS NOT NULL AND LTRIM(RTRIM([{column_name}])) != ''"
            
            try:
                cursor.execute(sql_query)
                rows = cursor.fetchall()
                
                for row in rows:
                    original_value = row[0]
                    if original_value and isinstance(original_value, str) and original_value.strip():
                        cleaned_value = original_value.strip().lower()
                        
                        key = f"{table_name}:{column_name}:{original_value}"
                        
                        m = create_enhanced_minhash(cleaned_value)
                        
                        lsh.insert(key, m)
                        indexed_value_count += 1
            except pyodbc.Error as ex:
                sqlstate = ex.args[0]
                print(f"    ! LỖI khi thực thi truy vấn cho {table_name}.{column_name}: {sqlstate}")

    except pyodbc.Error as ex:
        print(f"LỖI NGHIÊM TRỌNG: Kết nối DB thất bại. Vui lòng kiểm tra lại DB_CONNECTION_STRING.")
        print(ex)
    finally:
        if conn:
            conn.close()
            print("\nĐã đóng kết nối cơ sở dữ liệu.")

    # 5. Lưu chỉ mục LSH ra file
    if indexed_value_count > 0:
        with open(LSH_INDEX_PATH, 'wb') as f:
            pickle.dump(lsh, f)
        
        print("\n--- Xây dựng Chỉ mục LSH HOÀN TẤT! ---")
        print(f"Threshold sử dụng: {THRESHOLD}")
        print(f"Tổng số giá trị duy nhất đã được lập chỉ mục: {indexed_value_count}")
        print(f"Chỉ mục LSH đã được lưu tại: {os.path.abspath(LSH_INDEX_PATH)}")
        
        # 🧪 TEST: Kiểm tra số lượng keys trong LSH
        if hasattr(lsh, 'keys'):
            try:
                total_keys_in_lsh = len(lsh.keys) if lsh.keys else 0
                print(f"✅ Xác nhận: LSH index chứa {total_keys_in_lsh} keys")
            except:
                print(f"✅ Xác nhận: LSH index đã được tạo (không thể đếm keys)")
        
        # 🧪 TEST: Query thử với một giá trị để xem threshold ảnh hưởng như thế nào
        test_keywords = ["AI_K1_FA23", "ai_k1_fa23", "SE", "Student", "Course", "SE04"]
        for keyword in test_keywords:
            test_hash = create_enhanced_minhash(keyword)
            test_results = lsh.query(test_hash)
            print(f"🔍 Test query với '{keyword}' (threshold={THRESHOLD}): {len(test_results)} results")
            if test_results:
                print(f"  Ví dụ kết quả: {test_results[:3]}")
    else:
        print("\nKhông có giá trị nào được lập chỉ mục. Tệp LSH không được tạo.")

if __name__ == '__main__':
    main()