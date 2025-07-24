"""Admin HTML Pages - Complete admin interface pages"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse

router = APIRouter(prefix="/admin", tags=["admin-pages"])

# Shared admin styles
ADMIN_STYLES = '''
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Segoe UI', Arial; background: #1a1a1a; color: #fff; }
    .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
    .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid #4CAF50; padding-bottom: 15px; }
    .header h1 { color: #4CAF50; }
    .nav { display: flex; gap: 20px; margin-bottom: 30px; }
    .nav a { color: #fff; text-decoration: none; padding: 10px 20px; border-radius: 5px; background: #333; transition: all 0.3s; }
    .nav a:hover, .nav a.active { background: #4CAF50; }
    .card { background: #2d2d2d; padding: 25px; border-radius: 10px; margin-bottom: 20px; border: 1px solid #444; }
    .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; transition: all 0.3s; text-decoration: none; display: inline-block; font-size: 14px; }
    .btn-primary { background: #4CAF50; color: white; }
    .btn-warning { background: #FF9800; color: white; }
    .btn-danger { background: #f44336; color: white; }
    .btn-secondary { background: #6c757d; color: white; }
    .btn:hover { opacity: 0.8; transform: translateY(-1px); }
    .table { width: 100%; border-collapse: collapse; background: #2d2d2d; margin-top: 15px; }
    .table th, .table td { padding: 12px; text-align: left; border-bottom: 1px solid #444; }
    .table th { background: #4CAF50; color: white; font-weight: bold; }
    .table tr:hover { background: rgba(76, 175, 80, 0.1); }
    .badge { padding: 4px 8px; border-radius: 12px; font-size: 0.8em; font-weight: bold; margin-right: 5px; }
    .badge-success { background: #4CAF50; color: white; }
    .badge-warning { background: #FF9800; color: white; }
    .badge-danger { background: #f44336; color: white; }
    .badge-secondary { background: #6c757d; color: white; }
    .search-bar { width: 100%; padding: 12px; background: #333; border: 1px solid #555; border-radius: 6px; color: white; margin-bottom: 20px; font-size: 16px; }
    .search-bar:focus { outline: none; border-color: #4CAF50; }
    .controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px; }
    .stats-mini { display: flex; gap: 20px; }
    .stats-mini .stat { text-align: center; padding: 10px; background: #333; border-radius: 5px; min-width: 80px; }
    .stats-mini .stat-number { font-size: 1.2rem; color: #4CAF50; font-weight: bold; }
    .stats-mini .stat-label { font-size: 0.8rem; color: #a0a0a0; }
    .loading { text-align: center; padding: 40px; color: #a0a0a0; }
    .empty-state { text-align: center; padding: 40px; color: #a0a0a0; }
    .actions { display: flex; gap: 5px; }
    .filter-tabs { display: flex; gap: 10px; margin-bottom: 15px; }
    .filter-tab { padding: 8px 16px; background: #333; border: none; color: white; border-radius: 4px; cursor: pointer; transition: all 0.3s; }
    .filter-tab.active { background: #4CAF50; }
    .bulk-actions { display: none; padding: 15px; background: #333; border-radius: 5px; margin-bottom: 15px; }
    .bulk-actions.show { display: flex; justify-content: space-between; align-items: center; }
</style>
'''

@router.get("/", response_class=HTMLResponse)
async def admin_login_page():
    """Admin login page"""
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Admin Login - TheVault</title>
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body { font-family: 'Segoe UI', Arial; background: linear-gradient(135deg, #1a1a1a, #2d2d2d); color: #fff; height: 100vh; display: flex; align-items: center; justify-content: center; }
            .login-container { background: #2d2d2d; padding: 40px; border-radius: 10px; border: 1px solid #4CAF50; box-shadow: 0 10px 30px rgba(0,0,0,0.5); min-width: 400px; }
            .login-header { text-align: center; margin-bottom: 30px; }
            .login-header h1 { color: #4CAF50; margin-bottom: 10px; }
            .form-group { margin-bottom: 20px; }
            .form-group label { display: block; margin-bottom: 8px; font-weight: bold; }
            .form-group input { width: 100%; padding: 12px; background: #333; border: 1px solid #555; border-radius: 5px; color: white; font-size: 16px; }
            .form-group input:focus { outline: none; border-color: #4CAF50; }
            .btn { width: 100%; padding: 12px; background: #4CAF50; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; transition: all 0.3s; }
            .btn:hover { background: #45a049; transform: translateY(-1px); }
            .error { background: #f44336; color: white; padding: 10px; border-radius: 5px; margin-bottom: 15px; }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-header">
                <h1>🔐 Admin Portal</h1>
                <p>TheVault Desktop Management</p>
            </div>
            <div id="error" class="error" style="display: none;"></div>
            <form id="login-form">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" id="username" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="password" required>
                </div>
                <button type="submit" class="btn">Login</button>
            </form>
        </div>

        <script>
            document.getElementById('login-form').addEventListener('submit', async (e) => {
                e.preventDefault();
                
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const errorDiv = document.getElementById('error');
                
                try {
                    const response = await fetch('/admin/auth', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ username, password })
                    });
                    
                    const data = await response.json();
                    
                    if (response.ok) {
                        localStorage.setItem('admin_token', data.access_token);
                        window.location.href = '/admin/dashboard';
                    } else {
                        errorDiv.textContent = data.detail || 'Login failed';
                        errorDiv.style.display = 'block';
                    }
                } catch (error) {
                    errorDiv.textContent = 'Connection error';
                    errorDiv.style.display = 'block';
                }
            });
        </script>
    </body>
    </html>
    '''

@router.get("/dashboard", response_class=HTMLResponse)
async def admin_dashboard():
    """Main admin dashboard"""
    return ADMIN_STYLES + '''
    <div class="container">
        <div class="header">
            <h1>📊 Admin Dashboard</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        <div class="nav">
            <a href="/admin/dashboard" class="active">Dashboard</a>
            <a href="/admin/users">Users</a>
            <a href="/admin/beta">Beta Keys</a>
            <a href="/admin/releases">Releases</a>
            <a href="/admin/analytics">Analytics</a>
        </div>
        
        <div class="card">
            <h3>📈 System Statistics</h3>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" id="total-users">-</div>
                    <div class="stat-label">Total Users</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="verified-users">-</div>
                    <div class="stat-label">Verified Users</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="beta-users">-</div>
                    <div class="stat-label">Beta Users</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="analytics-users">-</div>
                    <div class="stat-label">Analytics Users</div>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>🖥️ Service Status</h3>
            <div id="service-status">Loading...</div>
        </div>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadStats() {
            try {
                const response = await fetch('/admin/stats', {
                    headers: { 'Authorization': `Bearer ${token}` }
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

        async function updateServiceStatus() {
            try {
                const response = await fetch('/admin/services', {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (response.ok) {
                    const services = await response.json();
                    const statusDiv = document.getElementById('service-status');
                    statusDiv.innerHTML = services.map(service => `
                        <div style="display: flex; justify-content: space-between; padding: 10px; border-bottom: 1px solid #444;">
                            <span>${service.name}</span>
                            <span class="badge ${service.status === 'active' ? 'badge-success' : 'badge-danger'}">
                                ${service.status}
                            </span>
                        </div>
                    `).join('');
                }
            } catch (error) {
                document.getElementById('service-status').innerHTML = '<div style="color: #f44336;">Error loading service status</div>';
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
    """Enhanced user management page with search and controls"""
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
            <div class="controls">
                <div class="stats-mini" id="user-stats">
                    <div class="stat">
                        <div class="stat-number" id="showing-count">0</div>
                        <div class="stat-label">Showing</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number" id="total-count">0</div>
                        <div class="stat-label">Total</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number" id="beta-count">0</div>
                        <div class="stat-label">Beta</div>
                    </div>
                </div>
                <div>
                    <button class="btn btn-secondary" onclick="exportUsers()">📊 Export CSV</button>
                    <button class="btn btn-primary" onclick="refreshUsers()">🔄 Refresh</button>
                </div>
            </div>

            <input type="text" class="search-bar" id="search-input" placeholder="🔍 Search users by email, ID, or date..." onkeyup="filterUsers()">
            
            <div class="filter-tabs">
                <button class="filter-tab active" onclick="setFilter('all')">All Users</button>
                <button class="filter-tab" onclick="setFilter('verified')">Verified</button>
                <button class="filter-tab" onclick="setFilter('beta')">Beta Users</button>
                <button class="filter-tab" onclick="setFilter('unverified')">Unverified</button>
                <button class="filter-tab" onclick="setFilter('recent')">Recent (7 days)</button>
            </div>

            <div class="bulk-actions" id="bulk-actions">
                <span id="selected-count">0 users selected</span>
                <div>
                    <button class="btn btn-warning" onclick="bulkGrantBeta()">Grant Beta</button>
                    <button class="btn btn-secondary" onclick="bulkRevokeBeta()">Revoke Beta</button>
                    <button class="btn btn-danger" onclick="bulkDelete()">Delete Selected</button>
                </div>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="select-all" onchange="toggleSelectAll()"></th>
                        <th onclick="sortBy('id')" style="cursor: pointer;">ID ↕️</th>
                        <th onclick="sortBy('email')" style="cursor: pointer;">Email ↕️</th>
                        <th>Status</th>
                        <th onclick="sortBy('created_at')" style="cursor: pointer;">Created ↕️</th>
                        <th onclick="sortBy('last_login')" style="cursor: pointer;">Last Login ↕️</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="users-tbody">
                    <tr><td colspan="7" class="loading">Loading users...</td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        let allUsers = [];
        let filteredUsers = [];
        let currentFilter = 'all';
        let sortField = 'created_at';
        let sortDirection = 'desc';

        async function loadUsers() {
            try {
                const response = await fetch('/admin/users/data', {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (!response.ok) {
                    throw new Error('Failed to load users');
                }
                
                allUsers = await response.json();
                applyFilter();
                updateStats();
            } catch (error) {
                console.error('Error loading users:', error);
                document.getElementById('users-tbody').innerHTML = 
                    '<tr><td colspan="7" style="color: #f44336; text-align: center;">Error loading users</td></tr>';
            }
        }

        function applyFilter() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            
            filteredUsers = allUsers.filter(user => {
                // Search filter
                const matchesSearch = !searchTerm || 
                    user.email.toLowerCase().includes(searchTerm) ||
                    user.id.toString().includes(searchTerm) ||
                    (user.created_at && user.created_at.includes(searchTerm));

                // Status filter
                let matchesFilter = true;
                switch(currentFilter) {
                    case 'verified':
                        matchesFilter = user.email_verified;
                        break;
                    case 'beta':
                        matchesFilter = user.has_beta;
                        break;
                    case 'unverified':
                        matchesFilter = !user.email_verified;
                        break;
                    case 'recent':
                        const weekAgo = new Date();
                        weekAgo.setDate(weekAgo.getDate() - 7);
                        matchesFilter = new Date(user.created_at) > weekAgo;
                        break;
                }

                return matchesSearch && matchesFilter;
            });

            sortUsers();
            renderUsers();
            updateStats();
        }

        function sortUsers() {
            filteredUsers.sort((a, b) => {
                let aVal = a[sortField] || '';
                let bVal = b[sortField] || '';
                
                if (sortField === 'id') {
                    aVal = parseInt(aVal);
                    bVal = parseInt(bVal);
                } else if (sortField.includes('_at') || sortField.includes('login')) {
                    aVal = new Date(aVal || 0);
                    bVal = new Date(bVal || 0);
                }
                
                if (aVal < bVal) return sortDirection === 'asc' ? -1 : 1;
                if (aVal > bVal) return sortDirection === 'asc' ? 1 : -1;
                return 0;
            });
        }

        function renderUsers() {
            const tbody = document.getElementById('users-tbody');
            
            if (filteredUsers.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" class="empty-state">No users found matching your criteria</td></tr>';
                return;
            }

            tbody.innerHTML = filteredUsers.map(user => `
                <tr data-user-id="${user.id}">
                    <td><input type="checkbox" class="user-checkbox" value="${user.id}" onchange="updateBulkActions()"></td>
                    <td>#${user.id}</td>
                    <td><strong>${user.email}</strong></td>
                    <td>
                        ${user.email_verified ? '<span class="badge badge-success">✓ Verified</span>' : '<span class="badge badge-secondary">Unverified</span>'}
                        ${user.has_beta ? '<span class="badge badge-warning">🚀 Beta</span>' : ''}
                    </td>
                    <td>${formatDate(user.created_at)}</td>
                    <td>${user.last_login ? formatDate(user.last_login) : '<span style="color: #6c757d;">Never</span>'}</td>
                    <td class="actions">
                        ${!user.has_beta ? 
                            `<button class="btn btn-warning" onclick="toggleBeta(${user.id}, 'grant')" title="Grant Beta">🚀</button>` :
                            `<button class="btn btn-secondary" onclick="toggleBeta(${user.id}, 'revoke')" title="Revoke Beta">❌</button>`
                        }
                        <button class="btn btn-danger" onclick="deleteUser(${user.id})" title="Delete User">🗑️</button>
                    </td>
                </tr>
            `).join('');
        }

        function updateStats() {
            document.getElementById('showing-count').textContent = filteredUsers.length;
            document.getElementById('total-count').textContent = allUsers.length;
            document.getElementById('beta-count').textContent = allUsers.filter(u => u.has_beta).length;
        }

        function setFilter(filter) {
            currentFilter = filter;
            document.querySelectorAll('.filter-tab').forEach(tab => tab.classList.remove('active'));
            event.target.classList.add('active');
            applyFilter();
        }

        function sortBy(field) {
            if (sortField === field) {
                sortDirection = sortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                sortField = field;
                sortDirection = 'asc';
            }
            applyFilter();
        }

        function filterUsers() {
            applyFilter();
        }

        function refreshUsers() {
            loadUsers();
        }

        async function toggleBeta(userId, action) {
            try {
                const response = await fetch('/admin/users/beta', {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ user_id: userId, action })
                });

                if (response.ok) {
                    loadUsers(); // Refresh data
                } else {
                    alert('Failed to update user beta status');
                }
            } catch (error) {
                console.error('Error updating beta status:', error);
                alert('Error updating user');
            }
        }

        async function deleteUser(userId) {
            if (!confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                return;
            }

            try {
                const response = await fetch(`/admin/users/${userId}`, {
                    method: 'DELETE',
                    headers: { 'Authorization': `Bearer ${token}` }
                });

                if (response.ok) {
                    loadUsers(); // Refresh data
                } else {
                    alert('Failed to delete user');
                }
            } catch (error) {
                console.error('Error deleting user:', error);
                alert('Error deleting user');
            }
        }

        function toggleSelectAll() {
            const selectAll = document.getElementById('select-all');
            const checkboxes = document.querySelectorAll('.user-checkbox');
            
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
            updateBulkActions();
        }

        function updateBulkActions() {
            const selected = document.querySelectorAll('.user-checkbox:checked');
            const bulkActions = document.getElementById('bulk-actions');
            const selectedCount = document.getElementById('selected-count');
            
            if (selected.length > 0) {
                bulkActions.classList.add('show');
                selectedCount.textContent = `${selected.length} users selected`;
            } else {
                bulkActions.classList.remove('show');
            }
        }

        async function bulkGrantBeta() {
            const selected = Array.from(document.querySelectorAll('.user-checkbox:checked')).map(cb => cb.value);
            if (selected.length === 0) return;
            
            if (!confirm(`Grant beta access to ${selected.length} users?`)) return;
            
            for (const userId of selected) {
                await toggleBeta(userId, 'grant');
            }
        }

        async function bulkRevokeBeta() {
            const selected = Array.from(document.querySelectorAll('.user-checkbox:checked')).map(cb => cb.value);
            if (selected.length === 0) return;
            
            if (!confirm(`Revoke beta access from ${selected.length} users?`)) return;
            
            for (const userId of selected) {
                await toggleBeta(userId, 'revoke');
            }
        }

        async function bulkDelete() {
            const selected = Array.from(document.querySelectorAll('.user-checkbox:checked')).map(cb => cb.value);
            if (selected.length === 0) return;
            
            if (!confirm(`DELETE ${selected.length} users? This cannot be undone!`)) return;
            
            for (const userId of selected) {
                await deleteUser(userId);
            }
        }

        function exportUsers() {
            const csv = [
                ['ID', 'Email', 'Verified', 'Beta', 'Created', 'Last Login'].join(','),
                ...filteredUsers.map(user => [
                    user.id,
                    user.email,
                    user.email_verified ? 'Yes' : 'No',
                    user.has_beta ? 'Yes' : 'No',
                    formatDate(user.created_at),
                    user.last_login ? formatDate(user.last_login) : 'Never'
                ].join(','))
            ].join('\\n');
            
            const blob = new Blob([csv], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `vault-users-${new Date().toISOString().split('T')[0]}.csv`;
            a.click();
            window.URL.revokeObjectURL(url);
        }

        function formatDate(dateStr) {
            if (!dateStr) return 'Never';
            const date = new Date(dateStr);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Initialize page
        loadUsers();
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
            <h3>Generate New Beta Key</h3>
            <button class="btn btn-primary" onclick="generateBetaKey()">🔑 Generate Beta Key</button>
            <div id="new-key-result" style="margin-top: 15px;"></div>
        </div>
        <div class="card">
            <h3>Existing Beta Keys</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Key</th>
                        <th>Created</th>
                        <th>Used By</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="beta-keys-tbody">
                    <tr><td colspan="4">Loading...</td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function generateBetaKey() {
            try {
                const response = await fetch('/admin/beta/generate', {
                    method: 'POST',
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                const result = await response.json();
                
                if (response.ok) {
                    document.getElementById('new-key-result').innerHTML = 
                        `<div style="background: #4CAF50; color: white; padding: 15px; border-radius: 5px;">
                            <strong>New Beta Key Generated:</strong><br>
                            <code style="background: rgba(0,0,0,0.3); padding: 5px; border-radius: 3px; font-size: 1.1em;">${result.key}</code>
                        </div>`;
                    loadBetaKeys(); // Refresh the list
                } else {
                    document.getElementById('new-key-result').innerHTML = 
                        `<div style="background: #f44336; color: white; padding: 15px; border-radius: 5px;">
                            Error: ${result.detail}
                        </div>`;
                }
            } catch (error) {
                console.error('Error generating beta key:', error);
            }
        }

        async function loadBetaKeys() {
            try {
                const response = await fetch('/admin/beta/keys', {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (response.ok) {
                    const keys = await response.json();
                    const tbody = document.getElementById('beta-keys-tbody');
                    
                    if (keys.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="4" style="text-align: center; color: #6c757d;">No beta keys found</td></tr>';
                        return;
                    }
                    
                    tbody.innerHTML = keys.map(key => `
                        <tr>
                            <td><code>${key.key}</code></td>
                            <td>${formatDate(key.created_at)}</td>
                            <td>${key.used_by || '<span style="color: #6c757d;">Unused</span>'}</td>
                            <td>
                                <button class="btn btn-danger" onclick="deleteBetaKey('${key.key}')">Delete</button>
                            </td>
                        </tr>
                    `).join('');
                } else {
                    document.getElementById('beta-keys-tbody').innerHTML = 
                        '<tr><td colspan="4" style="color: #f44336;">Error loading beta keys</td></tr>';
                }
            } catch (error) {
                console.error('Error loading beta keys:', error);
            }
        }

        async function deleteBetaKey(keyValue) {
            if (!confirm('Are you sure you want to delete this beta key?')) return;
            
            try {
                const response = await fetch(`/admin/beta/keys/${keyValue}`, {
                    method: 'DELETE',
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (response.ok) {
                    loadBetaKeys(); // Refresh the list
                } else {
                    alert('Failed to delete beta key');
                }
            } catch (error) {
                console.error('Error deleting beta key:', error);
            }
        }

        function formatDate(dateStr) {
            if (!dateStr) return 'Never';
            const date = new Date(dateStr);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Initialize page
        loadBetaKeys();
    </script>
    '''

@router.get("/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Release management page"""
    return ADMIN_STYLES + '''
    <div class="container">
        <div class="header">
            <h1>🚀 Release Management</h1>
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
            <h3>📤 Upload New Release</h3>
            <form id="upload-form" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Version Number</label>
                    <input type="text" id="version" placeholder="e.g., 2.0.7-beta" required>
                </div>
                <div class="form-group">
                    <label>Release Notes</label>
                    <textarea id="notes" rows="4" style="width: 100%; padding: 10px; background: #333; border: 1px solid #555; border-radius: 4px; color: white;" placeholder="What's new in this version..."></textarea>
                </div>
                <div class="upload-area" onclick="document.getElementById('file-input').click()">
                    <input type="file" id="file-input" accept=".exe" style="display: none;" onchange="handleFileSelect()">
                    <div id="upload-text">
                        📁 Click to select Vault.exe file<br>
                        <small style="color: #6c757d;">Only .exe files are accepted</small>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top: 15px;">🚀 Upload Release</button>
            </form>
            <div id="upload-progress" style="display: none; margin-top: 15px;">
                <div style="background: #333; border-radius: 10px; overflow: hidden;">
                    <div id="progress-bar" style="height: 20px; background: #4CAF50; width: 0%; transition: width 0.3s;"></div>
                </div>
                <div id="progress-text" style="text-align: center; margin-top: 5px;">Uploading...</div>
            </div>
        </div>

        <div class="card">
            <h3>📦 Release History</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Version</th>
                        <th>File Size</th>
                        <th>Upload Date</th>
                        <th>Downloads</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="releases-tbody">
                    <tr><td colspan="6">Loading releases...</td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        let selectedFile = null;

        function handleFileSelect() {
            const fileInput = document.getElementById('file-input');
            const uploadText = document.getElementById('upload-text');
            
            if (fileInput.files.length > 0) {
                selectedFile = fileInput.files[0];
                uploadText.innerHTML = `
                    ✅ Selected: ${selectedFile.name}<br>
                    <small style="color: #4CAF50;">Size: ${(selectedFile.size / 1024 / 1024).toFixed(2)} MB</small>
                `;
            }
        }

        document.getElementById('upload-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            if (!selectedFile) {
                alert('Please select a file to upload');
                return;
            }
            
            const version = document.getElementById('version').value;
            const notes = document.getElementById('notes').value;
            
            const formData = new FormData();
            formData.append('file', selectedFile);
            formData.append('version', version);
            formData.append('notes', notes);
            
            const progressDiv = document.getElementById('upload-progress');
            const progressBar = document.getElementById('progress-bar');
            const progressText = document.getElementById('progress-text');
            
            progressDiv.style.display = 'block';
            
            try {
                const xhr = new XMLHttpRequest();
                
                xhr.upload.addEventListener('progress', (e) => {
                    if (e.lengthComputable) {
                        const percentComplete = (e.loaded / e.total) * 100;
                        progressBar.style.width = percentComplete + '%';
                        progressText.textContent = `Uploading... ${Math.round(percentComplete)}%`;
                    }
                });
                
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        progressText.textContent = 'Upload complete!';
                        progressBar.style.background = '#4CAF50';
                        loadReleases(); // Refresh the list
                        
                        // Reset form
                        document.getElementById('upload-form').reset();
                        selectedFile = null;
                        document.getElementById('upload-text').innerHTML = 
                            '📁 Click to select Vault.exe file<br><small style="color: #6c757d;">Only .exe files are accepted</small>';
                        
                        setTimeout(() => {
                            progressDiv.style.display = 'none';
                            progressBar.style.width = '0%';
                        }, 3000);
                    } else {
                        progressText.textContent = 'Upload failed!';
                        progressBar.style.background = '#f44336';
                    }
                };
                
                xhr.open('POST', '/admin/releases/upload');
                xhr.setRequestHeader('Authorization', `Bearer ${token}`);
                xhr.send(formData);
                
            } catch (error) {
                console.error('Upload error:', error);
                progressText.textContent = 'Upload error!';
                progressBar.style.background = '#f44336';
            }
        });

        async function loadReleases() {
            try {
                const response = await fetch('/admin/releases/list', {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (response.ok) {
                    const releases = await response.json();
                    const tbody = document.getElementById('releases-tbody');
                    
                    if (releases.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6" style="text-align: center; color: #6c757d;">No releases found</td></tr>';
                        return;
                    }
                    
                    tbody.innerHTML = releases.map(release => `
                        <tr>
                            <td><strong>${release.version}</strong></td>
                            <td>${formatFileSize(release.file_size)}</td>
                            <td>${formatDate(release.created_at)}</td>
                            <td>${release.download_count || 0}</td>
                            <td>
                                <span class="badge ${release.is_current ? 'badge-success' : 'badge-secondary'}">
                                    ${release.is_current ? 'Current' : 'Archived'}
                                </span>
                            </td>
                            <td class="actions">
                                ${!release.is_current ? 
                                    `<button class="btn btn-warning" onclick="setCurrentRelease('${release.version}')">Set Current</button>` : 
                                    '<span style="color: #4CAF50;">✓ Current</span>'
                                }
                                <button class="btn btn-danger" onclick="deleteRelease('${release.version}')">Delete</button>
                            </td>
                        </tr>
                    `).join('');
                } else {
                    document.getElementById('releases-tbody').innerHTML = 
                        '<tr><td colspan="6" style="color: #f44336;">Error loading releases</td></tr>';
                }
            } catch (error) {
                console.error('Error loading releases:', error);
            }
        }

        async function setCurrentRelease(version) {
            if (!confirm(`Set version ${version} as the current release?`)) return;
            
            try {
                const response = await fetch('/admin/releases/set-current', {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ version })
                });
                
                if (response.ok) {
                    loadReleases(); // Refresh the list
                } else {
                    alert('Failed to set current release');
                }
            } catch (error) {
                console.error('Error setting current release:', error);
            }
        }

        async function deleteRelease(version) {
            if (!confirm(`Delete version ${version}? This action cannot be undone.`)) return;
            
            try {
                const response = await fetch(`/admin/releases/${version}`, {
                    method: 'DELETE',
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (response.ok) {
                    loadReleases(); // Refresh the list
                } else {
                    alert('Failed to delete release');
                }
            } catch (error) {
                console.error('Error deleting release:', error);
            }
        }

        function formatFileSize(bytes) {
            if (!bytes) return '0 B';
            const k = 1024;
            const sizes = ['B', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }

        function formatDate(dateStr) {
            if (!dateStr) return 'Never';
            const date = new Date(dateStr);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Initialize page
        loadReleases();
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
            <h3>📈 Usage Statistics</h3>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" id="total-sessions">0</div>
                    <div class="stat-label">Total Sessions</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="active-users">0</div>
                    <div class="stat-label">Active Users (7d)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="avg-session">0</div>
                    <div class="stat-label">Avg Session (min)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="crash-rate">0%</div>
                    <div class="stat-label">Crash Rate</div>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>🖥️ Platform Distribution</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Operating System</th>
                        <th>Users</th>
                        <th>Sessions</th>
                        <th>Percentage</th>
                    </tr>
                </thead>
                <tbody id="platform-tbody">
                    <tr><td colspan="4">Loading analytics...</td></tr>
                </tbody>
            </table>
        </div>

        <div class="card">
            <h3>📅 Recent Activity</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Sessions</th>
                        <th>Unique Users</th>
                        <th>Crashes</th>
                        <th>Version</th>
                    </tr>
                </thead>
                <tbody id="activity-tbody">
                    <tr><td colspan="5">Loading recent activity...</td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadAnalytics() {
            try {
                const response = await fetch('/admin/analytics/data', {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                
                if (response.ok) {
                    const data = await response.json();
                    
                    // Update statistics
                    document.getElementById('total-sessions').textContent = data.total_sessions || 0;
                    document.getElementById('active-users').textContent = data.active_users || 0;
                    document.getElementById('avg-session').textContent = data.avg_session_minutes || 0;
                    document.getElementById('crash-rate').textContent = (data.crash_rate || 0) + '%';
                    
                    // Update platform table
                    const platformTbody = document.getElementById('platform-tbody');
                    if (data.platforms && data.platforms.length > 0) {
                        platformTbody.innerHTML = data.platforms.map(platform => `
                            <tr>
                                <td>${platform.os}</td>
                                <td>${platform.users}</td>
                                <td>${platform.sessions}</td>
                                <td>${platform.percentage}%</td>
                            </tr>
                        `).join('');
                    } else {
                        platformTbody.innerHTML = '<tr><td colspan="4" style="text-align: center; color: #6c757d;">No platform data available</td></tr>';
                    }
                    
                    // Update activity table
                    const activityTbody = document.getElementById('activity-tbody');
                    if (data.recent_activity && data.recent_activity.length > 0) {
                        activityTbody.innerHTML = data.recent_activity.map(activity => `
                            <tr>
                                <td>${formatDate(activity.date)}</td>
                                <td>${activity.sessions}</td>
                                <td>${activity.unique_users}</td>
                                <td>${activity.crashes}</td>
                                <td>${activity.version}</td>
                            </tr>
                        `).join('');
                    } else {
                        activityTbody.innerHTML = '<tr><td colspan="5" style="text-align: center; color: #6c757d;">No recent activity data</td></tr>';
                    }
                    
                } else {
                    console.error('Failed to load analytics');
                    document.getElementById('platform-tbody').innerHTML = 
                        '<tr><td colspan="4" style="color: #f44336;">Error loading analytics data</td></tr>';
                    document.getElementById('activity-tbody').innerHTML = 
                        '<tr><td colspan="5" style="color: #f44336;">Error loading analytics data</td></tr>';
                }
            } catch (error) {
                console.error('Error loading analytics:', error);
            }
        }

        function formatDate(dateStr) {
            if (!dateStr) return 'Never';
            const date = new Date(dateStr);
            return date.toLocaleDateString();
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Initialize page
        loadAnalytics();
        
        // Auto-refresh every 5 minutes
        setInterval(loadAnalytics, 5 * 60 * 1000);
    </script>
    '''
