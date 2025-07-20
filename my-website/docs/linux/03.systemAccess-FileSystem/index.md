# Linux System Access & File System - Truy Cập Hệ Thống và File System

## 🎯 Mục Tiêu Học Tập

Sau khi hoàn thành chương này, bạn sẽ:

- Hiểu các cách truy cập hệ thống Linux
- Cài đặt và sử dụng PuTTY cho SSH connection
- Nắm vững SSH command line và troubleshooting
- Hiểu về user root và quản lý password
- Nắm rõ cấu trúc Linux File System
- Thành thạo các lệnh navigation cơ bản
- Tạo và quản lý files/directories
- Sử dụng wildcards và tìm kiếm files
- Hiểu về soft links và hard links

---

## 🔐 Access to Linux System

### Các Phương Thức Truy Cập Linux

#### 1. Physical Access (Direct Console)

```bash
# Ưu điểm:
✅ Truy cập trực tiếp, không cần network
✅ Full control, có thể boot/reboot
✅ Access ngay cả khi network down
✅ Suitable cho troubleshooting

# Nhược điểm:
❌ Cần physical access to machine
❌ Không thể remote work
❌ Limited to console interface
```

#### 2. Remote Access (SSH)

```bash
# Ưu điểm:
✅ Remote access từ anywhere
✅ Secure encryption
✅ Multiple concurrent sessions
✅ File transfer capability (SCP/SFTP)

# Nhược điểm:
❌ Requires network connectivity
❌ Dependent on SSH service running
❌ Potential security risks if misconfigured
```

#### 3. Web Console Access

```bash
# Examples:
- Cockpit (RHEL/CentOS): https://server:9090
- Webmin: https://server:10000
- Cloud provider consoles (AWS, GCP, Azure)

# Use cases:
- System monitoring
- Basic administration
- When SSH is not available
```

### SSH Protocol Overview

#### SSH Architecture

```
Client Machine                    Server Machine
┌─────────────────┐               ┌─────────────────┐
│   SSH Client    │    Encrypted  │   SSH Daemon    │
│   (PuTTY/ssh)   │◄─────────────►│   (sshd)        │
│   Port: Random  │   Connection  │   Port: 22      │
└─────────────────┘               └─────────────────┘
```

#### SSH Security Features

```bash
# Encryption:
- Symmetric encryption cho data transfer
- Asymmetric encryption cho key exchange
- Hash functions cho data integrity

# Authentication Methods:
1. Password authentication
2. Public/Private key pairs
3. Certificate-based authentication
4. Multi-factor authentication (MFA)
```

---

## 📱 Download and Install PuTTY

### PuTTY Overview

**PuTTY** là SSH client miễn phí, mã nguồn mở cho Windows, cung cấp secure connection đến Linux servers.

### Download PuTTY

#### Option 1: Official Website

```bash
1. Truy cập: https://www.putty.org/
2. Click "Download PuTTY"
3. Choose "64-bit x86" cho Windows modern
4. Download putty-64bit-0.78-installer.msi
```

#### Option 2: Microsoft Store

```bash
1. Mở Microsoft Store
2. Search "PuTTY"
3. Install official PuTTY app
4. Auto-updates available
```

#### Option 3: Portable Version

```bash
1. Download putty.exe (standalone)
2. No installation required
3. Suitable cho USB drives
4. Run directly from any location
```

### PuTTY Installation Steps

#### Standard Installation

```bash
1. Run putty-64bit-installer.msi
2. Click "Next" → "Next" → "Install"
3. Installation location: C:\Program Files\PuTTY\
4. Components installed:
   - PuTTY (SSH client)
   - PuTTYgen (Key generator)
   - Pageant (Key agent)
   - PSCP (SCP client)
   - PSFTP (SFTP client)
```

#### Verify Installation

```bash
# Check installation:
1. Start Menu → Search "PuTTY"
2. Command Prompt: putty --version
3. File location: C:\Program Files\PuTTY\putty.exe
```

### PuTTY Configuration

#### Session Configuration

```bash
# Basic Settings:
Host Name: 192.168.1.100 (hoặc domain name)
Port: 22 (default SSH port)
Connection Type: SSH
Saved Sessions: "My Linux Server"

# Advanced Settings:
Terminal → Keyboard:
- Function keys: Xterm R6
- Backspace key: Control-H

Window → Appearance:
- Font: Consolas, 12pt
- Cursor: Block
- Cursor blinks: Yes

Connection → Data:
- Auto-login username: your-username
- Terminal-type string: xterm-256color
```

#### Save Session Settings

```bash
1. Enter all connection details
2. Saved Sessions: "Production Server"
3. Click "Save"
4. Double-click saved session to connect
```

---

## 🔌 Access Linux via PuTTY or SSH Command Line

### Connecting via PuTTY

