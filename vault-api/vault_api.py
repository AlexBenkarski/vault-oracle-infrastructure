from fastapi import FastAPI, HTTPException, status, Depends, Form, Request, UploadFile, File
from fastapi.responses import JSONResponse, HTMLResponse, RedirectResponse, FileResponse
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr
import sqlite3
from datetime import datetime, timedelta
import os
from typing import Optional, List
import hashlib
import bcrypt
import secrets
import jwt
import re
import shutil
import json
from models import AnalyticsDB
from services_monitor import get_all_services_status, restart_service_safe

app = FastAPI(title="Vault Key Validation API")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://getvaultdesktop.com", "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# JWT Configuration
SECRET_KEY = "vault-secret-key-change-in-production"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_HOURS = 24
security = HTTPBearer()

# Database paths
DB_PATH = "/opt/discord-bot/bot_data.db"
analytics_db = AnalyticsDB("/opt/vault-api/analytics.db")

# File upload configuration
UPLOAD_DIR = "/opt/vault-files"
os.makedirs(f"{UPLOAD_DIR}/staging", exist_ok=True)
os.makedirs(f"{UPLOAD_DIR}/current", exist_ok=True)
os.makedirs(f"{UPLOAD_DIR}/archive", exist_ok=True)

# Models
class KeyValidationRequest(BaseModel):
    beta_key: str
    username: str

class KeyValidationResponse(BaseModel):
    valid: bool
    message: str
    user_info: Optional[dict] = None

class AnalyticsPayload(BaseModel):
    vault_id: str
    version: str
    os: str
    consent_given: bool
    install_metrics: dict
    vault_stats: dict
    feature_usage: dict
    performance: dict

class UserSignup(BaseModel):
    email: EmailStr
    password: str

class UserSignin(BaseModel):
    email: EmailStr
    password: str

class UserAction(BaseModel):
    user_id: int
    action: str

# Initialize user authentication database
def init_user_database():
    """Initialize user authentication database"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    conn.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            email TEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            email_verified BOOLEAN DEFAULT TRUE,
            has_beta BOOLEAN DEFAULT FALSE,
            verification_token TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            last_login TIMESTAMP
        )
    ''')

    conn.execute('''
        CREATE TABLE IF NOT EXISTS admin_users (
            id INTEGER PRIMARY KEY,
            username TEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            email TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            last_login TIMESTAMP
        )
    ''')

    conn.execute('''
        CREATE TABLE IF NOT EXISTS beta_keys (
            id INTEGER PRIMARY KEY,
            key_value TEXT UNIQUE NOT NULL,
            user_id INTEGER,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            activated_at TIMESTAMP,
            status TEXT DEFAULT 'unused',
            FOREIGN KEY (user_id) REFERENCES users (id)
        )
    ''')

    conn.execute('''
        CREATE TABLE IF NOT EXISTS file_releases (
            id INTEGER PRIMARY KEY,
            filename TEXT NOT NULL,
            version TEXT NOT NULL,
            file_path TEXT NOT NULL,
            file_size INTEGER,
            status TEXT DEFAULT 'staging',
            uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            activated_at TIMESTAMP
        )
    ''')

    # Create default admin user (password: Chance19!)
    admin_hash = hashlib.sha256("Chance19!".encode()).hexdigest()
    conn.execute('''
        INSERT OR IGNORE INTO admin_users (username, password_hash, email)
        VALUES (?, ?, ?)
    ''', ("admin", admin_hash, "admin@getvaultdesktop.com"))

    conn.commit()
    conn.close()

# Initialize user database
init_user_database()

# Authentication helper functions
def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode("utf-8"), hashed.encode("utf-8"))

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(hours=ACCESS_TOKEN_EXPIRE_HOURS)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

def verify_token(credentials: HTTPAuthorizationCredentials = Depends(security)):
    try:
        payload = jwt.decode(credentials.credentials, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise HTTPException(status_code=401, detail="Invalid token")
        return email
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Invalid token")

def verify_admin_token(credentials: HTTPAuthorizationCredentials = Depends(security)):
    try:
        payload = jwt.decode(credentials.credentials, SECRET_KEY, algorithms=[ALGORITHM])
        username = payload.get("sub")
        role = payload.get("role")
        if username is None or role != "admin":
            raise HTTPException(status_code=401, detail="Admin access required")
        return username
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Invalid admin token")

def is_valid_email(email: str) -> bool:
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

def generate_beta_key() -> str:
    """Generate a new beta key"""
    segments = []
    for _ in range(3):
        segment = ''.join(secrets.choice('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') for _ in range(4))
        segments.append(segment)
    return f"VAULT-{'-'.join(segments)}"

# Beta key functions
def get_db_connection():
    """Get database connection"""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def find_user_by_beta_key(beta_key: str):
    """Find user who owns this beta key"""
    conn = get_db_connection()
    try:
        cursor = conn.execute(
            "SELECT discord_id FROM user_data WHERE key = 'current_beta_key' AND value = ?",
            (beta_key,)
        )
        result = cursor.fetchone()

        if result:
            user_cursor = conn.execute(
                "SELECT * FROM users WHERE discord_id = ?",
                (result['discord_id'],)
            )
            user = user_cursor.fetchone()
            return dict(user) if user else None
        return None
    finally:
        conn.close()

def check_key_status(discord_id: str):
    """Check if user's beta access is still valid"""
    conn = get_db_connection()
    try:
        cursor = conn.execute(
            "SELECT value FROM user_data WHERE discord_id = ? AND key = 'status'",
            (discord_id,)
        )
        result = cursor.fetchone()
        return result['value'] if result else 'approved'
    finally:
        conn.close()

def mark_key_as_used(discord_id: str, username: str):
    """Mark beta key as activated"""
    conn = get_db_connection()
    try:
        conn.execute(
            "INSERT OR REPLACE INTO user_data (discord_id, key, value) VALUES (?, 'activated_at', ?)",
            (discord_id, datetime.now().isoformat())
        )
        conn.execute(
            "INSERT OR REPLACE INTO user_data (discord_id, key, value) VALUES (?, 'vault_username', ?)",
            (discord_id, username)
        )
        conn.execute(
            "INSERT OR REPLACE INTO user_data (discord_id, key, value) VALUES (?, 'status', 'activated')",
            (discord_id,)
        )
        conn.commit()
    finally:
        conn.close()

