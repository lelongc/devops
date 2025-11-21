#!/bin/bash
# Database Restore Script
# Khôi phục database từ backup

BACKUP_DIR="/backup/database"

# Restore MySQL
restore_mysql() {
    BACKUP_FILE="$1"
    DB_NAME="$2"
    DB_USER="root"
    DB_PASS="password"
    
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Error: Backup file not found: $BACKUP_FILE"
        exit 1
    fi
    
    echo "Restoring MySQL database: $DB_NAME"
    
    # Tạo database nếu chưa có
    mysql -u"$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
    
    # Restore
    gunzip < "$BACKUP_FILE" | mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ MySQL restore completed successfully"
    else
        echo "✗ MySQL restore failed"
        exit 1
    fi
}

# Restore PostgreSQL
restore_postgresql() {
    BACKUP_FILE="$1"
    DB_NAME="$2"
    DB_USER="postgres"
    
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Error: Backup file not found: $BACKUP_FILE"
        exit 1
    fi
    
    echo "Restoring PostgreSQL database: $DB_NAME"
    
    # Drop và tạo lại database
    dropdb -U "$DB_USER" "$DB_NAME" 2>/dev/null
    createdb -U "$DB_USER" "$DB_NAME"
    
    # Restore
    gunzip < "$BACKUP_FILE" | psql -U "$DB_USER" "$DB_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ PostgreSQL restore completed successfully"
    else
        echo "✗ PostgreSQL restore failed"
        exit 1
    fi
}

# Restore MongoDB
restore_mongodb() {
    BACKUP_FILE="$1"
    DB_NAME="$2"
    TEMP_DIR="/tmp/mongo_restore_$$"
    
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Error: Backup file not found: $BACKUP_FILE"
        exit 1
    fi
    
    echo "Restoring MongoDB database: $DB_NAME"
    
    mkdir -p "$TEMP_DIR"
    tar -xzf "$BACKUP_FILE" -C "$TEMP_DIR"
    
    mongorestore --db "$DB_NAME" --drop "$TEMP_DIR"/*
    
    rm -rf "$TEMP_DIR"
    
    if [ $? -eq 0 ]; then
        echo "✓ MongoDB restore completed successfully"
    else
        echo "✗ MongoDB restore failed"
        exit 1
    fi
}

# Liệt kê backups có sẵn
list_backups() {
    echo "Available backups:"
    echo "===================="
    find "$BACKUP_DIR" -type f -name "*.gz" -printf "%T@ %p\n" | sort -rn | head -20 | while read timestamp file; do
        date -d "@$timestamp" "+%Y-%m-%d %H:%M:%S" | tr -d '\n'
        echo " - $(basename "$file")"
    done
}

# Main
if [ $# -lt 2 ]; then
    echo "Usage: $0 <database_type> <backup_file> <database_name>"
    echo "Example: $0 mysql /backup/database/mysql/production_db_20250121.sql.gz production_db"
    list_backups
    exit 1
fi

DB_TYPE="$1"
BACKUP_FILE="$2"
DB_NAME="$3"

case "$DB_TYPE" in
    mysql)
        restore_mysql "$BACKUP_FILE" "$DB_NAME"
        ;;
    postgresql|postgres)
        restore_postgresql "$BACKUP_FILE" "$DB_NAME"
        ;;
    mongodb|mongo)
        restore_mongodb "$BACKUP_FILE" "$DB_NAME"
        ;;
    *)
        echo "Error: Unknown database type: $DB_TYPE"
        echo "Supported types: mysql, postgresql, mongodb"
        exit 1
        ;;
esac