#### Basic Connection Steps

```bash
1. Launch PuTTY
2. Host Name: your-server-ip hoặc domain
3. Port: 22
4. Connection type: SSH
5. Click "Open"
6. Security Alert: Click "Yes" (first time)
7. Username: your-username
8. Password: your-password
```

#### Connection Troubleshooting

```bash
# Common Issues:

❌ "Network error: Connection refused"
Solutions:
- Check if SSH service running: sudo systemctl status sshd
- Verify port 22 open: sudo netstat -tlnp | grep :22
- Check firewall: sudo firewall-cmd --list-services

❌ "Network error: Connection timed out"
Solutions:
- Ping server: ping server-ip
- Check network connectivity
- Verify correct IP/hostname
- Check if port blocked by firewall

❌ "Access denied"
Solutions:
- Verify username/password
- Check user account exists: cat /etc/passwd
- Check SSH configuration: /etc/ssh/sshd_config
```

### SSH Command Line (Native SSH Client)

#### Windows 10/11 Built-in SSH

```bash
# Enable OpenSSH Client:
Settings → Apps → Optional Features → Add Feature → OpenSSH Client

# Basic SSH command:
ssh username@server-ip
ssh admin@192.168.1.100
ssh user@example.com

# SSH with specific port:
ssh -p 2222 username@server-ip

# SSH with verbose output:
ssh -v username@server-ip
```

#### Linux/macOS SSH Commands

```bash
# Basic connection:
ssh username@hostname

# Examples:
ssh root@192.168.1.10
ssh admin@webserver.company.com
ssh -p 2222 user@remote.example.org

# SSH with key file:
ssh -i ~/.ssh/private_key username@hostname

# SSH with X11 forwarding:
ssh -X username@hostname

# SSH with local port forwarding:
ssh -L 8080:localhost:80 username@hostname
```

### SSH Key-Based Authentication

#### Generate SSH Key Pair

```bash
# On client machine:
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Output:
Generating public/private rsa key pair.
Enter file: /home/user/.ssh/id_rsa (Enter)
Enter passphrase: (optional but recommended)
Enter same passphrase again:

# Files created:
~/.ssh/id_rsa      (private key - KEEP SECRET)
~/.ssh/id_rsa.pub  (public key - safe to share)
```

#### Copy Public Key to Server

```bash
# Method 1: ssh-copy-id (Linux/macOS)
ssh-copy-id username@hostname

# Method 2: Manual copy
cat ~/.ssh/id_rsa.pub | ssh username@hostname "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# Method 3: SCP
scp ~/.ssh/id_rsa.pub username@hostname:~/.ssh/authorized_keys
```

#### Using SSH Keys with PuTTY

##### Convert OpenSSH Key to PuTTY Format

```bash
1. Launch PuTTYgen
2. Load → Select private key file
3. Enter passphrase if set
4. Save private key → .ppk format
5. PuTTY → Connection → SSH → Auth → Browse → Select .ppk file
```

---

## 💻 Command Prompts and Getting Prompts Back

### Understanding Linux Prompts

#### Standard Prompt Format

```bash
# Basic prompt structure:
[username@hostname current_directory]$ command

# Examples:
[admin@centos7 ~]$ ls
[root@server /var/log]# tail messages
[user@ubuntu /home/user/documents]$ pwd

# Prompt components:
username    → Current logged-in user
hostname    → Server/machine name
directory   → Current working directory
$           → Regular user prompt
#           → Root user prompt
```

#### Prompt Customization

```bash
# PS1 variable controls prompt appearance:
echo $PS1

# Common PS1 examples:
export PS1="\u@\h:\w$ "           # user@host:directory$
export PS1="[\u@\h \W]\$ "        # [user@host dir]$
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "  # Colored

# Make permanent:
echo 'export PS1="\u@\h:\w$ "' >> ~/.bashrc
source ~/.bashrc
```

### Getting Prompts Back

#### When Terminal Hangs

```bash
# Scenario 1: Command hung/frozen
Ctrl + C     → Cancel current command
Ctrl + Z     → Suspend current command
Ctrl + D     → Send EOF (exit if at prompt)

# Scenario 2: Terminal unresponsive
Ctrl + Q     → Resume terminal (if Ctrl+S pressed)
Enter        → Try to get prompt back
reset        → Reset terminal settings
```

#### Background/Foreground Jobs

```bash
# Send job to background:
command &
nohup command &

# List jobs:
jobs

# Bring job to foreground:
fg %1        # Bring job 1 to foreground
fg           # Bring latest job to foreground

# Send foreground job to background:
Ctrl + Z     # Suspend
bg %1        # Resume in background
```

#### Session Management

