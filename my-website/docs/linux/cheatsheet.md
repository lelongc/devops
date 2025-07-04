# Linux System Administration - Complete Knowledge Base

## 🎯 Mục tiêu

Trở thành Linux System Administrator chuyên nghiệp với kiến thức toàn diện về mọi khía cạnh của hệ thống Linux.

---

## 📚 **1. SYSTEM FUNDAMENTALS**

### 1.1 System Information Commands

```bash
# System Info
uname -a                    # Complete system information
hostnamectl                 # System hostname and info
uptime                      # System uptime and load
who, w, users              # Logged in users
last                       # Login history
id                         # Current user/group info
whoami                     # Current username
groups                     # User groups
finger username            # User information

# Hardware Info
lscpu                      # CPU information
cat /proc/cpuinfo          # Detailed CPU info
lsmem                      # Memory information
free -h                    # Memory usage
lsblk                      # Block devices
fdisk -l                   # Disk partitions
lsusb                      # USB devices
lspci                      # PCI devices
lshw                       # Hardware lister
dmidecode                  # DMI/SMBIOS info
hwinfo                     # Hardware info tool

# Kernel & Boot
cat /proc/version          # Kernel version
dmesg                      # Kernel ring buffer
journalctl --boot         # Boot messages
systemctl list-units --failed  # Failed services
```

### 1.2 File System Hierarchy

```bash
# Essential Directories
/                          # Root directory
/bin                       # Essential binaries
/boot                      # Boot files
/dev                       # Device files
/etc                       # Configuration files
/home                      # User directories
/lib, /lib64               # Libraries
/media, /mnt               # Mount points
/opt                       # Optional packages
/proc                      # Process information
/root                      # Root home
/run                       # Runtime data
/sbin                      # System binaries
/srv                       # Service data
/sys                       # System files
/tmp                       # Temporary files
/usr                       # User programs
/var                       # Variable data

# Important Files
/etc/passwd                # User accounts
/etc/shadow                # Password hashes
/etc/group                 # Group definitions
/etc/hosts                 # Host mappings
/etc/resolv.conf           # DNS configuration
/etc/fstab                 # File system table
/etc/crontab               # System cron jobs
/etc/sudoers               # Sudo configuration
/etc/ssh/sshd_config       # SSH daemon config
/var/log/                  # Log files
/proc/                     # Process/kernel info
```

---

## 📁 **2. FILE OPERATIONS & NAVIGATION**

### 2.1 Basic Navigation

```bash
# Navigation
pwd                        # Present working directory
cd [path]                  # Change directory
cd ~                       # Home directory
cd -                       # Previous directory
cd ..                      # Parent directory
dirs                       # Directory stack

# Listing
ls                         # List files
ls -la                     # Long format, all files
ls -lh                     # Human readable sizes
ls -lt                     # Sort by time
ls -lS                     # Sort by size
ls -R                      # Recursive
tree                       # Directory tree
```

### 2.2 File Operations

```bash
# Create/Delete
touch filename             # Create empty file
mkdir dirname              # Create directory
mkdir -p path/to/dir       # Create nested directories
rmdir dirname              # Remove empty directory
rm filename                # Remove file
rm -rf dirname             # Remove directory recursively

# Copy/Move
cp source dest             # Copy file
cp -r source dest          # Copy directory
cp -p source dest          # Preserve attributes
mv source dest             # Move/rename
ln -s target link          # Create symbolic link
ln target link             # Create hard link

# Find & Locate
find /path -name "pattern" # Find by name
find /path -type f         # Find files
find /path -type d         # Find directories
find /path -size +100M     # Find large files
find /path -mtime -7       # Modified in last 7 days
find /path -perm 755       # Find by permissions
locate filename            # Fast file search
which command              # Find command location
whereis command            # Find command, source, manual
```

### 2.3 File Content Operations

```bash
# View Content
cat filename               # Display file
less filename              # Page through file
more filename              # Page through file
head filename              # First 10 lines
head -n 20 filename        # First 20 lines
tail filename              # Last 10 lines
tail -f filename           # Follow file changes
tail -n 50 filename        # Last 50 lines

# Edit Content
nano filename              # Simple editor
vim filename               # Vi/Vim editor
emacs filename             # Emacs editor
sed 's/old/new/g' file     # Stream editor
awk '{print $1}' file      # Pattern processing

# File Information
file filename              # File type
stat filename              # File statistics
wc filename                # Word/line/character count
wc -l filename             # Line count only
du -sh dirname             # Directory size
df -h                      # Disk usage
```

---

## 🔐 **3. PERMISSIONS & OWNERSHIP**

### 3.1 Standard Permissions

```bash
# View Permissions
ls -l filename             # Long format listing
stat filename              # Detailed file stats

# Chmod (Change Permissions)
chmod 755 filename         # Octal notation
chmod u+x filename         # Add execute for user
chmod g-w filename         # Remove write for group
chmod o=r filename         # Set others to read only
chmod a+r filename         # Add read for all
chmod u=rwx,g=rx,o=r file  # Set exact permissions

# Chown (Change Ownership)
chown user filename        # Change user owner
chown user:group filename  # Change user and group
chown :group filename      # Change group only
chgrp group filename       # Change group (alternative)

# Special Permissions
chmod +s filename          # SUID/SGID
chmod +t dirname           # Sticky bit
chmod 4755 filename        # SUID + 755
chmod 2755 dirname         # SGID + 755
chmod 1777 dirname         # Sticky + 777

# Umask
umask                      # View current umask
umask 022                  # Set umask
umask -S                   # Symbolic format
```

