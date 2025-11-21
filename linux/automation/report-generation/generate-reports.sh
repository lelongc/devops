#!/bin/bash
# Automated Report Generation Script
# Tạo báo cáo tự động về hệ thống, performance, security

REPORT_DIR="/var/reports"
REPORT_DATE=$(date +%Y%m%d)
EMAIL="admin@example.com"

mkdir -p "$REPORT_DIR"

# System Status Report
generate_system_report() {
    REPORT_FILE="$REPORT_DIR/system-report-${REPORT_DATE}.html"
    
    cat > "$REPORT_FILE" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>System Report</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        h1 { color: #333; }
        h2 { color: #666; border-bottom: 2px solid #ddd; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        .ok { color: green; }
        .warning { color: orange; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>System Status Report</h1>
    <p>Generated: $(date)</p>
    
    <h2>System Information</h2>
    <table>
        <tr><th>Parameter</th><th>Value</th></tr>
        <tr><td>Hostname</td><td>$(hostname)</td></tr>
        <tr><td>Kernel</td><td>$(uname -r)</td></tr>
        <tr><td>Uptime</td><td>$(uptime -p)</td></tr>
        <tr><td>Load Average</td><td>$(uptime | awk -F'load average:' '{print $2}')</td></tr>
    </table>
    
    <h2>Resource Usage</h2>
    <table>
        <tr><th>Resource</th><th>Used</th><th>Total</th><th>Percentage</th></tr>
EOF
    
    # CPU usage
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo "<tr><td>CPU</td><td>${CPU_USAGE}%</td><td>100%</td><td>${CPU_USAGE}%</td></tr>" >> "$REPORT_FILE"
    
    # Memory usage
    MEM_INFO=$(free -h | grep Mem)
    MEM_USED=$(echo $MEM_INFO | awk '{print $3}')
    MEM_TOTAL=$(echo $MEM_INFO | awk '{print $2}')
    MEM_PERCENT=$(echo $MEM_INFO | awk '{printf "%.1f", ($3/$2)*100}')
    echo "<tr><td>Memory</td><td>$MEM_USED</td><td>$MEM_TOTAL</td><td>${MEM_PERCENT}%</td></tr>" >> "$REPORT_FILE"
    
    # Disk usage
    df -h | grep -v "tmpfs" | tail -n +2 | while read line; do
        MOUNT=$(echo $line | awk '{print $6}')
        USED=$(echo $line | awk '{print $3}')
        TOTAL=$(echo $line | awk '{print $2}')
        PERCENT=$(echo $line | awk '{print $5}')
        echo "<tr><td>Disk $MOUNT</td><td>$USED</td><td>$TOTAL</td><td>$PERCENT</td></tr>" >> "$REPORT_FILE"
    done
    
    cat >> "$REPORT_FILE" << 'EOF'
    </table>
    
    <h2>Service Status</h2>
    <table>
        <tr><th>Service</th><th>Status</th></tr>
EOF
    
    SERVICES=("nginx" "apache2" "mysql" "postgresql" "redis" "docker")
    for SERVICE in "${SERVICES[@]}"; do
        if systemctl list-unit-files | grep -q "^${SERVICE}.service"; then
            if systemctl is-active --quiet "$SERVICE"; then
                echo "<tr><td>$SERVICE</td><td class='ok'>Running</td></tr>" >> "$REPORT_FILE"
            else
                echo "<tr><td>$SERVICE</td><td class='error'>Stopped</td></tr>" >> "$REPORT_FILE"
            fi
        fi
    done
    
    cat >> "$REPORT_FILE" << 'EOF'
    </table>
</body>
</html>
EOF
    
    echo "✓ System report generated: $REPORT_FILE"
}

# Performance Report
generate_performance_report() {
    REPORT_FILE="$REPORT_DIR/performance-report-${REPORT_DATE}.txt"
    
    {
        echo "Performance Report - $(date)"
        echo "========================================"
        echo ""
        
        echo "CPU Information:"
        lscpu | grep -E "Model name|CPU\(s\)|Thread|Core"
        echo ""
        
        echo "Memory Performance:"
        vmstat 1 5
        echo ""
        
        echo "Disk I/O:"
        iostat -x 1 3
        echo ""
        
        echo "Network Statistics:"
        netstat -i
        echo ""
        
        echo "Top CPU Processes:"
        ps aux --sort=-%cpu | head -10
        echo ""
        
        echo "Top Memory Processes:"
        ps aux --sort=-%mem | head -10
        
    } > "$REPORT_FILE"
    
    echo "✓ Performance report generated: $REPORT_FILE"
}

# Security Report
generate_security_report() {
    REPORT_FILE="$REPORT_DIR/security-report-${REPORT_DATE}.txt"
    
    {
        echo "Security Report - $(date)"
        echo "========================================"
        echo ""
        
        echo "Failed Login Attempts (Last 24h):"
        grep "Failed password" /var/log/auth.log 2>/dev/null | grep "$(date +%b\ %d)" | wc -l
        echo ""
        
        echo "Active SSH Sessions:"
        who
        echo ""
        
        echo "Open Ports:"
        netstat -tuln | grep LISTEN
        echo ""
        
        echo "Firewall Status:"
        ufw status verbose 2>/dev/null || iptables -L -n
        echo ""
        
        echo "Last Logins:"
        last -10
        
    } > "$REPORT_FILE"
    
    echo "✓ Security report generated: $REPORT_FILE"
}

# Backup Report
generate_backup_report() {
    REPORT_FILE="$REPORT_DIR/backup-report-${REPORT_DATE}.txt"
    
    {
        echo "Backup Report - $(date)"
        echo "========================================"
        echo ""
        
        echo "Recent Backups:"
        find /backup -type f -name "*.tar.gz" -o -name "*.sql.gz" -mtime -7 -printf "%T@ %p\n" | \
            sort -rn | head -20 | while read timestamp file; do
                date -d "@$timestamp" "+%Y-%m-%d %H:%M:%S"
                echo "  $file ($(du -h "$file" | cut -f1))"
            done
        echo ""
        
        echo "Backup Directory Usage:"
        du -sh /backup/*
        
    } > "$REPORT_FILE"
    
    echo "✓ Backup report generated: $REPORT_FILE"
}

# Database Report
generate_database_report() {
    REPORT_FILE="$REPORT_DIR/database-report-${REPORT_DATE}.txt"
    
    {
        echo "Database Report - $(date)"
        echo "========================================"
        echo ""
        
        # MySQL
        if systemctl is-active --quiet mysql; then
            echo "MySQL Databases:"
            mysql -e "SHOW DATABASES;" 2>/dev/null
            echo ""
            
            echo "MySQL Database Sizes:"
            mysql -e "SELECT table_schema AS 'Database', 
                ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)' 
                FROM information_schema.TABLES 
                GROUP BY table_schema;" 2>/dev/null
        fi
        
        # PostgreSQL
        if systemctl is-active --quiet postgresql; then
            echo "PostgreSQL Databases:"
            psql -U postgres -c "\l" 2>/dev/null
        fi
        
    } > "$REPORT_FILE"
    
    echo "✓ Database report generated: $REPORT_FILE"
}

# Consolidate and send reports
send_reports() {
    COMBINED_REPORT="$REPORT_DIR/combined-report-${REPORT_DATE}.tar.gz"
    
    tar -czf "$COMBINED_REPORT" "$REPORT_DIR"/*-${REPORT_DATE}.*
    
    # Send via email
    echo "Please find attached the system reports for $(date)" | \
        mail -s "System Reports - $REPORT_DATE" \
        -a "$COMBINED_REPORT" \
        "$EMAIL"
    
    echo "✓ Reports sent to $EMAIL"
}

# Main
echo "Generating reports..."

generate_system_report
generate_performance_report
generate_security_report
generate_backup_report
generate_database_report
send_reports

echo "All reports generated and sent"
