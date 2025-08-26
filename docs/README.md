# SmartDrive Postman Collections

This repository contains Postman collections and environments for testing the SmartDrive microservices APIs.

## 📁 Repository Structure

```
smartdrive-postman-collections/
├── collections/                    # Postman collection files
│   └── SmartDrive-User-Service-Collection.json
├── environments/                   # Postman environment files
│   └── SmartDrive-Dev-Environment.json
├── .github/                       # GitHub Actions workflows
│   └── workflows/
│       └── sync-postman.yml
└── docs/                          # Documentation
    └── README.md
```

## 🚀 Quick Start

### 1. Import Collection and Environment

1. **Import Collection:**
   - Open Postman
   - Click "Import" → "File" → Select `collections/SmartDrive-User-Service-Collection.json`

2. **Import Environment:**
   - Click "Import" → "File" → Select `environments/SmartDrive-Dev-Environment.json`
   - Select the "SmartDrive Dev Environment" from the environment dropdown

### 2. Start SmartDrive Services

Before testing, ensure all required services are running:

```bash
# Navigate to SmartDrive root directory
cd /path/to/SmartDrive

# Build and start services
docker compose build
docker compose up -d
```

Required services:
- **Eureka Server** (Port 8761)
- **API Gateway** (Port 8080)
- **Auth Service** (Port 8085)
- **User Service** (Port 8081)

### 3. Test the APIs

#### Authentication Flow

1. **Register User** - Create a new account
2. **Verify Email** - Use the token from email (check logs)
3. **Get OAuth2 Token** - Login and get access token
4. **Test Protected Endpoints** - Use the access token

#### User Management

- **Get User Profile** - Retrieve current user info
- **Update User Profile** - Modify user details
- **Change Password** - Update password
- **Delete Account** - Remove user account

#### Admin Operations

- **Get All Users** - List all users (ADMIN role required)
- **Get User Statistics** - View user metrics
- **Toggle User Account** - Enable/disable users
- **Assign User Roles** - Manage user roles
- **Delete User** - Remove user accounts

## 🔧 Environment Variables

### Core Configuration
- `gateway_base_url`: API Gateway URL (default: http://localhost:8080)
- `oauth2_client_id`: OAuth2 client identifier (default: smartdrive-web)
- `oauth2_client_secret`: OAuth2 client secret (default: secret)
- `internal_auth_secret`: Internal service authentication key

### Test Data
- `test_username`: Test user username
- `test_password`: Test user password
- `test_email`: Test user email
- `test_first_name`: Test user first name
- `test_last_name`: Test user last name
- `test_phone`: Test user phone number
- `test_bio`: Test user bio

### Dynamic Variables
- `access_token`: OAuth2 access token (auto-populated)
- `refresh_token`: OAuth2 refresh token (auto-populated)
- `email_verification_token`: Email verification token (from email)

## 🔐 Authentication

### OAuth2 Flow
SmartDrive uses OAuth2 Resource Owner Password Credentials flow:

1. **Client Registration**: Pre-configured client `smartdrive-web`
2. **Token Endpoint**: `POST /oauth2/token`
3. **Token Types**: Access token + Refresh token
4. **Authorization**: Bearer token in Authorization header

### Internal Authentication
For service-to-service communication:
- **Header**: `X-Internal-Auth`
- **Value**: Internal secret key
- **Usage**: Verify credentials, get user profiles

## 📋 API Endpoints

### Public Endpoints
- `POST /api/v1/users/register` - User registration
- `GET /api/v1/users/verify-email` - Email verification

### Protected Endpoints
- `GET /api/v1/users/profile` - Get user profile
- `PUT /api/v1/users/profile` - Update user profile
- `POST /api/v1/users/change-password` - Change password
- `DELETE /api/v1/users/profile` - Delete account

### Admin Endpoints
- `GET /api/v1/admin/users` - List all users
- `GET /api/v1/admin/statistics` - User statistics
- `PUT /api/v1/admin/users/{id}/toggle` - Toggle user account
- `PUT /api/v1/admin/users/{id}/roles` - Assign roles
- `DELETE /api/v1/admin/users/{id}` - Delete user

### Internal Endpoints
- `POST /api/v1/users/verify-credentials` - Verify credentials
- `GET /api/v1/users/{username}/token-claims` - Get token claims
- `GET /api/v1/users/{username}/profile` - Get user profile

## 🔄 Automated Sync

This repository includes GitHub Actions for automatic Postman sync:

### Features
- **Auto-sync**: Updates Postman collection when files change
- **Environment Management**: Keeps environments in sync
- **Version Control**: Track changes to collections

### Setup
1. **Postman API Key**: Set `POSTMAN_API_KEY` in repository secrets
2. **Workspace ID**: Set `POSTMAN_WORKSPACE_ID` in repository secrets
3. **Collection ID**: Set `POSTMAN_COLLECTION_ID` in repository secrets

### Workflow
- Triggers on push to main branch
- Updates collection via Postman API
- Sends notifications on success/failure

## 🛠️ Development

### Adding New Endpoints
1. Update the collection JSON file
2. Add environment variables if needed
3. Test the endpoint
4. Commit and push changes

### Environment Management
- **Dev**: Local development (localhost)
- **Staging**: Staging environment (future)
- **Production**: Production environment (future)

### Best Practices
- Use descriptive endpoint names
- Include detailed descriptions
- Add example request/response bodies
- Use environment variables for dynamic values
- Test all endpoints before committing

## 🐛 Troubleshooting

### Common Issues

1. **Connection Refused**
   - Check if services are running: `docker compose ps`
   - Verify ports are not in use: `netstat -tulpn | grep :8080`

2. **Authentication Errors**
   - Verify OAuth2 client credentials
   - Check if user is registered and email verified
   - Ensure access token is valid

3. **Email Verification**
   - Check service logs for email content
   - Verify SMTP configuration
   - Use correct verification token

4. **Internal Auth Errors**
   - Verify internal auth secret matches
   - Check service configuration
   - Ensure proper headers are set

### Debug Steps
1. Check service logs: `docker compose logs <service-name>`
2. Verify environment variables
3. Test endpoints individually
4. Check network connectivity

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review service logs
3. Verify configuration
4. Test with curl commands

## 📄 License

This project is part of the SmartDrive microservices architecture.
