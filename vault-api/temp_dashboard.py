@app.get("/admin/dashboard", response_class=HTMLResponse)
async def admin_dashboard():
    """Admin dashboard with enhanced service monitoring"""
    return ADMIN_STYLES + '''
    <style>
        .service-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin: 20px 0; }
        .service-box { background: #2d2d2d; border-radius: 12px; padding: 20px; border: 3px solid; position: relative; }
        .service-box.running { border-color: #4CAF50; background: linear-gradient(135deg, rgba(76,175,80,0.1), rgba(76,175,80,0.05)); }
        .service-box.stopped { border-color: #f44336; background: linear-gradient(135deg, rgba(244,67,54,0.1), rgba(244,67,54,0.05)); }
        .service-header { display: flex; justify-content: between; align-items: center; margin-bottom: 15px; }
        .service-name { font-size: 1.3rem; font-weight: bold; color: white; }
        .service-status { font-size: 0.9rem; padding: 4px 12px; border-radius: 20px; }
        .status-active { background: #4CAF50; color: white; }
        .status-inactive { background: #f44336; color: white; }
        .service-info { margin: 15px 0; color: #ccc; font-size: 0.9rem; }
        .service-controls { display: flex; gap: 10px; margin-top: 15px; }
        .control-btn { flex: 1; padding: 10px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: all 0.3s; }
        .btn-start { background: #4CAF50; color: white; }
        .btn-stop { background: #f44336; color: white; }
        .btn-restart { background: #2196F3; color: white; }
        .control-btn:hover { opacity: 0.8; transform: translateY(-1px); }
        .control-btn:disabled { background: #666; cursor: not-allowed; opacity: 0.5; transform: none; }
        .uptime { font-size: 0.8rem; color: #4CAF50; margin-top: 5px; }
    </style>

    <div class="header">
        <h1>🔐 Admin Dashboard</h1>
        <button class="btn btn-danger" onclick="logout()">Logout</button>
    </div>

    <div class="nav">
        <a href="/admin/dashboard" class="active">Dashboard</a>
        <a href="#" onclick="loadPage('users')">Users</a>
        <a href="#" onclick="loadPage('beta')">Beta Keys</a>
        <a href="#" onclick="loadPage('releases')">Releases</a>
        <a href="#" onclick="loadPage('analytics')">Analytics</a>
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
            <!-- Services will be loaded here -->
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
                    document.getElementById('last-updated').textContent = new Date().toLocaleTimeString();
                }
            } catch (error) {
                console.error('Service status error:', error);
                document.getElementById('api-health').textContent = 'Error';
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
                        <div class="service-name">${service.name.toUpperCase()}</div>
                        <div class="service-status ${isRunning ? 'status-active' : 'status-inactive'}">
                            ${isRunning ? 'RUNNING' : 'STOPPED'}
                        </div>
                    </div>
                    <div class="service-info">
                        Status: ${service.status}<br>
                        Last Check: ${new Date(service.last_check).toLocaleTimeString()}
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

        function loadPage(page) {
            alert(`${page.charAt(0).toUpperCase() + page.slice(1)} page coming soon!`);
        }

        function logout() {
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }

        // Initialize
        loadStats();
        updateServiceStatus();
        setInterval(updateServiceStatus, 30000);
        setInterval(loadStats, 60000);
    </script>

    <div class="card">
        <h3>📊 Quick Stats</h3>
        <p>• API Status: <span id="api-health">Checking...</span></p>
        <p>• Last Updated: <span id="last-updated">Never</span></p>
    </div>
    '''

# Enhanced service control endpoints
@app.post("/admin/services/start/{service_name}")
async def start_service_endpoint(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Start a service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        raise HTTPException(status_code=400, detail="Service not allowed")
    
    try:
        result = subprocess.run(['sudo', 'systemctl', 'start', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "started", "service": service_name}
        else:
            raise HTTPException(status_code=500, detail=result.stderr)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/admin/services/stop/{service_name}")
async def stop_service_endpoint(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Stop a service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        raise HTTPException(status_code=400, detail="Service not allowed")
    
    try:
        result = subprocess.run(['sudo', 'systemctl', 'stop', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "stopped", "service": service_name}
        else:
            raise HTTPException(status_code=500, detail=result.stderr)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