### 3.2 Access Control Lists (ACL)

```bash
# View ACLs
getfacl filename           # Show ACLs
getfacl -R dirname         # Recursive

# Set ACLs
setfacl -m u:user:rwx file # Grant user permissions
setfacl -m g:group:rx file # Grant group permissions
setfacl -x u:user file     # Remove user ACL
setfacl -b file            # Remove all ACLs
setfacl -d -m u:user:rwx dir  # Default ACLs

# File Attributes
lsattr filename            # List attributes
chattr +i filename         # Make immutable
chattr +a filename         # Append only
chattr -i filename         # Remove immutable
```

---

## 👥 **4. USER & GROUP MANAGEMENT**

### 4.1 User Management

```bash
# User Information
id username                # User/group IDs
groups username            # User groups
finger username            # User info
getent passwd username     # User database entry

# Add/Modify Users
useradd username           # Add user
useradd -m username        # Add user with home directory
useradd -s /bin/bash user  # Specify shell
usermod -aG group user     # Add user to group
usermod -s /bin/bash user  # Change shell
userdel username           # Delete user
userdel -r username        # Delete user and home

# Password Management
passwd username            # Change password
passwd -l username         # Lock user account
passwd -u username         # Unlock user account
chage -l username          # Password aging info
chage -E 2024-12-31 user   # Set account expiration
```

### 4.2 Group Management

```bash
# Group Operations
groupadd groupname         # Create group
groupmod -n newname oldname # Rename group
groupdel groupname         # Delete group
gpasswd -a user group      # Add user to group
gpasswd -d user group      # Remove user from group
vigr                       # Edit group file safely

# Group Information
getent group groupname     # Group database entry
lid -g groupname           # List group members
```

### 4.3 Sudo Configuration

```bash
# Sudo Management
visudo                     # Edit sudoers file safely
sudo -l                    # List sudo privileges
sudo -u user command       # Run as different user
sudo -i                    # Interactive root shell
sudo su -                  # Switch to root

# Sudoers Examples
user ALL=(ALL:ALL) ALL     # Full sudo access
user ALL=(ALL) NOPASSWD: ALL  # No password required
%group ALL=(ALL) ALL       # Group access
user ALL=(ALL) /bin/systemctl  # Specific command only
```

---

## 🔧 **5. PROCESS MANAGEMENT**

### 5.1 Process Monitoring

```bash
# Process Listing
ps                         # Current user processes
ps aux                     # All processes (BSD style)
ps -ef                     # All processes (UNIX style)
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu  # Custom format
pstree                     # Process tree
pgrep pattern              # Find process by name
pidof program              # Get PID of program

# Real-time Monitoring
top                        # Interactive process viewer
htop                       # Enhanced top
atop                       # Advanced monitoring
iotop                      # I/O monitoring
nmon                       # System monitoring
glances                    # System monitoring

# System Load
uptime                     # Load averages
cat /proc/loadavg          # Load average file
vmstat 1                   # Virtual memory stats
iostat 1                   # I/O statistics
sar 1                      # System activity reporter
```

### 5.2 Process Control

```bash
# Job Control
jobs                       # List active jobs
bg %1                      # Background job 1
fg %1                      # Foreground job 1
nohup command &            # Run immune to hangups
screen command             # Detachable sessions
tmux                       # Terminal multiplexer

# Process Signals
kill PID                   # Terminate process (SIGTERM)
kill -9 PID                # Force kill (SIGKILL)
kill -HUP PID              # Hang up (SIGHUP)
kill -USR1 PID             # User signal 1
killall process_name       # Kill all instances
pkill pattern              # Kill by pattern
trap signal_handler SIGNAL # Trap signals in scripts

# Process Priority
nice -n 10 command         # Run with lower priority
renice 10 PID              # Change priority
ionice -c 3 command        # I/O scheduling class
```

---

## 💾 **6. STORAGE & FILESYSTEMS**

### 6.1 Disk Management

```bash
# Disk Information
fdisk -l                   # List all disks
lsblk                      # Block device tree
blkid                      # Block device attributes
df -h                      # Filesystem usage
du -sh dirname             # Directory size
ncdu                       # NCurses disk usage

# Partitioning
fdisk /dev/sdX             # Partition disk
parted /dev/sdX            # GNU parted tool
gdisk /dev/sdX             # GPT partitioning
cfdisk /dev/sdX            # Curses-based fdisk

# LVM (Logical Volume Manager)
pvcreate /dev/sdX1         # Create physical volume
vgcreate vg_name /dev/sdX1 # Create volume group
lvcreate -L 10G -n lv_name vg_name  # Create logical volume
pvs                        # List physical volumes
vgs                        # List volume groups
lvs                        # List logical volumes
```

### 6.2 Filesystem Operations