```bash
# Screen command:
screen -S session_name    # Create named session
screen -ls               # List sessions
screen -r session_name   # Reattach to session
Ctrl + A, D             # Detach from screen

# tmux command:
tmux new -s session_name # Create session
tmux ls                 # List sessions
tmux attach -t session_name  # Attach to session
Ctrl + B, D             # Detach from tmux
```

---

## 👑 What is Root?

### Root User Overview

**Root** là superuser account trong Linux với unlimited privileges, có thể thực hiện bất kỳ operation nào trên system.

### Root Characteristics

#### Privileges and Capabilities

```bash
# Root can do:
✅ Install/remove software packages
✅ Modify system configuration files
✅ Access any file or directory
✅ Start/stop system services
✅ Add/remove user accounts
✅ Change system settings
✅ Mount/unmount filesystems
✅ Modify kernel parameters

# UID and GID:
Root UID: 0 (always zero)
Root GID: 0 (wheel group)
Home directory: /root
Shell: /bin/bash (typically)
```

#### Security Implications

```bash
# Risks of using root:
❌ Accidental system damage
❌ Security vulnerability if compromised
❌ No audit trail of who did what
❌ Malware can cause maximum damage
❌ Typos can be catastrophic

# Best practices:
✅ Use sudo instead of direct root login
✅ Disable root SSH login
✅ Use strong root password
✅ Log all root activities
✅ Principle of least privilege
```

### Root vs Sudo

#### Direct Root Access

```bash
# Switch to root:
su -                    # Become root (need root password)
su - root              # Same as above
sudo su -              # Use sudo to become root

# Root prompt:
[root@hostname ~]#     # Notice the # symbol
```

#### Sudo Usage

```bash
# Sudo advantages:
✅ Use your own password (not root password)
✅ Granular permissions control
✅ Activity logging
✅ Time-limited elevation
✅ Can be revoked easily

# Sudo examples:
sudo ls /root          # List root's home directory
sudo systemctl restart httpd  # Restart service
sudo yum install package      # Install software
sudo vim /etc/hosts          # Edit system file

# Check sudo permissions:
sudo -l                # List allowed commands
```

### Sudo Configuration

#### /etc/sudoers File

```bash
# Edit safely:
sudo visudo

# Basic syntax:
user    ALL=(ALL)    ALL
%group  ALL=(ALL)    ALL

# Examples:
admin   ALL=(ALL)    ALL           # Full sudo access
user1   ALL=(root)   /usr/bin/systemctl  # Only systemctl
%wheel  ALL=(ALL)    NOPASSWD: ALL # No password required

# Common groups:
wheel    → Administrative group (RHEL/CentOS)
sudo     → Sudo group (Ubuntu/Debian)
admin    → Administrative group (older systems)
```

#### Adding Users to Sudo

```bash
# RHEL/CentOS (wheel group):
usermod -aG wheel username

# Ubuntu/Debian (sudo group):
usermod -aG sudo username

# Verify membership:
groups username
id username
```

### Root Account Security

#### Disable Root SSH Login

```bash
# Edit SSH config:
sudo vim /etc/ssh/sshd_config

# Change:
PermitRootLogin no

# Restart SSH:
sudo systemctl restart sshd
```

#### Root Password Policy

```bash
# Set strong password:
sudo passwd root

# Password requirements:
- Minimum 12 characters
- Mix of uppercase, lowercase, numbers, symbols
- Not based on dictionary words
- Change regularly (90-180 days)
```

---

## 🔑 Changing Password

### Password Management Commands

#### passwd Command

```bash
# Change your own password:
passwd

# Root changing any user's password:
passwd username
passwd admin
passwd john

# Command flow:
Current password: (enter current password)
New password: (enter new password)
Retype new password: (confirm new password)
passwd: password updated successfully
```

#### Password Options

```bash
# Useful passwd options:
passwd -l username     # Lock user account
passwd -u username     # Unlock user account
passwd -d username     # Delete password (dangerous)
passwd -e username     # Expire password (force change)
passwd -S username     # Show password status

# Examples:
sudo passwd -l testuser     # Lock testuser
sudo passwd -u testuser     # Unlock testuser
sudo passwd -e admin        # Force admin to change password
```

### Password Policy

#### System Password Requirements

```bash
# View current policy:
cat /etc/login.defs | grep PASS

# Common settings:
PASS_MAX_DAYS   90      # Maximum password age
PASS_MIN_DAYS   1       # Minimum days between changes
PASS_MIN_LEN    8       # Minimum password length
PASS_WARN_AGE   7       # Warning days before expiration
```

#### Password Complexity (PAM)

```bash
# Configure in: /etc/security/pwquality.conf
minlen = 12              # Minimum length
minclass = 3             # Character classes required
maxrepeat = 2            # Maximum repeated characters
maxclassrepeat = 4       # Maximum same class repeat
dcredit = -1             # Require digits
ucredit = -1             # Require uppercase
lcredit = -1             # Require lowercase
ocredit = -1             # Require symbols
```