# ADMIN STYLES
ADMIN_STYLES = '''
<style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #1a1a1a; color: white; }
    .header { display: flex; justify-content: space-between; margin-bottom: 30px; align-items: center; }
    .nav { background: #333; padding: 15px; border-radius: 8px; margin-bottom: 30px; }
    .nav a { color: #4CAF50; text-decoration: none; margin-right: 25px; padding: 8px 16px; border-radius: 4px; font-weight: 500; }
    .nav a:hover, .nav a.active { background: #4CAF50; color: white; }
    .card { background: #2d2d2d; padding: 20px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #444; }
    .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; margin: 2px; font-weight: 500; }
    .btn-primary { background: #4CAF50; color: white; }
    .btn-danger { background: #f44336; color: white; }
    .btn-warning { background: #FF9800; color: white; }
    .btn-secondary { background: #6c757d; color: white; }
    .btn:hover { opacity: 0.8; }
    .table { width: 100%; border-collapse: collapse; background: #2d2d2d; }
    .table th, .table td { padding: 12px; text-align: left; border-bottom: 1px solid #444; }
    .table th { background: #4CAF50; color: white; }
    .badge { padding: 4px 8px; border-radius: 12px; font-size: 0.8em; font-weight: bold; }
    .badge-success { background: #4CAF50; color: white; }
    .badge-warning { background: #FF9800; color: white; }
    .badge-danger { background: #f44336; color: white; }
    .badge-secondary { background: #6c757d; color: white; }
    .upload-area { border: 2px dashed #4CAF50; padding: 40px; text-align: center; border-radius: 8px; margin: 20px 0; }
    .upload-area:hover { background: rgba(76, 175, 80, 0.1); }
    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 20px 0; }
    .stat-card { background: #2d2d2d; padding: 20px; border-radius: 8px; text-align: center; border: 1px solid #4CAF50; }
    .stat-number { font-size: 2rem; color: #4CAF50; font-weight: bold; }
    .stat-label { color: #a0a0a0; text-transform: uppercase; font-size: 0.9rem; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; margin-bottom: 5px; color: #fff; }
    .form-group input, .form-group select { width: 100%; padding: 10px; background: #333; border: 1px solid #555; border-radius: 4px; color: white; }
    .service-card { display: flex; justify-content: space-between; align-items: center; margin: 10px 0; }
    .status-indicator { width: 12px; height: 12px; border-radius: 50%; margin-right: 10px; display: inline-block; }
    .status-running { background: #4CAF50; }
    .status-stopped { background: #f44336; }
    .restart-btn { background: #2196F3; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
    .restart-btn:hover { background: #1976D2; }
    .restart-btn:disabled { background: #ccc; cursor: not-allowed; }
</style>
'''

# ENDPOINTS
@app.get("/")
async def root():
    return {"message": "Vault Key Validation API", "status": "online", "version": "2.0"}

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    try:
        conn = get_db_connection()
        conn.close()
        return {"status": "healthy", "database": "connected"}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=f"Database connection failed: {str(e)}"
        )

# User Authentication Endpoints
@app.post("/auth/signup")
async def signup(user: UserSignup):
    """Register new user account"""
    if not is_valid_email(user.email):
        raise HTTPException(status_code=400, detail="Invalid email format")

    if len(user.password) < 8:
        raise HTTPException(status_code=400, detail="Password must be at least 8 characters")

    conn = sqlite3.connect('/opt/vault-api/users.db')

    cursor = conn.execute("SELECT email FROM users WHERE email = ?", (user.email,))
    if cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=400, detail="Email already registered")

    password_hash = hash_password(user.password)

    conn.execute('''
        INSERT INTO users (email, password_hash, email_verified)
        VALUES (?, ?, ?)
    ''', (user.email, password_hash, True))

    conn.commit()
    conn.close()

    return {"message": "Account created successfully!"}

@app.post("/auth/signin")
async def signin(user: UserSignin):
    """Sign in user"""
    conn = sqlite3.connect('/opt/vault-api/users.db')

    cursor = conn.execute('''
        SELECT email, password_hash, email_verified
        FROM users WHERE email = ?
    ''', (user.email,))

    result = cursor.fetchone()

    if not result or not verify_password(user.password, result[1]):
        conn.close()
        raise HTTPException(status_code=401, detail="Invalid email or password")

    if not result[2]:
        conn.close()
        raise HTTPException(status_code=401, detail="Please verify your email first")

    conn.execute('''
        UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE email = ?
    ''', (user.email,))
    conn.commit()
    conn.close()

    token = create_access_token({"sub": user.email})
    return {"token": token, "message": "Sign in successful"}

@app.post("/auth/login")
async def login(user: UserSignin):
    """Login alias for signin"""
    return await signin(user)

# Admin Authentication
@app.post("/admin/auth")
async def admin_login(username: str = Form(), password: str = Form()):
    """Admin login"""
    conn = sqlite3.connect('/opt/vault-api/users.db')

    # Use SHA256 for admin password (legacy compatibility)
    password_hash = hashlib.sha256(password.encode()).hexdigest()

    cursor = conn.execute('''
        SELECT username, password_hash FROM admin_users WHERE username = ? AND password_hash = ?
    ''', (username, password_hash))

    result = cursor.fetchone()

    if not result:
        conn.close()
        raise HTTPException(status_code=401, detail="Invalid credentials")

    conn.execute('''
        UPDATE admin_users SET last_login = CURRENT_TIMESTAMP WHERE username = ?
    ''', (username,))
    conn.commit()
    conn.close()

    token = create_access_token({"sub": username, "role": "admin"})
    return {"access_token": token, "token_type": "bearer", "message": "Admin login successful"}

