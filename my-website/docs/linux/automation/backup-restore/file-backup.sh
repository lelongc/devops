#!/bin/bash
# File System Backup Script
# Sao lưu thư mục và files quan trọng

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/files"
SOURCE_DIRS=("/var/www" "/etc" "/home" "/opt/applications")
RETENTION_DAYS=30

mkdir -p "$BACKUP_DIR"

# Backup từng thư mục
for SOURCE in "${SOURCE_DIRS[@]}"; do
    if [ -d "$SOURCE" ]; then
        DIR_NAME=$(basename "$SOURCE")
        BACKUP_FILE="$BACKUP_DIR/${DIR_NAME}_${DATE}.tar.gz"
        
        echo "Backing up $SOURCE..."
        tar -czf "$BACKUP_FILE" "$SOURCE" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo "✓ Backup completed: $BACKUP_FILE"
            echo "Size: $(du -h "$BACKUP_FILE" | cut -f1)"
        else
            echo "✗ Backup failed for $SOURCE"
        fi
    fi
done

# Xóa backup cũ hơn RETENTION_DAYS
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
echo "Cleaned up backups older than $RETENTION_DAYS days"

# Gửi thông báo
echo "Backup job completed at $(date)" | mail -s "File Backup Report" admin@example.com
