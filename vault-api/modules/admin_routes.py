"""Admin API Routes - All admin functionality endpoints"""

from fastapi import APIRouter, HTTPException, Depends, UploadFile, File, Form
from fastapi.responses import JSONResponse, Response
import sqlite3
import os
import shutil
import subprocess
import hashlib
import csv
import io
import bcrypt
from datetime import datetime
from typing import List

from auth import verify_admin_token, create_access_token
from models import UserAction, ReleaseData, AdminLogin
from database import get_db_connection
from config import UPLOAD_DIR, USER_DB_PATH
from services_monitor import get_all_services_status

router = APIRouter(prefix="/admin", tags=["admin"])

def hash_password(password: str) -> str:
    """Hash password using bcrypt"""
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

def verify_password(password: str, hashed: str) -> bool:
    """Verify password against hash"""
    try:
        return bcrypt.checkpw(password.encode('utf-8'), hashed.encode('utf-8'))
    except:
        return False

# ADMIN AUTHENTICATION
@router.post("/auth")
async def admin_login(login_data: AdminLogin):
    """Admin authentication endpoint"""
    try:
        # Check credentials against database
        conn = sqlite3.connect(USER_DB_PATH)
        
        cursor = conn.execute('''
            SELECT username, password_hash FROM admin_users 
            WHERE username = ?
        ''', (login_data.username,))
        
        result = cursor.fetchone()
        
        if not result:
            conn.close()
            raise HTTPException(status_code=401, detail="Invalid credentials")
        
        username, stored_hash = result
        
        # Try both bcrypt and SHA256 for backward compatibility
        password_valid = False
        
        # First try bcrypt (preferred)
        if stored_hash.startswith('$2b$'):
            password_valid = verify_password(login_data.password, stored_hash)
        else:
            # Try SHA256 (legacy)
            sha256_hash = hashlib.sha256(login_data.password.encode()).hexdigest()
            password_valid = (stored_hash == sha256_hash)
        
        if not password_valid:
            conn.close()
            raise HTTPException(status_code=401, detail="Invalid credentials")
        
        # Update last login
        conn.execute('''
            UPDATE admin_users SET last_login = CURRENT_TIMESTAMP 
            WHERE username = ?
        ''', (login_data.username,))
        conn.commit()
        conn.close()
        
        # Create JWT token with admin role
        token = create_access_token({"sub": login_data.username, "role": "admin"})
        
        return {
            "access_token": token, 
            "token_type": "bearer", 
            "message": "Admin login successful"
        }
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Login error: {str(e)}")

# DASHBOARD STATISTICS
@router.get("/stats")
async def get_admin_stats(admin_user: str = Depends(verify_admin_token)):
    """Get dashboard statistics"""
    # User stats from local DB
    conn = sqlite3.connect(USER_DB_PATH)
    
    cursor = conn.execute("SELECT COUNT(*) FROM users")
    total_users = cursor.fetchone()[0]
    
    cursor = conn.execute("SELECT COUNT(*) FROM users WHERE email_verified = TRUE")
    verified_users = cursor.fetchone()[0]
    
    cursor = conn.execute("SELECT COUNT(*) FROM users WHERE has_beta = TRUE")
    beta_users_local = cursor.fetchone()[0]
    
    conn.close()
    
    # Beta users from Discord bot DB
    try:
        bot_conn = get_db_connection()
        cursor = bot_conn.execute("SELECT COUNT(DISTINCT discord_id) FROM users")
        result = cursor.fetchone()
        beta_users_discord = result[0] if result else 0
        bot_conn.close()
    except:
        beta_users_discord = 0
    
    # Analytics users (will import analytics_db when available)
    analytics_users = 0  # Placeholder for now
    
    return {
        "total_users": total_users,
        "verified_users": verified_users,
        "beta_users": beta_users_local + beta_users_discord,
        "analytics_users": analytics_users
    }

# USER MANAGEMENT
@router.get("/users/data")
async def get_users_data(admin_user: str = Depends(verify_admin_token)):
    """Get all users data for management"""
    conn = sqlite3.connect(USER_DB_PATH)
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT id, email, email_verified, has_beta, created_at, last_login
        FROM users ORDER BY created_at DESC
    ''')
    
    users = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return users

@router.get("/users/admins")
async def get_admin_users(admin_user: str = Depends(verify_admin_token)):
    """Get list of admin users"""
    conn = sqlite3.connect(USER_DB_PATH)
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT username, created_at, last_login
        FROM admin_users ORDER BY created_at DESC
    ''')
    
    admins = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return admins

