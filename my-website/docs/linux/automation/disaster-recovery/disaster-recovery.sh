#!/bin/bash
# Disaster Recovery Script
# Khôi phục hệ thống sau sự cố

BACKUP_LOCATION="/backup"
RECOVERY_LOG="/var/log/disaster-recovery.log"
RECOVERY_POINT="${1:-latest}"

echo "$(date): Starting disaster recovery process..." | tee -a "$RECOVERY_LOG"

# Pre-recovery checks
pre_recovery_checks() {
    echo "Running pre-recovery checks..." | tee -a "$RECOVERY_LOG"
    
    # Check backup availability
    if [ ! -d "$BACKUP_LOCATION" ]; then
        echo "✗ Backup location not found: $BACKUP_LOCATION" | tee -a "$RECOVERY_LOG"
        exit 1
    fi
    
    # Check disk space
    AVAILABLE_SPACE=$(df / | tail -1 | awk '{print $4}')
    REQUIRED_SPACE=10485760  # 10GB in KB
    
    if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_SPACE" ]; then
        echo "✗ Insufficient disk space for recovery" | tee -a "$RECOVERY_LOG"
        exit 1
    fi
    
    echo "✓ Pre-recovery checks passed" | tee -a "$RECOVERY_LOG"
}

# Stop services
stop_services() {
    echo "Stopping services..." | tee -a "$RECOVERY_LOG"
    
    SERVICES=("nginx" "apache2" "mysql" "postgresql" "redis" "docker")
    
    for SERVICE in "${SERVICES[@]}"; do
        if systemctl is-active --quiet "$SERVICE"; then
            systemctl stop "$SERVICE"
            echo "Stopped: $SERVICE" | tee -a "$RECOVERY_LOG"
        fi
    done
}

# Restore system files
restore_system_files() {
    echo "Restoring system files..." | tee -a "$RECOVERY_LOG"
    
    SYSTEM_BACKUP="$BACKUP_LOCATION/system/latest.tar.gz"
    
    if [ -f "$SYSTEM_BACKUP" ]; then
        tar -xzf "$SYSTEM_BACKUP" -C /
        echo "✓ System files restored" | tee -a "$RECOVERY_LOG"
    else
        echo "⚠ System backup not found" | tee -a "$RECOVERY_LOG"
    fi
}

