#!/bin/bash

set -e

# Configuration
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=7

echo "🔄 Starting backup process..."

# Create backup directory
mkdir -p $BACKUP_DIR

# Database backup
echo "📊 Backing up PostgreSQL database..."
docker exec postgres-container pg_dump -U $POSTGRES_USER $POSTGRES_DB > $BACKUP_DIR/postgres_$DATE.sql

# Volume backups
echo "💾 Backing up Docker volumes..."
docker run --rm -v postgres_data:/data -v $BACKUP_DIR:/backup alpine tar czf /backup/postgres_volume_$DATE.tar.gz /data

docker run --rm -v redis_data:/data -v $BACKUP_DIR:/backup alpine tar czf /backup/redis_volume_$DATE.tar.gz /data

# Application files backup
echo "📁 Backing up application files..."
tar czf $BACKUP_DIR/app_files_$DATE.tar.gz --exclude=node_modules --exclude=.git .

# Configuration backup
echo "⚙️ Backing up configurations..."
tar czf $BACKUP_DIR/configs_$DATE.tar.gz env/ nginx/ monitoring/ logging/

# Cleanup old backups
echo "🧹 Cleaning up old backups..."
find $BACKUP_DIR -name "*.sql" -mtime +$RETENTION_DAYS -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete

# Upload to cloud (optional)
if [ "$BACKUP_TO_S3" = "true" ]; then
    echo "☁️ Uploading to S3..."
    aws s3 sync $BACKUP_DIR s3://$S3_BACKUP_BUCKET/$(hostname)/ --exclude "*" --include "*$DATE*"
fi

echo "✅ Backup completed successfully!"