```bash
# Create Filesystems
mkfs.ext4 /dev/sdX1        # Create ext4 filesystem
mkfs.xfs /dev/sdX1         # Create XFS filesystem
mkfs.btrfs /dev/sdX1       # Create Btrfs filesystem
mkswap /dev/sdX2           # Create swap

# Mount/Unmount
mount /dev/sdX1 /mnt       # Mount filesystem
umount /mnt                # Unmount filesystem
mount -a                   # Mount all in /etc/fstab
mount -o remount,rw /      # Remount with options

# Filesystem Maintenance
fsck /dev/sdX1             # Check filesystem
fsck.ext4 -f /dev/sdX1     # Force check ext4
xfs_repair /dev/sdX1       # Repair XFS
tune2fs -l /dev/sdX1       # Tune ext filesystem
resize2fs /dev/sdX1        # Resize ext filesystem
xfs_growfs /mount/point    # Grow XFS filesystem

# RAID Management
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdX1 /dev/sdY1
mdadm --detail /dev/md0    # RAID array details
cat /proc/mdstat           # RAID status
```

### 6.3 Backup & Sync

```bash
# Archive Tools
tar -czf archive.tar.gz dir/  # Create compressed archive
tar -xzf archive.tar.gz    # Extract archive
tar -tzf archive.tar.gz    # List archive contents
zip -r archive.zip dir/    # Create ZIP archive
unzip archive.zip          # Extract ZIP

# Synchronization
rsync -avz source/ dest/   # Sync directories
rsync -avz --delete src/ dst/  # Sync with deletion
rsync -avz -e ssh src/ user@host:dst/  # Sync over SSH
scp file user@host:/path   # Secure copy
```

---

## 🌐 **7. NETWORK MANAGEMENT**

### 7.1 Network Configuration

```bash
# Network Interfaces
ip addr show               # Show IP addresses
ip link show               # Show network interfaces
ip route show              # Show routing table
ip neighbor show           # Show ARP table

# Legacy Commands (still useful)
ifconfig                   # Interface configuration
route -n                   # Routing table
arp -a                     # ARP table
netstat -i                 # Interface statistics

# Network Configuration Files
/etc/network/interfaces    # Debian/Ubuntu network config
/etc/sysconfig/network-scripts/  # RHEL/CentOS network config
/etc/systemd/network/      # Systemd network config
/etc/hosts                 # Static hostname resolution
/etc/resolv.conf           # DNS configuration
```

### 7.2 Network Tools

```bash
# Connectivity Testing
ping hostname              # ICMP ping
ping6 hostname             # IPv6 ping
traceroute hostname        # Trace route
mtr hostname               # My traceroute
telnet host port           # Test TCP connection
nc -zv host port           # Netcat port scan

# DNS Tools
nslookup hostname          # DNS lookup
dig hostname               # DNS lookup (detailed)
host hostname              # DNS lookup (simple)
dig @8.8.8.8 hostname      # Query specific DNS server

# Network Monitoring
netstat -tuln              # Listening ports
ss -tuln                   # Socket statistics (modern)
lsof -i                    # Open network files
tcpdump -i eth0            # Packet capture
wireshark                  # GUI packet analyzer
iftop                      # Interface bandwidth usage
nethogs                    # Process network usage
```

### 7.3 Firewall Management

```bash
# iptables (traditional)
iptables -L                # List rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
iptables -A INPUT -j DROP  # Drop all other input
iptables-save > /etc/iptables/rules.v4  # Save rules

# ufw (Ubuntu)
ufw enable                 # Enable firewall
ufw allow 22               # Allow SSH
ufw allow from 192.168.1.0/24  # Allow from subnet
ufw deny 23                # Deny telnet
ufw status                 # Show status

# firewalld (RHEL/CentOS)
systemctl start firewalld  # Start firewalld
firewall-cmd --permanent --add-service=ssh  # Allow SSH
firewall-cmd --permanent --add-port=8080/tcp  # Allow port
firewall-cmd --reload      # Reload configuration
firewall-cmd --list-all    # List all rules
```

---

## 🔄 **8. SYSTEMD & SERVICES**

### 8.1 Service Management

```bash
# Service Control
systemctl start service    # Start service
systemctl stop service     # Stop service
systemctl restart service  # Restart service
systemctl reload service   # Reload configuration
systemctl enable service   # Enable at boot
systemctl disable service  # Disable at boot
systemctl status service   # Service status
systemctl is-active service # Check if active
systemctl is-enabled service # Check if enabled

# Service Information
systemctl list-units       # List all units
systemctl list-units --type=service  # List services only
systemctl list-units --failed  # List failed units
systemctl show service      # Show service properties
systemctl cat service       # Show service file
```

### 8.2 Systemd Configuration

```bash
# System Targets
systemctl get-default       # Current default target
systemctl set-default multi-user.target  # Set default target
systemctl list-units --type=target  # List targets
systemctl isolate rescue.target  # Switch to rescue mode

# Journal Management
journalctl                  # View all logs
journalctl -u service       # Service logs
journalctl -f               # Follow logs
journalctl --since "1 hour ago"  # Recent logs
journalctl --boot          # Current boot logs
journalctl --vacuum-time=7d # Clean old logs

# Timer Management
systemctl list-timers       # List timers
systemctl enable timer      # Enable timer
systemctl start timer       # Start timer
```

### 8.3 Creating Custom Services

```bash
# Service File Location
/etc/systemd/system/        # Custom service files
/usr/lib/systemd/system/    # Package service files

# Example Service File
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/my-script.sh
Restart=always
User=myuser

[Install]
WantedBy=multi-user.target

# Commands
systemctl daemon-reload     # Reload service definitions
systemctl edit service      # Edit service (creates override)
```

