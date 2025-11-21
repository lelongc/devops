#!/bin/bash
# Log Analysis Script
# Phân tích logs để tìm errors và patterns

LOG_FILE="/var/log/syslog"
APP_LOG="/var/log/applications/app.log"
REPORT_FILE="/tmp/log-analysis-$(date +%Y%m%d).txt"
ALERT_EMAIL="admin@example.com"

echo "Log Analysis Report - $(date)" > "$REPORT_FILE"
echo "======================================" >> "$REPORT_FILE"

# Tìm errors trong logs
find_errors() {
    echo -e "\n### ERROR SUMMARY ###" >> "$REPORT_FILE"
    
    ERROR_COUNT=$(grep -i "error" "$LOG_FILE" | wc -l)
    echo "Total errors found: $ERROR_COUNT" >> "$REPORT_FILE"
    
    if [ "$ERROR_COUNT" -gt 0 ]; then
        echo -e "\nTop 10 error messages:" >> "$REPORT_FILE"
        grep -i "error" "$LOG_FILE" | awk '{$1=$2=$3=""; print $0}' | \
            sort | uniq -c | sort -rn | head -10 >> "$REPORT_FILE"
    fi
}

# Tìm failed login attempts
find_failed_logins() {
    echo -e "\n### FAILED LOGIN ATTEMPTS ###" >> "$REPORT_FILE"
    
    FAILED_COUNT=$(grep -i "failed password" /var/log/auth.log 2>/dev/null | wc -l)
    echo "Failed login attempts: $FAILED_COUNT" >> "$REPORT_FILE"
    
    if [ "$FAILED_COUNT" -gt 10 ]; then
        echo -e "\nTop IPs with failed logins:" >> "$REPORT_FILE"
        grep -i "failed password" /var/log/auth.log 2>/dev/null | \
            grep -oP "from \K[\d.]+" | sort | uniq -c | sort -rn | head -10 >> "$REPORT_FILE"
    fi
}

# Tìm HTTP errors (nếu có nginx/apache logs)
find_http_errors() {
    NGINX_ERROR="/var/log/nginx/error.log"
    
    if [ -f "$NGINX_ERROR" ]; then
        echo -e "\n### HTTP ERRORS ###" >> "$REPORT_FILE"
        
        ERROR_COUNT=$(wc -l < "$NGINX_ERROR")
        echo "Nginx errors: $ERROR_COUNT" >> "$REPORT_FILE"
        
        if [ "$ERROR_COUNT" -gt 0 ]; then
            echo -e "\nTop 10 nginx errors:" >> "$REPORT_FILE"
            tail -1000 "$NGINX_ERROR" | awk '{print $NF}' | sort | uniq -c | sort -rn | head -10 >> "$REPORT_FILE"
        fi
    fi
}

# Phân tích database errors
find_db_errors() {
    MYSQL_ERROR="/var/log/mysql/error.log"
    
    if [ -f "$MYSQL_ERROR" ]; then
        echo -e "\n### DATABASE ERRORS ###" >> "$REPORT_FILE"
        
        ERROR_COUNT=$(grep -i "error" "$MYSQL_ERROR" | wc -l)
        echo "MySQL errors: $ERROR_COUNT" >> "$REPORT_FILE"
        
        if [ "$ERROR_COUNT" -gt 0 ]; then
            echo -e "\nRecent MySQL errors:" >> "$REPORT_FILE"
            grep -i "error" "$MYSQL_ERROR" | tail -20 >> "$REPORT_FILE"
        fi
    fi
}

# Tìm patterns bất thường
find_anomalies() {
    echo -e "\n### ANOMALIES ###" >> "$REPORT_FILE"
    
    # Tìm OOM (Out of Memory) errors
    OOM_COUNT=$(grep -i "out of memory" "$LOG_FILE" | wc -l)
    if [ "$OOM_COUNT" -gt 0 ]; then
        echo "Out of Memory errors: $OOM_COUNT" >> "$REPORT_FILE"
    fi
    
    # Tìm segmentation faults
    SEGFAULT_COUNT=$(grep -i "segmentation fault" "$LOG_FILE" | wc -l)
    if [ "$SEGFAULT_COUNT" -gt 0 ]; then
        echo "Segmentation faults: $SEGFAULT_COUNT" >> "$REPORT_FILE"
    fi
    
    # Tìm disk full errors
    DISKFULL_COUNT=$(grep -i "no space left" "$LOG_FILE" | wc -l)
    if [ "$DISKFULL_COUNT" -gt 0 ]; then
        echo "Disk full errors: $DISKFULL_COUNT" >> "$REPORT_FILE"
    fi
}

# Log parsing cho custom application
parse_app_logs() {
    if [ -f "$APP_LOG" ]; then
        echo -e "\n### APPLICATION LOGS ###" >> "$REPORT_FILE"
        
        # Đếm log levels
        echo "Log level distribution:" >> "$REPORT_FILE"
        grep -oP "(ERROR|WARN|INFO|DEBUG)" "$APP_LOG" | sort | uniq -c | sort -rn >> "$REPORT_FILE"
        
        # Top errors
        echo -e "\nTop application errors:" >> "$REPORT_FILE"
        grep "ERROR" "$APP_LOG" | tail -20 >> "$REPORT_FILE"
    fi
}

# Main analysis
find_errors
find_failed_logins
find_http_errors
find_db_errors
find_anomalies
parse_app_logs

# Hiển thị và gửi report
cat "$REPORT_FILE"

# Gửi email nếu có critical errors
CRITICAL_COUNT=$(grep -c "CRITICAL\|FATAL\|SEVERE" "$LOG_FILE")
if [ "$CRITICAL_COUNT" -gt 0 ]; then
    mail -s "CRITICAL: Log Analysis Alert" "$ALERT_EMAIL" < "$REPORT_FILE"
fi

echo -e "\nReport saved to: $REPORT_FILE"
