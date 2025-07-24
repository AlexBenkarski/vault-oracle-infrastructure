"""Admin HTML Pages - Dashboard and management interfaces"""

from fastapi import APIRouter, Response
from fastapi.responses import HTMLResponse

router = APIRouter(prefix="/admin", tags=["admin-pages"])

# Base admin styles
ADMIN_STYLES = '''
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
        color: white;
        line-height: 1.6;
        min-height: 100vh;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 20px 0;
        border-bottom: 2px solid #4CAF50;
    }
    
    .header h1 {
        color: #4CAF50;
        font-size: 2.5em;
        font-weight: 300;
    }
    
    .nav {
        display: flex;
        gap: 30px;
        margin-bottom: 40px;
        border-bottom: 1px solid #333;
        padding-bottom: 10px;
    }
    
    .nav a {
        color: #ccc;
        text-decoration: none;
        padding: 15px 20px;
        border-bottom: 3px solid transparent;
        transition: all 0.3s ease;
        font-weight: 500;
    }
    
    .nav a:hover, .nav a.active {
        color: #4CAF50;
        border-bottom-color: #4CAF50;
        transform: translateY(-2px);
    }
    
    .card {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border-radius: 12px;
        padding: 30px;
        margin: 25px 0;
        border: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
        margin: 30px 0;
    }
    
    .stat-card {
        background: linear-gradient(135deg, rgba(76, 175, 80, 0.1), rgba(76, 175, 80, 0.05));
        border: 2px solid #4CAF50;
        border-radius: 12px;
        padding: 25px;
        text-align: center;
        transition: all 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(76, 175, 80, 0.3);
    }
    
    .stat-number {
        font-size: 2.8em;
        font-weight: bold;
        color: #4CAF50;
        margin-bottom: 10px;
    }
    
    .stat-label {
        color: #a0a0a0;
        text-transform: uppercase;
        font-size: 0.9em;
        letter-spacing: 1px;
    }
    
    .service-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 25px;
        margin: 30px 0;
    }
    
    .service-box {
        background: rgba(255, 255, 255, 0.03);
        border-radius: 15px;
        padding: 25px;
        border: 3px solid;
        position: relative;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
    }
    
    .service-box.running {
        border-color: #4CAF50;
        background: linear-gradient(135deg, rgba(76,175,80,0.15), rgba(76,175,80,0.05));
        box-shadow: 0 0 20px rgba(76, 175, 80, 0.3);
    }
    
    .service-box.stopped {
        border-color: #f44336;
        background: linear-gradient(135deg, rgba(244,67,54,0.15), rgba(244,67,54,0.05));
        box-shadow: 0 0 20px rgba(244, 67, 54, 0.3);
    }
    
    .service-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .service-name {
        font-size: 1.4em;
        font-weight: bold;
        color: white;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .service-status {
        font-size: 0.9em;
        padding: 6px 15px;
        border-radius: 25px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .status-active {
        background: #4CAF50;
        color: white;
        box-shadow: 0 0 10px rgba(76, 175, 80, 0.5);
    }
    
    .status-inactive {
        background: #f44336;
        color: white;
        box-shadow: 0 0 10px rgba(244, 67, 54, 0.5);
    }
    
    .service-info {
        margin: 20px 0;
        color: #ccc;
        font-size: 0.95em;
        line-height: 1.6;
    }
    
    .uptime {
        color: #4CAF50;
        font-weight: bold;
        margin-top: 8px;
    }
    
    .service-controls {
        display: flex;
        gap: 12px;
        margin-top: 20px;
    }
    
    .control-btn {
        flex: 1;
        padding: 12px 8px;
        border: none;
        border-radius: 8px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        font-size: 0.85em;
        letter-spacing: 0.5px;
    }
    
    .btn-start {
        background: linear-gradient(135deg, #4CAF50, #45a049);
        color: white;
        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
    }
    
    .btn-stop {
        background: linear-gradient(135deg, #f44336, #da190b);
        color: white;
        box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
    }
    
    .btn-restart {
        background: linear-gradient(135deg, #2196F3, #0b7dda);
        color: white;
        box-shadow: 0 4px 15px rgba(33, 150, 243, 0.3);
    }
    
    .control-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
    }
    
    .control-btn:disabled {
        background: #666 !important;
        cursor: not-allowed;
        opacity: 0.6;
        transform: none;
        box-shadow: none;
    }
    
    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .btn-primary {
        background: linear-gradient(135deg, #4CAF50, #45a049);
        color: white;
        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
    }
    
    .btn-danger {
        background: linear-gradient(135deg, #f44336, #da190b);
        color: white;
        box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
    }
    
    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
    }
    
    .quick-stats {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: rgba(255, 255, 255, 0.05);
        padding: 15px 25px;
        border-radius: 10px;
        margin-top: 20px;
    }
    
    .quick-stats span {
        font-weight: bold;
    }
    
    #api-health.online {
        color: #4CAF50;
    }
    
    #api-health.error {
        color: #f44336;
    }
</style>
'''