### Password Best Practices

#### Strong Password Guidelines

```bash
# Good password characteristics:
✅ 12+ characters long
✅ Mix of character types
✅ No personal information
✅ No dictionary words
✅ Unique for each system
✅ Regular changes (90-180 days)

# Password examples:
❌ Bad: admin123, password, qwerty123
✅ Good: MyS3cur3P@ssw0rd2024!, P@ssw0rd#2024$Secure
```

#### Password Management Tools

```bash
# Generate secure passwords:
openssl rand -base64 32
pwgen -s 16 1
apg -a 1 -m 12 -n 1

# Password managers:
- KeePass (open source)
- Bitwarden (free tier)
- LastPass (freemium)
- 1Password (paid)
```

### Account Security

#### Password Aging

```bash
# Set password aging:
chage -M 90 username     # Max 90 days
chage -m 1 username      # Min 1 day between changes
chage -W 7 username      # Warn 7 days before expiry
chage -E 2024-12-31 username  # Account expires

# View aging info:
chage -l username

# Example output:
Last password change                    : Jan 15, 2024
Password expires                        : Apr 15, 2024
Password inactive                       : never
Account expires                         : never
Minimum number of days between password change : 1
Maximum number of days between password change : 90
Number of days of warning before password expires : 7
```

#### Failed Login Attempts

```bash
# View failed attempts:
lastb               # Bad login attempts
faillog -u username # Failed login count for user

# Lock after failed attempts (PAM):
# Edit: /etc/security/faillock.conf
deny = 5            # Lock after 5 failed attempts
unlock_time = 900   # Unlock after 15 minutes
```

---

## 📁 Introduction to Linux File System

### File System Concept

Linux File System là hierarchical structure tổ chức tất cả files và directories trong một single tree structure, starting từ root directory (/).

### Key Characteristics

#### Everything is a File

```bash
# In Linux, everything is treated as a file:
📄 Regular files    → Documents, images, executables
📁 Directories      → Folders containing other files
🔗 Symbolic links   → Shortcuts to other files
🖥️  Device files    → Hardware devices (/dev/sda, /dev/tty)
📡 Socket files     → Network communications
🔧 Named pipes      → Inter-process communication
```

#### Case Sensitivity

```bash
# Linux is case-sensitive:
File.txt ≠ file.txt ≠ FILE.TXT

# All different files:
touch Document.txt
touch document.txt
touch DOCUMENT.TXT
ls -l Document*
```

#### No Drive Letters

```bash
# Unlike Windows (C:, D:, E:), Linux uses:
/ → Root directory (top of hierarchy)
/home → User home directories
/mnt → Mount points for additional storage
/media → Removable media mount points
```

### File System Types

#### Common File Systems

```bash
# Native Linux:
ext4     → Extended 4 (most common)
xfs      → High-performance journaling
btrfs    → Advanced features (snapshots, compression)
zfs      → Enterprise-grade with advanced features

# Cross-platform:
fat32    → Compatibility with Windows
ntfs     → Windows native (read/write support)
exfat    → Modern cross-platform

# Special:
tmpfs    → RAM-based temporary filesystem
procfs   → Virtual filesystem for process info
sysfs    → Virtual filesystem for system info
```

#### View File System Information

```bash
# Show mounted filesystems:
df -h

# Example output:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        20G  3.5G   15G  19% /
/dev/sda2       100G   45G   50G  48% /home
tmpfs           2.0G     0  2.0G   0% /dev/shm

# Show filesystem type:
lsblk -f
mount | column -t
```

---

## 🏗️ FileSystem Structure and Description

### Linux Directory Structure (FHS - Filesystem Hierarchy Standard)

```
/
├── bin/          → Essential user command binaries
├── boot/         → Boot loader files (kernel, initrd)
├── dev/          → Device files
├── etc/          → System configuration files
├── home/         → User home directories
├── lib/          → Essential shared libraries
├── media/        → Removable media mount points
├── mnt/          → Temporary mount points
├── opt/          → Optional software packages
├── proc/         → Process and kernel information
├── root/         → Root user's home directory
├── run/          → Runtime data
├── sbin/         → System administration binaries
├── srv/          → Service data
├── sys/          → System hardware information
├── tmp/          → Temporary files
├── usr/          → User utilities and applications
├── var/          → Variable data (logs, databases)
└── lost+found/   → Recovered files (ext filesystems)
```

### Detailed Directory Descriptions

#### System Directories

##### /bin - Essential User Binaries

```bash
# Contains essential commands available to all users:
ls /bin/
# Examples:
cat, cp, ls, mv, rm, bash, sh, grep, sed, awk

# These commands work even in single-user mode
```

##### /sbin - System Administration Binaries

