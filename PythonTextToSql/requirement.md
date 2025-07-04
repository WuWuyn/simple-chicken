Bối cảnh ví dụ
•	Câu hỏi (Query): Lớp SE1800 có bao nhiêu sinh viên trong kì này?
•	Thông tin người dùng (UID): 
o	Id: HE0001
o	Vai trò (Role): Student
o	Thời gian (Time): 22h00 15/6/2024
Phân tích chi tiết phương pháp
Dưới đây là phân tích chi tiết các bước trong quy trình xử lý truy vấn ngôn ngữ tự nhiên để tạo ra câu lệnh SQL, dựa trên sơ đồ bạn đã cung cấp.
________________________________________
Bước 1: Pre-Checking
Đây là bước đầu vào của hệ thống, thực hiện các kiểm tra bảo mật cơ bản trước khi xử lý truy vấn, ở đây chúng ta sử dụng 1 model của gemini với prompt được tinh chỉnh để kiểm tra các điều kiện:
•	Input format checking (Kiểm tra định dạng đầu vào): Hệ thống sẽ kiểm tra xem câu hỏi và thông tin người dùng có tuân thủ đúng định dạng đã quy định hay không. 
o	Ví dụ: Dữ liệu đầu vào từ người dùng có cấu trúc JSON hợp lệ, chứa các trường Id, Role, Time và câu hỏi không chứa các ký tự độc hại và các cú pháp SQL như Select, Drop, Update, Alter,...
•	Behaviour checking (Kiểm tra hành vi): Phân tích các truy vấn từ người dùng để phát hiện các hành vi bất thường.
•	Harmful intent checking (Kiểm tra ý định xấu): Phát hiện các ý định độc hại trong câu hỏi của người dùng, chẳng hạn như các cuộc tấn công SQL injection hoặc các yêu cầu truy cập dữ liệu trái phép.
________________________________________
Bước 2: Value Retrieval (Truy xuất giá trị)
Mục tiêu của bước này là trích xuất và chuẩn bị các thông tin liên quan từ câu hỏi của người dùng để tạo thành một "bối cảnh" (Context) đầy đủ cho việc sinh câu lệnh SQL. Bước này được triển khai dựa trên các kỹ thuật từ hai bài báo nghiên cứu là CHESS và CHASE-SQL.
1. Trích xuất từ khóa (extract_keywords)
Sử dụng mô hình ngôn ngữ lớn (LLM) để xác định các từ khóa và cụm từ quan trọng trong câu hỏi. 
•	Ví dụ: Với câu hỏi "Lớp SE1800 có bao nhiêu sinh viên trong kì này?", các từ khóa được trích xuất sẽ là: 
o	Lớp SE1800
o	bao nhiêu sinh viên
o	trong kì này
2. Truy xuất thực thể (retrieve_entity)
Hệ thống sử dụng các từ khóa đã trích xuất để tìm kiếm các giá trị tương ứng trong cơ sở dữ liệu. Để tối ưu hóa việc tìm kiếm trên các cơ sở dữ liệu lớn, phương pháp này áp dụng kỹ thuật Locality-Sensitive Hashing (LSH) để lập chỉ mục các giá trị trong cơ sở dữ liệu trong giai đoạn tiền xử lý. Khi có yêu cầu, hệ thống sẽ truy vấn chỉ mục LSH này để nhanh chóng tìm thấy các giá trị tương tự nhất. Sau đó, kết hợp cả sự tương đồng về ngữ nghĩa (thông qua embedding) và cú pháp (sử dụng khoảng cách chỉnh sửa - edit distance) để tìm ra các giá trị phù hợp nhất. 
•	Ví dụ: 
o	Từ khóa "SE1800" được tìm thấy trong cột class_id của bảng Classes. 
o	Từ khóa "sinh viên" không tồn tại trực tiếp dưới dạng một giá trị cụ thể trong cơ sở dữ liệu.
o	Từ khóa "kì này" có thể được hiểu là học kỳ hiện tại (ví dụ: SU24) dựa trên ngữ cảnh thời gian của truy vấn, và được tìm thấy trong cột semester của bảng ClassCourse.
3. Truy xuất ngữ cảnh (content_retriever)
Bước này chuyển đổi các câu hỏi và các giá trị thực thể đã tìm thấy thành các vector để tìm kiếm trong một cơ sở dữ liệu vector. Cơ sở dữ liệu này chứa các mô tả về bảng, cột và các mối quan hệ trong schema. 
•	Ví dụ: 
o	Match với mô tả về vector_Cl (lớp học): 
	Thông tin về SE1800 sẽ được liên kết với bảng Classes (thông qua class_id) và bảng Enrollments.