@router.post("/users/beta")
async def toggle_user_beta(action_data: UserAction, admin_user: str = Depends(verify_admin_token)):
    """Grant or revoke beta access for user"""
    conn = sqlite3.connect(USER_DB_PATH)
    
    grant_beta = action_data.action == 'grant'
    
    conn.execute('''
        UPDATE users SET has_beta = ?
        WHERE id = ?
    ''', (grant_beta, action_data.user_id))
    
    conn.commit()
    conn.close()
    
    return {"message": f"Beta access {'granted' if grant_beta else 'revoked'} successfully"}

@router.delete("/users/delete")
async def delete_user(user_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Delete a user account permanently"""
    user_id = user_data.get('user_id')
    email = user_data.get('email')
    
    if not user_id or not email:
        raise HTTPException(status_code=400, detail="User ID and email required")
    
    conn = sqlite3.connect(USER_DB_PATH)
    
    # Verify user exists
    cursor = conn.execute('SELECT id, email FROM users WHERE id = ? AND email = ?', 
                         (user_id, email))
    result = cursor.fetchone()
    
    if not result:
        conn.close()
        raise HTTPException(status_code=404, detail="User not found")
    
    # Also remove from admin_users if they are an admin
    conn.execute('DELETE FROM admin_users WHERE username = ?', (email,))
    
    # Delete user
    conn.execute('DELETE FROM users WHERE id = ? AND email = ?', (user_id, email))
    conn.commit()
    conn.close()
    
    return {"message": f"User {email} deleted successfully"}

@router.post("/users/make-admin")
async def make_user_admin(user_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Grant admin access to a user"""
    user_id = user_data.get('user_id')
    email = user_data.get('email')
    
    if not user_id or not email:
        raise HTTPException(status_code=400, detail="User ID and email required")
    
    conn = sqlite3.connect(USER_DB_PATH)
    
    # Verify user exists
    cursor = conn.execute('SELECT id, email, password_hash FROM users WHERE id = ? AND email = ?', 
                         (user_id, email))
    result = cursor.fetchone()
    
    if not result:
        conn.close()
        raise HTTPException(status_code=404, detail="User not found")
    
    user_id, user_email, password_hash = result
    
    # Check if already admin
    cursor = conn.execute('SELECT username FROM admin_users WHERE username = ?', (user_email,))
    if cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=400, detail="User already has admin access")
    
    # Add to admin_users table using their existing password hash (which should be bcrypt)
    conn.execute('''
        INSERT INTO admin_users (username, password_hash, created_at)
        VALUES (?, ?, CURRENT_TIMESTAMP)
    ''', (user_email, password_hash))
    
    conn.commit()
    conn.close()
    
    return {"message": f"Admin access granted to {user_email}"}

