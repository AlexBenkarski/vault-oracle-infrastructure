"""Analytics Routes - Data collection and admin dashboard"""

from fastapi import APIRouter, HTTPException, Depends
from datetime import datetime

from .auth import verify_admin_token
from .models import AnalyticsPayload
# Note: AnalyticsDB import will be added when available

router = APIRouter(tags=["analytics"])

# Placeholder for analytics database - will be imported when available
class MockAnalyticsDB:
    """Mock analytics DB for testing - replace with real AnalyticsDB import"""
    def __init__(self, db_path: str):
        self.db_path = db_path
    
    def upsert_user_data(self, data: dict):
        """Mock method - replace with real implementation"""
        pass
    
    def get_analytics_summary(self):
        """Mock method - replace with real implementation"""
        return {
            "total_users": 0,
            "consent_given": 0,
            "avg_session_minutes": 0,
            "most_used_os": "Unknown"
        }
    
    def get_all_users_summary(self):
        """Mock method - replace with real implementation"""
        return []

# Initialize mock analytics DB - replace with real AnalyticsDB
analytics_db = MockAnalyticsDB("/opt/vault-api/analytics.db")

@router.post("/analytics")
async def receive_analytics(payload: AnalyticsPayload):
    """Receive analytics data from Vault desktop app
    
    This endpoint collects usage data when users have given consent.
    Data includes: version info, OS, feature usage, performance metrics.
    """
    try:
        # Convert Pydantic model to dict
        analytics_data = payload.dict()
        analytics_data["last_ping"] = datetime.now().strftime("%Y-%m-%d")

        # Store in analytics database
        analytics_db.upsert_user_data(analytics_data)
        
        return {"status": "success", "message": "Analytics received"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Analytics processing error: {str(e)}")

@router.get("/admin/analytics/data")
async def get_analytics_data(admin_user: str = Depends(verify_admin_token)):
    """Get analytics data for admin dashboard
    
    Returns aggregated analytics including:
    - User statistics (total, consent rates)
    - Performance metrics 
    - OS distribution
    - Feature usage patterns
    """
    try:
        # Get analytics summary stats
        analytics_stats = analytics_db.get_analytics_summary()
        analytics_users = analytics_db.get_all_users_summary()
        
        return {
            "stats": analytics_stats,
            "users": analytics_users
        }
    except Exception as e:
        # Return safe defaults if analytics DB unavailable
        return {
            "stats": {
                "total_users": 0,
                "consent_given": 0, 
                "avg_session_minutes": 0,
                "most_used_os": "Unknown"
            },
            "users": []
        }

@router.get("/admin/analytics/export")
async def export_analytics_data(admin_user: str = Depends(verify_admin_token)):
    """Export analytics data for external analysis (CSV/JSON)"""
    try:
        # This would export analytics data in a structured format
        # Implementation depends on specific analytics needs
        return {"message": "Export functionality - to be implemented"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Export error: {str(e)}")

# Health check for analytics system
@router.get("/analytics/health")
async def analytics_health():
    """Check if analytics system is operational"""
    try:
        # Simple health check - could ping analytics DB
        return {"status": "healthy", "service": "analytics"}
    except Exception as e:
        raise HTTPException(status_code=503, detail="Analytics service unavailable")