---

## 📋 **9. PACKAGE MANAGEMENT**

### 9.1 APT (Debian/Ubuntu)

```bash
# Package Operations
apt update                  # Update package list
apt upgrade                 # Upgrade packages
apt full-upgrade            # Full system upgrade
apt install package         # Install package
apt remove package          # Remove package
apt purge package           # Remove package and config
apt autoremove              # Remove unnecessary packages

# Package Information
apt search keyword          # Search packages
apt show package            # Package information
apt list --installed        # List installed packages
apt list --upgradable       # List upgradable packages

# Repository Management
add-apt-repository ppa:user/repo  # Add PPA
apt-key add keyfile         # Add repository key
/etc/apt/sources.list       # Repository list
/etc/apt/sources.list.d/    # Additional repositories

# dpkg (low-level)
dpkg -i package.deb         # Install .deb package
dpkg -r package             # Remove package
dpkg -l                     # List installed packages
dpkg -L package             # List package files
dpkg -S filename            # Find package owning file
```

### 9.2 YUM/DNF (RHEL/CentOS/Fedora)

```bash
# Package Operations
dnf update                  # Update packages
dnf install package         # Install package
dnf remove package          # Remove package
dnf upgrade                 # Upgrade packages
dnf autoremove              # Remove orphaned packages

# Package Information
dnf search keyword          # Search packages
dnf info package            # Package information
dnf list installed          # List installed packages
dnf history                 # Transaction history

# Repository Management
dnf config-manager --add-repo URL  # Add repository
dnf repolist                # List repositories
/etc/yum.repos.d/           # Repository configuration

# rpm (low-level)
rpm -ivh package.rpm        # Install RPM package
rpm -qa                     # List all packages
rpm -qi package             # Package information
rpm -ql package             # List package files
rpm -qf filename            # Find package owning file
```

### 9.3 Other Package Managers

```bash
# Snap (Ubuntu)
snap list                   # List snap packages
snap install package        # Install snap
snap remove package         # Remove snap
snap refresh                # Update snaps

# Flatpak
flatpak list                # List flatpak packages
flatpak install package     # Install flatpak
flatpak remove package      # Remove flatpak
flatpak update              # Update flatpaks

# AppImage
chmod +x app.AppImage       # Make executable
./app.AppImage              # Run AppImage
```

---

## 🕐 **10. TASK SCHEDULING**

### 10.1 Cron

```bash
# Cron Management
crontab -l                  # List user cron jobs
crontab -e                  # Edit user cron jobs
crontab -r                  # Remove all user cron jobs
crontab -u user -l          # List another user's cron

# System Cron
/etc/crontab                # System cron table
/etc/cron.d/                # Additional cron files
/etc/cron.daily/            # Daily scripts
/etc/cron.weekly/           # Weekly scripts
/etc/cron.monthly/          # Monthly scripts

# Cron Syntax
# m h dom mon dow command
0 2 * * * /backup/script.sh # Daily at 2 AM
0 0 * * 0 /weekly/script.sh # Weekly on Sunday
@reboot /startup/script.sh  # Run at boot
```

### 10.2 Systemd Timers

```bash
# Timer Files
/etc/systemd/system/        # Custom timers
/usr/lib/systemd/system/    # System timers

# Example Timer
[Unit]
Description=My Daily Task
Requires=my-task.service

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target

# Timer Management
systemctl enable my-task.timer
systemctl start my-task.timer
systemctl list-timers
```

### 10.3 at Command

```bash
# One-time Scheduling
at 15:30                    # Schedule for 3:30 PM
at now + 1 hour             # Schedule for 1 hour from now
at 2023-12-25 08:00         # Schedule for specific date
atq                         # List scheduled jobs
atrm job_number             # Remove scheduled job
```

---

## 📊 **11. MONITORING & LOGGING**

### 11.1 System Monitoring

```bash
# Performance Monitoring
top                         # Process monitor
htop                        # Enhanced top
atop                        # Advanced monitor
iotop                       # I/O monitor
mytop                       # MySQL monitor
iftop                       # Network monitor
nethogs                     # Network usage by process
dstat                       # System statistics
sysstat                     # System activity tools

# Memory Monitoring
free -h                     # Memory usage
cat /proc/meminfo           # Detailed memory info
vmstat 1                    # Virtual memory stats
pmap PID                    # Process memory map

# Disk Monitoring
df -h                       # Filesystem usage
du -sh directory            # Directory size
iotop                       # Disk I/O by process
iostat 1                    # I/O statistics
lsof +D /path               # Open files in directory
```

### 11.2 Log Management

```bash
# Log Files
/var/log/syslog             # System messages
/var/log/auth.log           # Authentication logs
/var/log/kern.log           # Kernel messages
/var/log/cron.log           # Cron job logs
/var/log/boot.log           # Boot messages
/var/log/apache2/           # Apache logs
/var/log/nginx/             # Nginx logs
/var/log/mysql/             # MySQL logs

# Log Viewing
tail -f /var/log/syslog     # Follow system log
grep ERROR /var/log/syslog  # Search for errors
zcat /var/log/syslog.1.gz   # View compressed logs
journalctl -f               # Follow systemd journal
journalctl -u service       # Service-specific logs

# Log Rotation
logrotate -d /etc/logrotate.conf  # Test log rotation
/etc/logrotate.conf         # Main logrotate config
/etc/logrotate.d/           # Service-specific configs
```