```bash
# Commands for system administration:
ls /sbin/
# Examples:
fdisk, mount, umount, iptables, systemctl, ifconfig

# Usually require root privileges
```

##### /etc - Configuration Files

```bash
# System-wide configuration files:
ls /etc/

# Important files:
/etc/passwd          → User account information
/etc/shadow          → Encrypted passwords
/etc/group           → Group information
/etc/hosts           → Static hostname resolution
/etc/fstab           → Filesystem mount information
/etc/ssh/sshd_config → SSH daemon configuration
/etc/crontab         → System-wide cron jobs
```

##### /var - Variable Data

```bash
# Data that changes during system operation:
/var/log/            → Log files
/var/spool/          → Spool directories (mail, print)
/var/tmp/            → Temporary files (preserved across reboots)
/var/lib/            → Application state information
/var/cache/          → Cached data from applications

# Examples:
/var/log/messages    → System log messages
/var/log/secure      → Authentication log
/var/spool/mail/     → User mailboxes
```

#### User Directories

##### /home - User Home Directories

```bash
# Structure:
/home/username/      → Individual user directories

# Example:
/home/admin/         → admin user's home
/home/john/          → john user's home
/home/mary/          → mary user's home

# User's default location after login
cd ~                 # Goes to user's home directory
```

##### /root - Root User Home

```bash
# Root user's home directory (separate from /home)
/root/

# Why separate?
- Available even if /home unmounted
- Security isolation
- Different backup strategies
```

#### Special Directories

##### /proc - Process Information

```bash
# Virtual filesystem containing:
/proc/cpuinfo        → CPU information
/proc/meminfo        → Memory information
/proc/version        → Kernel version
/proc/mounts         → Currently mounted filesystems
/proc/[pid]/         → Process-specific information

# Examples:
cat /proc/cpuinfo    # Show CPU details
cat /proc/meminfo    # Show memory usage
ls /proc/1/          # Process 1 (init) information
```

##### /sys - System Information

```bash
# Virtual filesystem for hardware info:
/sys/class/          → Device classes
/sys/devices/        → Device hierarchy
/sys/fs/             → Filesystem information
/sys/kernel/         → Kernel information

# Examples:
ls /sys/class/net/   # Network interfaces
cat /sys/class/thermal/thermal_zone0/temp  # CPU temperature
```

##### /dev - Device Files

```bash
# Device files for hardware access:
/dev/sda             → First SATA/SCSI disk
/dev/sda1            → First partition on first disk
/dev/tty1            → First virtual console
/dev/null            → Null device (discard output)
/dev/zero            → Zero device (infinite zeros)
/dev/random          → Random number generator

# Examples:
ls -l /dev/sd*       # List storage devices
echo "test" > /dev/null  # Discard output
```

### Directory Permissions and Ownership

#### Standard Directory Permissions

```bash
# View directory permissions:
ls -ld /etc /home /var

# Example output:
drwxr-xr-x  2 root root  4096 Jan 15 10:30 /etc
drwxr-xr-x  3 root root  4096 Jan 15 10:30 /home
drwxr-xr-x 12 root root  4096 Jan 15 10:30 /var

# Permission breakdown:
d         → Directory
rwx       → Owner permissions (read, write, execute)
r-x       → Group permissions (read, execute)
r-x       → Other permissions (read, execute)
```

#### Security Considerations

```bash
# Sensitive directories:
/etc/shadow          → 600 (root only)
/home/user/          → 755 (user writable)
/tmp/                → 1777 (sticky bit)
/var/log/            → 755 (logs readable)

# Check permissions:
stat /etc/shadow
ls -ld /tmp
```

---

## 🧭 File System Navigation Commands

### Primary Navigation Commands

#### pwd - Print Working Directory

```bash
# Show current directory:
pwd

# Example output:
/home/admin

# Absolute path from root (/) to current location
# Always starts with /
```

#### ls - List Directory Contents

```bash
# Basic usage:
ls                   # List current directory
ls /home            # List specific directory
ls -l               # Long format (detailed)
ls -a               # Show hidden files (starting with .)
ls -la              # Long format + hidden files
ls -lh              # Human-readable sizes
ls -lt              # Sort by modification time
ls -lS              # Sort by file size

# Examples:
ls -la /home/admin/
# Output:
total 32
drwxr-xr-x  4 admin admin 4096 Jan 15 14:30 .
drwxr-xr-x  3 root  root  4096 Jan 15 10:15 ..
-rw-r--r--  1 admin admin  220 Jan 15 10:15 .bash_logout
-rw-r--r--  1 admin admin 3526 Jan 15 10:15 .bashrc
drwxr-xr-x  2 admin admin 4096 Jan 15 14:30 Documents
drwxr-xr-x  2 admin admin 4096 Jan 15 14:30 Downloads
```

