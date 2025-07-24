"""Main FastAPI Application - Modular API server initialization"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse, FileResponse
import uvicorn
import os

# Import modular route components
from .admin_routes import router as admin_router
from .beta_routes import router as beta_router
from .analytics_routes import router as analytics_router
from .admin_pages import router as pages_router
from .user_routes import router as user_router
from .database import init_user_database
from .config import UPLOAD_DIR

# Initialize FastAPI app
app = FastAPI(
    title="Vault Desktop API Server",
    description="Modular API for Vault Desktop beta management, analytics, and admin control",
    version="2.0.0"
)

# CORS middleware configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://getvaultdesktop.com", "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include all route modules
app.include_router(admin_router)    # Admin API endpoints (/admin/*)
app.include_router(beta_router)     # Beta key validation (/validate_key, /admin/beta/*)
app.include_router(analytics_router) # Analytics collection (/analytics)
app.include_router(pages_router)    # Admin HTML pages (/admin/dashboard, etc.)
app.include_router(user_router)     # User auth endpoints (/signup, /signin)

# Initialize database on startup
@app.on_event("startup")
async def startup_event():
    """Initialize databases and create upload directories"""
    print("🚀 Initializing Vault API Server...")
    
    # Create upload directories
    os.makedirs(f"{UPLOAD_DIR}/staging", exist_ok=True)
    os.makedirs(f"{UPLOAD_DIR}/current", exist_ok=True)
    os.makedirs(f"{UPLOAD_DIR}/archive", exist_ok=True)
    
    # Initialize user database with tables
    init_user_database()
    
    print("✅ Database initialized")
    print("✅ Upload directories created")
    print("🔐 Admin Login: username=admin, password=Chance19!")

# Root endpoint - redirect to admin
@app.get("/", response_class=HTMLResponse)
async def root():
    """Root endpoint - redirect to admin panel"""
    return '''
    <html>
        <head>
            <title>Vault API Server</title>
            <meta http-equiv="refresh" content="0; url=/admin">
        </head>
        <body>
            <p>Redirecting to admin panel...</p>
        </body>
    </html>
    '''

# Health check endpoint
@app.get("/health")
async def health_check():
    """API health check"""
    return {
        "status": "healthy",
        "service": "vault-api",
        "version": "2.0.0-modular"
    }

# Download endpoint for current Vault.exe
@app.get("/download/vault.exe")
async def download_current_vault():
    """Download current Vault.exe release"""
    current_file = f"{UPLOAD_DIR}/current/Vault.exe"
    
    if os.path.exists(current_file):
        return FileResponse(
            current_file,
            media_type='application/octet-stream',
            filename='Vault.exe'
        )
    else:
        return {"error": "No current release available"}

# Legacy admin login page (for direct access)
@app.get("/admin", response_class=HTMLResponse)
async def admin_login():
    """Admin login page"""
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Vault Admin Login</title>
        <style>
            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: linear-gradient(135deg, #1a1a1a, #2d2d2d);
                color: #e0e0e0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }
            .login-card {
                background: rgba(255,255,255,0.05);
                padding: 40px;
                border-radius: 15px;
                border: 1px solid rgba(255,255,255,0.1);
                box-shadow: 0 8px 32px rgba(0,0,0,0.3);
                width: 400px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
            }
            input {
                width: 100%;
                padding: 12px;
                border: 1px solid rgba(255,255,255,0.2);
                border-radius: 8px;
                background: rgba(255,255,255,0.1);
                color: white;
                font-size: 16px;
            }
            .btn {
                width: 100%;
                padding: 15px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
            }
            .btn:hover {
                background: #45a049;
                transform: translateY(-2px);
            }
            .error {
                color: #f44336;
                margin-top: 10px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="login-card">
            <h2 style="text-align: center; margin-bottom: 30px;">🔐 Admin Login</h2>
            <form id="loginForm">
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" id="username" required>
                </div>
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" id="password" required>
                </div>
                <button type="submit" class="btn">Login</button>
                <div id="error" class="error"></div>
            </form>
        </div>

        <script>
            document.getElementById('loginForm').addEventListener('submit', async (e) => {
                e.preventDefault();
                
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                
                try {
                    const response = await fetch('/admin/auth', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ username, password })
                    });
                    
                    if (response.ok) {
                        const data = await response.json();
                        localStorage.setItem('admin_token', data.access_token);
                        window.location.href = '/admin/dashboard';
                    } else {
                        document.getElementById('error').textContent = 'Invalid credentials';
                    }
                } catch (error) {
                    document.getElementById('error').textContent = 'Login failed';
                }
            });
        </script>
    </body>
    </html>
    '''

# Development server entry point
if __name__ == "__main__":
    print("="*60)
    print("🚀 Starting Vault API Server (Modular)")
    print("📊 Admin Panel: https://getvaultdesktop.com/admin")
    print("🔐 Login: admin / Chance19!")
    print("="*60)
    
    uvicorn.run(
        "main:app",
        host="0.0.0.0", 
        port=8000,
        reload=True,
        log_level="info"
    )
