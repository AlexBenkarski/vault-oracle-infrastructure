"""Admin API Routes - All admin functionality endpoints"""

from fastapi import APIRouter, HTTPException, Depends, UploadFile, File, Form
from fastapi.responses import JSONResponse
import sqlite3
import os
import shutil
import subprocess
import hashlib
from datetime import datetime
from typing import List

from auth import verify_admin_token, create_access_token
from models import UserAction, ReleaseData, AdminLogin
from database import get_db_connection
from config import UPLOAD_DIR, USER_DB_PATH
from services_monitor import get_all_services_status

router = APIRouter(prefix="/admin", tags=["admin"])

# ADMIN AUTHENTICATION
@router.post("/auth")
async def admin_login(login_data: AdminLogin):
    """Admin authentication endpoint"""
    try:
        # Check credentials against database
        conn = sqlite3.connect(USER_DB_PATH)
        
        # Use SHA256 for admin password (legacy compatibility)
        password_hash = hashlib.sha256(login_data.password.encode()).hexdigest()
        
        cursor = conn.execute('''
            SELECT username, password_hash FROM admin_users 
            WHERE username = ? AND password_hash = ?
        ''', (login_data.username, password_hash))
        
        result = cursor.fetchone()
        
        if not result:
            conn.close()
            raise HTTPException(status_code=401, detail="Invalid credentials")
        
        # Update last login
        conn.execute('''
            UPDATE admin_users SET last_login = CURRENT_TIMESTAMP 
            WHERE username = ?
        ''', (login_data.username,))
        conn.commit()
        conn.close()
        
        # Create JWT token
        token = create_access_token({"sub": login_data.username, "role": "admin"})
        return {"access_token": token, "token_type": "bearer", "message": "Admin login successful"}
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Login error: {str(e)}")

# Add placeholder endpoints for other admin functions
@router.get("/stats")
async def admin_stats(admin_user: str = Depends(verify_admin_token)):
    """Get admin dashboard stats"""
    return {"total_users": 0, "verified_users": 0, "beta_users": 0}

@router.get("/users/data")
async def get_users_data(admin_user: str = Depends(verify_admin_token)):
    """Get all users data for admin"""
    return []

@router.post("/beta/generate")
async def generate_beta_key(admin_user: str = Depends(verify_admin_token)):
    """Generate new beta key"""
    return {"message": "Beta key generation not implemented yet"}