#### cd - Change Directory

```bash
# Change directory commands:
cd /path/to/directory    # Absolute path
cd directory_name        # Relative path
cd ..                   # Parent directory
cd ../..                # Two levels up
cd ~                    # Home directory
cd -                    # Previous directory
cd /                    # Root directory
cd                      # Home directory (same as cd ~)

# Examples:
cd /var/log             # Go to log directory
pwd                     # Shows: /var/log
cd ../spool            # Go to /var/spool
cd ~/Documents         # Go to user's Documents
cd -                   # Return to /var/spool
```

### Advanced Navigation

#### Tab Completion

```bash
# Auto-complete feature:
cd /ho<TAB>            # Completes to /home/
cd Docu<TAB>           # Completes to Documents/

# Double-tab shows options:
cd /u<TAB><TAB>
# Shows: usr/ user/
```

#### Directory Stack (pushd/popd)

```bash
# Push current directory to stack:
pushd /var/log         # Go to /var/log and save current dir

# Show directory stack:
dirs

# Pop from stack (return to previous):
popd

# Push without changing directory:
pushd -n /tmp

# Rotate stack:
pushd +1               # Rotate to next directory in stack
```

#### History and Shortcuts

```bash
# Command history navigation:
history                # Show command history
!ls                   # Repeat last ls command
!cd                   # Repeat last cd command
!!                    # Repeat last command

# Directory shortcuts:
cd ~user              # Go to user's home directory
cd ~+                 # Current directory
cd ~-                 # Previous directory
```

### Navigation Tips and Tricks

#### Useful Aliases

```bash
# Add to ~/.bashrc:
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Usage after sourcing:
source ~/.bashrc
ll                    # Same as ls -alF
...                   # Go up two directories
```

#### Path Shortcuts

```bash
# Special directory references:
.                     # Current directory
..                    # Parent directory
~                     # Home directory
~username            # Specific user's home
-                    # Previous directory (with cd)

# Examples:
cp file.txt .         # Copy to current directory
ls ../                # List parent directory
cd ~/Downloads        # Go to Downloads in home
```

#### Finding Your Way

```bash
# When lost:
pwd                   # Where am I?
ls -la                # What's here?
cd ~                  # Go home
which command         # Where is this command?
whereis command       # Find command and documentation

# File location:
locate filename       # Find file anywhere
find / -name filename # Search from root
```

---

## 📋 Linux File or Directory Properties

### File Attributes and Metadata

#### Basic File Properties

```bash
# View detailed file information:
ls -l filename

# Example output:
-rw-r--r-- 1 admin admin 1024 Jan 15 14:30 document.txt

# Breakdown:
-         → File type (- = regular file)
rw-r--r-- → Permissions
1         → Link count
admin     → Owner
admin     → Group
1024      → Size in bytes
Jan 15 14:30 → Last modified time
document.txt → Filename
```

#### File Types in ls -l

```bash
# File type indicators (first character):
-         → Regular file
d         → Directory
l         → Symbolic link
b         → Block device
c         → Character device
s         → Socket
p         → Named pipe (FIFO)

# Examples:
drwxr-xr-x  directory
lrwxrwxrwx  symbolic link
brw-rw----  block device
crw-rw-rw-  character device
```

### Detailed File Information

#### stat Command

```bash
# Comprehensive file information:
stat filename

# Example output:
  File: document.txt
  Size: 1024            Blocks: 8          IO Block: 4096   regular file
Device: 8,1     Inode: 131074      Links: 1
Access: (0644/-rw-r--r--)  Uid: (1000/  admin)   Gid: (1000/  admin)
Access: 2024-01-15 14:30:00.000000000 +0700
Modify: 2024-01-15 14:30:00.000000000 +0700
Change: 2024-01-15 14:30:00.000000000 +0700
 Birth: -
```

#### Timestamps Explained

```bash
# Three timestamps:
Access time (atime)  → Last time file was read
Modify time (mtime)  → Last time file content was modified
Change time (ctime)  → Last time file metadata was changed

# View specific timestamps:
ls -l            # Shows mtime
ls -lu           # Shows atime
ls -lc           # Shows ctime
```

### File Permissions System

#### Permission Structure

```bash
# Permission format: rwxrwxrwx
# Divided into three groups:
Owner (User)    Group           Others
rwx             rwx             rwx
421             421             421

# Permissions meaning:
r (4) → Read permission
w (2) → Write permission
x (1) → Execute permission
```

#### Numeric Permissions

```bash
# Common permission combinations:
755 → rwxr-xr-x (executable files, directories)
644 → rw-r--r-- (regular files)
600 → rw------- (private files)
777 → rwxrwxrwx (world writable - dangerous)
000 → --------- (no permissions)

# Examples:
chmod 755 script.sh    # Make executable
chmod 644 document.txt # Regular file permissions
chmod 600 private.key  # Private key permissions
```

