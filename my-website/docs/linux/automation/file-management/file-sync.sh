#!/bin/bash
# File Synchronization Script
# Đồng bộ files giữa servers hoặc directories

SOURCE_DIR="$1"
DEST_DIR="$2"
SYNC_TYPE="${3:-rsync}"

usage() {
    echo "Usage: $0 source_dir destination_dir [rsync|scp|ftp]"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

# Rsync synchronization
sync_with_rsync() {
    SOURCE="$1"
    DEST="$2"
    
    echo "Syncing with rsync: $SOURCE -> $DEST"
    
    rsync -avz --progress \
        --delete \
        --exclude='.git' \
        --exclude='node_modules' \
        --exclude='*.tmp' \
        --backup --backup-dir=/backup/rsync-backup-$(date +%Y%m%d) \
        "$SOURCE/" "$DEST/"
    
    if [ $? -eq 0 ]; then
        echo "✓ Rsync completed successfully"
    else
        echo "✗ Rsync failed"
        exit 1
    fi
}

# Remote rsync over SSH
sync_remote_rsync() {
    SOURCE="$1"
    REMOTE_USER="$2"
    REMOTE_HOST="$3"
    REMOTE_DIR="$4"
    
    echo "Syncing to remote server: $REMOTE_HOST"
    
    rsync -avz --progress \
        -e "ssh -i ~/.ssh/sync_key" \
        --delete \
        --exclude='.git' \
        "$SOURCE/" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
    
    if [ $? -eq 0 ]; then
        echo "✓ Remote sync completed"
    else
        echo "✗ Remote sync failed"
        exit 1
    fi
}

# SCP sync
sync_with_scp() {
    SOURCE="$1"
    REMOTE_USER="$2"
    REMOTE_HOST="$3"
    REMOTE_DIR="$4"
    
    echo "Syncing with SCP..."
    
    scp -r "$SOURCE"/* "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
    
    if [ $? -eq 0 ]; then
        echo "✓ SCP sync completed"
    else
        echo "✗ SCP sync failed"
        exit 1
    fi
}

# Bidirectional sync
bidirectional_sync() {
    DIR1="$1"
    DIR2="$2"
    
    echo "Performing bidirectional sync..."
    
    # Sync from DIR1 to DIR2
    rsync -avz --update "$DIR1/" "$DIR2/"
    
    # Sync from DIR2 to DIR1
    rsync -avz --update "$DIR2/" "$DIR1/"
    
    echo "✓ Bidirectional sync completed"
}

# Watch and auto-sync
watch_and_sync() {
    SOURCE_DIR="$1"
    DEST_DIR="$2"
    
    echo "Watching $SOURCE_DIR for changes..."
    
    if ! command -v inotifywait &> /dev/null; then
        echo "Installing inotify-tools..."
        apt-get install -y inotify-tools
    fi
    
    inotifywait -m -r -e modify,create,delete,move "$SOURCE_DIR" |
    while read path action file; do
        echo "Change detected: $action $file"
        rsync -avz --delete "$SOURCE_DIR/" "$DEST_DIR/"
        echo "✓ Synced at $(date)"
    done
}

# Main
case "$SYNC_TYPE" in
    rsync)
        sync_with_rsync "$SOURCE_DIR" "$DEST_DIR"
        ;;
    remote)
        sync_remote_rsync "$SOURCE_DIR" "user" "remote.server.com" "/remote/path"
        ;;
    scp)
        sync_with_scp "$SOURCE_DIR" "user" "remote.server.com" "/remote/path"
        ;;
    bidirectional)
        bidirectional_sync "$SOURCE_DIR" "$DEST_DIR"
        ;;
    watch)
        watch_and_sync "$SOURCE_DIR" "$DEST_DIR"
        ;;
    *)
        sync_with_rsync "$SOURCE_DIR" "$DEST_DIR"
        ;;
esac