### 11.3 System Alerts

```bash
# System Health Checks
systemctl --failed          # Failed services
dmesg | grep -i error       # Kernel errors
last reboot                 # Reboot history
who -b                      # System boot time
uptime                      # System load

# Automated Monitoring Scripts
#!/bin/bash
# Check disk usage
df -h | awk '$5 > 80 {print $0}' | mail -s "Disk Alert" admin@example.com

# Check memory usage
free | awk 'NR==2{printf "Memory Usage: %.2f%%\n", $3*100/$2}'

# Check load average
uptime | awk '{print $10 $11 $12}' | sed 's/,//g'
```

---

## 🔒 **12. SECURITY**

### 12.1 SSH Security

```bash
# SSH Configuration
/etc/ssh/sshd_config        # SSH daemon configuration

# Key Security Settings
Port 2222                   # Change default port
PermitRootLogin no          # Disable root login
PasswordAuthentication no   # Disable password auth
PubkeyAuthentication yes    # Enable key auth
AllowUsers user1 user2      # Restrict users
MaxAuthTries 3              # Limit auth attempts

# SSH Key Management
ssh-keygen -t rsa -b 4096   # Generate RSA key
ssh-keygen -t ed25519       # Generate Ed25519 key
ssh-copy-id user@host       # Copy public key
ssh-add ~/.ssh/id_rsa       # Add key to agent
ssh-agent bash              # Start SSH agent
```

### 12.2 Firewall & Network Security

```bash
# iptables Rules
iptables -A INPUT -i lo -j ACCEPT  # Allow loopback
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
iptables -A INPUT -j DROP   # Drop everything else

# Port Scanning
nmap -sS target             # SYN scan
nmap -sU target             # UDP scan
nmap -O target              # OS detection
nmap -A target              # Aggressive scan

# Network Security Tools
fail2ban                    # Intrusion prevention
aide                        # File integrity checker
rkhunter                    # Rootkit hunter
chkrootkit                  # Rootkit checker
```

### 12.3 File Security

```bash
# File Permissions Audit
find / -perm -4000 -type f  # Find SUID files
find / -perm -2000 -type f  # Find SGID files
find / -perm -1000 -type d  # Find sticky bit dirs
find / -perm 777 -type f    # World writable files

# File Integrity
md5sum file                 # MD5 checksum
sha256sum file              # SHA256 checksum
tripwire                    # File integrity monitor
aide --init                 # Initialize AIDE database
aide --check                # Check file integrity

# Encryption
gpg --gen-key               # Generate GPG key
gpg --encrypt file          # Encrypt file
gpg --decrypt file.gpg      # Decrypt file
openssl enc -aes-256-cbc -in file -out file.enc  # Encrypt with OpenSSL
```

---

## 🗄️ **13. DATABASES**

### 13.1 MySQL/MariaDB

```bash
# Installation & Setup
systemctl start mysql       # Start MySQL
systemctl enable mysql      # Enable at boot
mysql_secure_installation   # Secure installation
mysql -u root -p            # Connect as root

# Database Operations
SHOW DATABASES;             # List databases
CREATE DATABASE dbname;     # Create database
USE dbname;                 # Select database
SHOW TABLES;                # List tables
DESCRIBE tablename;         # Table structure

# User Management
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON dbname.* TO 'user'@'localhost';
FLUSH PRIVILEGES;           # Reload privileges
DROP USER 'user'@'localhost';  # Delete user

# Backup & Restore
mysqldump -u root -p dbname > backup.sql  # Backup database
mysql -u root -p dbname < backup.sql      # Restore database
mysqldump --all-databases > all_dbs.sql   # Backup all databases
```

### 13.2 PostgreSQL

```bash
# Installation & Setup
systemctl start postgresql  # Start PostgreSQL
systemctl enable postgresql # Enable at boot
sudo -u postgres psql       # Connect as postgres user

# Database Operations
\l                          # List databases
\c dbname                   # Connect to database
\dt                         # List tables
\d tablename                # Describe table
\q                          # Quit

# User Management
CREATE USER username WITH PASSWORD 'password';
CREATE DATABASE dbname OWNER username;
GRANT ALL PRIVILEGES ON DATABASE dbname TO username;
DROP USER username;         # Delete user

# Backup & Restore
pg_dump dbname > backup.sql # Backup database
psql dbname < backup.sql    # Restore database
pg_dumpall > all_dbs.sql    # Backup all databases
```

---

## 🌐 **14. WEB SERVERS**

### 14.1 Apache HTTP Server

```bash
# Installation & Management
systemctl start apache2     # Start Apache (Debian/Ubuntu)
systemctl start httpd       # Start Apache (RHEL/CentOS)
systemctl enable apache2    # Enable at boot
systemctl reload apache2    # Reload configuration

# Configuration Files
/etc/apache2/apache2.conf   # Main config (Debian/Ubuntu)
/etc/httpd/conf/httpd.conf  # Main config (RHEL/CentOS)
/etc/apache2/sites-available/  # Virtual hosts (Debian/Ubuntu)
/etc/apache2/mods-available/   # Available modules

# Virtual Host Example
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot /var/www/example.com
    ErrorLog ${APACHE_LOG_DIR}/example_error.log
    CustomLog ${APACHE_LOG_DIR}/example_access.log combined
</VirtualHost>

# Apache Commands
a2ensite sitename           # Enable site (Debian/Ubuntu)
a2dissite sitename          # Disable site
a2enmod modname             # Enable module
a2dismod modname            # Disable module
apache2ctl configtest      # Test configuration
```

