"""Admin Beta Keys Management Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(prefix="", tags=["admin-beta"])

@router.get("/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Beta key generation and management page"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>🔑 Beta Key Management</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('beta')}
        
        <div class="card">
            <h3>Generate New Beta Key</h3>
            <div style="margin: 20px 0;">
                <button class="btn btn-primary" onclick="generateBetaKey()">Generate Beta Key</button>
                <div id="generated-key" style="margin-top: 15px; font-family: monospace; color: #4CAF50;"></div>
            </div>
        </div>
        
        <div class="card">
            <h3>Active Beta Keys</h3>
            <div id="beta-keys-table">
                <p>Loading beta keys...</p>
            </div>
            <button class="btn btn-primary" onclick="refreshBetaKeys()" style="margin-top: 15px;">Refresh Keys</button>
        </div>
    </div>
    
    <script>
        async function generateBetaKey() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/beta/generate', {{
                    method: 'POST',
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const result = await response.json();
                    document.getElementById('generated-key').innerHTML = 
                        `<strong>New Beta Key:</strong> ${{result.beta_key}}`;
                    refreshBetaKeys(); // Refresh the list
                }} else {{
                    const error = await response.json();
                    document.getElementById('generated-key').innerHTML = 
                        `<span style="color: #f44336;">Error: ${{error.detail}}</span>`;
                }}
            }} catch (error) {{
                console.error('Error generating beta key:', error);
                document.getElementById('generated-key').innerHTML = 
                    '<span style="color: #f44336;">Failed to generate beta key</span>';
            }}
        }}

        async function refreshBetaKeys() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/beta/keys', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const keys = await response.json();
                    displayBetaKeys(keys);
                }} else {{
                    document.getElementById('beta-keys-table').innerHTML = 
                        '<p style="color: #f44336;">Failed to load beta keys</p>';
                }}
            }} catch (error) {{
                console.error('Error loading beta keys:', error);
                document.getElementById('beta-keys-table').innerHTML = 
                    '<p style="color: #f44336;">Error loading beta keys</p>';
            }}
        }}

        function displayBetaKeys(keys) {{
            if (!keys || keys.length === 0) {{
                document.getElementById('beta-keys-table').innerHTML = 
                    '<p>No beta keys found</p>';
                return;
            }}

            let html = `
                <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                    <thead>
                        <tr style="border-bottom: 2px solid #4CAF50;">
                            <th style="padding: 12px; text-align: left;">Beta Key</th>
                            <th style="padding: 12px; text-align: left;">Status</th>
                            <th style="padding: 12px; text-align: left;">Used By</th>
                            <th style="padding: 12px; text-align: left;">Created</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            keys.forEach(key => {{
                html += `
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 12px; font-family: monospace;">${{key.beta_key}}</td>
                        <td style="padding: 12px;">
                            <span style="color: ${{key.is_used ? '#ff9800' : '#4CAF50'}};">
                                ${{key.is_used ? 'Used' : 'Available'}}
                            </span>
                        </td>
                        <td style="padding: 12px;">${{key.used_by || 'None'}}</td>
                        <td style="padding: 12px;">${{key.created_at}}</td>
                    </tr>
                `;
            }});

            html += '</tbody></table>';
            document.getElementById('beta-keys-table').innerHTML = html;
        }}

        // Load beta keys on page load
        refreshBetaKeys();
    </script>
    ''' + LOGOUT_SCRIPT
