"""Enhanced Admin Release Management Page"""

from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from admin_styles import ADMIN_STYLES, get_nav_html, LOGOUT_SCRIPT

router = APIRouter(prefix="/admin", tags=["admin-releases"])

@router.get("/releases", response_class=HTMLResponse)
async def admin_releases_page():
    """Enhanced release management page with dual file support and rollout controls"""
    return ADMIN_STYLES + f'''
    <div class="container">
        <div class="header">
            <h1>Release Management</h1>
            <button class="btn btn-danger" onclick="logout()">Logout</button>
        </div>
        
        {get_nav_html('releases')}
        
        <!-- Upload New Release Section -->
        <div class="card">
            <h3>Upload New Release</h3>
            <form id="upload-form" style="display: grid; gap: 20px;">
                <div class="form-group">
                    <label for="version">Version Number *</label>
                    <input type="text" id="version" name="version" placeholder="2.0.7-beta" required 
                           pattern="[0-9]+\.[0-9]+\.[0-9]+.*" title="Version format: 1.0.0 or 1.0.0-beta">
                </div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="upload-box">
                        <h4>Vault.exe (Update File)</h4>
                        <input type="file" id="vault-file" accept=".exe" style="margin-bottom: 10px;">
                        <p style="color: #888; font-size: 14px;">For existing users to update their app</p>
                        <div id="vault-file-info" style="color: #4CAF50; font-size: 14px;"></div>
                    </div>
                    
                    <div class="upload-box">
                        <h4>VaultSetup.exe (Installer)</h4>
                        <input type="file" id="setup-file" accept=".exe" style="margin-bottom: 10px;">
                        <p style="color: #888; font-size: 14px;">For new users to install the app</p>
                        <div id="setup-file-info" style="color: #4CAF50; font-size: 14px;"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="release-notes">Release Notes</label>
                    <textarea id="release-notes" name="release-notes" rows="4" 
                              placeholder="What's new in this version..."></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Upload to Staging</button>
                <div id="upload-status" style="margin-top: 10px;"></div>
            </form>
        </div>
        
        <!-- Staging Releases -->
        <div class="card">
            <h3>Staging Releases</h3>
            <div id="staging-releases">
                <p>Loading staging releases...</p>
            </div>
        </div>
        
        <!-- Production Release -->
        <div class="card">
            <h3>Production Release</h3>
            <div id="production-release">
                <p>Loading production release...</p>
            </div>
        </div>
        
        <!-- Release History -->
        <div class="card">
            <h3>Release History</h3>
            <div id="release-history">
                <p>Loading release history...</p>
            </div>
        </div>
        
        <!-- Rollout Controls Modal -->
        <div id="rollout-modal" class="modal" style="display: none;">
            <div class="modal-content">
                <h3>Deploy to Production</h3>
                <div class="form-group">
                    <label for="rollout-percentage">Rollout Percentage (0-100%)</label>
                    <input type="range" id="rollout-percentage" min="0" max="100" value="0" 
                           oninput="document.getElementById('rollout-value').textContent = this.value + '%'">
                    <div id="rollout-value" style="color: #4CAF50; font-weight: bold;">0%</div>
                    <p style="color: #888; font-size: 14px;">
                        0% = No rollout, 100% = All users receive update immediately
                    </p>
                </div>
                
                <div class="form-group">
                    <label>
                        <input type="checkbox" id="force-update"> Force Update
                    </label>
                    <p style="color: #888; font-size: 14px;">
                        Users will be required to update before using the app
                    </p>
                </div>
                
                <div style="display: flex; gap: 10px; margin-top: 20px;">
                    <button class="btn btn-primary" onclick="deployToProduction()">Deploy</button>
                    <button class="btn btn-secondary" onclick="closeRolloutModal()">Cancel</button>
                </div>
            </div>
        </div>
        
        <!-- Force Update Modal -->
        <div id="force-modal" class="modal" style="display: none;">
            <div class="modal-content">
                <h3>Force Update Control</h3>
                <p id="force-modal-message"></p>
                <div style="display: flex; gap: 10px; margin-top: 20px;">
                    <button class="btn btn-warning" onclick="confirmForceAction()">Confirm</button>
                    <button class="btn btn-secondary" onclick="closeForceModal()">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    
    <style>
        .upload-box {{
            border: 2px dashed #4CAF50;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            background: rgba(76, 175, 80, 0.1);
        }}
        
        .upload-box h4 {{
            margin-top: 0;
            color: #4CAF50;
        }}
        
        .modal {{
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            z-index: 1000;
            display: flex;
            justify-content: center;
            align-items: center;
        }}
        
        .modal-content {{
            background: #2d2d2d;
            padding: 30px;
            border-radius: 12px;
            max-width: 500px;
            width: 90%;
            border: 1px solid #4CAF50;
        }}
        
        .release-card {{
            border: 1px solid #333;
            border-radius: 8px;
            padding: 20px;
            margin: 10px 0;
            background: rgba(45, 45, 45, 0.5);
        }}
        
        .release-header {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }}
        
        .version-badge {{
            background: #4CAF50;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: bold;
        }}
        
        .status-badge {{
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }}
        
        .status-staging {{ background: #ff9800; color: white; }}
        .status-production {{ background: #4CAF50; color: white; }}
        .status-archived {{ background: #666; color: white; }}
        
        .file-info {{
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin: 15px 0;
        }}
        
        .file-item {{
            background: rgba(76, 175, 80, 0.1);
            padding: 10px;
            border-radius: 6px;
            border-left: 3px solid #4CAF50;
        }}
        
        .controls {{
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 15px;
        }}
        
        .progress-bar {{
            width: 100%;
            height: 20px;
            background: #333;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }}
        
        .progress-fill {{
            height: 100%;
            background: linear-gradient(90deg, #4CAF50, #8BC34A);
            transition: width 0.3s ease;
        }}
    </style>
    
    <script>
        const token = localStorage.getItem('admin_token');
        if (!token) window.location.href = '/admin';
        
        let currentReleaseId = null;
        let currentAction = null;
        
        // File upload handlers
        document.getElementById('vault-file').addEventListener('change', function(e) {{
            const file = e.target.files[0];
            if (file) {{
                document.getElementById('vault-file-info').textContent = 
                    file.name + ' (' + formatFileSize(file.size) + ')';
            }}
        }});
        
        document.getElementById('setup-file').addEventListener('change', function(e) {{
            const file = e.target.files[0];
            if (file) {{
                document.getElementById('setup-file-info').textContent = 
                    file.name + ' (' + formatFileSize(file.size) + ')';
            }}
        }});
        
        // Upload form handler
        document.getElementById('upload-form').addEventListener('submit', async function(e) {{
            e.preventDefault();
            
            const formData = new FormData();
            const vaultFile = document.getElementById('vault-file').files[0];
            const setupFile = document.getElementById('setup-file').files[0];
            const version = document.getElementById('version').value;
            const releaseNotes = document.getElementById('release-notes').value;
            
            if (!vaultFile && !setupFile) {{
                alert('Please select at least one file to upload');
                return;
            }}
            
            if (vaultFile) formData.append('vault_file', vaultFile);
            if (setupFile) formData.append('vault_setup_file', setupFile);
            formData.append('version', version);
            formData.append('release_notes', releaseNotes);
            
            try {{
                document.getElementById('upload-status').innerHTML = 
                    '<div style="color: #ff9800;">Uploading files...</div>';
                
                const response = await fetch('/admin/releases/upload-dual', {{
                    method: 'POST',
                    headers: {{ 'Authorization': 'Bearer ' + token }},
                    body: formData
                }});
                
                const result = await response.json();
                
                if (response.ok) {{
                    document.getElementById('upload-status').innerHTML = 
                        '<div style="color: #4CAF50;">✅ ' + result.message + '</div>';
                    loadReleases();
                    // Reset form
                    document.getElementById('upload-form').reset();
                    document.getElementById('vault-file-info').textContent = '';
                    document.getElementById('setup-file-info').textContent = '';
                }} else {{
                    throw new Error(result.detail || 'Upload failed');
                }}
            }} catch (error) {{
                document.getElementById('upload-status').innerHTML = 
                    '<div style="color: #f44336;">❌ Error: ' + error.message + '</div>';
            }}
        }});
        
        async function loadReleases() {{
            try {{
                const response = await fetch('/admin/releases/enhanced-list', {{
                    headers: {{ 'Authorization': 'Bearer ' + token }}
                }});
                
                if (response.ok) {{
                    const data = await response.json();
                    displayReleases(data.releases, data.config);
                }} else {{
                    throw new Error('Failed to load releases');
                }}
            }} catch (error) {{
                console.error('Error loading releases:', error);
            }}
        }}
        
        function displayReleases(releases, config) {{
            const staging = releases.filter(r => r.status === 'staging');
            const production = releases.filter(r => r.status === 'production');
            const archived = releases.filter(r => r.status === 'archived');
            
            // Display staging releases
            const stagingHtml = staging.length > 0 ? 
                staging.map(release => createReleaseCard(release, 'staging')).join('') :
                '<p>No staging releases</p>';
            document.getElementById('staging-releases').innerHTML = stagingHtml;
            
            // Display production release
            const productionHtml = production.length > 0 ?
                production.map(release => createReleaseCard(release, 'production')).join('') :
                '<p>No production release</p>';
            document.getElementById('production-release').innerHTML = productionHtml;
            
            // Display archived releases
            const archivedHtml = archived.length > 0 ?
                archived.slice(0, 10).map(release => createReleaseCard(release, 'archived')).join('') :
                '<p>No archived releases</p>';
            document.getElementById('release-history').innerHTML = archivedHtml;
        }}
        
        function createReleaseCard(release, type) {{
            const hasVault = release.vault_exe_exists;
            const hasSetup = release.vault_setup_exe_exists;
            const rolloutPercentage = release.rollout_percentage || 0;
            
            return `
                <div class="release-card">
                    <div class="release-header">
                        <div>
                            <span class="version-badge">${{release.version}}</span>
                            <span class="status-badge status-${{type}}">${{type.toUpperCase()}}</span>
                            ${{release.force_update ? '<span class="status-badge" style="background: #f44336;">FORCED</span>' : ''}}
                            ${{release.force_rollback ? '<span class="status-badge" style="background: #ff5722;">ROLLBACK</span>' : ''}}
                        </div>
                        <div style="color: #888; font-size: 14px;">
                            ${{formatDate(release.uploaded_at)}}
                        </div>
                    </div>
                    
                    ${{type === 'production' && rolloutPercentage < 100 ? `
                        <div>
                            <div style="color: #ff9800; font-weight: bold; margin-bottom: 5px;">
                                Rollout: ${{rolloutPercentage}}%
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${{rolloutPercentage}}%;"></div>
                            </div>
                        </div>
                    ` : ''}}
                    
                    <div class="file-info">
                        <div class="file-item">
                            <strong>Vault.exe</strong><br>
                            ${{hasVault ? 
                                '✅ ' + formatFileSize(release.vault_exe_size) : 
                                '❌ Not uploaded'
                            }}
                        </div>
                        <div class="file-item">
                            <strong>VaultSetup.exe</strong><br>
                            ${{hasSetup ? 
                                '✅ ' + formatFileSize(release.vault_setup_exe_size) : 
                                '❌ Not uploaded'
                            }}
                        </div>
                    </div>
                    
                    ${{release.release_notes ? `
                        <div style="margin: 15px 0; padding: 10px; background: rgba(76, 175, 80, 0.1); border-radius: 6px;">
                            <strong>Release Notes:</strong><br>
                            ${{release.release_notes}}
                        </div>
                    ` : ''}}
                    
                    <div class="controls">
                        ${{getControlButtons(release, type)}}
                    </div>
                </div>
            `;
        }}
        
        function getControlButtons(release, type) {{
            let buttons = [];
            
            if (type === 'staging') {{
                buttons.push('<button class="btn btn-primary" onclick="openRolloutModal(' + release.id + ')">Deploy to Production</button>');
                buttons.push('<button class="btn btn-danger" onclick="deleteRelease(' + release.id + ')">Delete</button>');
            }}
            
            if (type === 'production') {{
                if (release.rollout_percentage < 100) {{
                    buttons.push('<button class="btn btn-warning" onclick="updateRollout(' + release.id + ', 100)">Complete Rollout (100%)</button>');
                    buttons.push('<button class="btn btn-secondary" onclick="updateRollout(' + release.id + ', 50)">50% Rollout</button>');
                }}
                
                buttons.push('<button class="btn ' + (release.force_update ? 'btn-secondary' : 'btn-warning') + '" onclick="toggleForceUpdate(' + release.id + ', ' + (!release.force_update) + ')">' + (release.force_update ? 'Disable Force Update' : 'Force Update') + '</button>');
            }}
            
            if (type === 'archived') {{
                buttons.push('<button class="btn btn-warning" onclick="rollbackToVersion(' + release.id + ')">Rollback to This</button>');
            }}
            
            return buttons.join('');
        }}
        
        function openRolloutModal(releaseId) {{
            currentReleaseId = releaseId;
            document.getElementById('rollout-modal').style.display = 'flex';
        }}
        
        function closeRolloutModal() {{
            document.getElementById('rollout-modal').style.display = 'none';
            currentReleaseId = null;
        }}
        
        async function deployToProduction() {{
            if (!currentReleaseId) return;
            
            const rolloutPercentage = document.getElementById('rollout-percentage').value;
            const forceUpdate = document.getElementById('force-update').checked;
            
            try {{
                const response = await fetch('/admin/releases/deploy-to-production', {{
                    method: 'POST',
                    headers: {{
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify({{
                        release_id: currentReleaseId,
                        rollout_percentage: parseInt(rolloutPercentage),
                        force_update: forceUpdate
                    }})
                }});
                
                if (response.ok) {{
                    const result = await response.json();
                    alert('✅ ' + result.message);
                    loadReleases();
                    closeRolloutModal();
                }} else {{
                    const error = await response.json();
                    throw new Error(error.detail || 'Deployment failed');
                }}
            }} catch (error) {{
                alert('❌ Error: ' + error.message);
            }}
        }}
        
        async function updateRollout(releaseId, percentage) {{
            if (!confirm('Update rollout to ' + percentage + '%?')) return;
            
            try {{
                const response = await fetch('/admin/releases/update-rollout', {{
                    method: 'POST',
                    headers: {{
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify({{
                        release_id: releaseId,
                        rollout_percentage: percentage
                    }})
                }});
                
                if (response.ok) {{
                    loadReleases();
                }} else {{
                    throw new Error('Failed to update rollout');
                }}
            }} catch (error) {{
                alert('❌ Error: ' + error.message);
            }}
        }}
        
        function toggleForceUpdate(releaseId, enable) {{
            currentReleaseId = releaseId;
            currentAction = {{ type: 'force_update', enable: enable }};
            
            document.getElementById('force-modal-message').textContent = 
                enable ? 
                'This will force ALL users to update before they can use the app. Continue?' :
                'This will remove the forced update requirement. Continue?';
            
            document.getElementById('force-modal').style.display = 'flex';
        }}
        
        function rollbackToVersion(releaseId) {{
            currentReleaseId = releaseId;
            currentAction = {{ type: 'rollback' }};
            
            document.getElementById('force-modal-message').textContent = 
                'This will rollback the production version and may force users to downgrade. Continue?';
            
            document.getElementById('force-modal').style.display = 'flex';
        }}
        
        function closeForceModal() {{
            document.getElementById('force-modal').style.display = 'none';
            currentReleaseId = null;
            currentAction = null;
        }}
        
        async function confirmForceAction() {{
            if (!currentReleaseId || !currentAction) return;
            
            try {{
                let endpoint, body;
                
                if (currentAction.type === 'force_update') {{
                    endpoint = '/admin/releases/force-update';
                    body = {{
                        release_id: currentReleaseId,
                        force_update: currentAction.enable
                    }};
                }} else if (currentAction.type === 'rollback') {{
                    endpoint = '/admin/releases/rollback';
                    body = {{
                        release_id: currentReleaseId,
                        force_rollback: true
                    }};
                }}
                
                const response = await fetch(endpoint, {{
                    method: 'POST',
                    headers: {{
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    }},
                    body: JSON.stringify(body)
                }});
                
                if (response.ok) {{
                    const result = await response.json();
                    alert('✅ ' + result.message);
                    loadReleases();
                    closeForceModal();
                }} else {{
                    const error = await response.json();
                    throw new Error(error.detail || 'Action failed');
                }}
            }} catch (error) {{
                alert('❌ Error: ' + error.message);
            }}
        }}
        
        async function deleteRelease(releaseId) {{
            if (!confirm('Delete this release? This cannot be undone.')) return;
            
            try {{
                const response = await fetch('/admin/releases/' + releaseId, {{
                    method: 'DELETE',
                    headers: {{ 'Authorization': 'Bearer ' + token }}
                }});
                
                if (response.ok) {{
                    loadReleases();
                }} else {{
                    throw new Error('Failed to delete release');
                }}
            }} catch (error) {{
                alert('❌ Error: ' + error.message);
            }}
        }}
        
        function formatFileSize(bytes) {{
            if (!bytes) return '0 B';
            const k = 1024;
            const sizes = ['B', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }}
        
        function formatDate(dateString) {{
            if (!dateString) return 'Unknown';
            return new Date(dateString).toLocaleString();
        }}
        
        function logout() {{
            localStorage.removeItem('admin_token');
            window.location.href = '/admin';
        }}
        
        // Load releases on page load
        loadReleases();
    </script>
    ''' + LOGOUT_SCRIPT
