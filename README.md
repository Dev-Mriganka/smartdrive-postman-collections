# SmartDrive Postman Collections

This repository contains comprehensive Postman collections and environments for testing all SmartDrive services through the API Gateway.

## 📋 Collections Available

### 1. SmartDrive Complete API Gateway Collection

**File**: `collections/SmartDrive-Gateway-Complete-Collection.json`

Complete collection testing all services through the API Gateway including:

- 🔐 **Authentication & User Registration** - Register users, verify emails, get OAuth2 tokens
- 👤 **User Profile Management** - CRUD operations for user profiles
- 📁 **File Storage Service** - Upload, download, list, and delete files
- 🤖 **AI Service** - Chat with AI and analyze files
- 🔍 **Search Service** - Search files and content
- ⚙️ **Admin Operations** - User management for admins
- 🔧 **System Health & Monitoring** - Check gateway health and routes
- 🧪 **CORS Testing** - Validate CORS configuration

### 2. Legacy User Service Collection

**File**: `collections/SmartDrive-User-Service-Collection.json`

Legacy collection focusing on user service endpoints.

## 🚀 Quick Start

1. **Import Collections**: Import both JSON files into Postman
2. **Import Environment**: Import `environments/SmartDrive-Dev-Environment.json`
3. **Select Environment**: Choose "SmartDrive Dev Environment" in Postman
4. **Start Testing**: Begin with "Register New User" to create a test account

## 🔧 Testing Flow

### Step 1: User Registration & Authentication

1. Run **"Register New User"** - Creates a new user account
   - ⚠️ **Note**: May return 405 error due to gateway response issue, but user is still created
2. Run **"Get OAuth2 Token"** - Authenticates and retrieves access tokens
   - Automatically stores `access_token` and `refresh_token` for subsequent requests

### Step 2: Test User Operations

3. Run **"Get User Profile"** - Retrieves user information
4. Run **"Update User Profile"** - Modifies user details
5. Run **"Change Password"** - Updates user password

### Step 3: Test File Operations

6. Run **"Upload File"** - Upload a test file
7. Run **"List User Files"** - View uploaded files
8. Run **"Download File"** - Download a file by ID

### Step 4: Test AI & Search

9. Run **"Chat with AI"** - Test AI service integration
10. Run **"Search Files"** - Test search functionality

## 🔍 Known Issues & Solutions

### Registration 405 Error

- **Issue**: POST `/api/v1/users/register` returns 405 Method Not Allowed
- **Status**: Gateway response handling bug (user is still created successfully)
- **Workaround**: Check if user was created by attempting to get OAuth2 token

### Password Requirements

Passwords must meet these criteria:

- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character (`@$!%*?&`)

### Username Requirements

- 3-50 characters
- Alphanumeric characters and underscores only
- Must be unique

## 🌐 CORS Testing

The collection includes CORS preflight testing to validate browser compatibility:

- **Origin**: `http://localhost:5174` (UI development server)
- **Methods**: POST, GET, PUT, DELETE, OPTIONS
- **Headers**: Content-Type, Authorization

## 📊 Environment Variables

Key variables in `SmartDrive-Dev-Environment.json`:

- `gateway_base_url`: http://localhost:8080
- `oauth2_client_id`: smartdrive-web
- `oauth2_client_secret`: secret
- `test_username`: Auto-generated unique username
- `test_email`: Auto-generated unique email
- `access_token`: OAuth2 access token (auto-populated)
- `refresh_token`: OAuth2 refresh token (auto-populated)

Structure:

- collections/
- environments/
- docs/
