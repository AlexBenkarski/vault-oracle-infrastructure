"""
User authentication routes (signup, signin, login)
"""
from fastapi import APIRouter, HTTPException
from .models import UserSignup, UserSignin
from .database import get_users_db_connection
from .auth import hash_password, verify_password, create_access_token, is_valid_email

router = APIRouter(prefix="/auth", tags=["user-auth"])

@router.post("/signup")
async def signup(user: UserSignup):
    """Register new user account"""
    if not is_valid_email(user.email):
        raise HTTPException(status_code=400, detail="Invalid email format")

    if len(user.password) < 8:
        raise HTTPException(status_code=400, detail="Password must be at least 8 characters")

    conn = get_users_db_connection()
    try:
        cursor = conn.execute("SELECT email FROM users WHERE email = ?", (user.email,))
        if cursor.fetchone():
            raise HTTPException(status_code=400, detail="Email already registered")

        password_hash = hash_password(user.password)
        conn.execute('''
            INSERT INTO users (email, password_hash, email_verified)
            VALUES (?, ?, ?)
        ''', (user.email, password_hash, True))

        conn.commit()
        return {"message": "Account created successfully!"}
    finally:
        conn.close()

@router.post("/signin")
async def signin(user: UserSignin):
    """Sign in user"""
    conn = get_users_db_connection()
    try:
        cursor = conn.execute('''
            SELECT email, password_hash, email_verified
            FROM users WHERE email = ?
        ''', (user.email,))

        result = cursor.fetchone()
        if not result or not verify_password(user.password, result[1]):
            raise HTTPException(status_code=401, detail="Invalid email or password")

        if not result[2]:
            raise HTTPException(status_code=401, detail="Please verify your email first")

        conn.execute('''
            UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE email = ?
        ''', (user.email,))
        conn.commit()

        token = create_access_token({"sub": user.email})
        return {"token": token, "message": "Sign in successful"}
    finally:
        conn.close()

@router.post("/login")
async def login(user: UserSignin):
    """Login alias for signin"""
    return await signin(user)
