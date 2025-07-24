"""Admin Users Management Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(prefix="", tags=["admin-users"])  # Empty prefix since parent already has /admin

@router.get("/users", response_class=HTMLResponse)
async def admin_users_page():
    """User management and overview page with search and user actions"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>User Management</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('users')}
        
        <div class="card">
            <h3>User Search & Management</h3>
            <div style="margin-bottom: 20px;">
                <input type="text" id="search-input" placeholder="Search users by email..." 
                       style="padding: 10px; width: 300px; border: 1px solid #333; background: #1a1a1a; color: white; border-radius: 4px; margin-right: 10px;">
                <button class="btn btn-primary" onclick="exportUsers()">Export User Data</button>
            </div>
            
            <div id="users-table">
                <p>Loading user data...</p>
            </div>
        </div>
        
        <!-- User Action Modal -->
        <div id="user-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); z-index: 1000;">
            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #2a2a2a; padding: 30px; border-radius: 8px; min-width: 400px;">
                <h3 id="modal-title" style="margin-top: 0;">User Actions</h3>
                <div id="modal-content">
                    <p><strong>Email:</strong> <span id="modal-email"></span></p>
                    <p><strong>Status:</strong> <span id="modal-status"></span></p>
                    <p><strong>Admin Access:</strong> <span id="modal-admin-status"></span></p>
                    <p><strong>Registered:</strong> <span id="modal-registered"></span></p>
                    <p><strong>Last Login:</strong> <span id="modal-last-login"></span></p>
                    
                    <div style="margin-top: 20px; display: flex; gap: 10px; flex-wrap: wrap;">
                        <button class="btn btn-warning" onclick="toggleAdmin()" id="admin-btn">Grant Admin Access</button>
                        <button class="btn btn-danger" onclick="deleteUser()" id="delete-btn">Delete Account</button>
                        <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        let allUsers = [];
        let allAdmins = [];
        let selectedUserId = null;
        let selectedUserEmail = null;
        let selectedUserIsAdmin = false;

        async function refreshUsers() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                // Load users
                const usersResponse = await fetch('/admin/users/data', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                // Load admin list
                const adminsResponse = await fetch('/admin/users/admins', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (usersResponse.ok && adminsResponse.ok) {{
                    allUsers = await usersResponse.json();
                    allAdmins = await adminsResponse.json();
                    displayUsers(allUsers);
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

        function isUserAdmin(email) {{
            return allAdmins.some(admin => admin.username === email);
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
                            <th style="padding: 12px; text-align: left;">Admin Access</th>
                            <th style="padding: 12px; text-align: left;">Registered</th>
                            <th style="padding: 12px; text-align: left;">Last Login</th>
                            <th style="padding: 12px; text-align: left;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            users.forEach(user => {{
                const userIsAdmin = isUserAdmin(user.email);
                html += `
                    <tr style="border-bottom: 1px solid #333; cursor: pointer;" 
                        onclick="openUserModal(${{user.id}}, '${{user.email}}', ${{user.email_verified}}, '${{user.created_at}}', '${{user.last_login || ''}}', ${{userIsAdmin}})">
                        <td style="padding: 12px;">${{user.email}}</td>
                        <td style="padding: 12px;">
                            <span style="color: ${{user.email_verified ? '#4CAF50' : '#ff9800'}};">
                                ${{user.email_verified ? 'Verified' : 'Unverified'}}
                            </span>
                        </td>
                        <td style="padding: 12px;">
                            <span style="color: ${{userIsAdmin ? '#4CAF50' : '#888'}};">
                                ${{userIsAdmin ? 'Admin' : 'User'}}
                            </span>
                        </td>
                        <td style="padding: 12px;">${{new Date(user.created_at).toLocaleDateString()}}</td>
                        <td style="padding: 12px;">${{user.last_login ? new Date(user.last_login).toLocaleDateString() : 'Never'}}</td>
                        <td style="padding: 12px;">
                            <button class="btn btn-sm btn-primary" onclick="event.stopPropagation(); openUserModal(${{user.id}}, '${{user.email}}', ${{user.email_verified}}, '${{user.created_at}}', '${{user.last_login || ''}}', ${{userIsAdmin}})">
                                Manage
                            </button>
                        </td>
                    </tr>
                `;
            }});

            html += `
                    </tbody>
                </table>
                <p style="margin-top: 10px; color: #888; font-size: 14px;">
                    Showing ${{users.length}} user(s). Click on a user row to manage their account.
                </p>
            `;

            document.getElementById('users-table').innerHTML = html;
        }}

        function openUserModal(userId, email, verified, created, lastLogin, isAdmin) {{
            selectedUserId = userId;
            selectedUserEmail = email;
            selectedUserIsAdmin = isAdmin;
            
            document.getElementById('modal-email').textContent = email;
            document.getElementById('modal-status').textContent = verified ? 'Verified' : 'Unverified';
            document.getElementById('modal-admin-status').textContent = isAdmin ? 'Admin' : 'Regular User';
            document.getElementById('modal-registered').textContent = new Date(created).toLocaleDateString();
            document.getElementById('modal-last-login').textContent = lastLogin ? new Date(lastLogin).toLocaleDateString() : 'Never';
            
            // Update admin button text
            const adminBtn = document.getElementById('admin-btn');
            adminBtn.textContent = isAdmin ? 'Revoke Admin Access' : 'Grant Admin Access';
            adminBtn.className = isAdmin ? 'btn btn-warning' : 'btn btn-success';
            
            document.getElementById('user-modal').style.display = 'block';
        }}

        function closeModal() {{
            document.getElementById('user-modal').style.display = 'none';
            selectedUserId = null;
            selectedUserEmail = null;
            selectedUserIsAdmin = false;
        }}

        async function toggleAdmin() {{
            if (!selectedUserId || !selectedUserEmail) return;
            
            const action = selectedUserIsAdmin ? 'revoke' : 'grant';
            const actionText = selectedUserIsAdmin ? 'revoke admin access from' : 'grant admin access to';
            
            const confirmed = confirm(`Are you sure you want to ${{actionText}} ${{selectedUserEmail}}?`);
            if (!confirmed) return;
            
            try {{
                const token = localStorage.getItem('admin_token');
                const endpoint = selectedUserIsAdmin ? '/admin/users/revoke-admin' : '/admin/users/make-admin';
                
                const response = await fetch(endpoint, {{
                    method: 'POST',
                    headers: {{
                        'Authorization': `Bearer ${{token}}`,
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify({{
                        user_id: selectedUserId,
                        email: selectedUserEmail
                    }})
                }});
                
                if (response.ok) {{
                    alert(`Admin access ${{action}}d successfully!`);
                    closeModal();
                    refreshUsers();
                }} else {{
                    const error = await response.json();
                    alert(`Failed to ${{action}} admin access: ` + (error.detail || 'Unknown error'));
                }}
            }} catch (error) {{
                console.error(`Error ${{action}}ing admin access:`, error);
                alert(`Error ${{action}}ing admin access`);
            }}
        }}

        async function deleteUser() {{
            if (!selectedUserId || !selectedUserEmail) return;
            
            const confirmed = confirm(`DELETE USER ACCOUNT?\\n\\nEmail: ${{selectedUserEmail}}\\n\\nThis action cannot be undone and will permanently remove all user data.`);
            if (!confirmed) return;
            
            const doubleConfirm = confirm('Are you absolutely sure? Type "DELETE" to confirm:');
            if (!doubleConfirm) return;
            
            try {{
                const token = localStorage.getItem('admin_token');
                const response = await fetch('/admin/users/delete', {{
                    method: 'DELETE',
                    headers: {{
                        'Authorization': `Bearer ${{token}}`,
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify({{
                        user_id: selectedUserId,
                        email: selectedUserEmail
                    }})
                }});
                
                if (response.ok) {{
                    alert('User account deleted successfully!');
                    closeModal();
                    refreshUsers();
                }} else {{
                    const error = await response.json();
                    alert('Failed to delete user: ' + (error.detail || 'Unknown error'));
                }}
            }} catch (error) {{
                console.error('Error deleting user:', error);
                alert('Error deleting user');
            }}
        }}

        function searchUsers() {{
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            if (!searchTerm) {{
                displayUsers(allUsers);
                return;
            }}
            
            const filteredUsers = allUsers.filter(user => 
                user.email.toLowerCase().includes(searchTerm)
            );
            
            displayUsers(filteredUsers);
        }}

        async function exportUsers() {{
            try {{
                const token = localStorage.getItem('admin_token');
                const response = await fetch('/admin/users/export', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});
                
                if (response.ok) {{
                    const blob = await response.blob();
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = `vault-users-${{new Date().toISOString().split('T')[0]}}.csv`;
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);
                    document.body.removeChild(a);
                }} else {{
                    alert('Failed to export user data');
                }}
            }} catch (error) {{
                console.error('Error exporting users:', error);
                alert('Error exporting user data');
            }}
        }}

        function logout() {{
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }}

        // Event listeners
        document.getElementById('search-input').addEventListener('input', searchUsers);
        
        // Close modal when clicking outside
        document.getElementById('user-modal').addEventListener('click', function(e) {{
            if (e.target === this) {{
                closeModal();
            }}
        }});

        // Initialize page
        refreshUsers();
    </script>
    '''
