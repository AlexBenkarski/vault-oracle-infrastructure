"""Admin Dashboard Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(tags=["admin-dashboard"])

@router.get("/dashboard", response_class=HTMLResponse)
async def admin_dashboard():
    """Main admin dashboard with system overview and service controls"""
    return ADMIN_STYLES + f'''
    <style>
        .service-grid {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 20px; margin: 20px 0; }}
        .service-box {{ background: #2d2d2d; border-radius: 12px; padding: 20px; border: 3px solid; transition: all 0.3s; }}
        .service-box.running {{ border-color: #4CAF50; background: linear-gradient(135deg, rgba(76,175,80,0.1), rgba(76,175,80,0.05)); }}
        .service-box.stopped {{ border-color: #f44336; background: linear-gradient(135deg, rgba(244,67,54,0.1), rgba(244,67,54,0.05)); }}
        .service-header {{ display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }}
        .service-name {{ font-size: 1.3rem; font-weight: bold; color: white; }}
        .service-status {{ font-size: 0.9rem; padding: 4px 12px; border-radius: 20px; font-weight: bold; }}
        .status-active {{ background: #4CAF50; color: white; }}
        .status-inactive {{ background: #f44336; color: white; }}
        .service-info {{ margin: 15px 0; color: #ccc; font-size: 0.9rem; line-height: 1.4; }}
        .uptime {{ color: #4CAF50; font-weight: bold; margin-top: 8px; }}
        .service-controls {{ display: flex; gap: 8px; margin-top: 15px; }}
        .control-btn {{ flex: 1; padding: 10px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: all 0.3s; }}
        .btn-start {{ background: #4CAF50; color: white; }}
        .btn-stop {{ background: #f44336; color: white; }}
        .btn-restart {{ background: #2196F3; color: white; }}
        .control-btn:hover {{ opacity: 0.8; transform: translateY(-1px); }}
        .control-btn:disabled {{ background: #666; cursor: not-allowed; opacity: 0.5; transform: none; }}
    </style>
    
    <div class="container">
        <div class="header">
            <h1>Admin Dashboard</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('dashboard')}
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Users</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="total-users">Loading...</div>
                <p>Registered accounts</p>
            </div>
            <div class="stat-card">
                <h3>Verified Users</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="verified-users">Loading...</div>
                <p>Email verified</p>
            </div>
            <div class="stat-card">
                <h3>Beta Users</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="beta-users">Loading...</div>
                <p>Active beta keys</p>
            </div>
            <div class="stat-card">
                <h3>Analytics Users</h3>
                <div style="font-size: 2.5em; margin: 10px 0; color: #4CAF50;" id="analytics-users">Loading...</div>
                <p>Consent given</p>
            </div>
        </div>

        <div class="card">
            <h3>System Services</h3>
            <div class="service-grid" id="services-grid">
                <p>Loading services...</p>
            </div>
        </div>
    </div>
    
    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';

        async function loadStats() {{
            try {{
                const response = await fetch('/admin/stats', {{
                    headers: {{ 'Authorization': `Bearer ${{token}}` }}
                }});

                if (response.ok) {{
                    const stats = await response.json();
                    document.getElementById('total-users').textContent = stats.total_users;
                    document.getElementById('verified-users').textContent = stats.verified_users;
                    document.getElementById('beta-users').textContent = stats.beta_users;
                    document.getElementById('analytics-users').textContent = stats.analytics_users || 0;
                }} else if (response.status === 401) {{
                    window.location.href = '/admin';
                }}
            }} catch (error) {{
                console.error('Error loading stats:', error);
            }}
        }}

        async function updateServiceStatus() {{
            try {{
                const response = await fetch('/admin/services/status', {{
                    headers: {{ 'Authorization': `Bearer ${{token}}` }}
                }});

                if (response.ok) {{
                    const services = await response.json();
                    renderServices(services);
                }}
            }} catch (error) {{
                console.error('Service status error:', error);
                document.getElementById('services-grid').innerHTML = '<p style="color: #f44336;">Error loading services</p>';
            }}
        }}

        function renderServices(services) {{
            const grid = document.getElementById('services-grid');
            grid.innerHTML = '';

            services.forEach(service => {{
                const isRunning = service.status === 'active';
                const uptime = service.uptime || 'Unknown';
                
                const serviceBox = document.createElement('div');
                serviceBox.className = `service-box ${{isRunning ? 'running' : 'stopped'}}`;
                serviceBox.innerHTML = `
                    <div class="service-header">
                        <div class="service-name">${{service.name.toUpperCase()}}</div>
                        <div class="service-status ${{isRunning ? 'status-active' : 'status-inactive'}}">
                            ${{isRunning ? 'RUNNING' : 'STOPPED'}}
                        </div>
                    </div>
                    <div class="service-info">
                        Status: ${{service.status}}<br>
                        Last Check: ${{new Date().toLocaleTimeString()}}
                        ${{isRunning ? `<div class="uptime">Uptime: ${{uptime}}</div>` : ''}}
                    </div>
                    <div class="service-controls">
                        <button class="control-btn btn-start" onclick="controlService('${{service.name}}', 'start')" 
                                id="start-${{service.name}}" ${{isRunning ? 'disabled' : ''}}>Start</button>
                        <button class="control-btn btn-stop" onclick="controlService('${{service.name}}', 'stop')" 
                                id="stop-${{service.name}}" ${{!isRunning ? 'disabled' : ''}}>Stop</button>
                        <button class="control-btn btn-restart" onclick="controlService('${{service.name}}', 'restart')"
                                id="restart-${{service.name}}">Restart</button>
                    </div>
                `;
                grid.appendChild(serviceBox);
            }});
        }}

        async function controlService(serviceName, action) {{
            const startBtn = document.getElementById(`start-${{serviceName}}`);
            const stopBtn = document.getElementById(`stop-${{serviceName}}`);
            const restartBtn = document.getElementById(`restart-${{serviceName}}`);
            
            // Disable all buttons and show loading state
            [startBtn, stopBtn, restartBtn].forEach(btn => {{
                btn.disabled = true;
                if (btn.id.includes(action)) {{
                    btn.textContent = action.charAt(0).toUpperCase() + action.slice(1) + 'ing...';
                }}
            }});

            try {{
                const response = await fetch(`/admin/services/${{action}}/${{serviceName}}`, {{
                    method: 'POST',
                    headers: {{ 'Authorization': `Bearer ${{token}}` }}
                }});

                if (response.ok) {{
                    const result = await response.json();
                    console.log(`${{action}} result:`, result);
                    // Refresh service status after 2 seconds
                    setTimeout(updateServiceStatus, 2000);
                }} else {{
                    const error = await response.json();
                    alert(`Failed to ${{action}} ${{serviceName}}: ${{error.detail}}`);
                }}
            }} catch (error) {{
                console.error(`${{action}} error:`, error);
                alert(`Error: Could not ${{action}} ${{serviceName}}`);
            }} finally {{
                // Re-enable buttons after 3 seconds
                setTimeout(() => {{
                    updateServiceStatus();
                }}, 3000);
            }}
        }}

        function logout() {{
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }}

        // Initialize dashboard
        loadStats();
        updateServiceStatus();
        
        // Auto-refresh intervals
        setInterval(updateServiceStatus, 30000); // Update services every 30 seconds
        setInterval(loadStats, 60000); // Update stats every minute
    </script>
    '''