#### Special Permissions

```bash
# Setuid (4000):
-rwsr-xr-x → Set user ID on execution
# File runs with owner's privileges

# Setgid (2000):
-rwxr-sr-x → Set group ID on execution
# File runs with group's privileges

# Sticky bit (1000):
drwxrwxrwt → Sticky bit on directory
# Only owner can delete files in directory

# Examples:
chmod 4755 file        # Setuid + 755
chmod 2755 directory   # Setgid + 755
chmod 1777 /tmp        # Sticky + 777
```

### File Ownership

#### Ownership Information

```bash
# View ownership:
ls -l filename
stat filename

# Change ownership:
chown user:group filename      # Change both owner and group
chown user filename           # Change owner only
chown :group filename         # Change group only
chgrp group filename          # Change group only

# Examples:
sudo chown admin:admin file.txt
sudo chown admin file.txt
sudo chgrp users file.txt
```

#### Ownership Best Practices

```bash
# Security considerations:
✅ Files in /home/user should be owned by user
✅ System files should be owned by root
✅ Web content should be owned by web server user
✅ Database files should be owned by database user

# Check ownership issues:
find /home -not -user $(whoami)  # Find files not owned by you
find /etc -not -user root        # Find non-root owned system files
```

### Extended Attributes

#### File System Extended Attributes

```bash
# View extended attributes:
lsattr filename
getfattr -d filename

# Set extended attributes:
chattr +i filename     # Make immutable
chattr +a filename     # Append only
chattr -i filename     # Remove immutable

# Common attributes:
i → Immutable (cannot be modified/deleted)
a → Append only
s → Secure deletion
A → No atime updates
```

#### ACLs (Access Control Lists)

```bash
# View ACLs:
getfacl filename

# Set ACLs:
setfacl -m u:username:rwx filename     # User permissions
setfacl -m g:groupname:r-x filename    # Group permissions
setfacl -m o::--- filename             # Others permissions

# Remove ACLs:
setfacl -x u:username filename
setfacl -b filename                    # Remove all ACLs
```

---

## 🗺️ Absolute and Relative Paths

### Path Concepts

#### Absolute Paths

```bash
# Definition: Complete path from root directory (/)
# Always starts with /
# Same regardless of current directory

# Examples:
/home/admin/Documents/file.txt
/var/log/messages
/etc/passwd
/usr/bin/ls

# Usage:
cat /etc/passwd
ls /home/admin/Documents
cd /var/log
```

#### Relative Paths

```bash
# Definition: Path relative to current directory
# Does NOT start with /
# Changes based on current location

# Special symbols:
.  → Current directory
.. → Parent directory
~  → Home directory

# Examples (from /home/admin):
Documents/file.txt      # File in Documents subdirectory
../root/               # Root's home directory
../../etc/passwd       # System passwd file
./script.sh           # Script in current directory
```

### Path Examples and Comparisons

#### Scenario: Current directory is /home/admin

```bash
# Absolute paths (same from anywhere):
/home/admin/Documents/report.txt
/var/log/messages
/etc/ssh/sshd_config

# Relative paths (from /home/admin):
Documents/report.txt           # Same as /home/admin/Documents/report.txt
../admin/Documents/report.txt  # Same file via parent directory
./Documents/report.txt         # Explicit current directory
~/Documents/report.txt         # Using home directory shortcut
```

#### Path Navigation Examples

```bash
# Starting location: /home/admin
pwd  # Shows: /home/admin

# Using relative paths:
cd Documents                   # Now in /home/admin/Documents
cd ../Downloads               # Now in /home/admin/Downloads
cd ../../var/log              # Now in /var/log
cd ~/Pictures                 # Now in /home/admin/Pictures

# Using absolute paths:
cd /etc                       # Now in /etc
cd /home/admin/Documents      # Now in /home/admin/Documents
cd /usr/local/bin             # Now in /usr/local/bin
```

### Best Practices

#### When to Use Absolute Paths

```bash
✅ Scripts and automation
✅ System configuration
✅ Cron jobs
✅ When path must be exact
✅ Documentation and instructions

# Examples:
#!/bin/bash
cp /etc/passwd /backup/passwd.bak
/usr/bin/systemctl restart httpd
```

#### When to Use Relative Paths

```bash
✅ Interactive shell commands
✅ Working within project directories
✅ Shorter, more readable commands
✅ Portable scripts within projects

# Examples:
cd ../config
cp *.txt backup/
./configure --prefix=/usr/local
```

#### Path Tips and Shortcuts