@router.get("/", response_class=HTMLResponse)
async def admin_login_page():
    """Admin login page"""
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Vault Admin Login</title>
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
                color: white;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .login-container {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                padding: 40px;
                border-radius: 15px;
                border: 1px solid rgba(255, 255, 255, 0.1);
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                width: 400px;
            }
            .login-container h1 {
                color: #4CAF50;
                text-align: center;
                margin-bottom: 30px;
                font-size: 2em;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #ccc;
                font-weight: 500;
            }
            .form-group input {
                width: 100%;
                padding: 12px;
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 8px;
                color: white;
                font-size: 16px;
            }
            .form-group input:focus {
                outline: none;
                border-color: #4CAF50;
                box-shadow: 0 0 10px rgba(76, 175, 80, 0.3);
            }
            .btn {
                width: 100%;
                padding: 12px;
                background: linear-gradient(135deg, #4CAF50, #45a049);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
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
        <div class="login-container">
            <h1>🔐 Admin Login</h1>
            <form onsubmit="login(event)">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" id="username" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="password" required>
                </div>
                <button type="submit" class="btn">Login</button>
                <div class="error" id="error"></div>
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
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ username, password })
                    });

                    if (response.ok) {
                        const data = await response.json();
                        localStorage.setItem('admin_token', data.access_token);
                        window.location.href = '/admin/dashboard';
                    } else {
                        const error = await response.json();
                        errorDiv.textContent = error.detail || 'Login failed';
                        errorDiv.style.display = 'block';
                    }
                } catch (error) {
                    errorDiv.textContent = 'Network error';
                    errorDiv.style.display = 'block';
                }
            }
        </script>
    </body>
    </html>
    '''

@router.get("/dashboard", response_class=HTMLResponse)
async def admin_dashboard():
    """Enhanced admin dashboard with service monitoring"""
    return ADMIN_STYLES + '''
    <div class="container">
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
            <div class="service-grid" id="services-grid">
                <!-- Services will be dynamically loaded here -->
            </div>
            <div class="quick-stats">
                <span>API Status: <span id="api-health">Checking...</span></span>
                <span>Last Updated: <span id="last-updated">Never</span></span>
            </div>
        </div>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        let servicesData = {};

        async function updateServiceStatus() {
            try {
                const response = await fetch('/admin/services/status', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    const services = await response.json();
                    servicesData = {};
                    services.forEach(service => servicesData[service.name] = service);
                    renderServices();
                    document.getElementById('api-health').textContent = 'Online';
                    document.getElementById('api-health').className = 'online';
                    document.getElementById('last-updated').textContent = new Date().toLocaleTimeString();
                } else {
                    document.getElementById('api-health').textContent = 'Error';
                    document.getElementById('api-health').className = 'error';
                }
            } catch (error) {
                console.error('Service status error:', error);
                document.getElementById('api-health').textContent = 'Error';
                document.getElementById('api-health').className = 'error';
            }
        }

        function renderServices() {
            const grid = document.getElementById('services-grid');
            grid.innerHTML = '';

            Object.values(servicesData).forEach(service => {
                const isRunning = service.status === 'active';
                const uptime = service.uptime || 'Unknown';
                
                const serviceBox = document.createElement('div');
                serviceBox.className = `service-box ${isRunning ? 'running' : 'stopped'}`;
                serviceBox.innerHTML = `
                    <div class="service-header">
                        <div class="service-name">${service.name}</div>
                        <div class="service-status ${isRunning ? 'status-active' : 'status-inactive'}">
                            ${isRunning ? 'Running' : 'Stopped'}
                        </div>
                    </div>
                    <div class="service-info">
                        <strong>Status:</strong> ${service.status}<br>
                        <strong>Last Check:</strong> ${new Date(service.last_check).toLocaleTimeString()}
                        ${isRunning ? `<div class="uptime">Uptime: ${uptime}</div>` : ''}
                    </div>
                    <div class="service-controls">
                        <button class="control-btn btn-start" onclick="controlService('${service.name}', 'start')" 
                                ${isRunning ? 'disabled' : ''}>Start</button>
                        <button class="control-btn btn-stop" onclick="controlService('${service.name}', 'stop')" 
                                ${!isRunning ? 'disabled' : ''}>Stop</button>
                        <button class="control-btn btn-restart" onclick="controlService('${service.name}', 'restart')">Restart</button>
                    </div>
                `;
                grid.appendChild(serviceBox);
            });
        }

        async function controlService(serviceName, action) {
            const buttons = document.querySelectorAll(`[onclick*="${serviceName}"]`);
            buttons.forEach(btn => {
                btn.disabled = true;
                btn.textContent = action.charAt(0).toUpperCase() + action.slice(1) + 'ing...';
            });

            try {
                const response = await fetch(`/admin/services/${action}/${serviceName}`, {
                    method: 'POST',
                    headers: { 'Authorization': 'Bearer ' + token }
                });

                if (response.ok) {
                    setTimeout(updateServiceStatus, 2000);
                }
            } catch (error) {
                console.error(`${action} error:`, error);
            } finally {
                setTimeout(() => {
                    updateServiceStatus();
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

        // Initialize dashboard
        loadStats();
        updateServiceStatus();
        setInterval(updateServiceStatus, 30000); // Update every 30 seconds
        setInterval(loadStats, 60000); // Update stats every minute
    </script>
    '''

@router.get("/users", response_class=HTMLResponse)
async def admin_users_page():
    """User management page"""
    return ADMIN_STYLES + '''
    <div class="container">
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
            <h3>Registered Users</h3>
            <p>User management functionality coming soon...</p>
        </div>
    </div>
    <script>
        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }
    </script>
    '''

@router.get("/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Beta key management page"""
    return ADMIN_STYLES + '''
    <div class="container">
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
            <h3>Beta Key Generation</h3>
            <p>Beta key management functionality coming soon...</p>
        </div>
    </div>
    <script>
        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }
    </script>
    '''

@router.get("/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Release management page"""
    return ADMIN_STYLES + '''
    <div class="container">
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
            <p>Release management functionality coming soon...</p>
        </div>
    </div>
    <script>
        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }
    </script>
    '''

@router.get("/analytics", response_class=HTMLResponse) 
async def admin_analytics_page():
    """Analytics dashboard page"""
    return ADMIN_STYLES + '''
    <div class="container">
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
        <div class="card">
            <h3>Analytics Overview</h3>
            <p>Analytics dashboard functionality coming soon...</p>
        </div>
    </div>
    <script>
        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }
    </script>
    '''
