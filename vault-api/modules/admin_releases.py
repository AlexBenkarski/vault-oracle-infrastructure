"""Admin Release Management Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(prefix="/admin", tags=["admin-releases"])

@router.get("/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Release management and file upload page"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>📦 Release Management</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('releases')}
        
        <div class="card">
            <h3>Upload New Release</h3>
            <div style="margin: 20px 0;">
                <input type="file" id="vault-file" accept=".exe" style="margin-bottom: 15px;">
                <div>
                    <button class="btn btn-primary" onclick="uploadRelease()">Upload to Staging</button>
                    <button class="btn btn-primary" onclick="deployToCurrent()" style="margin-left: 10px;">Deploy to Production</button>
                </div>
                <div id="upload-status" style="margin-top: 15px;"></div>
            </div>
        </div>
        
        <div class="card">
            <h3>Current Releases</h3>
            <div id="releases-table">
                <p>Loading release information...</p>
            </div>
            <button class="btn btn-primary" onclick="refreshReleases()" style="margin-top: 15px;">Refresh</button>
        </div>
        
        <div class="card">
            <h3>Download Links</h3>
            <div style="margin: 15px 0;">
                <p><strong>Current Release:</strong> <a href="/download/vault.exe" style="color: #4CAF50;">https://getvaultdesktop.com/download/vault.exe</a></p>
                <p><strong>Beta Channel:</strong> <a href="/download/vault-beta.exe" style="color: #4CAF50;">https://getvaultdesktop.com/download/vault-beta.exe</a></p>
            </div>
        </div>
    </div>
    
    <script>
        async function uploadRelease() {{
            const fileInput = document.getElementById('vault-file');
            const file = fileInput.files[0];
            
            if (!file) {{
                document.getElementById('upload-status').innerHTML = 
                    '<span style="color: #f44336;">Please select a file first</span>';
                return;
            }}

            if (!file.name.endsWith('.exe')) {{
                document.getElementById('upload-status').innerHTML = 
                    '<span style="color: #f44336;">Please select a .exe file</span>';
                return;
            }}

            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const formData = new FormData();
                formData.append('file', file);

                document.getElementById('upload-status').innerHTML = 
                    '<span style="color: #4CAF50;">Uploading...</span>';

                const response = await fetch('/admin/releases/upload', {{
                    method: 'POST',
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }},
                    body: formData
                }});

                if (response.ok) {{
                    const result = await response.json();
                    document.getElementById('upload-status').innerHTML = 
                        `<span style="color: #4CAF50;">✅ Upload successful: ${{result.message}}</span>`;
                    refreshReleases();
                }} else {{
                    const error = await response.json();
                    document.getElementById('upload-status').innerHTML = 
                        `<span style="color: #f44336;">❌ Upload failed: ${{error.detail}}</span>`;
                }}
            }} catch (error) {{
                console.error('Upload error:', error);
                document.getElementById('upload-status').innerHTML = 
                    '<span style="color: #f44336;">❌ Upload failed</span>';
            }}
        }}

        async function deployToCurrent() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/releases/deploy', {{
                    method: 'POST',
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const result = await response.json();
                    document.getElementById('upload-status').innerHTML = 
                        `<span style="color: #4CAF50;">✅ ${{result.message}}</span>`;
                    refreshReleases();
                }} else {{
                    const error = await response.json();
                    document.getElementById('upload-status').innerHTML = 
                        `<span style="color: #f44336;">❌ Deploy failed: ${{error.detail}}</span>`;
                }}
            }} catch (error) {{
                console.error('Deploy error:', error);
                document.getElementById('upload-status').innerHTML = 
                    '<span style="color: #f44336;">❌ Deploy failed</span>';
            }}
        }}

        async function refreshReleases() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/releases/list', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const releases = await response.json();
                    displayReleases(releases);
                }} else {{
                    document.getElementById('releases-table').innerHTML = 
                        '<p style="color: #f44336;">Failed to load releases</p>';
                }}
            }} catch (error) {{
                console.error('Error loading releases:', error);
                document.getElementById('releases-table').innerHTML = 
                    '<p style="color: #f44336;">Error loading releases</p>';
            }}
        }}

        function displayReleases(releases) {{
            if (!releases || releases.length === 0) {{
                document.getElementById('releases-table').innerHTML = 
                    '<p>No releases found</p>';
                return;
            }}

            let html = `
                <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                    <thead>
                        <tr style="border-bottom: 2px solid #4CAF50;">
                            <th style="padding: 12px; text-align: left;">File</th>
                            <th style="padding: 12px; text-align: left;">Size</th>
                            <th style="padding: 12px; text-align: left;">Status</th>
                            <th style="padding: 12px; text-align: left;">Uploaded</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            releases.forEach(release => {{
                html += `
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 12px;">${{release.filename}}</td>
                        <td style="padding: 12px;">${{release.size}}</td>
                        <td style="padding: 12px;">
                            <span style="color: ${{release.status === 'current' ? '#4CAF50' : '#ff9800'}};">
                                ${{release.status}}
                            </span>
                        </td>
                        <td style="padding: 12px;">${{release.uploaded_at}}</td>
                    </tr>
                `;
            }});

            html += '</tbody></table>';
            document.getElementById('releases-table').innerHTML = html;
        }}

        // Load releases on page load
        refreshReleases();
    </script>
    ''' + LOGOUT_SCRIPT
