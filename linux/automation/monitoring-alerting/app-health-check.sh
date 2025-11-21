#!/bin/bash
# Application Health Check Script
# Kiểm tra health của web applications và APIs

LOG_FILE="/var/log/app-health.log"
ALERT_EMAIL="admin@example.com"
TIMEOUT=10

# Danh sách endpoints cần check
declare -A ENDPOINTS=(
    ["Production Web"]="https://example.com/health"
    ["API Gateway"]="https://api.example.com/health"
    ["Admin Panel"]="https://admin.example.com/ping"
    ["Database API"]="http://localhost:3000/health"
)

echo "$(date): Starting application health checks..." | tee -a "$LOG_FILE"

# Check HTTP endpoint
check_endpoint() {
    NAME="$1"
    URL="$2"
    
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time "$TIMEOUT" "$URL" 2>&1)
    
    if [ "$RESPONSE" = "200" ] || [ "$RESPONSE" = "301" ]; then
        echo "$(date): ✓ $NAME is healthy (HTTP $RESPONSE)" | tee -a "$LOG_FILE"
        return 0
    else
        echo "$(date): ✗ $NAME is unhealthy (HTTP $RESPONSE)" | tee -a "$LOG_FILE"
        
        # Gửi alert
        echo "Application $NAME is not responding properly. Status: $RESPONSE" | \
            mail -s "App Health Alert: $NAME" "$ALERT_EMAIL"
        
        return 1
    fi
}

# Check API response time
check_response_time() {
    NAME="$1"
    URL="$2"
    MAX_TIME=2
    
    RESPONSE_TIME=$(curl -s -o /dev/null -w "%{time_total}" --max-time "$TIMEOUT" "$URL")
    
    echo "$(date): $NAME response time: ${RESPONSE_TIME}s" | tee -a "$LOG_FILE"
    
    if (( $(echo "$RESPONSE_TIME > $MAX_TIME" | bc -l) )); then
        echo "$(date): ⚠ $NAME slow response (>${MAX_TIME}s)" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Check SSL certificate expiry
check_ssl_expiry() {
    DOMAIN="$1"
    DAYS_WARNING=30
    
    EXPIRY_DATE=$(echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN:443" 2>/dev/null | \
        openssl x509 -noout -enddate 2>/dev/null | cut -d= -f2)
    
    if [ -n "$EXPIRY_DATE" ]; then
        EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s)
        CURRENT_EPOCH=$(date +%s)
        DAYS_LEFT=$(( ($EXPIRY_EPOCH - $CURRENT_EPOCH) / 86400 ))
        
        echo "$(date): SSL cert for $DOMAIN expires in $DAYS_LEFT days" | tee -a "$LOG_FILE"
        
        if [ "$DAYS_LEFT" -lt "$DAYS_WARNING" ]; then
            echo "⚠ SSL certificate expiring soon: $DOMAIN ($DAYS_LEFT days)" | \
                mail -s "SSL Certificate Alert: $DOMAIN" "$ALERT_EMAIL"
        fi
    fi
}

# Main
FAILED_CHECKS=0

for NAME in "${!ENDPOINTS[@]}"; do
    URL="${ENDPOINTS[$NAME]}"
    
    if ! check_endpoint "$NAME" "$URL"; then
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    else
        check_response_time "$NAME" "$URL"
    fi
done

# Check SSL certificates
check_ssl_expiry "example.com"
check_ssl_expiry "api.example.com"

# Summary
echo "$(date): Health check completed. Failed: $FAILED_CHECKS" | tee -a "$LOG_FILE"
