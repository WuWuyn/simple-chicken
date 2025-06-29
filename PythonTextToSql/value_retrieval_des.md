Giai đoạn 1: Thiết lập và Tiền xử lý (Thực hiện một lần, Offline)
Mục tiêu của giai đoạn này là xây dựng các chỉ mục (indexes) để việc tra cứu sau này diễn ra nhanh chóng.

Bước 1.1: Xây dựng Chỉ mục LSH cho Giá trị Dữ liệu
Mục tiêu: Tạo một chỉ mục cho phép tìm kiếm nhanh các chuỗi ký tự gần giống nhau (xử lý lỗi chính tả, các biến thể cú pháp).

Công nghệ/Tài nguyên cần thiết:

Ngôn ngữ lập trình: Python là lựa chọn phổ biến nhất.

Thư viện LSH: Bạn cần một thư viện để triển khai Locality-Sensitive Hashing. Một lựa chọn rất phổ biến và phù hợp cho tác vụ này là datasketch. Thư viện này triển khai MinHash, một thuật toán hiệu quả để ước tính sự tương đồng giữa các tập hợp, rất phù-hợp với dữ liệu văn bản.

Kết nối Cơ sở dữ liệu: Các thư viện Python như SQLAlchemy, psycopg2 (cho PostgreSQL), pyodbc (cho SQL Server), v.v., để đọc dữ liệu từ DB của bạn.

Hành động cụ thể:

Viết một script Python để kết nối vào cơ sở dữ liệu của bạn.

Truy vấn để lấy ra tất cả các giá trị duy nhất (unique values) từ các cột dạng văn bản (TEXT, VARCHAR, CHAR) mà bạn muốn người dùng có thể tìm kiếm.

Với mỗi giá trị, sử dụng thư viện datasketch để tạo một đối tượng MinHash.

Chèn tất cả các đối tượng MinHash này vào một chỉ mục LSH (ví dụ: datasketch.MinHashLSH).

Lưu (serialize) đối tượng chỉ mục LSH này ra một file trên đĩa để có thể tải lại sau này.

Bước 1.2: Xây dựng Cơ sở dữ liệu Vector cho Ngữ cảnh
Mục tiêu: Tạo một chỉ mục cho phép tìm kiếm các mô tả có ngữ nghĩa (ý nghĩa) tương đồng với câu hỏi.

Công nghệ/Tài nguyên cần thiết:

Mô hình/Dịch vụ Embedding:


API Dịch vụ: Bài báo CHESS đề cập sử dụng API của OpenAI (text-embedding-3-small). Các dịch vụ khác như Cohere, hoặc API Embedding của Gemini cũng là lựa chọn tốt.

Mô hình Mã nguồn mở: Nếu bạn muốn chạy tại chỗ (on-premise), các mô hình trong thư viện SentenceTransformers (ví dụ: all-MiniLM-L6-v2) là một lựa chọn tuyệt vời.

Cơ sở dữ liệu Vector (Vector Database):


Mã nguồn mở/Tại chỗ: Bài báo CHESS đề cập sử dụng ChromaDB. 

FAISS của Facebook AI cũng là một lựa chọn rất mạnh mẽ.

Dịch vụ Cloud: Các dịch vụ như Pinecone, Weaviate, hoặc các tính năng vector search của các nhà cung cấp cloud lớn.

Hành động cụ thể:

Thu thập tất cả các siêu dữ liệu (metadata) của bạn: mô tả bảng, mô tả cột, các mối quan hệ, v.v.

Viết một script để duyệt qua từng đoạn mô tả.

Với mỗi mô tả, gọi API hoặc mô hình embedding để chuyển nó thành một vector số thực.

Lưu trữ cặp (đoạn mô tả gốc, vector của nó) vào Cơ sở dữ liệu Vector đã chọn (ví dụ: ChromaDB).

Giai đoạn 2: Xử lý Truy vấn Thời gian thực (Online)
Đây là luồng xử lý khi hệ thống nhận được một câu hỏi từ người dùng.

Bước 2.1: Trích xuất Từ khóa
Mục tiêu: Lấy ra các từ khóa quan trọng từ câu hỏi.

Công nghệ/Tài nguyên cần thiết:


API của LLM: Các bài báo đã thử nghiệm với Gemini 1.5 Pro, Claude-3.5-Sonnet, GPT-4, Llama-3-70B. Bạn cần một API đến một trong các mô hình này.


Kỹ thuật Prompt (Prompt Engineering): Đây không phải là công nghệ mà là kỹ năng. Bạn cần thiết kế một "few-shot prompt" hiệu quả để hướng dẫn LLM thực hiện đúng nhiệm vụ.

Hành động cụ thể:

Trong ứng dụng của bạn, viết một hàm nhận câu hỏi của người dùng làm đầu vào.

Định dạng câu hỏi này bên trong một prompt đã có sẵn vài ví dụ mẫu.

Gửi prompt hoàn chỉnh đến API của LLM.

Phân tích (parse) câu trả lời từ LLM (thường là dạng JSON hoặc văn bản có cấu trúc) để lấy ra danh sách các từ khóa.

Bước 2.2 & 2.3: Truy xuất Thực thể và Ngữ cảnh
Mục tiêu: Sử dụng các chỉ mục đã tạo để tìm giá trị và ngữ cảnh liên quan.

Công nghệ/Tài nguyên cần thiết:

Chỉ mục LSH và DB Vector: Tải file chỉ mục LSH và kết nối tới DB Vector đã tạo ở Giai đoạn 1.

Mô hình Embedding: Cùng một mô hình đã dùng ở Bước 1.2.

Thư viện tính Khoảng cách Chỉnh sửa: Các thư viện Python như python-Levenshtein hoặc thefuzz rất hiệu quả cho việc này.

Hành động cụ thể (kết hợp hai bước):

Truy xuất Thực thể:

Với mỗi từ khóa từ Bước 2.1, tạo MinHash của nó.

Dùng MinHash này để truy vấn (.query()) vào chỉ mục LSH và lấy ra một danh sách ngắn các ứng viên.

Với danh sách ứng viên này, tính điểm tương đồng cú pháp (dùng Levenshtein) và ngữ nghĩa (dùng mô hình embedding + cosine similarity) để chọn ra giá trị tốt nhất.

Truy xuất Ngữ cảnh:

Lấy toàn bộ câu hỏi của người dùng, dùng mô hình embedding để tạo vector cho nó.

Dùng vector câu hỏi này để truy vấn (.query()) vào DB Vector (ChromaDB) để lấy ra các mô tả ngữ cảnh tương đồng nhất.

Cuối cùng, bạn tổng hợp tất cả các thông tin thu thập được (từ khóa, thực thể đã tìm thấy, ngữ cảnh liên quan) thành một "gói thông tin" có cấu trúc để chuyển sang cho các thành phần xử lý tiếp theo trong hệ thống của bạn.


Lời khuyên quan trọng: Hãy bắt đầu bằng cách khám phá kho mã nguồn của CHESS trên GitHub (https://github.com/ShayanTalaei/CHESS). Đây là cách trực tiếp và thực tế nhất để xem họ đã triển khai các công nghệ này như thế nào.