Tôi muốn xây dựng 1 website chat bot với hệ thống text-to-sql đã được xây dựng với những yêu cầu:
-	Sử dụng jwt cho bảo mật: khi người dùng đặt ra câu hỏi thì bắt buộc có các thông tin đi kèm user_question, user_id, user_role, timestamp (tôi muốn cố định nó vào 22h 15/6/2-24). Vì vậy sau khi người dung đăng nhập tôi muốn hệ thống sẽ truy vấn ra các thông tin user_id, user_role và trả nó về kèm theo token jwt. Sau này khi người dùng đặt câu hỏi, các thông tin đi kèm này cũng sẽ được gửi kèm theo.
-	Bạn có thể sử dụng những công nghệ, công cụ, ngôn ngữ lập trình mà bạn cho là phù hợp, nhưng hãy phân tích thật kỹ trước khi quyết định
-	Hệ thống có khả năng giữ context của cuộc trò chuyện giúp tăng độ tương tác với người dùng, vì là bản demo nên chỉ cần lưu trữ một phần nhỏ
-	Hệ thống phải có giao diện bắt mắt chuyên nghiệp, bạn có thể sử dụng các thư viện để hỗ trợ

✅ Ưu điểm:
- Native Python (tương thích hoàn hảo với pipeline hiện tại)
- Async/await support (tốt cho real-time chat)
- Auto API documentation (Swagger)
- High performance
- JWT integration sẵn có
- WebSocket support

❌ Alternatives loại bỏ:
- Flask: Thiếu async, ít feature
- Django: Quá nặng cho chatbot API
- Node.js: Phải rewrite pipeline sang JS

✅ Ưu điểm:
- Component-based (dễ tái sử dụng)
- Rich ecosystem cho chat UI
- TypeScript: Type safety
- Real-time WebSocket support
- Material-UI/Ant Design cho professional UI

🎨 UI Libraries options:
- Material-UI: Google Material Design
- Ant Design: Enterprise-class UI
- Chakra UI: Modern, simple

📊 MS SQL Server (existing): User data, academic data
🚀 Redis: Session management, conversation cache (REMOVED FOR DEMO)
💾 SQLite (optional): Local development

Lý do:
- Tận dụng DB hiện tại cho authentication
- Redis cho fast session/context storage (REMOVED FOR DEMO)
- Không cần migration data

🔄 WebSocket: Chat messages, real-time responses
📡 REST API: Authentication, user management
📱 Fallback: HTTP polling nếu WebSocket fail
1
🔧 Backend Core:
├── FastAPI project structure
├── JWT authentication system
├── Database connection (MS SQL Server)
├── User login/logout endpoints
└── Basic health check APIs

🎨 Frontend Core:
├── React + TypeScript setup
├── Basic chat UI layout
├── Login/logout components
└── API client setup
2
🔐 Authentication Flow:
├── Login endpoint query user from existing DB
├── Generate JWT với user_id, user_role
├── Frontend store JWT in localStorage/cookies
├── Protected routes với JWT validation
└── Auto-refresh token mechanism
3
🔌 Pipeline Integration:
├── FastAPI wrapper cho existing pipeline
├── Request format: {user_question, user_id, user_role, timestamp}
├── Response handling với error cases
├── Async processing cho better UX
└── WebSocket cho real-time responses
4
💬 Chat Features:
├── Real-time messaging UI
├── Message history display
├── Typing indicators
├── SQL result formatting
├── Error message handling
└── Context management (In-memory for demo)
5
✨ Professional UI:
├── Responsive design
├── Loading states
├── Professional color scheme
├── Academic theme customization
├── Accessibility features
└── Performance optimization
6
🧪 Quality Assurance:
├── Unit tests cho critical functions
├── Integration tests
├── Security testing (JWT, SQL injection)
├── Performance testing
└── Deployment setup (Docker/local)
