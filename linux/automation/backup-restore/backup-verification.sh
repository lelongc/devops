#!/bin/bash
# Backup Verification Script
# Kiểm tra tính toàn vẹn của backup files

BACKUP_DIR="/backup"
LOG_FILE="/var/log/backup-verification.log"
EMAIL="admin@example.com"

echo "$(date): Starting backup verification..." | tee -a "$LOG_FILE"

# Kiểm tra backup files tồn tại
verify_backup_exists() {
    REQUIRED_BACKUPS=("database/mysql" "database/postgresql" "files")
    
    for BACKUP_TYPE in "${REQUIRED_BACKUPS[@]}"; do
        LATEST=$(find "$BACKUP_DIR/$BACKUP_TYPE" -type f -name "*.gz" -mtime -1 | head -1)
        
        if [ -z "$LATEST" ]; then
            echo "$(date): ✗ No recent backup found for: $BACKUP_TYPE" | tee -a "$LOG_FILE"
            return 1
        else
            echo "$(date): ✓ Found recent backup: $(basename "$LATEST")" | tee -a "$LOG_FILE"
        fi
    done
}

# Kiểm tra tính toàn vẹn file (checksum)
verify_integrity() {
    CHECKSUM_FILE="$BACKUP_DIR/checksums.txt"
    
    find "$BACKUP_DIR" -type f -name "*.gz" -mtime -1 | while read file; do
        if [ -f "$file" ]; then
            # Tạo checksum
            CURRENT_MD5=$(md5sum "$file" | awk '{print $1}')
            
            # Kiểm tra file có thể giải nén
            if gzip -t "$file" 2>/dev/null; then
                echo "$(date): ✓ Integrity OK: $(basename "$file")" | tee -a "$LOG_FILE"
                echo "$CURRENT_MD5  $file" >> "$CHECKSUM_FILE"
            else
                echo "$(date): ✗ Corrupted file: $(basename "$file")" | tee -a "$LOG_FILE"
                return 1
            fi
        fi
    done
}

# Kiểm tra dung lượng backup
verify_size() {
    find "$BACKUP_DIR" -type f -name "*.gz" -mtime -1 | while read file; do
        SIZE=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
        SIZE_MB=$((SIZE / 1024 / 1024))
        
        if [ "$SIZE_MB" -lt 1 ]; then
            echo "$(date): ⚠ Warning: Small backup file: $(basename "$file") (${SIZE_MB}MB)" | tee -a "$LOG_FILE"
        else
            echo "$(date): ✓ Size OK: $(basename "$file") (${SIZE_MB}MB)" | tee -a "$LOG_FILE"
        fi
    done
}

# Test restore (optional - trong môi trường test)
test_restore() {
    TEST_DIR="/tmp/restore_test_$$"
    mkdir -p "$TEST_DIR"
    
    LATEST_BACKUP=$(find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime -1 | head -1)
    
    if [ -n "$LATEST_BACKUP" ]; then
        echo "$(date): Testing restore: $(basename "$LATEST_BACKUP")" | tee -a "$LOG_FILE"
        
        tar -xzf "$LATEST_BACKUP" -C "$TEST_DIR" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo "$(date): ✓ Test restore successful" | tee -a "$LOG_FILE"
            rm -rf "$TEST_DIR"
        else
            echo "$(date): ✗ Test restore failed" | tee -a "$LOG_FILE"
            rm -rf "$TEST_DIR"
            return 1
        fi
    fi
}

# Gửi báo cáo
send_report() {
    STATUS="$1"
    SUBJECT="Backup Verification Report - $STATUS"
    
    {
        echo "Backup Verification Report"
        echo "=========================="
        echo "Date: $(date)"
        echo "Status: $STATUS"
        echo ""
        tail -20 "$LOG_FILE"
    } | mail -s "$SUBJECT" "$EMAIL"
}

# Main
if verify_backup_exists && verify_integrity && verify_size; then
    echo "$(date): ✓ All verifications passed" | tee -a "$LOG_FILE"
    send_report "SUCCESS"
    exit 0
else
    echo "$(date): ✗ Verification failed" | tee -a "$LOG_FILE"
    send_report "FAILED"
    exit 1
fi
