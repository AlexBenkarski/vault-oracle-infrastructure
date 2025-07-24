import sqlite3
import json
from datetime import datetime

class AnalyticsDB:
    def __init__(self, db_path="database/analytics.db"):
        self.db_path = db_path
        self.init_db()
    
    def init_db(self):
        with sqlite3.connect(self.db_path) as conn:
            conn.execute('''
                CREATE TABLE IF NOT EXISTS users (
                    vault_id TEXT PRIMARY KEY,
                    version TEXT,
                    os TEXT,
                    last_ping TEXT,
                    consent_given BOOLEAN,
                    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
            ''')
            conn.execute('''
                CREATE TABLE IF NOT EXISTS analytics_data (
                    vault_id TEXT,
                    data_type TEXT,
                    data_json TEXT,
                    timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (vault_id) REFERENCES users (vault_id)
                )
            ''')
    
    def upsert_user_data(self, analytics_payload):
        vault_id = analytics_payload["vault_id"]
        with sqlite3.connect(self.db_path) as conn:
            # Store complete analytics payload
            conn.execute('''
                INSERT OR REPLACE INTO users
                (vault_id, version, os, last_ping, consent_given, updated_at)
                VALUES (?, ?, ?, ?, ?, ?)
            ''', (
                vault_id,
                analytics_payload.get("version"),
                analytics_payload.get("os"),
                datetime.now().isoformat(),
                analytics_payload.get("consent_given"),
                datetime.now().isoformat()
            ))
            # Store full payload as JSON
            conn.execute('''
                INSERT INTO analytics_data (vault_id, data_type, data_json)
                VALUES (?, ?, ?)
            ''', (vault_id, "full_analytics", json.dumps(analytics_payload)))
    
    def get_total_users(self):
        """Get total number of analytics users"""
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.execute("SELECT COUNT(*) FROM users")
                result = cursor.fetchone()
                return result[0] if result else 0
        except Exception as e:
            print(f"Error getting total users: {e}")
            return 0
