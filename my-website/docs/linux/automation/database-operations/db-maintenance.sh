#!/bin/bash
# Database Backup and Maintenance Script
# Sao lưu, optimize và maintain databases

DB_TYPE="${1:-mysql}"
DB_NAME="$2"
ACTION="${3:-backup}"

usage() {
    echo "Usage: $0 {mysql|postgresql|mongodb} database_name {backup|optimize|repair}"
    exit 1
}

# MySQL operations
mysql_backup() {
    DB_NAME="$1"
    BACKUP_DIR="/backup/mysql"
    DATE=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$BACKUP_DIR"
    
    echo "Backing up MySQL database: $DB_NAME"
    
    mysqldump --single-transaction --quick \
        --routines --triggers --events \
        "$DB_NAME" | gzip > "$BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz"
    
    echo "✓ Backup completed: $BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz"
}

mysql_optimize() {
    DB_NAME="$1"
    
    echo "Optimizing MySQL database: $DB_NAME"
    
    # Get all tables
    TABLES=$(mysql -NBe "SELECT table_name FROM information_schema.tables WHERE table_schema='$DB_NAME'")
    
    for TABLE in $TABLES; do
        echo "Optimizing table: $TABLE"
        mysql -e "OPTIMIZE TABLE $DB_NAME.$TABLE"
    done
    
    echo "✓ Optimization completed"
}

mysql_repair() {
    DB_NAME="$1"
    
    echo "Repairing MySQL database: $DB_NAME"
    
    TABLES=$(mysql -NBe "SELECT table_name FROM information_schema.tables WHERE table_schema='$DB_NAME'")
    
    for TABLE in $TABLES; do
        echo "Checking table: $TABLE"
        mysql -e "CHECK TABLE $DB_NAME.$TABLE"
        
        echo "Repairing table: $TABLE"
        mysql -e "REPAIR TABLE $DB_NAME.$TABLE"
    done
    
    echo "✓ Repair completed"
}

# PostgreSQL operations
postgresql_backup() {
    DB_NAME="$1"
    BACKUP_DIR="/backup/postgresql"
    DATE=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$BACKUP_DIR"
    
    echo "Backing up PostgreSQL database: $DB_NAME"
    
    pg_dump -Fc "$DB_NAME" > "$BACKUP_DIR/${DB_NAME}_${DATE}.dump"
    
    echo "✓ Backup completed: $BACKUP_DIR/${DB_NAME}_${DATE}.dump"
}

postgresql_vacuum() {
    DB_NAME="$1"
    
    echo "Vacuuming PostgreSQL database: $DB_NAME"
    
    psql -d "$DB_NAME" -c "VACUUM ANALYZE"
    
    echo "✓ Vacuum completed"
}

postgresql_reindex() {
    DB_NAME="$1"
    
    echo "Reindexing PostgreSQL database: $DB_NAME"
    
    reindexdb "$DB_NAME"
    
    echo "✓ Reindex completed"
}

# MongoDB operations
mongodb_backup() {
    DB_NAME="$1"
    BACKUP_DIR="/backup/mongodb"
    DATE=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$BACKUP_DIR"
    
    echo "Backing up MongoDB database: $DB_NAME"
    
    mongodump --db "$DB_NAME" --out "$BACKUP_DIR/${DB_NAME}_${DATE}"
    tar -czf "$BACKUP_DIR/${DB_NAME}_${DATE}.tar.gz" -C "$BACKUP_DIR" "${DB_NAME}_${DATE}"
    rm -rf "$BACKUP_DIR/${DB_NAME}_${DATE}"
    
    echo "✓ Backup completed: $BACKUP_DIR/${DB_NAME}_${DATE}.tar.gz"
}

mongodb_compact() {
    DB_NAME="$1"
    
    echo "Compacting MongoDB database: $DB_NAME"
    
    mongo "$DB_NAME" --eval "db.runCommand({compact: 'collection_name'})"
    
    echo "✓ Compaction completed"
}

# Main
if [ -z "$DB_NAME" ]; then
    usage
fi

case "$DB_TYPE" in
    mysql)
        case "$ACTION" in
            backup) mysql_backup "$DB_NAME" ;;
            optimize) mysql_optimize "$DB_NAME" ;;
            repair) mysql_repair "$DB_NAME" ;;
            *) usage ;;
        esac
        ;;
    postgresql|postgres)
        case "$ACTION" in
            backup) postgresql_backup "$DB_NAME" ;;
            optimize) postgresql_vacuum "$DB_NAME" ;;
            reindex) postgresql_reindex "$DB_NAME" ;;
            *) usage ;;
        esac
        ;;
    mongodb|mongo)
        case "$ACTION" in
            backup) mongodb_backup "$DB_NAME" ;;
            optimize) mongodb_compact "$DB_NAME" ;;
            *) usage ;;
        esac
        ;;
    *)
        usage
        ;;
esac
