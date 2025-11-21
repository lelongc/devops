#!/bin/bash
# Security Audit Script
# Kiểm tra bảo mật hệ thống

REPORT_FILE="/tmp/security-audit-$(date +%Y%m%d).txt"
ALERT_EMAIL="security@example.com"

echo "Security Audit Report - $(date)" > "$REPORT_FILE"
echo "========================================" >> "$REPORT_FILE"

# Check for users with UID 0
check_root_users() {
    echo -e "\n### ROOT USERS (UID 0) ###" >> "$REPORT_FILE"
    
    ROOT_USERS=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
    
    for USER in $ROOT_USERS; do
        if [ "$USER" != "root" ]; then
            echo "⚠ Warning: User $USER has UID 0" >> "$REPORT_FILE"
        else
            echo "✓ Root user check OK" >> "$REPORT_FILE"
        fi
    done
}

# Check for empty password users
check_empty_passwords() {
    echo -e "\n### EMPTY PASSWORD CHECK ###" >> "$REPORT_FILE"
    
    EMPTY_PASS=$(awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null)
    
    if [ -n "$EMPTY_PASS" ]; then
        echo "⚠ Users with empty/locked passwords:" >> "$REPORT_FILE"
        echo "$EMPTY_PASS" >> "$REPORT_FILE"
    else
        echo "✓ No users with empty passwords" >> "$REPORT_FILE"
    fi
}

# Check SSH configuration
check_ssh_config() {
    echo -e "\n### SSH CONFIGURATION ###" >> "$REPORT_FILE"
    
    SSH_CONFIG="/etc/ssh/sshd_config"
    
    # Check root login
    if grep -q "^PermitRootLogin yes" "$SSH_CONFIG"; then
        echo "⚠ Root login is enabled" >> "$REPORT_FILE"
    else
        echo "✓ Root login is disabled" >> "$REPORT_FILE"
    fi
    
    # Check password authentication
    if grep -q "^PasswordAuthentication yes" "$SSH_CONFIG"; then
        echo "⚠ Password authentication is enabled" >> "$REPORT_FILE"
    else
        echo "✓ Password authentication is disabled" >> "$REPORT_FILE"
    fi
    
    # Check SSH protocol
    if grep -q "^Protocol 2" "$SSH_CONFIG"; then
        echo "✓ SSH Protocol 2 is configured" >> "$REPORT_FILE"
    else
        echo "⚠ SSH Protocol not explicitly set to 2" >> "$REPORT_FILE"
    fi
}

# Check file permissions
check_file_permissions() {
    echo -e "\n### SENSITIVE FILE PERMISSIONS ###" >> "$REPORT_FILE"
    
    SENSITIVE_FILES=(
        "/etc/passwd"
        "/etc/shadow"
        "/etc/group"
        "/etc/ssh/sshd_config"
    )
    
    for FILE in "${SENSITIVE_FILES[@]}"; do
        if [ -f "$FILE" ]; then
            PERMS=$(stat -c "%a" "$FILE")
            echo "$FILE: $PERMS" >> "$REPORT_FILE"
        fi
    done
}

# Check for world-writable files
check_world_writable() {
    echo -e "\n### WORLD-WRITABLE FILES ###" >> "$REPORT_FILE"
    
    WRITABLE=$(find / -xdev -type f -perm -002 2>/dev/null | head -20)
    
    if [ -n "$WRITABLE" ]; then
        echo "⚠ World-writable files found:" >> "$REPORT_FILE"
        echo "$WRITABLE" >> "$REPORT_FILE"
    else
        echo "✓ No critical world-writable files found" >> "$REPORT_FILE"
    fi
}

# Check for SUID/SGID files
check_suid_files() {
    echo -e "\n### SUID/SGID FILES ###" >> "$REPORT_FILE"
    
    SUID_FILES=$(find / -xdev \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null | head -20)
    
    echo "SUID/SGID files:" >> "$REPORT_FILE"
    echo "$SUID_FILES" >> "$REPORT_FILE"
}

# Check open ports
check_open_ports() {
    echo -e "\n### OPEN PORTS ###" >> "$REPORT_FILE"
    
    netstat -tuln | grep LISTEN >> "$REPORT_FILE"
}

# Check failed login attempts
check_failed_logins() {
    echo -e "\n### FAILED LOGIN ATTEMPTS (Last 24h) ###" >> "$REPORT_FILE"
    
    FAILED=$(grep "Failed password" /var/log/auth.log 2>/dev/null | grep "$(date +%b\ %d)" | wc -l)
    
    echo "Failed login attempts today: $FAILED" >> "$REPORT_FILE"
    
    if [ "$FAILED" -gt 10 ]; then
        echo "⚠ High number of failed login attempts" >> "$REPORT_FILE"
    fi
}

# Check system updates
check_updates() {
    echo -e "\n### SYSTEM UPDATES ###" >> "$REPORT_FILE"
    
    if command -v apt &> /dev/null; then
        apt update -qq
        UPDATES=$(apt list --upgradable 2>/dev/null | wc -l)
        echo "Available updates: $UPDATES" >> "$REPORT_FILE"
    elif command -v yum &> /dev/null; then
        UPDATES=$(yum check-update -q | wc -l)
        echo "Available updates: $UPDATES" >> "$REPORT_FILE"
    fi
}

# Check firewall status
check_firewall() {
    echo -e "\n### FIREWALL STATUS ###" >> "$REPORT_FILE"
    
    if command -v ufw &> /dev/null; then
        ufw status >> "$REPORT_FILE"
    elif command -v firewall-cmd &> /dev/null; then
        firewall-cmd --list-all >> "$REPORT_FILE"
    else
        iptables -L -n >> "$REPORT_FILE"
    fi
}

# Main audit
echo "Running security audit..."

check_root_users
check_empty_passwords
check_ssh_config
check_file_permissions
check_world_writable
check_suid_files
check_open_ports
check_failed_logins
check_updates
check_firewall

# Display report
cat "$REPORT_FILE"

# Send email if critical issues found
CRITICAL=$(grep -c "⚠" "$REPORT_FILE")
if [ "$CRITICAL" -gt 0 ]; then
    mail -s "Security Audit: $CRITICAL Issues Found" "$ALERT_EMAIL" < "$REPORT_FILE"
fi

echo -e "\nReport saved to: $REPORT_FILE"
