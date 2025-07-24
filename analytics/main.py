from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from models import AnalyticsDB
from datetime import datetime
import json

app = FastAPI(title="Vault Analytics API")
db = AnalyticsDB()

class AnalyticsPayload(BaseModel):
    vault_id: str
    version: str
    os: str
    consent_given: bool
    install_metrics: dict
    vault_stats: dict
    feature_usage: dict
    performance: dict

@app.post("/analytics")
async def receive_analytics(payload: AnalyticsPayload):
    try:
        analytics_data = payload.dict()
        analytics_data["last_ping"] = datetime.now().strftime("%Y-%m-%d")
        
        db.upsert_user_data(analytics_data)
        return {"status": "success", "message": "Analytics received"}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "analytics"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8001)