### 14.2 Nginx

```bash
# Installation & Management
systemctl start nginx       # Start Nginx
systemctl enable nginx      # Enable at boot
systemctl reload nginx      # Reload configuration
nginx -t                    # Test configuration

# Configuration Files
/etc/nginx/nginx.conf       # Main configuration
/etc/nginx/sites-available/ # Available sites
/etc/nginx/sites-enabled/   # Enabled sites
/etc/nginx/conf.d/          # Additional configurations

# Server Block Example
server {
    listen 80;
    server_name example.com;
    root /var/www/example.com;
    index index.html index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
    }
}

# Nginx Commands
nginx -s reload             # Reload configuration
nginx -s stop               # Stop Nginx
nginx -s quit               # Graceful shutdown
```

---

## 🐳 **15. CONTAINERIZATION**

### 15.1 Docker

```bash
# Docker Installation
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $USER    # Add user to docker group

# Container Management
docker run image            # Run container
docker run -d image         # Run in background
docker run -it image bash   # Interactive container
docker ps                   # List running containers
docker ps -a                # List all containers
docker stop container       # Stop container
docker start container      # Start container
docker rm container         # Remove container

# Image Management
docker images               # List images
docker pull image           # Download image
docker build -t name .      # Build image from Dockerfile
docker rmi image            # Remove image
docker tag image new_name   # Tag image

# Docker Compose
docker-compose up           # Start services
docker-compose up -d        # Start in background
docker-compose down         # Stop services
docker-compose logs         # View logs
docker-compose exec service bash  # Execute in service
```

### 15.2 Kubernetes

```bash
# Kubectl Commands
kubectl get pods            # List pods
kubectl get services        # List services
kubectl get deployments    # List deployments
kubectl describe pod name   # Pod details
kubectl logs pod-name       # Pod logs
kubectl exec -it pod-name bash  # Execute in pod

# Resource Management
kubectl apply -f file.yaml  # Apply configuration
kubectl delete -f file.yaml # Delete resources
kubectl scale deployment name --replicas=3  # Scale deployment
kubectl rollout status deployment/name      # Rollout status

# Cluster Information
kubectl cluster-info        # Cluster information
kubectl get nodes           # List nodes
kubectl top nodes           # Node resource usage
kubectl top pods            # Pod resource usage
```

---

## 📜 **16. SHELL SCRIPTING**

### 16.1 Bash Scripting Basics

```bash
#!/bin/bash
# Script header

# Variables
variable_name="value"
readonly CONSTANT="value"
export GLOBAL_VAR="value"

# Command Line Arguments
$0                          # Script name
$1, $2, $3                  # Positional parameters
$#                          # Number of arguments
$@                          # All arguments
$?                          # Exit status of last command
$$                          # Process ID

# Conditionals
if [ condition ]; then
    # commands
elif [ condition ]; then
    # commands
else
    # commands
fi

# Loops
for i in {1..10}; do
    echo $i
done

while [ condition ]; do
    # commands
done

# Functions
function_name() {
    local local_var="value"
    echo "Function output"
    return 0
}
```

### 16.2 Advanced Scripting

```bash
# Error Handling
set -e                      # Exit on error
set -u                      # Exit on undefined variable
set -o pipefail             # Exit on pipe failure

# Debugging
set -x                      # Debug mode
bash -x script.sh           # Debug script

# File Testing
[ -f file ]                 # File exists
[ -d directory ]            # Directory exists
[ -r file ]                 # File readable
[ -w file ]                 # File writable
[ -x file ]                 # File executable

# String Testing
[ -z "$string" ]            # String is empty
[ -n "$string" ]            # String is not empty
[ "$str1" = "$str2" ]       # Strings equal
[ "$str1" != "$str2" ]      # Strings not equal

# Numeric Testing
[ $num1 -eq $num2 ]         # Equal
[ $num1 -ne $num2 ]         # Not equal
[ $num1 -lt $num2 ]         # Less than
[ $num1 -le $num2 ]         # Less than or equal
[ $num1 -gt $num2 ]         # Greater than
[ $num1 -ge $num2 ]         # Greater than or equal
```

---

## 🔍 **17. TEXT PROCESSING**

### 17.1 Text Processing Tools

```bash
# grep - Pattern Searching
grep pattern file           # Search for pattern
grep -i pattern file        # Case insensitive
grep -r pattern directory   # Recursive search
grep -v pattern file        # Invert match
grep -n pattern file        # Show line numbers
grep -c pattern file        # Count matches
grep -E "pattern1|pattern2" file  # Extended regex

# sed - Stream Editor
sed 's/old/new/' file       # Replace first occurrence
sed 's/old/new/g' file      # Replace all occurrences
sed 's/old/new/gi' file     # Case insensitive replace
sed -n '5,10p' file         # Print lines 5-10
sed '5d' file               # Delete line 5
sed '/pattern/d' file       # Delete lines matching pattern

# awk - Pattern Processing
awk '{print $1}' file       # Print first column
awk '{print $1, $3}' file   # Print columns 1 and 3
awk '/pattern/ {print}' file # Print lines with pattern
awk 'NR==5' file            # Print line 5
awk 'NF==3' file            # Print lines with 3 fields
awk '{sum += $1} END {print sum}' file  # Sum first column
```

