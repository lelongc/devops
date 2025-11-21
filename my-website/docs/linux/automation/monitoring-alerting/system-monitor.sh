#!/bin/bash
# System Resource Monitoring Script
# Giám sát CPU, RAM, Disk, Network

LOG_FILE="/var/log/system-monitor.log"
THRESHOLD_CPU=80
THRESHOLD_MEM=85
THRESHOLD_DISK=90
ALERT_EMAIL="admin@example.com"

# Kiểm tra CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
    CPU_USED=$(echo "100 - $CPU_IDLE" | bc)
    
    echo "$(date): CPU Usage: ${CPU_USED}%" | tee -a "$LOG_FILE"
    
    if (( $(echo "$CPU_USED > $THRESHOLD_CPU" | bc -l) )); then
        echo "⚠ CPU Alert: Usage above ${THRESHOLD_CPU}%" | tee -a "$LOG_FILE"
        
        # Top processes
        echo "Top CPU Processes:" >> "$LOG_FILE"
        ps aux --sort=-%cpu | head -10 >> "$LOG_FILE"
        
        return 1
    fi
}

# Kiểm tra Memory usage
check_memory() {
    MEM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}')
    MEM_USED=$(echo "$MEM_USAGE" | cut -d'.' -f1)
    
    echo "$(date): Memory Usage: ${MEM_USED}%" | tee -a "$LOG_FILE"
    
    if [ "$MEM_USED" -gt "$THRESHOLD_MEM" ]; then
        echo "⚠ Memory Alert: Usage above ${THRESHOLD_MEM}%" | tee -a "$LOG_FILE"
        
        # Top memory processes
        echo "Top Memory Processes:" >> "$LOG_FILE"
        ps aux --sort=-%mem | head -10 >> "$LOG_FILE"
        
        return 1
    fi
}

# Kiểm tra Disk usage
check_disk() {
    ALERT_TRIGGERED=0
    
    df -h | grep -v "tmpfs\|devtmpfs" | tail -n +2 | while read line; do
        USAGE=$(echo "$line" | awk '{print $5}' | sed 's/%//')
        MOUNT=$(echo "$line" | awk '{print $6}')
        
        echo "$(date): Disk Usage $MOUNT: ${USAGE}%" | tee -a "$LOG_FILE"
        
        if [ "$USAGE" -gt "$THRESHOLD_DISK" ]; then
            echo "⚠ Disk Alert: $MOUNT usage above ${THRESHOLD_DISK}%" | tee -a "$LOG_FILE"
            
            # Largest directories
            echo "Largest directories in $MOUNT:" >> "$LOG_FILE"
            du -h "$MOUNT" 2>/dev/null | sort -rh | head -10 >> "$LOG_FILE"
            
            ALERT_TRIGGERED=1
        fi
    done
    
    return $ALERT_TRIGGERED
}

# Kiểm tra Network connectivity
check_network() {
    HOSTS=("8.8.8.8" "google.com" "cloudflare.com")
    
    for HOST in "${HOSTS[@]}"; do
        if ping -c 3 "$HOST" > /dev/null 2>&1; then
            echo "$(date): Network OK: $HOST reachable" | tee -a "$LOG_FILE"
        else
            echo "⚠ Network Alert: Cannot reach $HOST" | tee -a "$LOG_FILE"
            return 1
        fi
    done
}

# Kiểm tra Load Average
check_load() {
    LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    CPU_CORES=$(nproc)
    
    echo "$(date): Load Average: $LOAD_AVG (Cores: $CPU_CORES)" | tee -a "$LOG_FILE"
    
    if (( $(echo "$LOAD_AVG > $CPU_CORES * 2" | bc -l) )); then
        echo "⚠ Load Alert: High load average" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Gửi alert email
send_alert() {
    SUBJECT="$1"
    BODY="$2"
    
    echo "$BODY" | mail -s "$SUBJECT" "$ALERT_EMAIL"
}

# Main monitoring loop
main() {
    echo "========================================" | tee -a "$LOG_FILE"
    echo "System Health Check: $(date)" | tee -a "$LOG_FILE"
    echo "========================================" | tee -a "$LOG_FILE"
    
    ALERTS=""
    
    check_cpu || ALERTS="${ALERTS}CPU Alert\n"
    check_memory || ALERTS="${ALERTS}Memory Alert\n"
    check_disk || ALERTS="${ALERTS}Disk Alert\n"
    check_network || ALERTS="${ALERTS}Network Alert\n"
    check_load || ALERTS="${ALERTS}Load Alert\n"
    
    if [ -n "$ALERTS" ]; then
        send_alert "System Alert: $(hostname)" "$(echo -e $ALERTS)\n\nSee $LOG_FILE for details"
    fi
}

main
