import subprocess
import requests
from datetime import datetime
import re

def get_service_uptime(service_name):
    """Get service uptime in human readable format"""
    try:
        result = subprocess.run(['systemctl', 'show', service_name, '--property=ActiveEnterTimestamp'],
                              capture_output=True, text=True)
        if result.returncode == 0 and result.stdout:
            timestamp_line = result.stdout.strip()
            if '=' in timestamp_line:
                timestamp_str = timestamp_line.split('=', 1)[1].strip()
                if timestamp_str and timestamp_str != 'n/a':
                    try:
                        # Parse systemd timestamp: "Mon 2025-07-24 08:30:00 UTC"
                        from datetime import datetime
                        import re
                        
                        # Extract datetime part
                        match = re.search(r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})', timestamp_str)
                        if match:
                            start_time_str = match.group(1)
                            start_time = datetime.strptime(start_time_str, '%Y-%m-%d %H:%M:%S')
                            current_time = datetime.utcnow()
                            uptime_delta = current_time - start_time
                            
                            # Format uptime
                            days = uptime_delta.days
                            hours, remainder = divmod(uptime_delta.seconds, 3600)
                            minutes, _ = divmod(remainder, 60)
                            
                            if days > 0:
                                return f"{days}d {hours}h {minutes}m"
                            elif hours > 0:
                                return f"{hours}h {minutes}m"
                            else:
                                return f"{minutes}m"
                                
                    except Exception as e:
                        print(f"Error parsing uptime for {service_name}: {e}")
        return "Unknown"
    except Exception as e:
        print(f"Error getting uptime for {service_name}: {e}")
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
        print(f"Error checking service {service_name}: {e}")
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
