#!/bin/bash
# System Maintenance Script
# Tự động bảo trì hệ thống: cleanup, updates, optimization

LOG_FILE="/var/log/system-maintenance.log"

echo "$(date): Starting system maintenance..." | tee -a "$LOG_FILE"

# Clean package cache
clean_package_cache() {
    echo "Cleaning package cache..." | tee -a "$LOG_FILE"
    
    if command -v apt &> /dev/null; then
        apt-get clean
        apt-get autoclean
        apt-get autoremove -y
    elif command -v yum &> /dev/null; then
        yum clean all
    fi
    
    echo "✓ Package cache cleaned" | tee -a "$LOG_FILE"
}

# Clean old logs
clean_old_logs() {
    echo "Cleaning old logs..." | tee -a "$LOG_FILE"
    
    # Remove logs older than 30 days
    find /var/log -name "*.log" -type f -mtime +30 -delete
    find /var/log -name "*.gz" -type f -mtime +30 -delete
    
    # Truncate large logs
    find /var/log -name "*.log" -type f -size +100M -exec truncate -s 0 {} \;
    
    # Clean journal logs
    journalctl --vacuum-time=30d
    
    echo "✓ Old logs cleaned" | tee -a "$LOG_FILE"
}

# Clean temporary files
clean_temp_files() {
    echo "Cleaning temporary files..." | tee -a "$LOG_FILE"
    
    # Clean /tmp
    find /tmp -type f -atime +7 -delete 2>/dev/null
    
    # Clean user cache
    find /home -name ".cache" -type d -exec rm -rf {}/* \; 2>/dev/null
    
    echo "✓ Temporary files cleaned" | tee -a "$LOG_FILE"
}

# Update system packages
update_system() {
    echo "Updating system packages..." | tee -a "$LOG_FILE"
    
    if command -v apt &> /dev/null; then
        apt-get update -qq
        apt-get upgrade -y
        apt-get dist-upgrade -y
    elif command -v yum &> /dev/null; then
        yum update -y
    fi
    
    echo "✓ System updated" | tee -a "$LOG_FILE"
}

# Optimize database
optimize_databases() {
    echo "Optimizing databases..." | tee -a "$LOG_FILE"
    
    # MySQL
    if systemctl is-active --quiet mysql || systemctl is-active --quiet mariadb; then
        mysqlcheck --optimize --all-databases 2>/dev/null
        echo "✓ MySQL databases optimized" | tee -a "$LOG_FILE"
    fi
    
    # PostgreSQL
    if systemctl is-active --quiet postgresql; then
        psql -U postgres -c "VACUUM ANALYZE" 2>/dev/null
        echo "✓ PostgreSQL databases optimized" | tee -a "$LOG_FILE"
    fi
}

# Check disk usage
check_disk_usage() {
    echo "Checking disk usage..." | tee -a "$LOG_FILE"
    
    df -h | tee -a "$LOG_FILE"
    
    # Alert if usage > 90%
    df -h | awk '$5 > 90 {print "⚠ " $0}' | tee -a "$LOG_FILE"
}

# Check system load
check_system_load() {
    echo "System load:" | tee -a "$LOG_FILE"
    uptime | tee -a "$LOG_FILE"
    
    echo "Memory usage:" | tee -a "$LOG_FILE"
    free -h | tee -a "$LOG_FILE"
    
    echo "Top processes:" | tee -a "$LOG_FILE"
    ps aux --sort=-%cpu | head -10 | tee -a "$LOG_FILE"
}

# Clean Docker resources
clean_docker() {
    if command -v docker &> /dev/null; then
        echo "Cleaning Docker resources..." | tee -a "$LOG_FILE"
        
        # Remove unused images
        docker image prune -af --filter "until=168h"
        
        # Remove unused containers
        docker container prune -f
        
        # Remove unused volumes
        docker volume prune -f
        
        # Remove unused networks
        docker network prune -f
        
        echo "✓ Docker resources cleaned" | tee -a "$LOG_FILE"
    fi
}

# Check service status
check_services() {
    echo "Checking critical services..." | tee -a "$LOG_FILE"
    
    SERVICES=("nginx" "apache2" "mysql" "postgresql" "redis" "docker")
    
    for SERVICE in "${SERVICES[@]}"; do
        if systemctl list-unit-files | grep -q "^${SERVICE}.service"; then
            if systemctl is-active --quiet "$SERVICE"; then
                echo "✓ $SERVICE is running" | tee -a "$LOG_FILE"
            else
                echo "✗ $SERVICE is NOT running" | tee -a "$LOG_FILE"
            fi
        fi
    done
}

# Generate maintenance report
generate_report() {
    REPORT="/tmp/maintenance-report-$(date +%Y%m%d).txt"
    
    {
        echo "System Maintenance Report"
        echo "========================="
        echo "Date: $(date)"
        echo ""
        echo "Disk Usage:"
        df -h
        echo ""
        echo "Memory Usage:"
        free -h
        echo ""
        echo "System Uptime:"
        uptime
        echo ""
        echo "Package Updates Available:"
        if command -v apt &> /dev/null; then
            apt list --upgradable 2>/dev/null | wc -l
        fi
    } > "$REPORT"
    
    echo "✓ Maintenance report generated: $REPORT" | tee -a "$LOG_FILE"
}

# Main maintenance routine
main() {
    clean_package_cache
    clean_old_logs
    clean_temp_files
    clean_docker
    check_disk_usage
    check_system_load
    check_services
    optimize_databases
    generate_report
    
    echo "$(date): System maintenance completed" | tee -a "$LOG_FILE"
}

main
