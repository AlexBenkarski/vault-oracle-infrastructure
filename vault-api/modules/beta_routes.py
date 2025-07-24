"""Beta Key Routes - Key validation and management"""

from fastapi import APIRouter, HTTPException, status, Depends
import sqlite3
import secrets
from datetime import datetime
from typing import List, Dict

from auth import verify_admin_token
from config import USER_DB_PATH

router = APIRouter(tags=["beta"])

def generate_beta_key() -> str:
    """Generate a unique beta key in format XXXX-XXXX-XXXX"""
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    groups = []
    for _ in range(3):
        group = ''.join(secrets.choice(chars) for _ in range(4))
        groups.append(group)
    return '-'.join(groups)

# Admin endpoints for beta key management
@router.post("/admin/beta/generate")
async def generate_new_beta_key(admin_user: str = Depends(verify_admin_token)):
    """Generate new beta key for admin"""
    new_key = generate_beta_key()
    
    conn = sqlite3.connect(USER_DB_PATH)
    try:
        conn.execute('''
            INSERT INTO beta_keys (key_value, status, created_at)
            VALUES (?, 'unused', CURRENT_TIMESTAMP)
        ''', (new_key,))
        
        conn.commit()
        return {"key": new_key, "message": "Beta key generated successfully"}
    except sqlite3.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        conn.close()

@router.get("/admin/beta/keys")
async def get_beta_keys(admin_user: str = Depends(verify_admin_token)) -> List[Dict]:
    """Get all beta keys for admin"""
    conn = sqlite3.connect(USER_DB_PATH)
    conn.row_factory = sqlite3.Row
    
    try:
        cursor = conn.execute('''
            SELECT 
                bk.key_value, 
                bk.status, 
                bk.created_at, 
                bk.activated_at,
                u.email as used_by_email
            FROM beta_keys bk
            LEFT JOIN users u ON bk.user_id = u.id
            ORDER BY bk.created_at DESC
        ''')
        
        keys = []
        for row in cursor.fetchall():
            keys.append({
                "key_value": row["key_value"],
                "status": row["status"],
                "created_at": row["created_at"],
                "activated_at": row["activated_at"],
                "used_by_email": row["used_by_email"]
            })
        
        return keys
    except sqlite3.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        conn.close()

@router.post("/admin/beta/revoke")
async def revoke_beta_key(key_data: dict, admin_user: str = Depends(verify_admin_token)):
    """Revoke a beta key"""
    key_value = key_data.get("key_value")
    if not key_value:
        raise HTTPException(status_code=400, detail="key_value is required")
    
    conn = sqlite3.connect(USER_DB_PATH)
    try:
        # Check if key exists
        cursor = conn.execute('SELECT id FROM beta_keys WHERE key_value = ?', (key_value,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail="Beta key not found")
        
        # Revoke the key
        conn.execute('''
            UPDATE beta_keys 
            SET status = 'revoked' 
            WHERE key_value = ?
        ''', (key_value,))
        
        conn.commit()
        return {"message": "Beta key revoked successfully"}
    except sqlite3.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        conn.close()

# Desktop app validation endpoint
@router.post("/validate_key")
async def validate_beta_key(request: dict):
    """Validate beta key for Vault desktop app"""
    beta_key = request.get("beta_key", "").strip().upper()
    username = request.get("username", "").strip()
    
    if not beta_key or not username:
        return {
            "valid": False,
            "message": "Beta key and username are required"
        }
    
    conn = sqlite3.connect(USER_DB_PATH)
    try:
        # Check if key exists and is valid
        cursor = conn.execute('''
            SELECT id, status, user_id 
            FROM beta_keys 
            WHERE key_value = ?
        ''', (beta_key,))
        
        key_row = cursor.fetchone()
        
        if not key_row:
            return {
                "valid": False,
                "message": "Invalid beta key"
            }
        
        key_id, status, user_id = key_row
        
        if status == 'revoked':
            return {
                "valid": False,
                "message": "Beta key has been revoked"
            }
        
        if status == 'used' and user_id:
            # Key already used, check if it's the same user
            cursor = conn.execute('SELECT email FROM users WHERE id = ?', (user_id,))
            user_row = cursor.fetchone()
            if user_row:
                return {
                    "valid": True,
                    "message": "Beta key validated (already registered)",
                    "user_info": {
                        "registered_email": user_row[0],
                        "vault_username": username
                    }
                }
        
        # Key is unused or being revalidated
        return {
            "valid": True,
            "message": "Beta key validated successfully",
            "user_info": {
                "vault_username": username,
                "key_status": status
            }
        }
        
    except sqlite3.Error as e:
        return {
            "valid": False,
            "message": "Validation service temporarily unavailable"
        }
    finally:
        conn.close()