# Restore databases
restore_databases() {
    echo "Restoring databases..." | tee -a "$RECOVERY_LOG"
    
    # MySQL
    if [ -d "$BACKUP_LOCATION/mysql" ]; then
        LATEST_MYSQL=$(ls -t "$BACKUP_LOCATION/mysql"/*.sql.gz | head -1)
        
        if [ -f "$LATEST_MYSQL" ]; then
            systemctl start mysql
            sleep 5
            
            gunzip < "$LATEST_MYSQL" | mysql
            echo "✓ MySQL database restored" | tee -a "$RECOVERY_LOG"
        fi
    fi
    
    # PostgreSQL
    if [ -d "$BACKUP_LOCATION/postgresql" ]; then
        LATEST_PG=$(ls -t "$BACKUP_LOCATION/postgresql"/*.dump | head -1)
        
        if [ -f "$LATEST_PG" ]; then
            systemctl start postgresql
            sleep 5
            
            pg_restore -d postgres "$LATEST_PG"
            echo "✓ PostgreSQL database restored" | tee -a "$RECOVERY_LOG"
        fi
    fi
}

# Restore application data
restore_application_data() {
    echo "Restoring application data..." | tee -a "$RECOVERY_LOG"
    
    APP_BACKUP="$BACKUP_LOCATION/applications/latest.tar.gz"
    
    if [ -f "$APP_BACKUP" ]; then
        tar -xzf "$APP_BACKUP" -C /var/www/
        
        # Fix permissions
        chown -R www-data:www-data /var/www/
        
        echo "✓ Application data restored" | tee -a "$RECOVERY_LOG"
    else
        echo "⚠ Application backup not found" | tee -a "$RECOVERY_LOG"
    fi
}

# Restore configuration files
restore_configurations() {
    echo "Restoring configurations..." | tee -a "$RECOVERY_LOG"
    
    CONFIG_BACKUP="$BACKUP_LOCATION/config/latest.tar.gz"
    
    if [ -f "$CONFIG_BACKUP" ]; then
        tar -xzf "$CONFIG_BACKUP" -C /etc/
        echo "✓ Configurations restored" | tee -a "$RECOVERY_LOG"
    fi
}

# Verify restoration
verify_restoration() {
    echo "Verifying restoration..." | tee -a "$RECOVERY_LOG"
    
    ERRORS=0
    
    # Check critical directories
    CRITICAL_DIRS=("/var/www" "/etc/nginx" "/etc/apache2")
    
    for DIR in "${CRITICAL_DIRS[@]}"; do
        if [ ! -d "$DIR" ]; then
            echo "✗ Missing directory: $DIR" | tee -a "$RECOVERY_LOG"
            ERRORS=$((ERRORS + 1))
        fi
    done
    
    if [ $ERRORS -eq 0 ]; then
        echo "✓ Verification passed" | tee -a "$RECOVERY_LOG"
        return 0
    else
        echo "✗ Verification failed with $ERRORS errors" | tee -a "$RECOVERY_LOG"
        return 1
    fi
}

# Start services
start_services() {
    echo "Starting services..." | tee -a "$RECOVERY_LOG"
    
    SERVICES=("mysql" "postgresql" "redis" "nginx" "apache2" "docker")
    
    for SERVICE in "${SERVICES[@]}"; do
        if systemctl list-unit-files | grep -q "^${SERVICE}.service"; then
            systemctl start "$SERVICE"
            
            if systemctl is-active --quiet "$SERVICE"; then
                echo "✓ Started: $SERVICE" | tee -a "$RECOVERY_LOG"
            else
                echo "✗ Failed to start: $SERVICE" | tee -a "$RECOVERY_LOG"
            fi
        fi
    done
}

# Post-recovery health check
post_recovery_check() {
    echo "Running post-recovery health check..." | tee -a "$RECOVERY_LOG"
    
    sleep 10
    
    # Check web services
    for PORT in 80 443; do
        if curl -s -o /dev/null -w "%{http_code}" "http://localhost:$PORT" | grep -q "200\|301\|302"; then
            echo "✓ Web service on port $PORT is responding" | tee -a "$RECOVERY_LOG"
        else
            echo "⚠ Web service on port $PORT not responding" | tee -a "$RECOVERY_LOG"
        fi
    done
    
    # Check databases
    if systemctl is-active --quiet mysql; then
        if mysql -e "SELECT 1" &>/dev/null; then
            echo "✓ MySQL is operational" | tee -a "$RECOVERY_LOG"
        else
            echo "✗ MySQL connection failed" | tee -a "$RECOVERY_LOG"
        fi
    fi
}

# Generate recovery report
generate_recovery_report() {
    REPORT_FILE="/tmp/recovery-report-$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "Disaster Recovery Report"
        echo "========================"
        echo "Date: $(date)"
        echo "Recovery Point: $RECOVERY_POINT"
        echo ""
        echo "Recovery Steps Completed:"
        echo "- System files restored"
        echo "- Databases restored"
        echo "- Application data restored"
        echo "- Configurations restored"
        echo "- Services restarted"
        echo ""
        echo "System Status:"
        systemctl status nginx mysql postgresql redis --no-pager
        echo ""
        echo "Detailed log: $RECOVERY_LOG"
    } > "$REPORT_FILE"
    
    echo "✓ Recovery report generated: $REPORT_FILE" | tee -a "$RECOVERY_LOG"
    
    # Send notification
    mail -s "Disaster Recovery Completed" admin@example.com < "$REPORT_FILE"
}

# Main recovery process
main() {
    pre_recovery_checks
    stop_services
    restore_system_files
    restore_databases
    restore_application_data
    restore_configurations
    
    if verify_restoration; then
        start_services
        post_recovery_check
        generate_recovery_report
        
        echo "$(date): ✓ Disaster recovery completed successfully" | tee -a "$RECOVERY_LOG"
        exit 0
    else
        echo "$(date): ✗ Disaster recovery failed" | tee -a "$RECOVERY_LOG"
        exit 1
    fi
}

main
