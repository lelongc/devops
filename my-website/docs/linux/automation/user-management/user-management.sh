#!/bin/bash
# User Management Script
# Tạo, xóa và quản lý users

ACTION="$1"
USERNAME="$2"

usage() {
    echo "Usage: $0 {create|delete|disable|enable|reset-password} username"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

# Tạo user mới
create_user() {
    USERNAME="$1"
    
    echo "Creating user: $USERNAME"
    
    # Check if user exists
    if id "$USERNAME" &>/dev/null; then
        echo "Error: User $USERNAME already exists"
        exit 1
    fi
    
    # Create user
    useradd -m -s /bin/bash "$USERNAME"
    
    # Set random password
    PASSWORD=$(openssl rand -base64 12)
    echo "$USERNAME:$PASSWORD" | chpasswd
    
    # Force password change on first login
    chage -d 0 "$USERNAME"
    
    # Create SSH directory
    USER_HOME=$(eval echo ~$USERNAME)
    mkdir -p "$USER_HOME/.ssh"
    chmod 700 "$USER_HOME/.ssh"
    touch "$USER_HOME/.ssh/authorized_keys"
    chmod 600 "$USER_HOME/.ssh/authorized_keys"
    chown -R "$USERNAME:$USERNAME" "$USER_HOME/.ssh"
    
    echo "✓ User $USERNAME created"
    echo "Temporary password: $PASSWORD"
    echo "User must change password on first login"
}

# Xóa user
delete_user() {
    USERNAME="$1"
    
    echo "Deleting user: $USERNAME"
    
    if ! id "$USERNAME" &>/dev/null; then
        echo "Error: User $USERNAME does not exist"
        exit 1
    fi
    
    # Backup user home directory
    BACKUP_DIR="/backup/users"
    mkdir -p "$BACKUP_DIR"
    tar -czf "$BACKUP_DIR/${USERNAME}_$(date +%Y%m%d).tar.gz" "/home/$USERNAME" 2>/dev/null
    
    # Delete user and home directory
    userdel -r "$USERNAME"
    
    echo "✓ User $USERNAME deleted"
    echo "Home directory backed up to: $BACKUP_DIR/${USERNAME}_$(date +%Y%m%d).tar.gz"
}

# Disable user
disable_user() {
    USERNAME="$1"
    
    echo "Disabling user: $USERNAME"
    
    if ! id "$USERNAME" &>/dev/null; then
        echo "Error: User $USERNAME does not exist"
        exit 1
    fi
    
    # Lock account
    usermod -L "$USERNAME"
    
    # Expire account
    usermod -e 1 "$USERNAME"
    
    echo "✓ User $USERNAME disabled"
}

# Enable user
enable_user() {
    USERNAME="$1"
    
    echo "Enabling user: $USERNAME"
    
    if ! id "$USERNAME" &>/dev/null; then
        echo "Error: User $USERNAME does not exist"
        exit 1
    fi
    
    # Unlock account
    usermod -U "$USERNAME"
    
    # Remove expiration
    usermod -e "" "$USERNAME"
    
    echo "✓ User $USERNAME enabled"
}

# Reset password
reset_password() {
    USERNAME="$1"
    
    echo "Resetting password for: $USERNAME"
    
    if ! id "$USERNAME" &>/dev/null; then
        echo "Error: User $USERNAME does not exist"
        exit 1
    fi
    
    # Generate random password
    NEW_PASSWORD=$(openssl rand -base64 12)
    echo "$USERNAME:$NEW_PASSWORD" | chpasswd
    
    # Force password change
    chage -d 0 "$USERNAME"
    
    echo "✓ Password reset for $USERNAME"
    echo "New temporary password: $NEW_PASSWORD"
    echo "User must change password on next login"
}

# Bulk user creation
bulk_create_users() {
    USER_LIST="$1"
    
    if [ ! -f "$USER_LIST" ]; then
        echo "Error: User list file not found"
        exit 1
    fi
    
    while IFS=, read -r username fullname email; do
        if ! id "$username" &>/dev/null; then
            create_user "$username"
            
            # Add additional info
            if [ -n "$fullname" ]; then
                usermod -c "$fullname" "$username"
            fi
            
            echo "Created: $username ($fullname, $email)"
        fi
    done < "$USER_LIST"
}

# List users
list_users() {
    echo "System users:"
    echo "----------------------------------------"
    awk -F: '$3 >= 1000 && $1 != "nobody" {print $1, $3, $6}' /etc/passwd | column -t
}

# Main
case "$ACTION" in
    create)
        create_user "$USERNAME"
        ;;
    delete)
        delete_user "$USERNAME"
        ;;
    disable)
        disable_user "$USERNAME"
        ;;
    enable)
        enable_user "$USERNAME"
        ;;
    reset-password)
        reset_password "$USERNAME"
        ;;
    list)
        list_users
        ;;
    *)
        usage
        ;;
esac
