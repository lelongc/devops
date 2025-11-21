#!/bin/bash
# Remote Backup Script
# Đồng bộ backup lên remote server hoặc cloud storage

DATE=$(date +%Y%m%d_%H%M%S)
LOCAL_BACKUP_DIR="/backup"
REMOTE_USER="backup"
REMOTE_HOST="backup-server.example.com"
REMOTE_DIR="/remote-backup"
LOG_FILE="/var/log/remote-backup.log"

# Backup qua SSH/rsync
backup_via_rsync() {
    echo "$(date): Starting rsync to remote server..." | tee -a "$LOG_FILE"
    
    rsync -avz --delete \
        --exclude='*.tmp' \
        --exclude='*.log' \
        -e "ssh -i /root/.ssh/backup_key" \
        "$LOCAL_BACKUP_DIR/" \
        "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
    
    if [ $? -eq 0 ]; then
        echo "$(date): ✓ Rsync completed successfully" | tee -a "$LOG_FILE"
    else
        echo "$(date): ✗ Rsync failed" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Backup lên AWS S3
backup_to_s3() {
    S3_BUCKET="s3://my-company-backups"
    
    echo "$(date): Starting S3 sync..." | tee -a "$LOG_FILE"
    
    aws s3 sync "$LOCAL_BACKUP_DIR" "$S3_BUCKET/backups/" \
        --exclude "*.log" \
        --exclude "*.tmp" \
        --storage-class STANDARD_IA
    
    if [ $? -eq 0 ]; then
        echo "$(date): ✓ S3 sync completed successfully" | tee -a "$LOG_FILE"
    else
        echo "$(date): ✗ S3 sync failed" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Backup lên Google Cloud Storage
backup_to_gcs() {
    GCS_BUCKET="gs://my-company-backups"
    
    echo "$(date): Starting GCS sync..." | tee -a "$LOG_FILE"
    
    gsutil -m rsync -r -d "$LOCAL_BACKUP_DIR" "$GCS_BUCKET/backups/"
    
    if [ $? -eq 0 ]; then
        echo "$(date): ✓ GCS sync completed successfully" | tee -a "$LOG_FILE"
    else
        echo "$(date): ✗ GCS sync failed" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Backup qua FTP
backup_via_ftp() {
    FTP_HOST="ftp.example.com"
    FTP_USER="backup"
    FTP_PASS="password"
    
    echo "$(date): Starting FTP upload..." | tee -a "$LOG_FILE"
    
    lftp -c "
    open -u $FTP_USER,$FTP_PASS $FTP_HOST
    mirror -R --verbose $LOCAL_BACKUP_DIR /backups/
    bye
    "
    
    if [ $? -eq 0 ]; then
        echo "$(date): ✓ FTP upload completed successfully" | tee -a "$LOG_FILE"
    else
        echo "$(date): ✗ FTP upload failed" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Kiểm tra dung lượng trước khi backup
check_disk_space() {
    LOCAL_USAGE=$(df "$LOCAL_BACKUP_DIR" | tail -1 | awk '{print $5}' | sed 's/%//')
    
    if [ "$LOCAL_USAGE" -gt 90 ]; then
        echo "$(date): Warning: Local disk usage is ${LOCAL_USAGE}%" | tee -a "$LOG_FILE"
        # Xóa backup cũ nhất
        find "$LOCAL_BACKUP_DIR" -type f -name "*.tar.gz" | sort | head -5 | xargs rm -f
    fi
}

# Main
check_disk_space
backup_via_rsync
backup_to_s3

echo "$(date): Remote backup completed" | tee -a "$LOG_FILE"
