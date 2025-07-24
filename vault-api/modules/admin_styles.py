"""Shared CSS styles for admin pages"""

ADMIN_STYLES = '''
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
        color: white;
        line-height: 1.6;
        min-height: 100vh;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 20px 0;
        border-bottom: 2px solid #4CAF50;
    }
    
    .header h1 {
        color: #4CAF50;
        font-size: 2.5em;
        font-weight: 300;
    }
    
    .nav {
        display: flex;
        gap: 30px;
        margin-bottom: 40px;
        border-bottom: 1px solid #333;
        padding-bottom: 10px;
    }
    
    .nav a {
        color: #ccc;
        text-decoration: none;
        padding: 15px 20px;
        border-bottom: 3px solid transparent;
        transition: all 0.3s ease;
        font-weight: 500;
    }
    
    .nav a:hover, .nav a.active {
        color: #4CAF50;
        border-bottom-color: #4CAF50;
        transform: translateY(-2px);
    }
    
    .card {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border-radius: 12px;
        padding: 30px;
        margin: 25px 0;
        border: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
        margin: 30px 0;
    }
    
    .stat-card {
        background: linear-gradient(135deg, rgba(76, 175, 80, 0.1), rgba(76, 175, 80, 0.05));
        border: 2px solid #4CAF50;
        border-radius: 12px;
        padding: 25px;
        text-align: center;
        transition: transform 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
    }
    
    .service-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin: 20px 0;
    }
    
    .service-card {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 8px;
        padding: 20px;
        border-left: 4px solid #4CAF50;
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .status-indicator {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: #4CAF50;
        animation: pulse 2s infinite;
    }
    
    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }
    
    .btn-primary {
        background: #4CAF50;
        color: white;
    }
    
    .btn-danger {
        background: #f44336;
        color: white;
    }
    
    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    }
    
    @keyframes pulse {
        0% { opacity: 1; }
        50% { opacity: 0.5; }
        100% { opacity: 1; }
    }
</style>
'''

def get_nav_html(active_page):
    """Generate navigation HTML with active page highlighted"""
    pages = [
        ('dashboard', 'Dashboard'),
        ('users', 'Users'),
        ('beta', 'Beta Keys'),
        ('releases', 'Releases'),
        ('analytics', 'Analytics')
    ]
    
    nav_items = []
    for page_id, page_name in pages:
        class_attr = 'class="active"' if page_id == active_page else ''
        nav_items.append(f'<a href="/admin/{page_id}" {class_attr}>{page_name}</a>')
    
    return f'<div class="nav">{"".join(nav_items)}</div>'

LOGOUT_SCRIPT = '''
<script>
    function logout() {
        localStorage.removeItem('admin_token');
        window.location.href = '/admin';
    }
</script>
'''
