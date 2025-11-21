#!/bin/bash
# File Archiving Script
# Nén và archive files cũ

ARCHIVE_DIR="/archive"
SOURCE_DIR="${1:-.}"
DAYS_OLD="${2:-90}"
ACTION="${3:-archive}"

mkdir -p "$ARCHIVE_DIR"

echo "File archiving started: $(date)"

# Archive old files
archive_old_files() {
    SOURCE="$1"
    DAYS="$2"
    
    echo "Archiving files older than $DAYS days from $SOURCE"
    
    ARCHIVE_FILE="$ARCHIVE_DIR/archive_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    find "$SOURCE" -type f -mtime +$DAYS -print0 | \
        tar -czf "$ARCHIVE_FILE" --null -T -
    
    if [ $? -eq 0 ]; then
        echo "✓ Archive created: $ARCHIVE_FILE"
        
        # Remove archived files
        find "$SOURCE" -type f -mtime +$DAYS -delete
        echo "✓ Old files removed"
    else
        echo "✗ Archive failed"
        exit 1
    fi
}

# Compress large files
compress_large_files() {
    SIZE_MB="${1:-100}"
    
    echo "Compressing files larger than ${SIZE_MB}MB"
    
    find . -type f -size +${SIZE_MB}M ! -name "*.gz" ! -name "*.zip" | while read file; do
        echo "Compressing: $file"
        gzip "$file"
    done
    
    echo "✓ Compression completed"
}

# Clean empty directories
clean_empty_dirs() {
    SOURCE="$1"
    
    echo "Removing empty directories from $SOURCE"
    
    find "$SOURCE" -type d -empty -delete
    
    echo "✓ Empty directories removed"
}

# Archive by file type
archive_by_type() {
    FILE_TYPE="$1"
    DAYS="$2"
    
    echo "Archiving $FILE_TYPE files older than $DAYS days"
    
    ARCHIVE_FILE="$ARCHIVE_DIR/${FILE_TYPE}_$(date +%Y%m%d).tar.gz"
    
    find . -name "*.$FILE_TYPE" -type f -mtime +$DAYS -print0 | \
        tar -czf "$ARCHIVE_FILE" --null -T -
    
    if [ $? -eq 0 ]; then
        find . -name "*.$FILE_TYPE" -type f -mtime +$DAYS -delete
        echo "✓ $FILE_TYPE files archived"
    fi
}

# Main
case "$ACTION" in
    archive)
        archive_old_files "$SOURCE_DIR" "$DAYS_OLD"
        ;;
    compress)
        compress_large_files 100
        ;;
    clean)
        clean_empty_dirs "$SOURCE_DIR"
        ;;
    type)
        archive_by_type "log" 30
        archive_by_type "tmp" 7
        ;;
    *)
        archive_old_files "$SOURCE_DIR" "$DAYS_OLD"
        ;;
esac

echo "File archiving completed: $(date)"
