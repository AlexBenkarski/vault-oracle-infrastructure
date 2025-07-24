"""Admin Pages Router - Combines all admin page modules"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse

# Import individual page routers
from admin_dashboard import router as dashboard_router
from admin_users import router as users_router  
from admin_beta import router as beta_router
from admin_releases import router as releases_router
from admin_analytics import router as analytics_router

# Main admin pages router
router = APIRouter(prefix="/admin", tags=["admin-pages"])

# Include all page routers
router.include_router(dashboard_router)
router.include_router(users_router)
router.include_router(beta_router)
router.include_router(releases_router)
router.include_router(analytics_router)

# Legacy admin login page (for direct /admin access)
@router.get("", response_class=HTMLResponse)
@router.get("/", response_class=HTMLResponse)
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
                background: rgba(45, 45, 48, 0.9);
                padding: 40px;
                border-radius: 12px;
                border: 2px solid #4CAF50;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                width: 100%;
                max-width: 400px;
            }
            .login-card h2 {
                color: #4CAF50;
                text-align: center;
                margin-bottom: 30px;
                font-weight: 300;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #b0b0b0;
            }
            .form-group input {
                width: 100%;
                padding: 12px;
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 6px;
                color: #e0e0e0;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            .form-group input:focus {
                outline: none;
                border-color: #4CAF50;
            }
            .btn {
                width: 100%;
                padding: 12px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .btn:hover {
                background: #45a049;
            }
            .error {
                color: #f44336;
                text-align: center;
                margin-top: 15px;
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="login-card">
            <h2>🔐 Admin Login</h2>
            <form onsubmit="login(event)">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn">Login</button>
                <div id="error" class="error"></div>
            </form>
        </div>

        <script>
            async function login(event) {
                event.preventDefault();
                
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const errorDiv = document.getElementById('error');
                
                try {
                    const response = await fetch('/admin/auth', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ username, password })
                    });
                    
                    if (response.ok) {
                        const data = await response.json();
                        localStorage.setItem('admin_token', data.access_token);
                        window.location.href = '/admin/dashboard';
                    } else {
                        const error = await response.json();
                        errorDiv.style.display = 'block';
                        errorDiv.textContent = error.detail || 'Login failed';
                    }
                } catch (error) {
                    errorDiv.style.display = 'block';
                    errorDiv.textContent = 'Connection error';
                }
            }
            
            // Check if already logged in
            if (localStorage.getItem('admin_token')) {
                window.location.href = '/admin/dashboard';
            }
        </script>
    </body>
    </html>
    '''
