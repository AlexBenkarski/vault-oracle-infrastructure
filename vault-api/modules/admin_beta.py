"""Admin Beta Keys Management Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

# Remove the prefix since it's already included by admin_pages.py
router = APIRouter(tags=["admin-beta"])

@router.get("/beta", response_class=HTMLResponse)
async def admin_beta_page():
    """Beta key generation and management page"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>Beta Key Management</h1>
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
                        'Authorization': `Bearer ${{token}}`,
                        'Content-Type': 'application/json'
                    }}
                }});

                if (response.ok) {{
                    const result = await response.json();
                    document.getElementById('generated-key').innerHTML = `
                        <div style="background: #2d2d2d; padding: 15px; border-radius: 5px; margin-top: 10px;">
                            <strong>New Beta Key:</strong><br>
                            <code style="font-size: 18px; color: #4CAF50;">${{result.key}}</code>
                            <br><br>
                            <button class="btn btn-secondary" onclick="copyToClipboard('${{result.key}}')">Copy to Clipboard</button>
                        </div>
                    `;
                    // Refresh the keys list
                    refreshBetaKeys();
                }} else {{
                    const error = await response.json();
                    document.getElementById('generated-key').innerHTML = `
                        <div style="color: #f44336; margin-top: 10px;">
                            Error: ${{error.detail || 'Failed to generate key'}}
                        </div>
                    `;
                }}
            }} catch (error) {{
                console.error('Error generating beta key:', error);
                document.getElementById('generated-key').innerHTML = `
                    <div style="color: #f44336; margin-top: 10px;">
                        Error: Network error occurred
                    </div>
                `;
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
                            <th style="padding: 12px; text-align: left;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            keys.forEach(key => {{
                const createdDate = key.created_at ? new Date(key.created_at).toLocaleDateString() : 'Unknown';
                const usedBy = key.used_by_email || 'None';
                const statusColor = key.status === 'used' ? '#ff9800' : key.status === 'revoked' ? '#f44336' : '#4CAF50';
                
                html += `
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 12px; font-family: monospace;">
                            <code>${{key.key_value}}</code>
                            <button onclick="copyToClipboard('${{key.key_value}}')" style="margin-left: 10px; padding: 2px 8px; font-size: 12px;">Copy</button>
                        </td>
                        <td style="padding: 12px;">
                            <span style="color: ${{statusColor}}; text-transform: capitalize;">
                                ${{key.status}}
                            </span>
                        </td>
                        <td style="padding: 12px;">${{usedBy}}</td>
                        <td style="padding: 12px;">${{createdDate}}</td>
                        <td style="padding: 12px;">
                            ${{key.status !== 'revoked' ? `<button class="btn btn-danger" onclick="revokeKey('${{key.key_value}}')" style="padding: 4px 8px; font-size: 12px;">Revoke</button>` : ''}}
                        </td>
                    </tr>
                `;
            }});

            html += '</tbody></table>';
            document.getElementById('beta-keys-table').innerHTML = html;
        }}

        function copyToClipboard(text) {{
            navigator.clipboard.writeText(text).then(function() {{
                // Show temporary success message
                const originalText = event.target.textContent;
                event.target.textContent = 'Copied!';
                event.target.style.color = '#4CAF50';
                setTimeout(() => {{
                    event.target.textContent = originalText;
                    event.target.style.color = '';
                }}, 1000);
            }}).catch(function(err) {{
                console.error('Could not copy text: ', err);
                alert('Failed to copy to clipboard');
            }});
        }}

        async function revokeKey(keyValue) {{
            if (!confirm(`Are you sure you want to revoke key: ${{keyValue}}?`)) {{
                return;
            }}

            try {{
                const token = localStorage.getItem('admin_token');
                const response = await fetch('/admin/beta/revoke', {{
                    method: 'POST',
                    headers: {{
                        'Authorization': `Bearer ${{token}}`,
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify({{ key_value: keyValue }})
                }});

                if (response.ok) {{
                    alert('Key revoked successfully');
                    refreshBetaKeys();
                }} else {{
                    alert('Failed to revoke key');
                }}
            }} catch (error) {{
                console.error('Error revoking key:', error);
                alert('Error revoking key');
            }}
        }}

        // Load beta keys on page load
        refreshBetaKeys();
    </script>
    ''' + LOGOUT_SCRIPT
