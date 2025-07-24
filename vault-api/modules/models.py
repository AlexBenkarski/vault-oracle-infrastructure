"""
Pydantic models for request/response validation
"""
from pydantic import BaseModel, EmailStr
from typing import Optional, Dict, Any

# Beta Key Validation Models
class KeyValidationRequest(BaseModel):
    beta_key: str
    username: str

class KeyValidationResponse(BaseModel):
    valid: bool
    message: str
    user_info: Optional[dict] = None

# Analytics Models
class AnalyticsPayload(BaseModel):
    vault_id: str
    version: str
    os: str
    consent_given: bool
    install_metrics: dict
    vault_stats: dict
    feature_usage: dict
    performance: dict

# User Authentication Models
class UserSignup(BaseModel):
    email: EmailStr
    password: str

class UserSignin(BaseModel):
    email: EmailStr
    password: str

# Admin Models
class UserAction(BaseModel):
    user_id: int
    action: str

class AdminLogin(BaseModel):
    username: str
    password: str

class BetaKeyGenerate(BaseModel):
    count: Optional[int] = 1

class ReleaseData(BaseModel):
    release_id: int

class ServiceAction(BaseModel):
    service_name: str