```bash
# Tab completion works with both:
ls /ho<TAB>               # Completes to /home/
ls Doc<TAB>               # Completes to Documents/

# Environment variables:
echo $HOME                # Your home directory
echo $PWD                 # Current directory
echo $OLDPWD              # Previous directory

# Command substitution:
cd $(dirname /path/to/file)  # Go to file's directory
ls $(pwd)/filename           # Absolute path to file in current dir
```

---

## 📝 Creating Files and Directories

### Creating Files

#### touch Command

```bash
# Basic usage:
touch filename              # Create empty file
touch file1 file2 file3     # Create multiple files
touch "file name.txt"       # File with spaces (quotes needed)

# Advanced options:
touch -t 202401151430 file  # Set specific timestamp
touch -r reference_file new_file  # Copy timestamp from reference
touch -a file               # Update access time only
touch -m file               # Update modify time only

# Examples:
touch document.txt
touch report.pdf presentation.ppt
touch -t 202401010000 oldfile.txt
```

#### Creating Files with Content

##### Using echo

```bash
# Simple content:
echo "Hello World" > file.txt          # Overwrite file
echo "New line" >> file.txt            # Append to file
echo -e "Line1\nLine2" > multiline.txt # Multiple lines

# Examples:
echo "#!/bin/bash" > script.sh
echo "echo 'Hello World'" >> script.sh
chmod +x script.sh
```

##### Using cat with redirection

```bash
# Create file with multiple lines:
cat > newfile.txt << EOF
This is line 1
This is line 2
This is line 3
EOF

# Append to existing file:
cat >> existingfile.txt << EOF
Additional content
More content
EOF
```

##### Using heredoc

```bash
# Create configuration file:
cat > config.conf << 'EOF'
server.host = localhost
server.port = 8080
database.url = localhost:5432
EOF

# Create script with variables:
cat > script.sh << EOF
#!/bin/bash
USER=$(whoami)
echo "Current user: $USER"
EOF
```

#### vi/vim Editor

```bash
# Create and edit file:
vi filename.txt

# Basic vi commands:
i           # Insert mode
Esc         # Command mode
:w          # Save file
:q          # Quit
:wq         # Save and quit
:q!         # Quit without saving

# Example session:
vi document.txt
# Press 'i' to enter insert mode
# Type your content
# Press Esc to exit insert mode
# Type ':wq' to save and quit
```

### Creating Directories

#### mkdir Command

```bash
# Basic usage:
mkdir directory_name           # Create single directory
mkdir dir1 dir2 dir3          # Create multiple directories
mkdir "directory with spaces"  # Directory with spaces

# Advanced options:
mkdir -p path/to/nested/dirs  # Create parent directories
mkdir -m 755 directory        # Set permissions during creation
mkdir -v directory            # Verbose output

# Examples:
mkdir Documents Downloads Pictures
mkdir -p project/src/main/java
mkdir -m 700 private_folder
```

#### Directory Structure Creation

```bash
# Create project structure:
mkdir -p myproject/{src,docs,tests,config}
mkdir -p myproject/src/{main,test}
mkdir -p myproject/src/main/{java,resources}

# Result:
myproject/
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
│   └── test/
├── docs/
├── tests/
└── config/

# Verify structure:
tree myproject/
# or
find myproject/ -type d
```

### Copying Files and Directories

#### cp Command for Files

```bash
# Basic file copying:
cp source_file destination_file     # Copy file
cp file1 file2 directory/          # Copy multiple files to directory
cp -i source dest                   # Interactive (prompt before overwrite)
cp -v source dest                   # Verbose output
cp -p source dest                   # Preserve permissions and timestamps

# Examples:
cp document.txt backup.txt
cp *.txt /backup/
cp -p important.conf important.conf.bak
```

#### Advanced Copy Options

```bash
# Useful cp options:
cp -r source_dir dest_dir      # Recursive (copy directories)
cp -a source dest              # Archive mode (preserve everything)
cp -u source dest              # Update (copy only if newer)
cp -l source dest              # Create hard link instead of copy
cp -s source dest              # Create symbolic link instead of copy

# Examples:
cp -r Documents/ Documents_backup/
cp -a /etc/httpd/ /backup/httpd/
cp -u *.log /var/log/archive/
```

#### Copy with Permissions and Ownership

```bash
# Preserve attributes:
cp -p file.txt file_backup.txt           # Preserve permissions/timestamps
cp --preserve=all file.txt backup.txt    # Preserve all attributes
sudo cp --preserve=ownership file.txt /etc/  # Preserve ownership (need sudo)

# Examples:
cp -p /etc/passwd passwd.backup
sudo cp --preserve=all important.conf /etc/app/
```

---

## 🚀 Continuing with remaining sections...

The file is quite comprehensive already. Would you like me to continue with the remaining sections (Copying directories, Finding Files and Directories, WildCards, Linux File Types, and Soft/Hard Links)? Each section would be equally detailed with practical examples and explanations in Vietnamese.
