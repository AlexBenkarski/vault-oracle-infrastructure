"""Admin Analytics Dashboard Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(prefix="/admin", tags=["admin-analytics"])

@router.get("/analytics", response_class=HTMLResponse)
async def admin_analytics_page():
    """Analytics dashboard and data visualization page"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>📊 Analytics Dashboard</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('analytics')}
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Sessions</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="total-sessions">Loading...</div>
                <p>User sessions tracked</p>
            </div>
            <div class="stat-card">
                <h3>Average Session</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="avg-session">Loading...</div>
                <p>Minutes per session</p>
            </div>
            <div class="stat-card">
                <h3>Most Used OS</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="most-used-os">Loading...</div>
                <p>Primary platform</p>
            </div>
            <div class="stat-card">
                <h3>Active Users</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="active-users">Loading...</div>
                <p>Last 7 days</p>
            </div>
        </div>
        
        <div class="card">
            <h3>Analytics Data</h3>
            <div id="analytics-table">
                <p>Loading analytics data...</p>
            </div>
            <button class="btn btn-primary" onclick="refreshAnalytics()" style="margin-top: 15px;">Refresh Data</button>
            <button class="btn btn-primary" onclick="exportAnalytics()" style="margin-left: 10px;">Export CSV</button>
        </div>
        
        <div class="card">
            <h3>Test Analytics</h3>
            <div style="margin: 20px 0;">
                <button class="btn btn-primary" onclick="sendTestData()">Send Test Analytics</button>
                <div id="test-status" style="margin-top: 15px;"></div>
            </div>
        </div>
    </div>
    
    <script>
        async function refreshAnalytics() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/analytics/data', {{
                    headers: {{
                        'Authorization': `Bearer ${{token}}`
                    }}
                }});

                if (response.ok) {{
                    const data = await response.json();
                    displayAnalytics(data);
                    updateAnalyticsStats(data);
                }} else {{
                    document.getElementById('analytics-table').innerHTML = 
                        '<p style="color: #f44336;">Failed to load analytics data</p>';
                }}
            }} catch (error) {{
                console.error('Error loading analytics:', error);
                document.getElementById('analytics-table').innerHTML = 
                    '<p style="color: #f44336;">Error loading analytics data</p>';
            }}
        }}

        function updateAnalyticsStats(data) {{
            document.getElementById('total-sessions').textContent = data.summary?.total_sessions || '0';
            document.getElementById('avg-session').textContent = data.summary?.avg_session_minutes || '0';
            document.getElementById('most-used-os').textContent = data.summary?.most_used_os || 'Unknown';
            document.getElementById('active-users').textContent = data.summary?.active_users || '0';
        }}

        function displayAnalytics(data) {{
            if (!data.users || data.users.length === 0) {{
                document.getElementById('analytics-table').innerHTML = 
                    '<p>No analytics data found</p>';
                return;
            }}

            let html = `
                <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                    <thead>
                        <tr style="border-bottom: 2px solid #4CAF50;">
                            <th style="padding: 12px; text-align: left;">Vault ID</th>
                            <th style="padding: 12px; text-align: left;">Version</th>
                            <th style="padding: 12px; text-align: left;">OS</th>
                            <th style="padding: 12px; text-align: left;">Last Seen</th>
                            <th style="padding: 12px; text-align: left;">Sessions</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            data.users.forEach(user => {{
                html += `
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 12px; font-family: monospace;">${{user.vault_id.substring(0, 8)}}...</td>
                        <td style="padding: 12px;">${{user.version}}</td>
                        <td style="padding: 12px;">${{user.os}}</td>
                        <td style="padding: 12px;">${{user.last_seen}}</td>
                        <td style="padding: 12px;">${{user.session_count}}</td>
                    </tr>
                `;
            }});

            html += '</tbody></table>';
            document.getElementById('analytics-table').innerHTML = html;
        }}

        async function exportAnalytics() {{
            try {{
                const token = localStorage.getItem('admin_token');
                if (!token) {{
                    window.location.href = '/admin';
                    return;
                }}

                const response = await fetch('/admin/analytics/export', {{
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
                    a.download = 'vault-analytics.csv';
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);
                }} else {{
                    alert('Failed to export analytics');
                }}
            }} catch (error) {{
                console.error('Error exporting analytics:', error);
                alert('Error exporting analytics');
            }}
        }}

        async function sendTestData() {{
            try {{
                const testData = {{
                    vault_id: 'test-' + Math.random().toString(36).substring(7),
                    version: '2.0.6-beta',
                    os: 'Windows 11',
                    session_minutes: Math.floor(Math.random() * 60) + 5,
                    features_used: ['vault_creation', 'file_encryption'],
                    consent_analytics: true
                }};

                const response = await fetch('/analytics', {{
                    method: 'POST',
                    headers: {{
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify(testData)
                }});

                if (response.ok) {{
                    document.getElementById('test-status').innerHTML = 
                        '<span style="color: #4CAF50;">✅ Test data sent successfully</span>';
                    setTimeout(refreshAnalytics, 1000); // Refresh after 1 second
                }} else {{
                    document.getElementById('test-status').innerHTML = 
                        '<span style="color: #f44336;">❌ Failed to send test data</span>';
                }}
            }} catch (error) {{
                console.error('Error sending test data:', error);
                document.getElementById('test-status').innerHTML = 
                    '<span style="color: #f44336;">❌ Error sending test data</span>';
            }}
        }}

        // Load analytics on page load
        refreshAnalytics();
    </script>
    ''' + LOGOUT_SCRIPT
