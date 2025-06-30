# Text-to-SQL Chatbot System

A professional chatbot web application that integrates with the existing Text-to-SQL pipeline for academic management.

## 🏗️ Architecture

```
Frontend (React + TypeScript) ↔ Backend (FastAPI) ↔ Text-to-SQL Pipeline ↔ MS SQL Server
```

## ⚡ Quick Start (Fixed Installation)

### 🔍 Pre-Installation Validation
```bash
# Run this FIRST to check your setup
python validate_setup.py

# If all checks pass, proceed with installation
# If checks fail, fix the issues before continuing
```

### Prerequisites
```bash
# Check versions
python --version  # 3.8+ required
node --version    # 16+ required  
npm --version     # 8+ required
```

### Backend Setup
```bash
cd backend

# 1. Install dependencies (updated to prevent errors)
pip install -r requirements.txt

# 2. Verify critical imports
python -c "import jwt, pydantic_settings; print('✅ All imports working')"

# 3. Start server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Frontend Setup
```bash
cd frontend

# 1. Install dependencies
npm install

# 2. Start development server
npm start
```

### 🌐 Access Points
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs
- **Health Check**: http://localhost:8000/health

### 🔐 Test Accounts
- **Student**: `he00001_user` / `password`  
- **Lecturer**: `lec001_user` / `password`
- **Training Manager**: `tm001_user` / `password`

---

## 🔧 Common Issues & Solutions

### ❌ Backend Import Errors

**Problem 1: `BaseSettings` import error**
```
pydantic.errors.PydanticImportError: BaseSettings has been moved to pydantic-settings
```
**✅ Solution**: Updated requirements.txt includes `pydantic-settings>=2.10.1`

**Problem 2: JWT module not found**
```
ModuleNotFoundError: No module named 'jwt'
```
**✅ Solution**: Now using `PyJWT==2.8.0` instead of python-jose

**Problem 3: Pydantic version conflicts**
```
pydantic 2.5.0 which is incompatible with pydantic-settings 2.10.1
```
**✅ Solution**: Updated to `pydantic>=2.7.0` for compatibility

### ❌ Frontend Import Errors

**Problem 1: Path alias errors**
```
Module not found: Error: Can't resolve '@/components/Login/LoginForm'
```
**✅ Solution**: Fixed imports to use relative paths in App.tsx

**Problem 2: Material-UI icon errors**
```
'"@mui/icons-material"' has no exported member named 'Smart'
```  
**✅ Solution**: Changed `Smart` to `Psychology` icon

**Problem 3: Typography prop errors**
```
Property 'opacity' does not exist on type
```
**✅ Solution**: Use `sx={{ opacity: 0.7 }}` instead of `opacity={0.7}`

### ❌ Server Connection Issues

**Problem: Proxy errors**
```
Proxy error: Could not proxy request from localhost:3000 to http://localhost:8000
```
**✅ Solution**: Ensure backend is running on port 8000 before starting frontend

---

## 📁 Project Structure

```
text-to-sql-chatbot/
├── backend/           # FastAPI backend
│   ├── app/
│   │   ├── api/       # API endpoints
│   │   ├── core/      # Core configurations
│   │   ├── models/    # Data models
│   │   └── utils/     # Utility functions
│   ├── main.py        # App entry point
│   └── requirements.txt # Updated dependencies
├── frontend/          # React frontend
│   ├── src/
│   │   ├── components/
│   │   ├── services/
│   │   └── types/
│   └── package.json
└── README.md         # This file
```

## 🔧 Features

- ✅ JWT Authentication (Fixed PyJWT integration)
- ✅ Real-time Chat Interface (Fixed import paths)
- ✅ Text-to-SQL Integration (4-step pipeline)
- ✅ Context Management
- ✅ Professional UI (Fixed Material-UI issues)
- ✅ Role-based Access Control
- ✅ Query Caching & Analytics
- ✅ Rate Limiting Protection

## 🌟 Tech Stack

**Backend**: FastAPI, PyJWT, SQLAlchemy, WebSocket (Redis removed for demo)
**Frontend**: React, TypeScript, Material-UI, Axios
**Database**: MS SQL Server (Redis removed for demo)
**Integration**: Text-to-SQL Pipeline (Method/)

## 🧪 Testing Installation

### 🔍 Auto-Test Script (Recommended)
```bash
# Run comprehensive test
python test_login.py

# Expected output:
# ✅ Health Check: 200
# ✅ Login Successful! (for valid users)
# ❌ Login Failed (for invalid users)
# 🎯 Result: 3/3 valid logins successful
```

### 🔄 Switch Authentication Mode
```bash
# Easy mode switcher (Interactive)
python switch_auth_mode.py

# Quick commands:
# Mock mode: set USE_MOCK_AUTH=true
# Database mode: set USE_MOCK_AUTH=false
```

### Verify Backend Manually
```bash
cd backend
curl http://localhost:8000/health
# Expected: {"status":"healthy","app":"Text-to-SQL Chatbot API","version":"1.0.0"}
```

### Verify Frontend  
```bash
# Open browser: http://localhost:3000
# Should show login page without console errors
# No more manifest.json 404 errors
```

### Test Login Flow

#### Option 1: Mock Authentication (Current - Quick Testing)
```bash
# Use these test accounts:
# Username: he00001_user, Password: password (Student)
# Username: lec001_user, Password: password (Lecturer)  
# Username: tm001_user, Password: password (Training Manager)

# Mock authentication is currently ACTIVE for quick testing
# These are temporary accounts for demo purposes
```

#### Option 2: Database Authentication (Real Users)
```bash
# If you have SQL Server with user data:
# 1. Check database connection: python test_database.py
# 2. Configure database settings in backend/app/core/config.py
# 3. Disable mock: set USE_MOCK_AUTH=false
# 4. Restart backend: cd backend && python main.py
# 5. Login with real usernames/passwords from your Users table

# See SETUP_DATABASE.md for detailed instructions
```

### Login Testing
```bash
# 1. Login should show JWT token and user info
# 2. Chat interface should load  
# 3. Send test message: "What courses am I taking?"
# 4. Should receive response from Text-to-SQL pipeline
```

---

## 🆘 Need Help?

### Dependencies Not Installing?
```bash
# Update pip first
pip install --upgrade pip

# Clear cache and reinstall
pip cache purge
pip install -r requirements.txt --force-reinstall
```

### Still Getting Import Errors?
```bash
# Check Python environment
python -c "import sys; print(sys.path)"

# Verify specific packages
python -c "import jwt, pydantic_settings, fastapi; print('✅ All working')"
```

### Frontend Build Errors?
```bash
# Clear node modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

---

## 🚀 Production Deployment

For production deployment, uncomment these in requirements.txt:
```
gunicorn==21.2.0
docker==6.1.3
```

And use:
```bash
gunicorn main:app -w 4 -k uvicorn.workers.UvicornWorker
```

---

**Note**: All common installation issues have been resolved in this version. If you encounter new problems, please check the troubleshooting section above. 