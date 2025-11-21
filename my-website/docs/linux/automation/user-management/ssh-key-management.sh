#!/bin/bash
# SSH Key Management Script
# Quản lý SSH keys cho users

USERNAME="$1"
ACTION="$2"

usage() {
    echo "Usage: $0 username {generate|add|remove|list}"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

# Generate SSH key pair
generate_key() {
    USERNAME="$1"
    USER_HOME=$(eval echo ~$USERNAME)
    SSH_DIR="$USER_HOME/.ssh"
    KEY_FILE="$SSH_DIR/id_rsa"
    
    echo "Generating SSH key for $USERNAME..."
    
    mkdir -p "$SSH_DIR"
    
    # Generate key
    ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" -N "" -C "${USERNAME}@$(hostname)"
    
    # Set permissions
    chmod 700 "$SSH_DIR"
    chmod 600 "$KEY_FILE"
    chmod 644 "${KEY_FILE}.pub"
    chown -R "$USERNAME:$USERNAME" "$SSH_DIR"
    
    echo "✓ SSH key generated"
    echo "Public key:"
    cat "${KEY_FILE}.pub"
}

# Add public key to authorized_keys
add_key() {
    USERNAME="$1"
    PUBLIC_KEY="$2"
    USER_HOME=$(eval echo ~$USERNAME)
    AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"
    
    echo "Adding SSH key for $USERNAME..."
    
    mkdir -p "$USER_HOME/.ssh"
    
    # Check if key already exists
    if grep -q "$PUBLIC_KEY" "$AUTH_KEYS" 2>/dev/null; then
        echo "Key already exists"
        exit 0
    fi
    
    # Add key
    echo "$PUBLIC_KEY" >> "$AUTH_KEYS"
    
    # Set permissions
    chmod 700 "$USER_HOME/.ssh"
    chmod 600 "$AUTH_KEYS"
    chown -R "$USERNAME:$USERNAME" "$USER_HOME/.ssh"
    
    echo "✓ SSH key added"
}

# Remove key from authorized_keys
remove_key() {
    USERNAME="$1"
    KEY_IDENTIFIER="$2"
    USER_HOME=$(eval echo ~$USERNAME)
    AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"
    
    echo "Removing SSH key for $USERNAME..."
    
    if [ ! -f "$AUTH_KEYS" ]; then
        echo "No authorized_keys file found"
        exit 0
    fi
    
    # Backup
    cp "$AUTH_KEYS" "${AUTH_KEYS}.backup"
    
    # Remove key
    grep -v "$KEY_IDENTIFIER" "$AUTH_KEYS" > "${AUTH_KEYS}.tmp"
    mv "${AUTH_KEYS}.tmp" "$AUTH_KEYS"
    
    chmod 600 "$AUTH_KEYS"
    chown "$USERNAME:$USERNAME" "$AUTH_KEYS"
    
    echo "✓ SSH key removed"
}

# List all keys
list_keys() {
    USERNAME="$1"
    USER_HOME=$(eval echo ~$USERNAME)
    AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"
    
    echo "SSH keys for $USERNAME:"
    echo "----------------------------------------"
    
    if [ -f "$AUTH_KEYS" ]; then
        cat "$AUTH_KEYS" | while read line; do
            echo "$line" | awk '{print $NF}'
        done
    else
        echo "No keys found"
    fi
}

# Main
case "$ACTION" in
    generate)
        generate_key "$USERNAME"
        ;;
    add)
        echo "Enter public key:"
        read PUBLIC_KEY
        add_key "$USERNAME" "$PUBLIC_KEY"
        ;;
    remove)
        echo "Enter key identifier to remove:"
        read KEY_ID
        remove_key "$USERNAME" "$KEY_ID"
        ;;
    list)
        list_keys "$USERNAME"
        ;;
    *)
        usage
        ;;
esac
