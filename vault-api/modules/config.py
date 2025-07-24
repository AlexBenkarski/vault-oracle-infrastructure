"""
Configuration module for Vault API
Contains all constants, paths, and configuration settings
"""
import os

# JWT Configuration
SECRET_KEY = "vault-secret-key-change-in-production"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_HOURS = 24

# Database paths
DB_PATH = "/opt/discord-bot/bot_data.db"
USERS_DB_PATH = "/opt/vault-api/users.db"
ANALYTICS_DB_PATH = "/opt/vault-api/analytics.db"

# File upload configuration
UPLOAD_DIR = "/opt/vault-files"
UPLOAD_DIRS = {
    "staging": f"{UPLOAD_DIR}/staging",
    "current": f"{UPLOAD_DIR}/current", 
    "archive": f"{UPLOAD_DIR}/archive"
}

# CORS Configuration
ALLOWED_ORIGINS = [
    "https://getvaultdesktop.com",
    "http://localhost:3000"
]

# Admin credentials (legacy)
DEFAULT_ADMIN_USERNAME = "admin"
DEFAULT_ADMIN_PASSWORD = "Chance19!"

# Initialize upload directories
def init_upload_dirs():
    """Create upload directories if they don't exist"""
    for dir_path in UPLOAD_DIRS.values():
        os.makedirs(dir_path, exist_ok=True)

# Service names for monitoring
ALLOWED_SERVICES = ['vault-api', 'nginx', 'discord-bot']
