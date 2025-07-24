"""Admin Users Management Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(prefix="", tags=["admin-users"])

@router.get("/users", response_class=HTMLResponse)
async def admin_users_page():
    """User management and overview page"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>👥 User Management</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('users')}
        
        <div class="card">
            <h3>Registered Users</h3>
            <div id="users-table">
                <p>Loading user data...</p>
            </div>
        </div>
        
        <div class="card">
            <h3>User Actions</h3>
            <button class="btn btn-primary" onclick="refreshUsers()">Refresh Users</button>
            <button class="btn btn-primary" onclick="exportUsers()">Export User Data</button>
        </div>
    </div>
    
    <script>
        async function refreshUsers() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/users/data', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const users = await response.json();
                    displayUsers(users);
                }} else {{
                    document.getElementById('users-table').innerHTML = 
                        '<p style="color: #f44336;">Failed to load users</p>';
                }}
            }} catch (error) {{
                console.error('Error loading users:', error);
                document.getElementById('users-table').innerHTML = 
                    '<p style="color: #f44336;">Error loading users</p>';
            }}
        }}

        function displayUsers(users) {{
            if (!users || users.length === 0) {{
                document.getElementById('users-table').innerHTML = 
                    '<p>No users found</p>';
                return;
            }}

            let html = `
                <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                    <thead>
                        <tr style="border-bottom: 2px solid #4CAF50;">
                            <th style="padding: 12px; text-align: left;">Email</th>
                            <th style="padding: 12px; text-align: left;">Status</th>
                            <th style="padding: 12px; text-align: left;">Beta Key</th>
                            <th style="padding: 12px; text-align: left;">Registered</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            users.forEach(user => {{
                html += `
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 12px;">${{user.email}}</td>
                        <td style="padding: 12px;">
                            <span style="color: ${{user.verified ? '#4CAF50' : '#ff9800'}};">
                                ${{user.verified ? 'Verified' : 'Pending'}}
                            </span>
                        </td>
                        <td style="padding: 12px;">
                            ${{user.has_beta ? 'Yes' : 'No'}}
                        </td>
                        <td style="padding: 12px;">${{user.created_at}}</td>
                    </tr>
                `;
            }});

            html += '</tbody></table>';
            document.getElementById('users-table').innerHTML = html;
        }}

        async function exportUsers() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/users/export', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const blob = await response.blob();
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.style.display = 'none';
                    a.href = url;
                    a.download = 'vault-users.csv';
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);
                }} else {{
                    alert('Failed to export users');
                }}
            }} catch (error) {{
                console.error('Error exporting users:', error);
                alert('Error exporting users');
            }}
        }}

        // Load users on page load
        refreshUsers();
    </script>
    ''' + LOGOUT_SCRIPT
