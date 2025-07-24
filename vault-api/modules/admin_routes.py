"""Admin API Routes - All admin functionality endpoints"""

from fastapi import APIRouter, HTTPException, Depends, UploadFile, File
from fastapi.responses import JSONResponse
import sqlite3
import os
import shutil
from datetime import datetime
from typing import List

from auth import verify_admin_token
from models import UserAction, ReleaseData
from database import get_db_connection
from config import UPLOAD_DIR, USER_DB_PATH

router = APIRouter(prefix="/admin", tags=["admin"])

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

@router.post("/users/beta")
async def toggle_user_beta(action_data: UserAction, admin_user: str = Depends(verify_admin_token)):
    """Grant or revoke beta access for user"""
    conn = sqlite3.connect(USER_DB_PATH)
    
    grant_beta = action_data.action == 'grant'
    
    conn.execute('''
        UPDATE users SET has_beta = ? WHERE id = ?
    ''', (grant_beta, action_data.user_id))
    
    conn.commit()
    conn.close()
    
    return {"message": f"Beta access {'granted' if grant_beta else 'revoked'} successfully"}

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