### 17.2 Text Manipulation

```bash
# cut - Extract Columns
cut -d: -f1 /etc/passwd     # Extract usernames
cut -c1-5 file              # Extract characters 1-5
cut -d, -f2,4 file          # Extract columns 2 and 4

# sort - Sort Lines
sort file                   # Sort alphabetically
sort -n file                # Numeric sort
sort -r file                # Reverse sort
sort -k2 file               # Sort by second column
sort -u file                # Sort and remove duplicates

# uniq - Remove Duplicates
uniq file                   # Remove adjacent duplicates
uniq -c file                # Count occurrences
uniq -d file                # Show only duplicates
uniq -u file                # Show only unique lines

# tr - Translate Characters
tr 'a-z' 'A-Z' < file       # Convert to uppercase
tr -d ' ' < file            # Remove spaces
tr '\n' ' ' < file          # Replace newlines with spaces
```

---

## 🔧 **18. SYSTEM CONFIGURATION**

### 18.1 Environment Variables

```bash
# View Environment
env                         # All environment variables
printenv                    # All environment variables
echo $PATH                  # Specific variable
export VAR=value            # Set environment variable

# Configuration Files
/etc/environment            # System-wide environment
/etc/profile                # System-wide profile
~/.bashrc                   # User bash configuration
~/.profile                  # User profile
~/.bash_profile             # User bash profile
```

### 18.2 Locale & Time

```bash
# Locale Settings
locale                      # Current locale settings
locale -a                   # Available locales
localectl list-locales      # List locales (systemd)
localectl set-locale LANG=en_US.UTF-8  # Set locale

# Time & Date
date                        # Current date/time
timedatectl                 # System time settings
timedatectl set-timezone UTC  # Set timezone
timedatectl set-ntp true    # Enable NTP
ntpq -p                     # NTP peers
chrony sources              # Chrony time sources
```

### 18.3 Kernel Parameters

```bash
# Kernel Parameters
sysctl -a                   # All kernel parameters
sysctl kernel.hostname      # Specific parameter
sysctl -w net.ipv4.ip_forward=1  # Set parameter
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf  # Persistent

# Module Management
lsmod                       # List loaded modules
modprobe module_name        # Load module
rmmod module_name           # Remove module
modinfo module_name         # Module information
/etc/modules                # Modules to load at boot
```

---

## 🚨 **19. TROUBLESHOOTING**

### 19.1 System Diagnostics

```bash
# Boot Issues
dmesg | grep -i error       # Kernel boot errors
journalctl --boot          # Current boot logs
systemctl --failed          # Failed services
systemctl list-jobs         # Active jobs

# Hardware Issues
lshw -short                 # Hardware summary
lscpu                       # CPU information
lsmem                       # Memory information
lsblk                       # Block devices
smartctl -a /dev/sda        # Disk health

# Performance Issues
top                         # Process monitor
iotop                       # I/O monitor
netstat -i                  # Network statistics
ss -tuln                    # Socket statistics
```

### 19.2 Network Troubleshooting

```bash
# Connectivity
ping -c 4 8.8.8.8          # Test connectivity
traceroute google.com       # Trace route
mtr google.com              # My traceroute
nslookup google.com         # DNS lookup
dig google.com              # DNS query

# Network Configuration
ip addr show                # IP addresses
ip route show               # Routing table
ip link show                # Network interfaces
netstat -rn                 # Routing table (legacy)
arp -a                      # ARP table

# Port & Service Issues
netstat -tuln               # Listening ports
ss -tuln                    # Socket statistics (modern)
lsof -i :80                 # Processes using port 80
telnet host port            # Test port connectivity
nc -zv host port            # Netcat port test
```

### 19.3 File System Issues

```bash
# Disk Space
df -h                       # Filesystem usage
du -sh /var/log/*           # Log file sizes
lsof +L1                    # Deleted files still open
find / -size +100M          # Large files

# File System Errors
fsck /dev/sda1              # Check filesystem
fsck -f /dev/sda1           # Force check
mount -o remount,ro /       # Remount read-only
dmesg | grep -i "i/o error" # I/O errors

# Permission Issues
ls -la file                 # Check permissions
getfacl file                # Check ACLs
lsattr file                 # Check attributes
```

---

## 📖 **20. ESSENTIAL CONFIGURATION FILES**

### 20.1 System Configuration

```bash
# Core System Files
/etc/passwd                 # User accounts
/etc/shadow                 # Password hashes
/etc/group                  # Group definitions
/etc/hosts                  # Static hostname resolution
/etc/hostname               # System hostname
/etc/resolv.conf            # DNS configuration
/etc/nsswitch.conf          # Name service switch
/etc/fstab                  # Filesystem mount table
/etc/mtab                   # Currently mounted filesystems

# Boot & Kernel
/boot/grub/grub.cfg         # GRUB bootloader config
/etc/default/grub           # GRUB defaults
/etc/modules                # Kernel modules to load
/etc/modprobe.d/            # Module configuration
/proc/cmdline               # Kernel command line
/proc/version               # Kernel version
```

