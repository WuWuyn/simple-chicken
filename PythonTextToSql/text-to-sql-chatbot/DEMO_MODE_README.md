# 🎭 DEMO MODE CONFIGURATION

## Overview

Hệ thống Text-to-SQL Chatbot đã được cấu hình để chạy ở **DEMO MODE** với timestamp cố định **22:00 15/6/2024**. Điều này đảm bảo tính nhất quán với dữ liệu trong database demo.

## 🎯 Mục đích Demo Mode

1. **Tính nhất quán**: Tất cả queries sẽ sử dụng cùng một timestamp
2. **Database compatibility**: Phù hợp với dữ liệu sample trong database
3. **Demo experience**: Người dùng thấy kết quả nhất quán mỗi lần demo
4. **Testing**: Dễ dàng test và reproduce các scenarios

## ⚙️ Cấu hình hiện tại

### Backend Configuration
```python
# backend/app/core/config.py
FIXED_TIMESTAMP: str = "22:00 15/6/2024"  # Fixed demo timestamp
DEMO_MODE: bool = config("DEMO_MODE", default=True, cast=bool)
```

### Demo Time Management
```python
# backend/app/utils/demo_time.py
class DemoTimeManager:
    DEMO_TIMESTAMP = "22:00 15/6/2024"
    DEMO_DATE_FORMAT = "%H:%M %d/%m/%Y"
```

## 🔧 Các thành phần đã được cập nhật

### 1. Backend API Endpoints
- ✅ `chat.py` - Sử dụng demo timestamp cho tất cả responses
- ✅ `schemas.py` - Default timestamp values updated
- ✅ `demo_time.py` - New utility module for time management

### 2. Frontend Components
- ✅ `ChatInterface.tsx` - Hiển thị demo mode indicator
- ✅ User messages sử dụng demo timestamp
- ✅ UI hiển thị "Demo Time: 22:00 15/6/2024"

### 3. Pipeline Integration
- ✅ All pipeline requests use fixed timestamp
- ✅ Security validation với demo time
- ✅ SQL generation với demo context

## 🎨 UI Changes

### App Bar
```
Text-to-SQL Chatbot (DEMO MODE)
User Name (Role)
Demo Time: 22:00 15/6/2024
```

### Demo Notice Alert
```
🎭 DEMO MODE: All queries run at fixed time 22:00 15/6/2024 for database consistency.
```

## 🚀 Sử dụng Demo Mode

### 1. Start Backend
```bash
cd backend
python main.py
```

### 2. Start Frontend
```bash
cd frontend
npm start
```

### 3. Demo Flow
1. Login với credentials demo
2. Nhìn thấy "DEMO MODE" indicator
3. Gửi câu hỏi bất kỳ
4. Tất cả queries sẽ sử dụng timestamp cố định
5. Kết quả nhất quán với demo database

## 🔧 Chuyển đổi về Production Mode

### 1. Update Environment
```bash
# Set DEMO_MODE=false
export DEMO_MODE=false
```

### 2. Update Code (nếu cần)
```python
# backend/app/utils/demo_time.py
def get_current_time() -> datetime:
    if DemoTimeManager.is_demo_mode():
        return DemoTimeManager.get_demo_datetime()
    else:
        return datetime.utcnow()  # Real time
```

## 📋 Checklist Implementation

- ✅ Backend API endpoints sử dụng fixed timestamp
- ✅ Frontend hiển thị demo mode indicators
- ✅ Pipeline requests với demo timestamp
- ✅ Database queries với demo time context
- ✅ User interface thân thiện với demo mode
- ✅ Documentation cho demo mode
- ✅ Easy switch between demo/production modes

## 🎯 Benefits

1. **Consistent Demo Experience**: Mỗi lần demo đều cho kết quả giống nhau
2. **Database Compatibility**: Phù hợp với sample data timestamps
3. **Easy Testing**: Dễ dàng test các scenarios với fixed time
4. **Professional Demo**: UI rõ ràng về demo mode
5. **Flexible**: Dễ chuyển đổi sang production mode

## 🔍 Verification

Để verify demo mode hoạt động đúng:

1. Check welcome message: "Demo Time: 22:00 15/6/2024"
2. Check UI có hiển thị "(DEMO MODE)"
3. Check alert notification về demo mode
4. Check timestamp trong chat messages
5. Check backend logs cho fixed timestamp usage

---

**⚠️ Lưu ý**: Demo mode được thiết kế để hoạt động với dữ liệu demo cụ thể. Đối với production, cần set `DEMO_MODE=false` và sử dụng real timestamps. 