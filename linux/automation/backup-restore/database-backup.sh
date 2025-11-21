#!/bin/bash
# Database Backup Script
# Tự động sao lưu database (MySQL/PostgreSQL/MongoDB)

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/database"
RETENTION_DAYS=7

# MySQL Backup
backup_mysql() {
    DB_NAME="$1"
    DB_USER="root"
    DB_PASS="password"
    
    mkdir -p "$BACKUP_DIR/mysql"
    mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" | gzip > "$BACKUP_DIR/mysql/${DB_NAME}_${DATE}.sql.gz"
    
    echo "MySQL backup completed: ${DB_NAME}_${DATE}.sql.gz"
}

# PostgreSQL Backup
backup_postgresql() {
    DB_NAME="$1"
    DB_USER="postgres"
    
    mkdir -p "$BACKUP_DIR/postgresql"
    pg_dump -U "$DB_USER" "$DB_NAME" | gzip > "$BACKUP_DIR/postgresql/${DB_NAME}_${DATE}.sql.gz"
    
    echo "PostgreSQL backup completed: ${DB_NAME}_${DATE}.sql.gz"
}

# MongoDB Backup
backup_mongodb() {
    DB_NAME="$1"
    
    mkdir -p "$BACKUP_DIR/mongodb"
    mongodump --db "$DB_NAME" --out "$BACKUP_DIR/mongodb/${DB_NAME}_${DATE}"
    tar -czf "$BACKUP_DIR/mongodb/${DB_NAME}_${DATE}.tar.gz" -C "$BACKUP_DIR/mongodb" "${DB_NAME}_${DATE}"
    rm -rf "$BACKUP_DIR/mongodb/${DB_NAME}_${DATE}"
    
    echo "MongoDB backup completed: ${DB_NAME}_${DATE}.tar.gz"
}

# Xóa backup cũ
cleanup_old_backups() {
    find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -delete
    echo "Cleaned up backups older than $RETENTION_DAYS days"
}

# Main
backup_mysql "production_db"
backup_postgresql "app_db"
backup_mongodb "analytics_db"
cleanup_old_backups
