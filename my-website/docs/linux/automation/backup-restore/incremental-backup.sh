#!/bin/bash
# Incremental Backup Script
# Sao lưu tăng dần chỉ backup các file thay đổi

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/incremental"
SOURCE_DIR="/var/www/production"
SNAPSHOT_FILE="$BACKUP_DIR/snapshot.file"

mkdir -p "$BACKUP_DIR"

# Backup đầy đủ vào ngày chủ nhật
if [ $(date +%u) -eq 7 ]; then
    BACKUP_TYPE="full"
    BACKUP_FILE="$BACKUP_DIR/full_${DATE}.tar.gz"
    
    tar -czf "$BACKUP_FILE" "$SOURCE_DIR"
    tar -czf "$SNAPSHOT_FILE.gz" -C "$SOURCE_DIR" .
    
    echo "Full backup completed: $BACKUP_FILE"
else
    # Backup tăng dần các ngày khác
    BACKUP_TYPE="incremental"
    BACKUP_FILE="$BACKUP_DIR/incremental_${DATE}.tar.gz"
    
    if [ -f "$SNAPSHOT_FILE.gz" ]; then
        tar -czf "$BACKUP_FILE" --listed-incremental="$SNAPSHOT_FILE" "$SOURCE_DIR"
        echo "Incremental backup completed: $BACKUP_FILE"
    else
        echo "Error: Snapshot file not found. Run full backup first."
        exit 1
    fi
fi

# Log kết quả
echo "$(date): $BACKUP_TYPE backup - $BACKUP_FILE ($(du -h "$BACKUP_FILE" | cut -f1))" >> "$BACKUP_DIR/backup.log"