# Admin Pages
@app.get("/admin", response_class=HTMLResponse)
async def admin_login_page():
    """Admin login page"""
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Admin Login - TheVault</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #1a1a1d;
                color: white;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .login-box {
                background: #2d2d30;
                padding: 40px;
                border-radius: 12px;
                border: 2px solid #4CAF50;
                width: 300px;
            }
            h2 { color: #4CAF50; text-align: center; margin-bottom: 30px; }
            input {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.3);
                border-radius: 6px;
                color: white;
                box-sizing: border-box;
            }
            button {
                width: 100%;
                padding: 12px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }
            button:hover { background: #45a049; }
            .error { color: #ff4757; margin-top: 10px; text-align: center; }
        </style>
    </head>
    <body>
        <div class="login-box">
            <h2>Admin Login</h2>
            <form id="adminForm">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
                <div id="error" class="error"></div>
            </form>
        </div>

        <script>
            document.getElementById('adminForm').addEventListener('submit', async function(e) {
                e.preventDefault();
                const formData = new FormData(this);

                try {
                    const response = await fetch('/admin/auth', {
                        method: 'POST',
                        body: formData
                    });

                    const data = await response.json();

                    if (response.ok) {
                        localStorage.setItem('admin_token', data.access_token);
                        window.location.href = '/admin/dashboard';
                    } else {
                        document.getElementById('error').textContent = data.detail;
                    }
                } catch (error) {
                    document.getElementById('error').textContent = 'Network error';
                }
            });
        </script>
    </body>
    </html>
    '''

@app.get("/admin/dashboard", response_class=HTMLResponse)
async def admin_dashboard():
    """Admin dashboard with service monitoring"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>🔐 Admin Dashboard</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard" class="active">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number" id="total-users">--</div>
            <div class="stat-label">Total Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="verified-users">--</div>
            <div class="stat-label">Verified Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="beta-users">--</div>
            <div class="stat-label">Beta Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="analytics-users">--</div>
            <div class="stat-label">Analytics Users</div>
        </div>
    </div>

    <div class="card">
        <h3>🖥️ System Services</h3>
        <div id="services-container">
            <div class="service-card">
                <div style="display: flex; align-items: center;">
                    <div class="status-indicator" id="vault-api-status"></div>
                    <span>Vault API</span>
                </div>
                <button class="restart-btn" onclick="restartService('vault-api')" id="restart-vault-api">Restart</button>
            </div>
            <div class="service-card">
                <div style="display: flex; align-items: center;">
                    <div class="status-indicator" id="nginx-status"></div>
                    <span>Nginx</span>
                </div>
                <button class="restart-btn" onclick="restartService('nginx')" id="restart-nginx">Restart</button>
            </div>
            <div class="service-card">
                <div style="display: flex; align-items: center;">
                    <div class="status-indicator" id="discord-bot-status"></div>
                    <span>Discord Bot</span>
                </div>
                <button class="restart-btn" onclick="restartService('discord-bot')" id="restart-discord-bot">Restart</button>
            </div>
        </div>
    </div>

    <div class="card">
        <h3>📊 Quick Stats</h3>
        <p>• API Status: <span id="api-health">Checking...</span></p>
        <p>• Last Updated: <span id="last-updated">Never</span></p>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function updateServiceStatus() {
            try {
                const response = await fetch('/admin/services/status', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const services = await response.json();

                    services.forEach(service => {
                        const indicator = document.getElementById(service.name + '-status');
                        if (indicator) {
                            indicator.className = 'status-indicator ' + (service.status === 'active' ? 'status-running' : 'status-stopped');
                        }
                    });

                    document.getElementById('api-health').textContent = 'Online';
                    document.getElementById('last-updated').textContent = new Date().toLocaleTimeString();
                }
            } catch (error) {
                console.error('Service status error:', error);
                document.getElementById('api-health').textContent = 'Error';
            }
        }

        async function restartService(serviceName) {
            const button = document.getElementById('restart-' + serviceName);
            button.disabled = true;
            button.textContent = 'Restarting...';

            try {
                const response = await fetch('/admin/services/restart/' + serviceName, {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    setTimeout(updateServiceStatus, 2000);
                }
            } catch (error) {
                console.error('Restart error:', error);
            } finally {
                setTimeout(() => {
                    button.disabled = false;
                    button.textContent = 'Restart';
                }, 3000);
            }
        }

        async function loadStats() {
            try {
                const response = await fetch('/admin/stats', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const stats = await response.json();
                    document.getElementById('total-users').textContent = stats.total_users;
                    document.getElementById('verified-users').textContent = stats.verified_users;
                    document.getElementById('beta-users').textContent = stats.beta_users;
                    document.getElementById('analytics-users').textContent = stats.analytics_users;
                } else {
                    window.location.href = '/admin';
                }
            } catch (error) {
                console.error('Error loading stats:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Initialize
        loadStats();
        updateServiceStatus();
        setInterval(updateServiceStatus, 30000);
        setInterval(loadStats, 60000);
    </script>
    '''

# MISSING ADMIN PAGES - USERS
@app.get("/admin/users", response_class=HTMLResponse)
async def admin_users_page():
    """Admin users management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>👥 User Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users" class="active">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>👤 User List</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Beta Access</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="users-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadUsers() {
            try {
                const response = await fetch('/admin/users/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const users = await response.json();
                    const tbody = document.getElementById('users-table');
                    
                    if (users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No users found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = users.map(user => `
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.email}</td>
                            <td><span class="badge ${user.email_verified ? 'badge-success' : 'badge-warning'}">${user.email_verified ? 'Verified' : 'Pending'}</span></td>
                            <td><span class="badge ${user.has_beta ? 'badge-success' : 'badge-secondary'}">${user.has_beta ? 'Yes' : 'No'}</span></td>
                            <td>${new Date(user.created_at).toLocaleDateString()}</td>
                            <td>
                                <button class="btn btn-warning" onclick="toggleBeta(${user.id}, ${!user.has_beta})">${user.has_beta ? 'Remove Beta' : 'Grant Beta'}</button>
                            </td>
                        </tr>
                    `).join('');
                } else {
                    window.location.href = '/admin';
                }
            } catch (error) {
                console.error('Error loading users:', error);
            }
        }

        async function toggleBeta(userId, grantBeta) {
            try {
                const response = await fetch('/admin/users/beta', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ user_id: userId, action: grantBeta ? 'grant' : 'revoke' })
                });

                if (response.ok) {
                    loadUsers();
                }
            } catch (error) {
                console.error('Error toggling beta:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadUsers();
    </script>
    '''

# MISSING ADMIN PAGES - BETA KEYS
@app.get("/admin/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Admin beta keys management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>🔑 Beta Key Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta" class="active">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Generate New Beta Key</h3>
        <button class="btn btn-primary" onclick="generateKey()">Generate Beta Key</button>
        <div id="new-key-result" style="margin-top: 15px;"></div>
    </div>

    <div class="card">
        <h3>🔑 Beta Keys List</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Key</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Used By</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="keys-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function generateKey() {
            try {
                const response = await fetch('/admin/beta/generate', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    document.getElementById('new-key-result').innerHTML = `
                        <div style="background: #2d2d2d; padding: 15px; border-radius: 8px; border: 1px solid #4CAF50;">
                            <strong>New Beta Key Generated:</strong><br>
                            <code style="color: #4CAF50; font-size: 1.2em;">${data.key}</code>
                        </div>
                    `;
                    loadKeys();
                }
            } catch (error) {
                console.error('Error generating key:', error);
            }
        }

        async function loadKeys() {
            try {
                const response = await fetch('/admin/beta/keys', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const keys = await response.json();
                    const tbody = document.getElementById('keys-table');
                    
                    if (keys.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No beta keys found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = keys.map(key => `
                        <tr>
                            <td><code>${key.key_value}</code></td>
                            <td><span class="badge ${key.status === 'unused' ? 'badge-success' : 'badge-secondary'}">${key.status}</span></td>
                            <td>${new Date(key.created_at).toLocaleDateString()}</td>
                            <td>${key.used_by_email || 'Not used'}</td>
                            <td>
                                ${key.status === 'unused' ? '<button class="btn btn-danger" onclick="revokeKey(\'' + key.key_value + '\')">Revoke</button>' : ''}
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading keys:', error);
            }
        }

        async function revokeKey(keyValue) {
            if (!confirm('Are you sure you want to revoke this key?')) return;

            try {
                const response = await fetch('/admin/beta/revoke', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ key_value: keyValue })
                });

                if (response.ok) {
                    loadKeys();
                }
            } catch (error) {
                console.error('Error revoking key:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadKeys();
    </script>
    '''

# MISSING ADMIN PAGES - RELEASES
@app.get("/admin/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Admin releases management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📦 Release Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases" class="active">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Upload New Release</h3>
        <div class="upload-area" onclick="document.getElementById('fileInput').click()">
            <p>Click to upload Vault.exe file</p>
            <input type="file" id="fileInput" accept=".exe" style="display: none;" onchange="uploadFile()">
        </div>
        <div id="upload-progress" style="margin-top: 15px;"></div>
    </div>

    <div class="card">
        <h3>📦 Releases List</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Version</th>
                    <th>Filename</th>
                    <th>Status</th>
                    <th>Upload Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="releases-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function uploadFile() {
            const fileInput = document.getElementById('fileInput');
            const file = fileInput.files[0];
            
            if (!file) return;

            const formData = new FormData();
            formData.append('file', file);

            document.getElementById('upload-progress').innerHTML = '<p>Uploading...</p>';

            try {
                const response = await fetch('/admin/releases/upload', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token },
                    body: formData
                });

                if (response.ok) {
                    const data = await response.json();
                    document.getElementById('upload-progress').innerHTML = `
                        <div style="background: #2d2d2d; padding: 15px; border-radius: 8px; border: 1px solid #4CAF50;">
                            <strong>Upload successful:</strong> ${data.filename}
                        </div>
                    `;
                    loadReleases();
                } else {
                    document.getElementById('upload-progress').innerHTML = '<p style="color: #ff4757;">Upload failed</p>';
                }
            } catch (error) {
                console.error('Upload error:', error);
                document.getElementById('upload-progress').innerHTML = '<p style="color: #ff4757;">Upload failed</p>';
            }
        }

        async function loadReleases() {
            try {
                const response = await fetch('/admin/releases/list', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const releases = await response.json();
                    const tbody = document.getElementById('releases-table');
                    
                    if (releases.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No releases found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = releases.map(release => `
                        <tr>
                            <td>${release.version}</td>
                            <td>${release.filename}</td>
                            <td><span class="badge ${release.status === 'active' ? 'badge-success' : 'badge-warning'}">${release.status}</span></td>
                            <td>${new Date(release.uploaded_at).toLocaleDateString()}</td>
                            <td>
                                ${release.status !== 'active' ? '<button class="btn btn-primary" onclick="activateRelease(' + release.id + ')">Activate</button>' : ''}
                                <button class="btn btn-danger" onclick="deleteRelease(' + release.id + ')">Delete</button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading releases:', error);
            }
        }

        async function activateRelease(releaseId) {
            try {
                const response = await fetch('/admin/releases/activate', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error activating release:', error);
            }
        }

        async function deleteRelease(releaseId) {
            if (!confirm('Are you sure you want to delete this release?')) return;

            try {
                const response = await fetch('/admin/releases/delete', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error deleting release:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadReleases();
    </script>
    '''

# MISSING ADMIN PAGES - ANALYTICS
@app.get("/admin/analytics", response_class=HTMLResponse)
async def admin_analytics_page():
    """Admin analytics page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📊 Analytics Dashboard</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics" class="active">Analytics</a>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number" id="total-analytics-users">--</div>
            <div class="stat-label">Total Analytics Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="consent-given">--</div>
            <div class="stat-label">Consent Given</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="avg-session">--</div>
            <div class="stat-label">Avg Session (min)</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="most-used-os">--</div>
            <div class="stat-label">Most Used OS</div>
        </div>
    </div>

    <div class="card">
        <h3>📈 Analytics Data</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Vault ID</th>
                    <th>Version</th>
                    <th>OS</th>
                    <th>Last Ping</th>
                    <th>Total Passwords</th>
                    <th>Total Folders</th>
                </tr>
            </thead>
            <tbody id="analytics-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadAnalytics() {
            try {
                const response = await fetch('/admin/analytics/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    
                    // Update stats
                    document.getElementById('total-analytics-users').textContent = data.stats.total_users;
                    document.getElementById('consent-given').textContent = data.stats.consent_given;
                    document.getElementById('avg-session').textContent = data.stats.avg_session_minutes;
                    document.getElementById('most-used-os').textContent = data.stats.most_used_os;
                    
                    // Update table
                    const tbody = document.getElementById('analytics-table');
                    if (data.users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No analytics data found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = data.users.map(user => `
                        <tr>
                            <td><code>${user.vault_id.substring(0, 12)}...</code></td>
                            <td>${user.version}</td>
                            <td>${user.os}</td>
                            <td>${user.last_ping}</td>
                            <td>${user.total_passwords || 0}</td>
                            <td>${user.total_folders || 0}</td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading analytics:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadAnalytics();
        setInterval(loadAnalytics, 60000);
    </script>
    '''

# Service monitoring endpoints
@app.get("/admin/services/status")
async def services_status(admin_user: str = Depends(verify_admin_token)):
    """Get service status"""
    return get_all_services_status()

@app.post("/admin/services/restart/{service_name}")
async def restart_service_endpoint(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Restart a service"""
    result, status_code = restart_service_safe(service_name)
    if status_code != 200:
        raise HTTPException(status_code=status_code, detail=result["message"])
    return result


# Enhanced service control endpoints
@app.post("/admin/services/stop/{service_name}")
async def stop_service_endpoint(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Stop a service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        raise HTTPException(status_code=400, detail="Service not allowed")
    
    try:
        result = subprocess.run(['sudo', 'systemctl', 'stop', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "stopped", "service": service_name}
        else:
            raise HTTPException(status_code=500, detail=result.stderr)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))



# Enhanced service control endpoints
@app.post("/admin/services/stop/{service_name}")
async def stop_service_endpoint(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Stop a service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        raise HTTPException(status_code=400, detail="Service not allowed")
    
    try:
        result = subprocess.run(['sudo', 'systemctl', 'stop', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "stopped", "service": service_name}
        else:
            raise HTTPException(status_code=500, detail=result.stderr)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))



# Enhanced service control endpoints
@app.post("/admin/services/stop/{service_name}")
async def stop_service_endpoint(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Stop a service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        raise HTTPException(status_code=400, detail="Service not allowed")
    
    try:
        result = subprocess.run(['sudo', 'systemctl', 'stop', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "stopped", "service": service_name}
        else:
            raise HTTPException(status_code=500, detail=result.stderr)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/admin/stats")
async def admin_stats(admin_user: str = Depends(verify_admin_token)):
    """Get admin statistics"""
    conn = sqlite3.connect('/opt/vault-api/users.db')

    cursor = conn.execute("SELECT COUNT(*) FROM users")
    total_users = cursor.fetchone()[0]

    cursor = conn.execute("SELECT COUNT(*) FROM users WHERE email_verified = TRUE")
    verified_users = cursor.fetchone()[0]

    cursor = conn.execute("SELECT COUNT(*) FROM users WHERE has_beta = TRUE")
    beta_users_local = cursor.fetchone()[0]

    conn.close()

    try:
        bot_conn = get_db_connection()
        cursor = bot_conn.execute("SELECT COUNT(DISTINCT discord_id) FROM users")
        result = cursor.fetchone()
        beta_users_discord = result[0] if result else 0
        bot_conn.close()
    except:
        beta_users_discord = 0

    try:
        analytics_users = analytics_db.get_total_users()
    except:
        analytics_users = 0

    return {
        "total_users": total_users,
        "verified_users": verified_users,
        "beta_users": beta_users_local + beta_users_discord,
        "analytics_users": analytics_users
    }

# MISSING API ENDPOINTS FOR ADMIN FUNCTIONALITY

@app.get("/admin/users/data")
async def get_users_data(admin_user: str = Depends(verify_admin_token)):
    """Get all users data"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT id, email, email_verified, has_beta, created_at, last_login
        FROM users ORDER BY created_at DESC
    ''')
    
    users = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return users

@app.post("/admin/users/beta")
async def toggle_user_beta(action_data: UserAction, admin_user: str = Depends(verify_admin_token)):
    """Grant or revoke beta access for user"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    
    grant_beta = action_data.action == 'grant'
    
    conn.execute('''
        UPDATE users SET has_beta = ? WHERE id = ?
    ''', (grant_beta, action_data.user_id))
    
    conn.commit()
    conn.close()
    
    return {"message": f"Beta access {'granted' if grant_beta else 'revoked'} successfully"}

@app.post("/admin/beta/generate")
async def generate_new_beta_key(admin_user: str = Depends(verify_admin_token)):
    """Generate new beta key"""
    new_key = generate_beta_key()
    
    conn = sqlite3.connect('/opt/vault-api/users.db')
    conn.execute('''
        INSERT INTO beta_keys (key_value, status, created_at)
        VALUES (?, 'unused', CURRENT_TIMESTAMP)
    ''', (new_key,))
    
    conn.commit()
    conn.close()
    
    return {"key": new_key, "message": "Beta key generated successfully"}

@app.get("/admin/beta/keys")
async def get_beta_keys(admin_user: str = Depends(verify_admin_token)):
    """Get all beta keys"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT key_value, status, created_at, activated_at,
               (SELECT email FROM users WHERE id = beta_keys.user_id) as used_by_email
        FROM beta_keys ORDER BY created_at DESC
    ''')
    
    keys = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return keys

@app.post("/admin/beta/revoke")
async def revoke_beta_key(key_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Revoke a beta key"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    
    conn.execute('''
        UPDATE beta_keys SET status = 'revoked' WHERE key_value = ?
    ''', (key_data['key_value'],))
    
    conn.commit()
    conn.close()
    
    return {"message": "Beta key revoked successfully"}

@app.post("/admin/releases/upload")
async def upload_release(file: UploadFile = File(), admin_user: str = Depends(verify_admin_token)):
    """Upload new release file"""
    if not file.filename.endswith('.exe'):
        raise HTTPException(status_code=400, detail="Only .exe files allowed")
    
    # Extract version from filename or use timestamp
    version = file.filename.replace('.exe', '') or f"upload_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
    
    file_path = f"{UPLOAD_DIR}/staging/{file.filename}"
    
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    
    file_size = os.path.getsize(file_path)
    
    conn = sqlite3.connect('/opt/vault-api/users.db')
    conn.execute('''
        INSERT INTO file_releases (filename, version, file_path, file_size, status)
        VALUES (?, ?, ?, ?, 'staging')
    ''', (file.filename, version, file_path, file_size))
    
    conn.commit()
    conn.close()
    
    return {"message": "File uploaded successfully", "filename": file.filename}

@app.get("/admin/releases/list")
async def get_releases(admin_user: str = Depends(verify_admin_token)):
    """Get all releases"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT id, filename, version, file_size, status, uploaded_at, activated_at
        FROM file_releases ORDER BY uploaded_at DESC
    ''')
    
    releases = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return releases

@app.post("/admin/releases/activate")
async def activate_release(release_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Activate a release"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    
    # Deactivate all other releases
    conn.execute("UPDATE file_releases SET status = 'inactive'")
    
    # Activate the selected release
    conn.execute('''
        UPDATE file_releases SET status = 'active', activated_at = CURRENT_TIMESTAMP 
        WHERE id = ?
    ''', (release_data['release_id'],))
    
    conn.commit()
    conn.close()
    
    return {"message": "Release activated successfully"}

@app.post("/admin/releases/delete")
async def delete_release(release_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Delete a release"""
    conn = sqlite3.connect('/opt/vault-api/users.db')
    
    # Get file path before deleting
    cursor = conn.execute('SELECT file_path FROM file_releases WHERE id = ?', (release_data['release_id'],))
    result = cursor.fetchone()
    
    if result:
        file_path = result[0]
        # Delete file
        try:
            os.remove(file_path)
        except:
            pass
    
    # Delete from database
    conn.execute('DELETE FROM file_releases WHERE id = ?', (release_data['release_id'],))
    conn.commit()
    conn.close()
    
    return {"message": "Release deleted successfully"}

@app.get("/admin/analytics/data")
async def get_analytics_data(admin_user: str = Depends(verify_admin_token)):
    """Get analytics data"""
    try:
        analytics_stats = analytics_db.get_analytics_summary()
        analytics_users = analytics_db.get_all_users_summary()
        
        return {
            "stats": analytics_stats,
            "users": analytics_users
        }
    except Exception as e:
        return {
            "stats": {
                "total_users": 0,
                "consent_given": 0,
                "avg_session_minutes": 0,
                "most_used_os": "Unknown"
            },
            "users": []
        }

# Beta Key Validation Endpoint
@app.post("/validate_key", response_model=KeyValidationResponse)
async def validate_beta_key(request: KeyValidationRequest):
    """Validate beta key for Vault desktop app"""

    if not request.beta_key or not request.username:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Beta key and username are required"
        )

    beta_key = request.beta_key.strip().upper().replace(" ", "-")
    user = find_user_by_beta_key(beta_key)

    if not user:
        return KeyValidationResponse(
            valid=False,
            message="Invalid or unregistered beta key"
        )

    status = check_key_status(user['discord_id'])

    if status == 'revoked':
        return KeyValidationResponse(
            valid=False,
            message="Beta access has been revoked"
        )

    mark_key_as_used(user['discord_id'], request.username)

    return KeyValidationResponse(
        valid=True,
        message="Beta key validated successfully",
        user_info={
            "discord_user": user['username'],
            "joined_at": user['joined_at'],
            "vault_username": request.username
        }
    )

# Analytics Endpoint
@app.post("/analytics")
async def receive_analytics(payload: AnalyticsPayload):
    """Receive analytics data from Vault desktop app"""
    try:
        analytics_data = payload.dict()
        analytics_data["last_ping"] = datetime.now().strftime("%Y-%m-%d")

        analytics_db.upsert_user_data(analytics_data)
        return {"status": "success", "message": "Analytics received"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
import string
    print("="*50)
    print("TheVault API Server Starting...")
    print("Admin Login: username=admin, password=Chance19!")
    print("CHANGE DEFAULT PASSWORDS IN PRODUCTION!")
    print("="*50)
    uvicorn.run(app, host="0.0.0.0", port=8000)

# MISSING ADMIN PAGES - USERS
@app.get("/admin/users", response_class=HTMLResponse)
async def admin_users_page():
    """Admin users management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>👥 User Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users" class="active">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>👥 Registered Users</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Verified</th>
                    <th>Beta Access</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="users-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadUsers() {
            try {
                const response = await fetch('/admin/users/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const users = await response.json();
                    const tbody = document.getElementById('users-table');
                    
                    if (users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No users found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = users.map(user => `
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.email}</td>
                            <td>${user.email_verified ? '✅' : '❌'}</td>
                            <td>${user.has_beta ? '✅' : '❌'}</td>
                            <td>${user.created_at}</td>
                            <td>
                                <button class="btn ${user.has_beta ? 'btn-danger' : 'btn-success'}" 
                                        onclick="toggleBeta(${user.id}, '${user.has_beta ? 'revoke' : 'grant'}')">
                                    ${user.has_beta ? 'Revoke Beta' : 'Grant Beta'}
                                </button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading users:', error);
            }
        }

        async function toggleBeta(userId, action) {
            try {
                const response = await fetch('/admin/users/beta', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ user_id: userId, action: action })
                });

                if (response.ok) {
                    loadUsers();
                }
            } catch (error) {
                console.error('Error toggling beta:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadUsers();
    </script>
    '''

# MISSING ADMIN PAGES - BETA KEYS
@app.get("/admin/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Admin beta keys management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>🔑 Beta Key Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta" class="active">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Generate New Beta Key</h3>
        <button class="btn btn-primary" onclick="generateKey()">Generate Beta Key</button>
        <div id="new-key-result" style="margin-top: 15px;"></div>
    </div>

    <div class="card">
        <h3>🔑 Beta Keys List</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Key</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Used By</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="keys-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function generateKey() {
            try {
                const response = await fetch('/admin/beta/generate', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    document.getElementById('new-key-result').innerHTML = `
                        <div style="background: #2d2d2d; padding: 15px; border-radius: 8px; border: 1px solid #4CAF50;">
                            <strong>New Beta Key Generated:</strong><br>
                            <code style="font-size: 1.2em; color: #4CAF50;">${data.key}</code>
                        </div>
                    `;
                    loadKeys();
                }
            } catch (error) {
                console.error('Error generating key:', error);
            }
        }

        async function loadKeys() {
            try {
                const response = await fetch('/admin/beta/keys', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const keys = await response.json();
                    const tbody = document.getElementById('keys-table');
                    
                    if (keys.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No beta keys found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = keys.map(key => `
                        <tr>
                            <td><code>${key.key_value}</code></td>
                            <td>${key.used ? 'Used' : 'Available'}</td>
                            <td>${key.created_at}</td>
                            <td>${key.used_by || 'Not used'}</td>
                            <td>
                                ${!key.used ? '<button class="btn btn-danger" onclick="revokeKey(\'' + key.key_value + '\')">Revoke</button>' : ''}
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading keys:', error);
            }
        }

        async function revokeKey(keyValue) {
            if (!confirm('Are you sure you want to revoke this key?')) return;

            try {
                const response = await fetch('/admin/beta/revoke', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ key_value: keyValue })
                });

                if (response.ok) {
                    loadKeys();
                }
            } catch (error) {
                console.error('Error revoking key:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadKeys();
    </script>
    '''

# MISSING ADMIN PAGES - RELEASES
@app.get("/admin/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Admin releases management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📦 Release Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases" class="active">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Upload New Release</h3>
        <div class="upload-area" onclick="document.getElementById('fileInput').click()">
            <p>Click to upload Vault.exe file</p>
            <input type="file" id="fileInput" accept=".exe" style="display: none;" onchange="uploadFile()">
        </div>
        <div id="upload-status"></div>
    </div>

    <div class="card">
        <h3>📦 Current Releases</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Version</th>
                    <th>File Size</th>
                    <th>Upload Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="releases-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function uploadFile() {
            const fileInput = document.getElementById('fileInput');
            const file = fileInput.files[0];
            
            if (!file) return;

            const formData = new FormData();
            formData.append('file', file);

            document.getElementById('upload-status').innerHTML = '<p>Uploading...</p>';

            try {
                const response = await fetch('/admin/releases/upload', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token },
                    body: formData
                });

                if (response.ok) {
                    const result = await response.json();
                    document.getElementById('upload-status').innerHTML = `
                        <div style="color: #4CAF50;">✅ Upload successful: ${result.filename}</div>
                    `;
                    loadReleases();
                } else {
                    document.getElementById('upload-status').innerHTML = `
                        <div style="color: #f44336;">❌ Upload failed</div>
                    `;
                }
            } catch (error) {
                document.getElementById('upload-status').innerHTML = `
                    <div style="color: #f44336;">❌ Upload error: ${error.message}</div>
                `;
            }
        }

        async function loadReleases() {
            try {
                const response = await fetch('/admin/releases/list', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const releases = await response.json();
                    const tbody = document.getElementById('releases-table');
                    
                    if (releases.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No releases found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = releases.map(release => `
                        <tr>
                            <td>${release.version}</td>
                            <td>${(release.file_size / 1024 / 1024).toFixed(2)} MB</td>
                            <td>${release.upload_date}</td>
                            <td>${release.is_current ? '🟢 Current' : '⚪ Available'}</td>
                            <td>
                                <button class="btn btn-primary" onclick="setCurrent(${release.id})">Set Current</button>
                                <button class="btn btn-danger" onclick="deleteRelease(${release.id})">Delete</button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading releases:', error);
            }
        }

        async function setCurrent(releaseId) {
            try {
                const response = await fetch('/admin/releases/set-current', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error setting current release:', error);
            }
        }

        async function deleteRelease(releaseId) {
            if (!confirm('Are you sure you want to delete this release?')) return;

            try {
                const response = await fetch('/admin/releases/delete', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error deleting release:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadReleases();
    </script>
    '''

# MISSING ADMIN PAGES - ANALYTICS
@app.get("/admin/analytics", response_class=HTMLResponse)
async def admin_analytics_page():
    """Admin analytics page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📊 Analytics Dashboard</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics" class="active">Analytics</a>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number" id="total-analytics-users">--</div>
            <div class="stat-label">Total Analytics Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="consent-given">--</div>
            <div class="stat-label">Consent Given</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="avg-session">--</div>
            <div class="stat-label">Avg Session (min)</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="most-used-os">--</div>
            <div class="stat-label">Most Used OS</div>
        </div>
    </div>

    <div class="card">
        <h3>📊 User Analytics</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Vault ID</th>
                    <th>Version</th>
                    <th>OS</th>
                    <th>Last Ping</th>
                    <th>Passwords</th>
                    <th>Folders</th>
                </tr>
            </thead>
            <tbody id="analytics-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadAnalytics() {
            try {
                const response = await fetch('/admin/analytics/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    
                    // Update stats
                    document.getElementById('total-analytics-users').textContent = data.stats.total_users;
                    document.getElementById('consent-given').textContent = data.stats.consent_given;
                    document.getElementById('avg-session').textContent = data.stats.avg_session_minutes;
                    document.getElementById('most-used-os').textContent = data.stats.most_used_os;
                    
                    // Update table
                    const tbody = document.getElementById('analytics-table');
                    if (data.users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No analytics data found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = data.users.map(user => `
                        <tr>
                            <td><code>${user.vault_id.substring(0, 12)}...</code></td>
                            <td>${user.version}</td>
                            <td>${user.os}</td>
                            <td>${user.last_ping}</td>
                            <td>${user.total_passwords || 0}</td>
                            <td>${user.total_folders || 0}</td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading analytics:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadAnalytics();
        setInterval(loadAnalytics, 60000);
    </script>
    '''

# MISSING ADMIN PAGES - USERS
@app.get("/admin/users", response_class=HTMLResponse)
async def admin_users_page():
    """Admin users management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>👥 User Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users" class="active">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>👥 Registered Users</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Verified</th>
                    <th>Beta Access</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="users-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadUsers() {
            try {
                const response = await fetch('/admin/users/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const users = await response.json();
                    const tbody = document.getElementById('users-table');
                    
                    if (users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No users found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = users.map(user => `
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.email}</td>
                            <td>${user.email_verified ? '✅' : '❌'}</td>
                            <td>${user.has_beta ? '✅' : '❌'}</td>
                            <td>${user.created_at}</td>
                            <td>
                                <button class="btn ${user.has_beta ? 'btn-danger' : 'btn-success'}" 
                                        onclick="toggleBeta(${user.id}, '${user.has_beta ? 'revoke' : 'grant'}')">
                                    ${user.has_beta ? 'Revoke Beta' : 'Grant Beta'}
                                </button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading users:', error);
            }
        }

        async function toggleBeta(userId, action) {
            try {
                const response = await fetch('/admin/users/beta', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ user_id: userId, action: action })
                });

                if (response.ok) {
                    loadUsers();
                }
            } catch (error) {
                console.error('Error toggling beta:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadUsers();
    </script>
    '''

# MISSING ADMIN PAGES - BETA KEYS
@app.get("/admin/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Admin beta keys management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>🔑 Beta Key Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta" class="active">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Generate New Beta Key</h3>
        <button class="btn btn-primary" onclick="generateKey()">Generate Beta Key</button>
        <div id="new-key-result" style="margin-top: 15px;"></div>
    </div>

    <div class="card">
        <h3>🔑 Beta Keys List</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Key</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Used By</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="keys-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function generateKey() {
            try {
                const response = await fetch('/admin/beta/generate', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    document.getElementById('new-key-result').innerHTML = `
                        <div style="background: #2d2d2d; padding: 15px; border-radius: 8px; border: 1px solid #4CAF50;">
                            <strong>New Beta Key Generated:</strong><br>
                            <code style="font-size: 1.2em; color: #4CAF50;">${data.key}</code>
                        </div>
                    `;
                    loadKeys();
                }
            } catch (error) {
                console.error('Error generating key:', error);
            }
        }

        async function loadKeys() {
            try {
                const response = await fetch('/admin/beta/keys', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const keys = await response.json();
                    const tbody = document.getElementById('keys-table');
                    
                    if (keys.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No beta keys found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = keys.map(key => `
                        <tr>
                            <td><code>${key.key_value}</code></td>
                            <td>${key.used ? 'Used' : 'Available'}</td>
                            <td>${key.created_at}</td>
                            <td>${key.used_by || 'Not used'}</td>
                            <td>
                                ${!key.used ? '<button class="btn btn-danger" onclick="revokeKey(\'' + key.key_value + '\')">Revoke</button>' : ''}
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading keys:', error);
            }
        }

        async function revokeKey(keyValue) {
            if (!confirm('Are you sure you want to revoke this key?')) return;

            try {
                const response = await fetch('/admin/beta/revoke', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ key_value: keyValue })
                });

                if (response.ok) {
                    loadKeys();
                }
            } catch (error) {
                console.error('Error revoking key:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadKeys();
    </script>
    '''

# MISSING ADMIN PAGES - RELEASES
@app.get("/admin/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Admin releases management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📦 Release Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases" class="active">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Upload New Release</h3>
        <div class="upload-area" onclick="document.getElementById('fileInput').click()">
            <p>Click to upload Vault.exe file</p>
            <input type="file" id="fileInput" accept=".exe" style="display: none;" onchange="uploadFile()">
        </div>
        <div id="upload-status"></div>
    </div>

    <div class="card">
        <h3>📦 Current Releases</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Version</th>
                    <th>File Size</th>
                    <th>Upload Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="releases-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function uploadFile() {
            const fileInput = document.getElementById('fileInput');
            const file = fileInput.files[0];
            
            if (!file) return;

            const formData = new FormData();
            formData.append('file', file);

            document.getElementById('upload-status').innerHTML = '<p>Uploading...</p>';

            try {
                const response = await fetch('/admin/releases/upload', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token },
                    body: formData
                });

                if (response.ok) {
                    const result = await response.json();
                    document.getElementById('upload-status').innerHTML = `
                        <div style="color: #4CAF50;">✅ Upload successful: ${result.filename}</div>
                    `;
                    loadReleases();
                } else {
                    document.getElementById('upload-status').innerHTML = `
                        <div style="color: #f44336;">❌ Upload failed</div>
                    `;
                }
            } catch (error) {
                document.getElementById('upload-status').innerHTML = `
                    <div style="color: #f44336;">❌ Upload error: ${error.message}</div>
                `;
            }
        }

        async function loadReleases() {
            try {
                const response = await fetch('/admin/releases/list', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const releases = await response.json();
                    const tbody = document.getElementById('releases-table');
                    
                    if (releases.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No releases found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = releases.map(release => `
                        <tr>
                            <td>${release.version}</td>
                            <td>${(release.file_size / 1024 / 1024).toFixed(2)} MB</td>
                            <td>${release.upload_date}</td>
                            <td>${release.is_current ? '🟢 Current' : '⚪ Available'}</td>
                            <td>
                                <button class="btn btn-primary" onclick="setCurrent(${release.id})">Set Current</button>
                                <button class="btn btn-danger" onclick="deleteRelease(${release.id})">Delete</button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading releases:', error);
            }
        }

        async function setCurrent(releaseId) {
            try {
                const response = await fetch('/admin/releases/set-current', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error setting current release:', error);
            }
        }

        async function deleteRelease(releaseId) {
            if (!confirm('Are you sure you want to delete this release?')) return;

            try {
                const response = await fetch('/admin/releases/delete', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error deleting release:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadReleases();
    </script>
    '''

# MISSING ADMIN PAGES - ANALYTICS
@app.get("/admin/analytics", response_class=HTMLResponse)
async def admin_analytics_page():
    """Admin analytics page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📊 Analytics Dashboard</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics" class="active">Analytics</a>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number" id="total-analytics-users">--</div>
            <div class="stat-label">Total Analytics Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="consent-given">--</div>
            <div class="stat-label">Consent Given</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="avg-session">--</div>
            <div class="stat-label">Avg Session (min)</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="most-used-os">--</div>
            <div class="stat-label">Most Used OS</div>
        </div>
    </div>

    <div class="card">
        <h3>📊 User Analytics</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Vault ID</th>
                    <th>Version</th>
                    <th>OS</th>
                    <th>Last Ping</th>
                    <th>Passwords</th>
                    <th>Folders</th>
                </tr>
            </thead>
            <tbody id="analytics-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadAnalytics() {
            try {
                const response = await fetch('/admin/analytics/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    
                    // Update stats
                    document.getElementById('total-analytics-users').textContent = data.stats.total_users;
                    document.getElementById('consent-given').textContent = data.stats.consent_given;
                    document.getElementById('avg-session').textContent = data.stats.avg_session_minutes;
                    document.getElementById('most-used-os').textContent = data.stats.most_used_os;
                    
                    // Update table
                    const tbody = document.getElementById('analytics-table');
                    if (data.users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No analytics data found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = data.users.map(user => `
                        <tr>
                            <td><code>${user.vault_id.substring(0, 12)}...</code></td>
                            <td>${user.version}</td>
                            <td>${user.os}</td>
                            <td>${user.last_ping}</td>
                            <td>${user.total_passwords || 0}</td>
                            <td>${user.total_folders || 0}</td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading analytics:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadAnalytics();
        setInterval(loadAnalytics, 60000);
    </script>
    '''

# MISSING ADMIN PAGES - USERS
@app.get("/admin/users", response_class=HTMLResponse)
async def admin_users_page():
    """Admin users management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>👥 User Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users" class="active">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>👥 Registered Users</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Verified</th>
                    <th>Beta Access</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="users-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadUsers() {
            try {
                const response = await fetch('/admin/users/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const users = await response.json();
                    const tbody = document.getElementById('users-table');
                    
                    if (users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No users found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = users.map(user => `
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.email}</td>
                            <td>${user.email_verified ? '✅' : '❌'}</td>
                            <td>${user.has_beta ? '✅' : '❌'}</td>
                            <td>${user.created_at}</td>
                            <td>
                                <button class="btn ${user.has_beta ? 'btn-danger' : 'btn-success'}" 
                                        onclick="toggleBeta(${user.id}, '${user.has_beta ? 'revoke' : 'grant'}')">
                                    ${user.has_beta ? 'Revoke Beta' : 'Grant Beta'}
                                </button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading users:', error);
            }
        }

        async function toggleBeta(userId, action) {
            try {
                const response = await fetch('/admin/users/beta', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ user_id: userId, action: action })
                });

                if (response.ok) {
                    loadUsers();
                }
            } catch (error) {
                console.error('Error toggling beta:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadUsers();
    </script>
    '''

# MISSING ADMIN PAGES - BETA KEYS
@app.get("/admin/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Admin beta keys management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>🔑 Beta Key Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta" class="active">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Generate New Beta Key</h3>
        <button class="btn btn-primary" onclick="generateKey()">Generate Beta Key</button>
        <div id="new-key-result" style="margin-top: 15px;"></div>
    </div>

    <div class="card">
        <h3>🔑 Beta Keys List</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Key</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Used By</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="keys-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function generateKey() {
            try {
                const response = await fetch('/admin/beta/generate', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    document.getElementById('new-key-result').innerHTML = `
                        <div style="background: #2d2d2d; padding: 15px; border-radius: 8px; border: 1px solid #4CAF50;">
                            <strong>New Beta Key Generated:</strong><br>
                            <code style="font-size: 1.2em; color: #4CAF50;">${data.key}</code>
                        </div>
                    `;
                    loadKeys();
                }
            } catch (error) {
                console.error('Error generating key:', error);
            }
        }

        async function loadKeys() {
            try {
                const response = await fetch('/admin/beta/keys', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const keys = await response.json();
                    const tbody = document.getElementById('keys-table');
                    
                    if (keys.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No beta keys found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = keys.map(key => `
                        <tr>
                            <td><code>${key.key_value}</code></td>
                            <td>${key.used ? 'Used' : 'Available'}</td>
                            <td>${key.created_at}</td>
                            <td>${key.used_by || 'Not used'}</td>
                            <td>
                                ${!key.used ? '<button class="btn btn-danger" onclick="revokeKey(\'' + key.key_value + '\')">Revoke</button>' : ''}
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading keys:', error);
            }
        }

        async function revokeKey(keyValue) {
            if (!confirm('Are you sure you want to revoke this key?')) return;

            try {
                const response = await fetch('/admin/beta/revoke', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ key_value: keyValue })
                });

                if (response.ok) {
                    loadKeys();
                }
            } catch (error) {
                console.error('Error revoking key:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadKeys();
    </script>
    '''

# MISSING ADMIN PAGES - RELEASES
@app.get("/admin/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Admin releases management page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📦 Release Management</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases" class="active">Releases</a>
        <a href="/admin/analytics">Analytics</a>
    </div>

    <div class="card">
        <h3>Upload New Release</h3>
        <div class="upload-area" onclick="document.getElementById('fileInput').click()">
            <p>Click to upload Vault.exe file</p>
            <input type="file" id="fileInput" accept=".exe" style="display: none;" onchange="uploadFile()">
        </div>
        <div id="upload-status"></div>
    </div>

    <div class="card">
        <h3>📦 Current Releases</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Version</th>
                    <th>File Size</th>
                    <th>Upload Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="releases-table">
                <tr><td colspan="5">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function uploadFile() {
            const fileInput = document.getElementById('fileInput');
            const file = fileInput.files[0];
            
            if (!file) return;

            const formData = new FormData();
            formData.append('file', file);

            document.getElementById('upload-status').innerHTML = '<p>Uploading...</p>';

            try {
                const response = await fetch('/admin/releases/upload', {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token },
                    body: formData
                });

                if (response.ok) {
                    const result = await response.json();
                    document.getElementById('upload-status').innerHTML = `
                        <div style="color: #4CAF50;">✅ Upload successful: ${result.filename}</div>
                    `;
                    loadReleases();
                } else {
                    document.getElementById('upload-status').innerHTML = `
                        <div style="color: #f44336;">❌ Upload failed</div>
                    `;
                }
            } catch (error) {
                document.getElementById('upload-status').innerHTML = `
                    <div style="color: #f44336;">❌ Upload error: ${error.message}</div>
                `;
            }
        }

        async function loadReleases() {
            try {
                const response = await fetch('/admin/releases/list', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const releases = await response.json();
                    const tbody = document.getElementById('releases-table');
                    
                    if (releases.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="5">No releases found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = releases.map(release => `
                        <tr>
                            <td>${release.version}</td>
                            <td>${(release.file_size / 1024 / 1024).toFixed(2)} MB</td>
                            <td>${release.upload_date}</td>
                            <td>${release.is_current ? '🟢 Current' : '⚪ Available'}</td>
                            <td>
                                <button class="btn btn-primary" onclick="setCurrent(${release.id})">Set Current</button>
                                <button class="btn btn-danger" onclick="deleteRelease(${release.id})">Delete</button>
                            </td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading releases:', error);
            }
        }

        async function setCurrent(releaseId) {
            try {
                const response = await fetch('/admin/releases/set-current', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error setting current release:', error);
            }
        }

        async function deleteRelease(releaseId) {
            if (!confirm('Are you sure you want to delete this release?')) return;

            try {
                const response = await fetch('/admin/releases/delete', {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ release_id: releaseId })
                });

                if (response.ok) {
                    loadReleases();
                }
            } catch (error) {
                console.error('Error deleting release:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadReleases();
    </script>
    '''

# MISSING ADMIN PAGES - ANALYTICS
@app.get("/admin/analytics", response_class=HTMLResponse)
async def admin_analytics_page():
    """Admin analytics page"""
    return ADMIN_STYLES + '''
    <div class="header">
        <h1>📊 Analytics Dashboard</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/beta">Beta Keys</a>
        <a href="/admin/releases">Releases</a>
        <a href="/admin/analytics" class="active">Analytics</a>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number" id="total-analytics-users">--</div>
            <div class="stat-label">Total Analytics Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="consent-given">--</div>
            <div class="stat-label">Consent Given</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="avg-session">--</div>
            <div class="stat-label">Avg Session (min)</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="most-used-os">--</div>
            <div class="stat-label">Most Used OS</div>
        </div>
    </div>

    <div class="card">
        <h3>📊 User Analytics</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Vault ID</th>
                    <th>Version</th>
                    <th>OS</th>
                    <th>Last Ping</th>
                    <th>Passwords</th>
                    <th>Folders</th>
                </tr>
            </thead>
            <tbody id="analytics-table">
                <tr><td colspan="6">Loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadAnalytics() {
            try {
                const response = await fetch('/admin/analytics/data', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const data = await response.json();
                    
                    // Update stats
                    document.getElementById('total-analytics-users').textContent = data.stats.total_users;
                    document.getElementById('consent-given').textContent = data.stats.consent_given;
                    document.getElementById('avg-session').textContent = data.stats.avg_session_minutes;
                    document.getElementById('most-used-os').textContent = data.stats.most_used_os;
                    
                    // Update table
                    const tbody = document.getElementById('analytics-table');
                    if (data.users.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6">No analytics data found</td></tr>';
                        return;
                    }

                    tbody.innerHTML = data.users.map(user => `
                        <tr>
                            <td><code>${user.vault_id.substring(0, 12)}...</code></td>
                            <td>${user.version}</td>
                            <td>${user.os}</td>
                            <td>${user.last_ping}</td>
                            <td>${user.total_passwords || 0}</td>
                            <td>${user.total_folders || 0}</td>
                        </tr>
                    `).join('');
                }
            } catch (error) {
                console.error('Error loading analytics:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        loadAnalytics();
        setInterval(loadAnalytics, 60000);
    </script>
    '''