o	Liên quan tới mô tả của bảng Enrollments: Bảng này chứa thông tin về việc sinh viên đăng ký vào các lớp học. 
o	Liên quan tới mô tả của class_name: Tên của lớp học. 
4. Tổng hợp thành bối cảnh (Format Context)
Tất cả thông tin thu thập được từ các bước trên sẽ được tổng hợp lại thành một "bối cảnh" (Context) duy nhất và đầy đủ.
•	Ví dụ: Bối cảnh được tạo ra sẽ bao gồm: 
o	Thực thể đã xác định: 
	Lớp học: SE1800 trong bảng classes, enrollments.
	Học kỳ: SU24 trong bảng enrollments.
o	Ngữ cảnh liên quan: 
	Hành động cần thực hiện là "đếm" ("bao nhiêu").
	Đối tượng cần đếm là "sinh viên".
o	Các bảng có khả năng liên quan: enrollments, classes, và students dựa trên mô tả đã tìm thấy.
________________________________________
Bước 3: Access Control (Kiểm soát truy cập)
Bước này đảm bảo rằng người dùng chỉ có thể truy cập vào những dữ liệu mà họ được phép xem, dựa trên vai trò của họ.
•	Xác định vai trò và quyền hạn: Hệ thống xác định vai trò của người dùng là "Student" với Id là HE0001. Dựa trên tệp per_ENG.txt, vai trò "Student" có các quyền sau: 
o	Xem thông tin cá nhân của chính mình. 
o	Xem danh sách các lớp học đã đăng ký. 
o	Xem danh sách sinh viên trong các lớp học mà mình đã đăng ký. 
•	Đối chiếu với bối cảnh: Hệ thống kiểm tra xem các thực thể và hành động trong "Context" có phù hợp với quyền của người dùng hay không. 
o	Ví dụ: Người dùng HE0001 muốn đếm số sinh viên trong lớp SE1800. Hệ thống cần kiểm tra xem HE0001 có phải là thành viên của lớp SE1800 hay không.
o	Kiểm tra điều kiện: Hệ thống sẽ tạo một câu truy vấn kiểm tra (Permission check query) để xác thực. 
SQL
-- Giả sử hệ thống xác định được class_course_id tương ứng với "SE1800" trong kỳ SU24 là 'SE_K1_SP24_..._SU24'
-- và cần kiểm tra xem sinh viên HE0001 có đăng ký lớp này không.
IF EXISTS (
    SELECT 1
    FROM Enrollments
    WHERE student_id = 'HE0001'
      AND class_course_id = 'SE1800_...' -- (Mã lớp học đầy đủ)
)
-- Kết quả trả về là TRUE
•	Kết quả: Vì sinh viên HE0001 là thành viên của lớp SE1800 (giả định dựa trên quyền được xem danh sách sinh viên trong lớp mình đăng ký), yêu cầu được xem là hợp lệ và được tiếp tục xử lý.
________________________________________
Bước 4: Gen SQL (Sinh câu lệnh SQL)
Đây là bước cuối cùng, nơi mô hình Gemini sử dụng "Context" đã được làm giàu và xác thực để tạo ra câu lệnh SQL cuối cùng.
•	Đầu vào: Mô hình Gemini nhận vào "Context" chi tiết, bao gồm: 
o	Schema của các bảng liên quan (m-schema.txt). 
o	Thông tin chi tiết từ bước Value Retrieval (lớp SE1800, hành động "đếm", đối tượng "sinh viên").
•	Quá trình sinh SQL: Mô hình sẽ phân tích bối cảnh và tạo ra câu lệnh SQL phù hợp. 
o	Ví dụ: Dựa trên bối cảnh, mô hình sẽ tạo ra câu lệnh SQL để đếm số lượng sinh viên trong bảng Enrollments có class_course_id tương ứng với lớp SE1800. 
SQL
SELECT COUNT(T1.student_id)
FROM Enrollments AS T1
INNER JOIN ClassCourse AS T2 ON T1.class_course_id = T2.class_course_id
WHERE T2.class_id = 'SE1800' AND T2.semester = 'SU24'
•	Thực thi và trả về kết quả: Câu lệnh SQL này sau đó được gửi đến MS SQL Server để thực thi. Kết quả (ví dụ: một con số) sẽ được trả về cho người dùng.

