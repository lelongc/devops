#!/bin/bash
# Service Monitoring Script
# Giám sát các services quan trọng

SERVICES=("nginx" "apache2" "mysql" "postgresql" "redis" "mongodb" "docker")
LOG_FILE="/var/log/service-monitor.log"
ALERT_EMAIL="admin@example.com"

echo "$(date): Starting service monitoring..." | tee -a "$LOG_FILE"

# Kiểm tra service status
check_service() {
    SERVICE_NAME="$1"
    
    if systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "$(date): ✓ $SERVICE_NAME is running" | tee -a "$LOG_FILE"
        return 0
    else
        echo "$(date): ✗ $SERVICE_NAME is NOT running" | tee -a "$LOG_FILE"
        
        # Thử restart service
        echo "$(date): Attempting to restart $SERVICE_NAME..." | tee -a "$LOG_FILE"
        systemctl restart "$SERVICE_NAME"
        sleep 5
        
        if systemctl is-active --quiet "$SERVICE_NAME"; then
            echo "$(date): ✓ $SERVICE_NAME restarted successfully" | tee -a "$LOG_FILE"
            echo "$SERVICE_NAME was down but has been restarted" | mail -s "Service Recovered: $SERVICE_NAME" "$ALERT_EMAIL"
            return 0
        else
            echo "$(date): ✗ Failed to restart $SERVICE_NAME" | tee -a "$LOG_FILE"
            echo "$SERVICE_NAME is down and failed to restart" | mail -s "Service Down: $SERVICE_NAME" "$ALERT_EMAIL"
            return 1
        fi
    fi
}

# Kiểm tra port listening
check_port() {
    PORT="$1"
    SERVICE_NAME="$2"
    
    if netstat -tuln | grep -q ":$PORT "; then
        echo "$(date): ✓ Port $PORT ($SERVICE_NAME) is listening" | tee -a "$LOG_FILE"
        return 0
    else
        echo "$(date): ✗ Port $PORT ($SERVICE_NAME) is NOT listening" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Kiểm tra process running
check_process() {
    PROCESS_NAME="$1"
    
    if pgrep -x "$PROCESS_NAME" > /dev/null; then
        COUNT=$(pgrep -x "$PROCESS_NAME" | wc -l)
        echo "$(date): ✓ $PROCESS_NAME is running ($COUNT instances)" | tee -a "$LOG_FILE"
        return 0
    else
        echo "$(date): ✗ $PROCESS_NAME is NOT running" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Main
FAILED_SERVICES=()

for SERVICE in "${SERVICES[@]}"; do
    if ! check_service "$SERVICE"; then
        FAILED_SERVICES+=("$SERVICE")
    fi
done

# Kiểm tra ports quan trọng
check_port 80 "HTTP"
check_port 443 "HTTPS"
check_port 22 "SSH"
check_port 3306 "MySQL"
check_port 5432 "PostgreSQL"
check_port 6379 "Redis"

# Báo cáo tổng hợp
if [ ${#FAILED_SERVICES[@]} -eq 0 ]; then
    echo "$(date): All services are running normally" | tee -a "$LOG_FILE"
else
    echo "$(date): Failed services: ${FAILED_SERVICES[*]}" | tee -a "$LOG_FILE"
    echo "The following services are down: ${FAILED_SERVICES[*]}" | mail -s "Service Monitoring Alert" "$ALERT_EMAIL"
fi
