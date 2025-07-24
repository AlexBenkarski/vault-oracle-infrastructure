import sqlite3
import json
from datetime import datetime

class BotDatabase:
    def __init__(self, db_path='bot_data.db'):
        self.db_path = db_path
        
    def get_connection(self):
        return sqlite3.connect(self.db_path)
    
    def add_user(self, discord_id, username):
        conn = self.get_connection()
        conn.execute('''
            INSERT OR REPLACE INTO users (discord_id, username, last_active) 
            VALUES (?, ?, ?)
        ''', (str(discord_id), username, datetime.now()))
        conn.commit()
        conn.close()
    
    def get_user_data(self, discord_id, key):
        conn = self.get_connection()
        cursor = conn.execute(
            'SELECT value FROM user_data WHERE discord_id = ? AND key = ?',
            (str(discord_id), key)
        )
        result = cursor.fetchone()
        conn.close()
        return result[0] if result else None
    
    def set_user_data(self, discord_id, key, value):
        conn = self.get_connection()
        conn.execute('''
            INSERT OR REPLACE INTO user_data (discord_id, key, value) 
            VALUES (?, ?, ?)
        ''', (str(discord_id), key, str(value)))
        conn.commit()
        conn.close()
    
    def get_all_users(self):
        conn = self.get_connection()
        cursor = conn.execute('SELECT discord_id, username FROM users')
        users = cursor.fetchall()
        conn.close()
        return users

db = BotDatabase()
