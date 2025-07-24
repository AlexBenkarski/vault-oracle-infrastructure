"""
Database connection and initialization functions
"""
from datetime import datetime
import sqlite3
import hashlib
from typing import Optional, Dict, List
from .config import DB_PATH, USERS_DB_PATH

def get_db_connection():
    """Get database connection for beta keys"""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def get_users_db_connection():
    """Get database connection for user management"""
    conn = sqlite3.connect(USERS_DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_user_database():
    """Initialize user authentication database"""
    conn = sqlite3.connect(USERS_DB_PATH)
    
    # Create users table
    conn.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            email TEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            email_verified BOOLEAN DEFAULT TRUE,
            has_beta BOOLEAN DEFAULT FALSE,
            verification_token TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            last_login TIMESTAMP
        )
    ''')
    
    # Create admin users table
    conn.execute('''
        CREATE TABLE IF NOT EXISTS admin_users (
            id INTEGER PRIMARY KEY,
            username TEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            email TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            last_login TIMESTAMP
        )
    ''')
    
    # Create beta keys table
    conn.execute('''
        CREATE TABLE IF NOT EXISTS beta_keys (
            id INTEGER PRIMARY KEY,
            key_value TEXT UNIQUE NOT NULL,
            status TEXT DEFAULT 'active',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            used_at TIMESTAMP,
            used_by TEXT
        )
    ''')
    
    # Create file releases table
    conn.execute('''
        CREATE TABLE IF NOT EXISTS file_releases (
            id INTEGER PRIMARY KEY,
            filename TEXT NOT NULL,
            version TEXT NOT NULL,
            file_path TEXT NOT NULL,
            file_size INTEGER,
            status TEXT DEFAULT 'staging',
            uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            activated_at TIMESTAMP
        )
    ''')
    
    # Insert default admin user
    admin_hash = hashlib.sha256("Chance19!".encode()).hexdigest()
    conn.execute('''
        INSERT OR IGNORE INTO admin_users (username, password_hash, email)
        VALUES (?, ?, ?)
    ''', ("admin", admin_hash, "admin@getvaultdesktop.com"))

    conn.commit()
    conn.close()

# Beta key database functions
def find_user_by_beta_key(beta_key: str) -> Optional[Dict]:
    """Find user who owns this beta key"""
    conn = get_db_connection()
    try:
        cursor = conn.execute(
            "SELECT discord_id FROM user_data WHERE key = 'current_beta_key' AND value = ?",
            (beta_key,)
        )
        result = cursor.fetchone()

        if result:
            user_cursor = conn.execute(
                "SELECT * FROM users WHERE discord_id = ?",
                (result[0],)
            )
            user = user_cursor.fetchone()
            if user:
                return dict(user)
    finally:
        conn.close()
    return None

def check_key_status(discord_id: str) -> str:
    """Check if user's beta access is still valid"""
    conn = get_db_connection()
    try:
        cursor = conn.execute(
            "SELECT value FROM user_data WHERE discord_id = ? AND key = 'beta_status'",
            (discord_id,)
        )
        result = cursor.fetchone()
        return result[0] if result else 'active'
    finally:
        conn.close()

def mark_key_as_used(discord_id: str, vault_username: str):
    """Mark beta key as used by storing vault username"""
    conn = get_db_connection()
    try:
        conn.execute(
            "INSERT OR REPLACE INTO user_data (discord_id, key, value) VALUES (?, ?, ?)",
            (discord_id, 'vault_username', vault_username)
        )
        conn.execute(
            "INSERT OR REPLACE INTO user_data (discord_id, key, value) VALUES (?, ?, ?)",
            (discord_id, 'last_used', str(int(datetime.now().timestamp())))
        )
        conn.commit()
    finally:
        conn.close()
