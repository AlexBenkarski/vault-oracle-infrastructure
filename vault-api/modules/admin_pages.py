"""Admin HTML Pages - Generate admin interface pages"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse

router = APIRouter(prefix="/admin", tags=["admin-pages"])

# Common CSS styles for all admin pages
ADMIN_STYLES = '''
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', system-ui, sans-serif;
        background: linear-gradient(135deg, #1a1a1a, #2d2d2d);
        color: #e0e0e0;
        min-height: 100vh;
        padding: 20px;
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 20px;
        background: rgba(255,255,255,0.05);
        border-radius: 12px;
        border: 1px solid rgba(255,255,255,0.1);
    }
    
    .nav {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
        padding: 15px;
        background: rgba(255,255,255,0.03);
        border-radius: 10px;
    }
    
    .nav a {
        color: #ccc;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 8px;
        transition: all 0.3s;
    }
    
    .nav a:hover, .nav a.active {
        background: #4CAF50;
        color: white;
    }
    
    .card {
        background: rgba(255,255,255,0.05);
        border-radius: 12px;
        padding: 25px;
        margin-bottom: 25px;
        border: 1px solid rgba(255,255,255,0.1);
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: linear-gradient(135deg, #4CAF50, #45a049);
        padding: 25px;
        border-radius: 12px;
        text-align: center;
        color: white;
    }
    
    .stat-number {
        font-size: 2.5em;
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-block;
    }
    
    .btn-primary {
        background: #4CAF50;
        color: white;
    }
    
    .btn-danger {
        background: #f44336;
        color: white;
    }
    
    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    }
    
    .table {
        width: 100%;
        border-collapse: collapse;
        background: rgba(255,255,255,0.03);
        border-radius: 8px;
        overflow: hidden;
    }
    
    .table th, .table td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }
    
    .table th {
        background: rgba(255,255,255,0.1);
        font-weight: 600;
    }
</style>
'''

@router.get("/dashboard", response_class=HTMLResponse)
async def admin_dashboard():
    """Main admin dashboard page"""
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

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

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

        loadStats();
        setInterval(loadStats, 60000); // Refresh every minute
    </script>
    '''

@router.get("/users", response_class=HTMLResponse)
async def admin_users_page():
    """User management page"""
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
                    <th>Email</th>
                    <th>Verified</th>
                    <th>Beta Access</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="users-table">
                <tr><td colspan="5">Loading...</td></tr>
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
                    document.getElementById('users-table').innerHTML = users.map(user => `
                        <tr>
                            <td>${user.email}</td>
                            <td>${user.email_verified ? '✅' : '❌'}</td>
                            <td>${user.has_beta ? '✅' : '❌'}</td>
                            <td>${new Date(user.created_at).toLocaleDateString()}</td>
                            <td>
                                <button class="btn ${user.has_beta ? 'btn-danger' : 'btn-primary'}" 
                                        onclick="toggleBeta(${user.id}, '${user.has_beta ? 'revoke' : 'grant'}')">
                                    ${user.has_beta ? 'Revoke' : 'Grant'} Beta
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

@router.get("/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Beta key management page"""
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
                            <code style="font-size: 18px; color: #4CAF50;">${data.key}</code>
                        </div>
                    `;
                    loadKeys(); // Refresh the keys list
                }
            } catch (error) {
                console.error('Error generating key:', error);
            }
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Load keys functionality would go here
        async function loadKeys() {
            // Implementation for loading beta keys list
        }

        loadKeys();
    </script>
    '''

@router.get("/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Release management page"""
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
        <p>Release management functionality coming soon...</p>
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
    <script>
        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }
    </script>
    '''
