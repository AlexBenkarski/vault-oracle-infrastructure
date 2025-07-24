"""Beta Key Routes - Key validation and management"""

from fastapi import APIRouter, HTTPException, status, Depends
import sqlite3
import secrets
from datetime import datetime

from auth import verify_admin_token
from models import KeyValidationRequest, KeyValidationResponse
from database import get_db_connection, find_user_by_beta_key, check_key_status, mark_key_as_used
from config import USER_DB_PATH

router = APIRouter(tags=["beta"])

def generate_beta_key() -> str:
    """Generate a unique beta key in format XXXX-XXXX-XXXX"""
    # Generate 3 groups of 4 random uppercase letters/numbers
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    groups = []
    for _ in range(3):
        group = ''.join(secrets.choice(chars) for _ in range(4))
        groups.append(group)
    return '-'.join(groups)

@router.post("/validate_key", response_model=KeyValidationResponse)
async def validate_beta_key(request: KeyValidationRequest):
    """Validate beta key for Vault desktop app"""
    if not request.beta_key or not request.username:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Beta key and username are required"
        )

    # Normalize beta key format
    beta_key = request.beta_key.strip().upper().replace(" ", "-")
    user = find_user_by_beta_key(beta_key)

    if not user:
        return KeyValidationResponse(
            valid=False,
            message="Invalid or unregistered beta key"
        )

    key_status = check_key_status(user['discord_id'])

    if key_status == 'revoked':
        return KeyValidationResponse(
            valid=False,
            message="Beta access has been revoked"
        )

    # Mark key as used
    mark_key_as_used(user['discord_id'], request.username)

    return KeyValidationResponse(
        valid=True,
        message="Beta key validated successfully",
        user_info={
            "discord_user": user['username'],
            "joined_at": user['joined_at'],
            "vault_username": request.username
        }
    )

@router.post("/admin/beta/generate")
async def generate_new_beta_key(admin_user: str = Depends(verify_admin_token)):
    """Generate new beta key for admin"""
    new_key = generate_beta_key()
    
    conn = sqlite3.connect(USER_DB_PATH)
    conn.execute('''
        INSERT INTO beta_keys (key_value, status, created_at)
        VALUES (?, 'unused', CURRENT_TIMESTAMP)
    ''', (new_key,))
    
    conn.commit()
    conn.close()
    
    return {"key": new_key, "message": "Beta key generated successfully"}

@router.get("/admin/beta/keys")
async def get_beta_keys(admin_user: str = Depends(verify_admin_token)):
    """Get all beta keys for admin"""
    conn = sqlite3.connect(USER_DB_PATH)
    conn.row_factory = sqlite3.Row
    
    cursor = conn.execute('''
        SELECT key_value, status, created_at, activated_at,
               (SELECT email FROM users WHERE id = beta_keys.user_id) as used_by_email
        FROM beta_keys ORDER BY created_at DESC
    ''')
    
    keys = [dict(row) for row in cursor.fetchall()]
    conn.close()
    
    return keys

@router.post("/admin/beta/revoke")
async def revoke_beta_key(key_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Revoke a beta key"""
    conn = sqlite3.connect(USER_DB_PATH)
    
    conn.execute('''
        UPDATE beta_keys SET status = 'revoked' WHERE key_value = ?
    ''', (key_data['key_value'],))
    
    conn.commit()
    conn.close()
    
    return {"message": "Beta key revoked successfully"}