@router.post("/users/revoke-admin")
async def revoke_user_admin(user_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Revoke admin access from a user"""
    user_id = user_data.get('user_id')
    email = user_data.get('email')
    
    if not user_id or not email:
        raise HTTPException(status_code=400, detail="User ID and email required")
    
    # Prevent revoking access from the main admin account
    if email == "admin":
        raise HTTPException(status_code=400, detail="Cannot revoke access from main admin account")
    
    conn = sqlite3.connect(USER_DB_PATH)
    
    # Verify user exists and is admin
    cursor = conn.execute('SELECT username FROM admin_users WHERE username = ?', (email,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="User is not an admin")
    
    # Remove from admin_users table
    conn.execute('DELETE FROM admin_users WHERE username = ?', (email,))
    conn.commit()
    conn.close()
    
    return {"message": f"Admin access revoked from {email}"}

@router.get("/users/export")
async def export_users(admin_user: str = Depends(verify_admin_token)):
    """Export users data as CSV"""
    conn = sqlite3.connect(USER_DB_PATH)
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT id, email, email_verified, has_beta, created_at, last_login
        FROM users ORDER BY created_at DESC
    ''')
    
    users = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    # Create CSV content
    output = io.StringIO()
    writer = csv.DictWriter(output, fieldnames=['id', 'email', 'email_verified', 'has_beta', 'created_at', 'last_login'])
    writer.writeheader()
    writer.writerows(users)
    
    csv_content = output.getvalue()
    output.close()
    
    return Response(
        content=csv_content,
        media_type="text/csv",
        headers={"Content-Disposition": "attachment; filename=vault-users.csv"}
    )

# RELEASE MANAGEMENT
@router.post("/releases/upload")
async def upload_release(
    file: UploadFile = File(...),
    version: str = None,
    admin_user: str = Depends(verify_admin_token)
):
    """Upload new Vault.exe release"""
    if not file.filename.endswith('.exe'):
        raise HTTPException(status_code=400, detail="Only .exe files allowed")
    
    # Save to staging directory
    staging_path = f"{UPLOAD_DIR}/staging/{file.filename}"
    with open(staging_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    
    file_size = os.path.getsize(staging_path)
    
    # Save to database
    conn = sqlite3.connect(USER_DB_PATH)
    conn.execute('''
        INSERT INTO file_releases (filename, version, file_path, file_size, status)
        VALUES (?, ?, ?, ?, 'staging')
    ''', (file.filename, version or "Unknown", staging_path, file_size))
    
    conn.commit()
    conn.close()
    
    return {"message": "File uploaded successfully", "filename": file.filename}

@router.get("/releases/list")
async def get_releases(admin_user: str = Depends(verify_admin_token)):
    """Get all releases"""
    conn = sqlite3.connect(USER_DB_PATH)
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT id, filename, version, file_size, status, uploaded_at, activated_at
        FROM file_releases ORDER BY uploaded_at DESC
    ''')
    
    releases = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return releases

@router.post("/releases/activate")
async def activate_release(release_data: ReleaseData, admin_user: str = Depends(verify_admin_token)):
    """Move release from staging to production"""
    conn = sqlite3.connect(USER_DB_PATH)
    
    # Get file info
    cursor = conn.execute('SELECT file_path, filename FROM file_releases WHERE id = ?', 
                         (release_data.release_id,))
    result = cursor.fetchone()
    
    if not result:
        raise HTTPException(status_code=404, detail="Release not found")
    
    staging_path, filename = result
    current_path = f"{UPLOAD_DIR}/current/{filename}"
    
    # Move file from staging to current
    shutil.move(staging_path, current_path)
    
    # Update database
    conn.execute('''
        UPDATE file_releases 
        SET status = 'active', file_path = ?, activated_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ''', (current_path, release_data.release_id))
    
    conn.commit()
    conn.close()
    
    return {"message": "Release activated successfully"}

@router.post("/releases/delete")
async def delete_release(release_data: ReleaseData, admin_user: str = Depends(verify_admin_token)):
    """Delete a release"""
    conn = sqlite3.connect(USER_DB_PATH)
    
    # Get file path
    cursor = conn.execute('SELECT file_path FROM file_releases WHERE id = ?', 
                         (release_data.release_id,))
    result = cursor.fetchone()
    
    if result:
        file_path = result[0]
        # Delete file
        try:
            os.remove(file_path)
        except:
            pass
    
    # Delete from database
    conn.execute('DELETE FROM file_releases WHERE id = ?', (release_data.release_id,))
    conn.commit()
    conn.close()
    
    return {"message": "Release deleted successfully"}

# SERVICE MONITORING ENDPOINTS
@router.get("/services/status")
async def get_services_status(admin_user: str = Depends(verify_admin_token)):
    """Get status of all monitored services"""
    return get_all_services_status()

@router.post("/services/start/{service_name}")
async def start_service(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Start a systemd service"""
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

@router.post("/services/stop/{service_name}")
async def stop_service(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Stop a systemd service"""
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

@router.post("/services/restart/{service_name}")
async def restart_service(service_name: str, admin_user: str = Depends(verify_admin_token)):
    """Restart a systemd service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        raise HTTPException(status_code=400, detail="Service not allowed")
    
    try:
        result = subprocess.run(['sudo', 'systemctl', 'restart', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "restarted", "service": service_name}
        else:
            raise HTTPException(status_code=500, detail=result.stderr)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
