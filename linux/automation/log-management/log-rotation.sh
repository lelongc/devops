#!/bin/bash
# Log Rotation and Cleanup Script
# Quản lý và rotate log files

LOG_DIR="/var/log"
APP_LOG_DIR="/var/log/applications"
MAX_SIZE_MB=100
MAX_AGE_DAYS=30
ARCHIVE_DIR="/backup/logs"

mkdir -p "$ARCHIVE_DIR"

echo "Starting log rotation: $(date)"

# Rotate logs dựa theo size
rotate_by_size() {
    LOG_FILE="$1"
    
    if [ ! -f "$LOG_FILE" ]; then
        return
    fi
    
    SIZE_MB=$(du -m "$LOG_FILE" | cut -f1)
    
    if [ "$SIZE_MB" -gt "$MAX_SIZE_MB" ]; then
        echo "Rotating large log: $LOG_FILE (${SIZE_MB}MB)"
        
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        ROTATED_FILE="${LOG_FILE}.${TIMESTAMP}"
        
        # Copy và compress
        cp "$LOG_FILE" "$ROTATED_FILE"
        gzip "$ROTATED_FILE"
        
        # Clear original log
        > "$LOG_FILE"
        
        echo "Rotated to: ${ROTATED_FILE}.gz"
    fi
}

# Rotate logs theo ngày
rotate_by_date() {
    LOG_FILE="$1"
    
    if [ ! -f "$LOG_FILE" ]; then
        return
    fi
    
    YESTERDAY=$(date -d "yesterday" +%Y%m%d)
    ROTATED_FILE="${LOG_FILE}.${YESTERDAY}"
    
    if [ ! -f "${ROTATED_FILE}.gz" ]; then
        echo "Daily rotation: $LOG_FILE"
        
        cp "$LOG_FILE" "$ROTATED_FILE"
        gzip "$ROTATED_FILE"
        > "$LOG_FILE"
    fi
}

# Xóa logs cũ
cleanup_old_logs() {
    echo "Cleaning up old logs (older than $MAX_AGE_DAYS days)..."
    
    find "$LOG_DIR" -name "*.gz" -type f -mtime +$MAX_AGE_DAYS -exec rm -f {} \;
    find "$APP_LOG_DIR" -name "*.log.*" -type f -mtime +$MAX_AGE_DAYS -exec rm -f {} \;
    
    echo "Old logs cleaned up"
}

# Archive logs to backup location
archive_logs() {
    ARCHIVE_DATE=$(date +%Y%m)
    ARCHIVE_FILE="$ARCHIVE_DIR/logs_${ARCHIVE_DATE}.tar.gz"
    
    echo "Archiving logs to: $ARCHIVE_FILE"
    
    find "$LOG_DIR" -name "*.gz" -mtime -30 -mtime +7 -print0 | \
        tar -czf "$ARCHIVE_FILE" --null -T -
    
    echo "Archive completed"
}

# Rotate application logs
rotate_app_logs() {
    for LOG_FILE in "$APP_LOG_DIR"/*.log; do
        rotate_by_size "$LOG_FILE"
    done
}

# Rotate system logs
rotate_system_logs() {
    SYSTEM_LOGS=(
        "/var/log/syslog"
        "/var/log/auth.log"
        "/var/log/kern.log"
        "/var/log/messages"
    )
    
    for LOG_FILE in "${SYSTEM_LOGS[@]}"; do
        if [ -f "$LOG_FILE" ]; then
            rotate_by_size "$LOG_FILE"
        fi
    done
}

# Main
rotate_app_logs
rotate_system_logs
cleanup_old_logs
archive_logs

# Restart rsyslog để apply changes
systemctl restart rsyslog 2>/dev/null || service rsyslog restart 2>/dev/null

echo "Log rotation completed: $(date)"
