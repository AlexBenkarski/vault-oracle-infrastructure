"""
Data models for Vault API
Contains all Pydantic models and database classes
"""

from pydantic import BaseModel, EmailStr
from typing import Optional, Dict, Any
import sqlite3
import json
from datetime import datetime

# API Request/Response Models
class KeyValidationRequest(BaseModel):
    beta_key: str
    username: str

class KeyValidationResponse(BaseModel):
    valid: bool
    message: str
    user_info: Optional[dict] = None

class AnalyticsPayload(BaseModel):
    vault_id: str
    version: str
    os: str
    consent_given: bool = True
    install_metrics: Dict[str, Any] = {}
    vault_stats: Dict[str, Any] = {}
    feature_usage: Dict[str, Any] = {}
    performance: Dict[str, Any] = {}

class UserSignup(BaseModel):
    email: EmailStr
    password: str

class UserSignin(BaseModel):
    email: EmailStr
    password: str

class AdminLogin(BaseModel):
    username: str
    password: str

class UserAction(BaseModel):
    user_id: int
    action: str  # 'verify', 'grant_beta', 'revoke_beta', 'suspend'

class ReleaseData(BaseModel):
    release_id: int

class BetaKeyData(BaseModel):
    key_value: str

# Analytics Database Class
class AnalyticsDB:
    """Analytics database handler"""
    
    def __init__(self, db_path: str):
        self.db_path = db_path
        self.init_database()
    
    def init_database(self):
        """Initialize analytics database tables"""
        conn = sqlite3.connect(self.db_path)
        conn.execute('''
            CREATE TABLE IF NOT EXISTS analytics_data (
                id INTEGER PRIMARY KEY,
                vault_id TEXT UNIQUE NOT NULL,
                version TEXT,
                os TEXT,
                consent_given BOOLEAN DEFAULT TRUE,
                install_metrics TEXT,
                vault_stats TEXT,
                feature_usage TEXT,
                performance TEXT,
                last_ping DATE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()
        conn.close()
    
    def upsert_user_data(self, data: dict):
        """Insert or update user analytics data"""
        conn = sqlite3.connect(self.db_path)
        
        # Convert dict fields to JSON
        install_metrics = json.dumps(data.get('install_metrics', {}))
        vault_stats = json.dumps(data.get('vault_stats', {}))
        feature_usage = json.dumps(data.get('feature_usage', {}))
        performance = json.dumps(data.get('performance', {}))
        
        conn.execute('''
            INSERT OR REPLACE INTO analytics_data 
            (vault_id, version, os, consent_given, install_metrics, vault_stats, 
             feature_usage, performance, last_ping, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
        ''', (
            data['vault_id'],
            data.get('version', 'Unknown'),
            data.get('os', 'Unknown'),
            data.get('consent_given', True),
            install_metrics,
            vault_stats,
            feature_usage,
            performance,
            data.get('last_ping', datetime.now().strftime("%Y-%m-%d"))
        ))
        
        conn.commit()
        conn.close()
    
    def get_total_users(self) -> int:
        """Get total number of analytics users"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.execute('SELECT COUNT(*) FROM analytics_data')
        result = cursor.fetchone()[0]
        conn.close()
        return result
    
    def get_analytics_summary(self) -> dict:
        """Get analytics summary for admin dashboard"""
        conn = sqlite3.connect(self.db_path)
        
        # Total users
        cursor = conn.execute('SELECT COUNT(*) FROM analytics_data')
        total_users = cursor.fetchone()[0]
        
        # Users with consent
        cursor = conn.execute('SELECT COUNT(*) FROM analytics_data WHERE consent_given = TRUE')
        consent_given = cursor.fetchone()[0]
        
        # Recent activity (last 7 days)
        cursor = conn.execute('''
            SELECT COUNT(*) FROM analytics_data 
            WHERE last_ping >= date('now', '-7 days')
        ''')
        active_recent = cursor.fetchone()[0]
        
        # OS distribution
        cursor = conn.execute('''
            SELECT os, COUNT(*) as count 
            FROM analytics_data 
            GROUP BY os 
            ORDER BY count DESC
        ''')
        os_data = cursor.fetchall()
        
        conn.close()
        
        return {
            "total_users": total_users,
            "consent_given": consent_given,
            "active_recent": active_recent,
            "os_distribution": dict(os_data)
        }
    
    def get_all_users_summary(self) -> list:
        """Get summary of all analytics users"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.execute('''
            SELECT vault_id, version, os, last_ping, created_at
            FROM analytics_data 
            ORDER BY updated_at DESC
        ''')
        
        users = []
        for row in cursor.fetchall():
            users.append({
                "vault_id": row[0],
                "version": row[1],
                "os": row[2],
                "last_ping": row[3],
                "created_at": row[4]
            })
        
        conn.close()
        return users
