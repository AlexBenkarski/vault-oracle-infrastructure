import subprocess
import requests
from datetime import datetime
import re

def get_service_uptime(service_name):
    """Get service uptime"""
    try:
        result = subprocess.run(['systemctl', 'show', service_name, '--property=ActiveEnterTimestamp'],
                              capture_output=True, text=True)
        if result.returncode == 0 and result.stdout:
            timestamp_line = result.stdout.strip()
            if '=' in timestamp_line:
                timestamp_str = timestamp_line.split('=', 1)[1].strip()
                if timestamp_str and timestamp_str != 'n/a':
                    # Parse systemd timestamp format
                    try:
                        # Simple parsing for common format: "Mon 2025-07-24 08:30:00 UTC"
                        if 'UTC' in timestamp_str:
                            # Extract just the timestamp part and convert
                            import datetime as dt
                            # Get current time for uptime calculation
                            current_time = dt.datetime.now()
                            # For now, return a simple uptime - can be enhanced later
                            return "Running"
                    except Exception as e:
                        pass
        return "Unknown"
    except Exception as e:
        return "Unknown"

def check_systemd_service(service_name):
    """Check systemd service status"""
    try:
        # Check if service is active
        result = subprocess.run(['systemctl', 'is-active', service_name],
                              capture_output=True, text=True)
        status = result.stdout.strip()
        
        uptime = None
        if status == "active":
            uptime = get_service_uptime(service_name)
        
        return {
            "name": service_name,
            "status": "active" if status == "active" else "inactive",
            "uptime": uptime,
            "last_check": datetime.now().isoformat()
        }
    except Exception as e:
        return {
            "name": service_name,
            "status": "error",
            "uptime": None,
            "last_check": datetime.now().isoformat()
        }

def get_all_services_status():
    """Return list of service statuses"""
    services = ['vault-api', 'nginx', 'discord-bot']
    return [check_systemd_service(service) for service in services]

def restart_service_safe(service_name):
    """Safely restart a service"""
    allowed_services = ['vault-api', 'nginx', 'discord-bot']
    if service_name not in allowed_services:
        return {"error": "Service not allowed"}, 400

    try:
        result = subprocess.run(['sudo', 'systemctl', 'restart', service_name],
                              capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            return {"status": "restarted", "service": service_name}, 200
        else:
            return {"error": result.stderr}, 500
    except Exception as e:
        return {"error": str(e)}, 500