### 20.2 Service Configuration

```bash
# SSH Configuration
/etc/ssh/sshd_config        # SSH daemon configuration
/etc/ssh/ssh_config         # SSH client configuration
~/.ssh/authorized_keys      # User's public keys
~/.ssh/config               # User's SSH config

# Web Server Configuration
/etc/apache2/apache2.conf   # Apache main config
/etc/nginx/nginx.conf       # Nginx main config
/var/www/html/              # Default web root

# Database Configuration
/etc/mysql/mysql.conf.d/    # MySQL configuration
/var/lib/mysql/             # MySQL data directory
/etc/postgresql/            # PostgreSQL configuration
```

### 20.3 Network Configuration

```bash
# Network Configuration
/etc/network/interfaces     # Network interfaces (Debian/Ubuntu)
/etc/sysconfig/network-scripts/  # Network scripts (RHEL/CentOS)
/etc/systemd/network/       # Systemd network configuration
/etc/hosts                  # Static hostname resolution
/etc/resolv.conf            # DNS configuration

# Firewall Configuration
/etc/iptables/rules.v4      # IPv4 iptables rules
/etc/iptables/rules.v6      # IPv6 iptables rules
/etc/ufw/                   # UFW configuration
/etc/firewalld/             # Firewalld configuration
```

---

## 🎓 **ADVANCED TOPICS & CERTIFICATIONS**

### 21.1 Linux Certifications

```bash
# CompTIA Linux+
# LPIC-1, LPIC-2, LPIC-3 (Linux Professional Institute)
# Red Hat Certified System Administrator (RHCSA)
# Red Hat Certified Engineer (RHCE)
# SUSE Certified Linux Administrator
# Ubuntu Certified Professional
```

### 21.2 Advanced Technologies

```bash
# Virtualization
KVM/QEMU                    # Kernel-based Virtual Machine
VirtualBox                  # Desktop virtualization
VMware                      # Enterprise virtualization
Xen                         # Hypervisor

# Cloud Technologies
AWS CLI                     # Amazon Web Services
Azure CLI                   # Microsoft Azure
Google Cloud SDK            # Google Cloud Platform
OpenStack                   # Open source cloud platform

# Configuration Management
Ansible                     # Automation platform
Puppet                      # Configuration management
Chef                        # Infrastructure automation
SaltStack                   # Configuration management

# Container Orchestration
Kubernetes                  # Container orchestration
Docker Swarm                # Docker's orchestration
OpenShift                   # Red Hat's Kubernetes platform
Rancher                     # Kubernetes management
```

### 21.3 Monitoring & Observability

```bash
# Monitoring Systems
Nagios                      # Network monitoring
Zabbix                      # Infrastructure monitoring
Prometheus                  # Time-series monitoring
Grafana                     # Metrics visualization
ELK Stack                   # Elasticsearch, Logstash, Kibana
TICK Stack                  # Telegraf, InfluxDB, Chronograf, Kapacitor
```

---

## 🚀 **LEARNING PATH & PRACTICE**

### 22.1 Hands-on Labs

```bash
# Home Lab Setup
1. Install Linux in VirtualBox/VMware
2. Set up multiple VMs for clustering
3. Configure services (web, database, DNS)
4. Practice automation with scripts
5. Implement monitoring solutions

# Real-world Projects
1. Build a LAMP/LEMP stack
2. Set up a mail server
3. Configure a proxy server
4. Implement backup solutions
5. Create CI/CD pipelines
```

### 22.2 Essential Skills Timeline

```bash
# Beginner (1-3 months)
- Basic navigation and file operations
- User and permission management
- Package management
- Basic shell scripting

# Intermediate (3-6 months)
- Service management and systemd
- Network configuration
- Security hardening
- Database administration

# Advanced (6-12 months)
- Performance tuning
- Automation and configuration management
- Container technologies
- Cloud integration

# Expert (12+ months)
- Large-scale system architecture
- High availability and clustering
- Advanced troubleshooting
- Mentoring and team leadership
```

### 22.3 Daily Practice Routine

```bash
# Daily Tasks (30-60 minutes)
1. Check system logs for errors
2. Monitor system performance
3. Review and update configurations
4. Practice new commands
5. Read Linux documentation

# Weekly Tasks
1. System updates and patches
2. Backup verification
3. Security audits
4. Performance analysis
5. Documentation updates

# Monthly Tasks
1. Full system backups
2. Disaster recovery testing
3. Technology evaluation
4. Training and certification progress
5. Lab environment updates
```

---

## 📚 **ESSENTIAL RESOURCES**

### Documentation

- Linux man pages (`man command`)
- Distribution-specific documentation
- Red Hat Enterprise Linux Documentation
- Ubuntu Server Guide
- Arch Linux Wiki

### Books

- "The Linux Command Line" by William Shotts
- "Linux Bible" by Christopher Negus
- "UNIX and Linux System Administration Handbook"
- "Linux Performance and Tuning Guidelines"

### Online Resources

- Linux Foundation Training
- Red Hat Learning Subscription
- Pluralsight/Udemy Linux courses
- YouTube channels (LearnLinuxTV, NetworkChuck)
- Linux Forums and Communities

---

_This comprehensive guide covers all essential aspects of Linux System Administration. Practice regularly, build projects, and never stop learning!_
