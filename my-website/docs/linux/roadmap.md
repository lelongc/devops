# Linux Complete Learning Roadmap - Chi tiết từng topic

## 🎯 Mục tiêu: Master Linux từ A-Z trong 10-12 tháng

## 🔰 GIAI ĐOẠN 1: LINUX FOUNDATION (Tháng 1-2)

### Week 1: Linux Fundamentals

**Search Keywords để học:**

- [ ] "What is Linux operating system"
- [ ] "Linux vs Windows vs macOS comparison"
- [ ] "Linux distributions comparison Ubuntu CentOS RHEL"
- [ ] "Linux history and philosophy"
- [ ] "Open source vs proprietary software"
- [ ] "GNU/Linux difference explained"
- [ ] "Linux kernel vs Linux distribution"
- [ ] "How to choose Linux distro for beginners"

**Practical Labs:**

- [ ] Install Ubuntu 22.04 LTS on VirtualBox
- [ ] Install CentOS Stream 9 dual boot
- [ ] Try Linux live USB without installation
- [ ] Compare different desktop environments (GNOME, KDE, XFCE)

### Week 2: Terminal & Shell Basics

**Search Keywords để học:**

- [ ] "Linux terminal emulator vs shell difference"
- [ ] "Bash shell tutorial for beginners"
- [ ] "Linux command structure syntax"
- [ ] "Terminal shortcuts and hotkeys"
- [ ] "Shell prompt customization PS1"
- [ ] "History command in Linux bash"
- [ ] "Tab completion in Linux terminal"
- [ ] "Command substitution in bash"

**Commands để practice:**

```bash
# Basic navigation
pwd, cd, ls, clear, exit, logout, whoami, id, date, uptime, uname

# Getting help
man, info, --help, whatis, apropos, which, type, help

# History and shortcuts
history, !!, !n, Ctrl+R, Ctrl+C, Ctrl+Z, Ctrl+D, Ctrl+L
```

### Week 3: File System Navigation

**Search Keywords để học:**

- [ ] "Linux file system hierarchy standard FHS"
- [ ] "Linux directory structure explained /etc /var /usr"
- [ ] "Absolute vs relative path Linux"
- [ ] "Linux file system tree structure"
- [ ] "Important Linux directories purpose"
- [ ] "Linux file naming conventions"
- [ ] "Case sensitivity in Linux file names"
- [ ] "Hidden files in Linux dot files"

**Commands để practice:**

```bash
# Navigation
ls, ls -la, ls -lh, ls -R, cd, cd -, cd ~, pwd

# File operations
touch, mkdir, mkdir -p, rmdir, rm, rm -rf, cp, cp -r, mv

# Viewing content
cat, less, more, head, tail, tail -f, wc, file, stat
```

### Week 4: File Permissions & Ownership

**Search Keywords để học:**

- [ ] "Linux file permissions explained rwx"
- [ ] "chmod command tutorial octal notation"
- [ ] "chown chgrp command examples"
- [ ] "Linux permission bits calculation"
- [ ] "SUID SGID sticky bit Linux"
- [ ] "umask command Linux default permissions"
- [ ] "Access Control Lists ACL Linux"
- [ ] "Linux file attributes lsattr chattr"

**Commands để practice:**

```bash
# Permissions
chmod, chmod +x, chmod 755, chmod u+r,g-w,o=r
chown, chown user:group, chgrp
umask, umask 022

# Special permissions
chmod +s, chmod +t, chmod 4755, chmod 2755, chmod 1755

# ACLs
getfacl, setfacl, setfacl -m u:user:rwx
```

## 🔧 GIAI ĐOẠN 2: TEXT PROCESSING & SCRIPTING (Tháng 3)

### Week 5: Text Processing Mastery

**Search Keywords để học:**

- [ ] "grep command tutorial regular expressions"
- [ ] "sed command examples find and replace"
- [ ] "awk programming tutorial field processing"
- [ ] "sort command options Linux"
- [ ] "uniq command remove duplicates"
- [ ] "cut command extract columns"
- [ ] "tr command translate characters"
- [ ] "join paste commands Linux"

**Commands để practice:**

```bash
# Text search and filter
grep, grep -r, grep -v, grep -i, grep -n, grep -E, grep -F
egrep, fgrep, zgrep

# Text processing
sed, sed 's/old/new/g', sed -i, sed -n
awk, awk '{print $1}', awk -F, awk 'BEGIN{} {action} END{}'
sort, sort -n, sort -r, sort -k, sort -u
uniq, uniq -c, uniq -d
cut, cut -d, cut -f, cut -c
tr, tr '[:lower:]' '[:upper:]', tr -d, tr -s
```

### Week 6: I/O Redirection & Pipes

**Search Keywords để học:**

- [ ] "Linux I/O redirection tutorial stdin stdout stderr"
- [ ] "Pipe command Linux examples"
- [ ] "Tee command split output Linux"
- [ ] "Here document heredoc Linux"
- [ ] "Process substitution bash"
- [ ] "/dev/null black hole Linux"
- [ ] "File descriptors Linux 0 1 2"
- [ ] "Named pipes FIFO Linux"

**Commands để practice:**

```bash
# Redirections
>, >>, <, 2>, 2>>, &>, &>>, 2>&1, 1>&2

# Pipes and filters
|, tee, tee -a
command1 | command2 | command3

# Advanced redirection
exec, exec 3< file, exec 3> file
mkfifo, named pipes
```

### Week 7: Vim Editor Mastery

**Search Keywords để học:**

- [ ] "Vim editor tutorial for beginners"
- [ ] "Vim modes normal insert visual command"
- [ ] "Vim navigation commands hjkl"
- [ ] "Vim search and replace commands"
- [ ] "Vim configuration vimrc file"
- [ ] "Vim plugins installation"
- [ ] "Vim copy paste yank put commands"
- [ ] "Vim macros recording and playback"

**Vim Skills để practice:**

```vim
# Navigation
h,j,k,l, w,b,e, 0,$, gg,G, Ctrl+f,Ctrl+b, :n

# Editing
i,a,o,O,I,A, x,dd,yy,p,P, u,Ctrl+r
:w, :q, :wq, :q!, ZZ

# Search/Replace
/, ?, n, N, :%s/old/new/g, :g/pattern/d

# Visual mode
v, V, Ctrl+v, gv
```

### Week 8: Shell Scripting Fundamentals

**Search Keywords để học:**

- [ ] "Bash scripting tutorial for beginners"
- [ ] "Shell script shebang line #!/bin/bash"
- [ ] "Bash variables local global environment"
- [ ] "Command line arguments $1 $2 $@ $#"
- [ ] "Bash conditional statements if else"
- [ ] "Bash loops for while until"
- [ ] "Bash functions definition and calling"
- [ ] "Exit codes return values bash script"

**Scripting Concepts:**

```bash
# Script structure
#!/bin/bash, chmod +x script.sh, ./script.sh

# Variables
var=value, $var, ${var}, local var, export var
$0, $1, $2, $@, $#, $?, $$

# Conditionals
if, elif, else, fi, test, [, [[, case

# Loops
for, while, until, break, continue

# Functions
function_name() { commands; }, return, $1 in functions
```

## 🖥️ GIAI ĐOẠN 3: SYSTEM ADMINISTRATION (Tháng 4-5)

### Week 9: Process Management

**Search Keywords để học:**

- [ ] "Linux process management tutorial"
- [ ] "ps command options Linux processes"
- [ ] "top htop command system monitoring"
- [ ] "Linux signals SIGTERM SIGKILL"
- [ ] "Background jobs Linux nohup disown"
- [ ] "Process priority nice renice"
- [ ] "Linux process states running sleeping zombie"
- [ ] "pstree command process hierarchy"

**Commands để practice:**

```bash
# Process viewing
ps, ps aux, ps -ef, pstree, pgrep, pidof
top, htop, iotop, atop

# Process control
kill, killall, pkill, kill -9, kill -TERM
jobs, bg, fg, nohup, disown, screen, tmux

# Process priority
nice, renice, ionice
```

### Week 10: System Services & systemd

**Search Keywords để học:**

- [ ] "systemd tutorial Linux service management"
- [ ] "systemctl command examples"
- [ ] "Linux boot process systemd"
- [ ] "systemd unit files service timer"
- [ ] "journalctl log management systemd"
- [ ] "systemd targets vs runlevels"
- [ ] "Create custom systemd service"
- [ ] "systemd socket activation"

**Commands để practice:**

```bash
# Service management
systemctl start/stop/restart/reload service
systemctl enable/disable service
systemctl status service
systemctl list-units, systemctl list-unit-files

# System control
systemctl poweroff, systemctl reboot
systemctl isolate target

# Logging
journalctl, journalctl -u service, journalctl -f
journalctl --since "1 hour ago"
```

### Week 11: User & Group Management

**Search Keywords để học:**

- [ ] "Linux user management commands"
- [ ] "useradd usermod userdel commands"
- [ ] "Linux group management groupadd"
- [ ] "passwd command change password Linux"
- [ ] "sudo configuration sudoers file"
- [ ] "su vs sudo difference Linux"
- [ ] "Linux user home directory structure"
- [ ] "Password aging chage command"

**Commands để practice:**

```bash
# User management
useradd, useradd -m -s /bin/bash username
usermod, usermod -aG group user
userdel, userdel -r username
passwd, passwd username

# Group management
groupadd, groupmod, groupdel
groups, id, whoami, who, w, last

# Sudo configuration
visudo, sudo -l, sudo -u user command
```

### Week 12: File System Management

**Search Keywords để học:**

- [ ] "Linux file systems ext4 xfs btrfs"
- [ ] "Linux disk partitioning fdisk parted"
- [ ] "mount umount command Linux"
- [ ] "fstab file automatic mounting"
- [ ] "df du commands disk usage"
- [ ] "fsck file system check repair"
- [ ] "LVM logical volume management Linux"
- [ ] "Linux swap partition management"

**Commands để practice:**

```bash
# Disk management
fdisk, fdisk -l, parted, lsblk, blkid
mkfs.ext4, mkfs.xfs, mkswap
mount, umount, mount -a
df, df -h, du, du -h, du -s

# File system maintenance
fsck, fsck.ext4, e2fsck
tune2fs, dumpe2fs, debugfs
```

## 💾 GIAI ĐOẠN 4: STORAGE & NETWORKING (Tháng 6-7)

### Week 13: Advanced Storage (LVM & RAID)

**Search Keywords để học:**

- [ ] "LVM tutorial Linux logical volume manager"
- [ ] "Linux LVM commands pvcreate vgcreate lvcreate"
- [ ] "LVM snapshot backup restore"
- [ ] "Linux software RAID mdadm"
- [ ] "RAID levels 0 1 5 6 10 comparison"
- [ ] "Linux encrypted file system LUKS"
- [ ] "Linux quota management disk limits"
- [ ] "NFS network file system Linux"

**Commands để practice:**

```bash
# LVM
pvcreate, pvdisplay, pvscan
vgcreate, vgdisplay, vgextend
lvcreate, lvdisplay, lvextend, lvresize

# RAID
mdadm, mdadm --create, mdadm --detail
cat /proc/mdstat

# Encryption
cryptsetup, cryptsetup luksFormat
```

### Week 14: Network Configuration

**Search Keywords để học:**

- [ ] "Linux network configuration tutorial"
- [ ] "ip command Linux networking"
- [ ] "Linux network interfaces configuration"
- [ ] "netstat ss command network connections"
- [ ] "iptables firewall rules Linux"
- [ ] "Linux DNS configuration resolv.conf"
- [ ] "Linux network troubleshooting commands"
- [ ] "tcpdump wireshark packet capture"

**Commands để practice:**

```bash
# Network info
ip addr, ip route, ip link
ifconfig, route, netstat, ss
ping, traceroute, nslookup, dig

# Network tools
tcpdump, wireshark, nmap, telnet, nc
wget, curl, rsync, scp, sftp

# Firewall
iptables, iptables -L, iptables -A
firewalld, firewall-cmd
```

### Week 15: Security Fundamentals

**Search Keywords để học:**

- [ ] "Linux security best practices"
- [ ] "SSH secure shell configuration"
- [ ] "Linux file permissions security"
- [ ] "SELinux AppArmor security modules"
- [ ] "Linux firewall configuration"
- [ ] "Fail2ban intrusion prevention"
- [ ] "Linux log analysis security"
- [ ] "OpenSSL certificate management"

**Commands để practice:**

```bash
# SSH security
ssh, ssh-keygen, ssh-copy-id
sshd_config configuration

# Security tools
chkrootkit, rkhunter, lynis
aide, tripwire, fail2ban

# SSL/TLS
openssl, openssl req, openssl x509
```

### Week 16: System Monitoring

**Search Keywords để học:**

- [ ] "Linux system monitoring tools"
- [ ] "sar system activity reporter"
- [ ] "Linux performance monitoring"
- [ ] "iostat vmstat mpstat commands"
- [ ] "Linux log files analysis"
- [ ] "Nagios Zabbix system monitoring"
- [ ] "Linux system metrics collection"
- [ ] "Performance tuning Linux"

**Commands để practice:**

```bash
# System monitoring
sar, iostat, vmstat, mpstat, pidstat
dstat, nmon, glances

# Log analysis
tail -f /var/log/messages
grep ERROR /var/log/*
logrotate configuration

# Performance
perf, strace, ltrace, lsof
```

## 🚀 GIAI ĐOẠN 5: ADVANCED TOPICS (Tháng 8-9)

### Week 17: Package Management

**Search Keywords để học:**

- [ ] "Linux package management systems"
- [ ] "APT package manager Ubuntu Debian"
- [ ] "YUM DNF package manager RHEL CentOS"
- [ ] "RPM package format commands"
- [ ] "DEB package format dpkg"
- [ ] "Compile software from source Linux"
- [ ] "Package repository management"
- [ ] "Snap flatpak AppImage packages"

**Commands để practice:**

```bash
# APT (Ubuntu/Debian)
apt update, apt upgrade, apt install, apt remove
apt search, apt show, apt list
dpkg -i, dpkg -l, dpkg -r

# YUM/DNF (RHEL/CentOS)
yum install, yum update, yum remove, yum search
dnf install, dnf update, dnf remove
rpm -ivh, rpm -qa, rpm -e

# Source compilation
./configure, make, make install
checkinstall, alien
```

### Week 18: Backup & Recovery

**Search Keywords để học:**

- [ ] "Linux backup strategies"
- [ ] "rsync command synchronization backup"
- [ ] "tar command archive backup"
- [ ] "dd command disk cloning backup"
- [ ] "Linux automated backup scripts"
- [ ] "Bacula Amanda backup software"
- [ ] "Linux disaster recovery planning"
- [ ] "Database backup MySQL PostgreSQL"

**Commands để practice:**

```bash
# Backup tools
tar czf backup.tar.gz directory/
rsync -av source/ destination/
dd if=/dev/sda of=backup.img

# Incremental backups
rsync --link-dest, rdiff-backup
duplicity, borgbackup

# Recovery
tar xzf backup.tar.gz
rsync restore procedures
```

### Week 19: Automation & Scripting Advanced

**Search Keywords để học:**

- [ ] "Advanced bash scripting techniques"
- [ ] "Linux cron job scheduling"
- [ ] "at command one-time scheduling"
- [ ] "Linux automation with Python"
- [ ] "Ansible automation Linux"
- [ ] "Linux system administration automation"
- [ ] "Bash scripting best practices"
- [ ] "Error handling bash scripts"

**Advanced Scripting:**

```bash
# Cron jobs
crontab -e, crontab -l
@reboot, @daily, @weekly, @monthly

# Advanced bash
trap, exec, getopts
associative arrays, regex matching
error handling, logging

# Automation tools
ansible, ansible-playbook
puppet, chef basics
```

### Week 20: Performance Tuning

**Search Keywords để học:**

- [ ] "Linux performance tuning guide"
- [ ] "Linux kernel parameters tuning"
- [ ] "CPU performance optimization Linux"
- [ ] "Memory management Linux tuning"
- [ ] "Disk I/O optimization Linux"
- [ ] "Network performance tuning Linux"
- [ ] "Linux system benchmarking tools"
- [ ] "Application performance profiling"

**Performance Tools:**

```bash
# Benchmarking
sysbench, stress, stress-ng
bonnie++, iozone, fio

# Profiling
perf record, perf report, perf top
valgrind, gprof, callgrind

# Tuning
sysctl, /proc/sys tuning
CPU governors, I/O schedulers
```

## 🏆 GIAI ĐOẠN 6: EXPERT LEVEL (Tháng 10-12)

### Week 21-22: Kernel & Low-level

**Search Keywords để học:**

- [ ] "Linux kernel compilation tutorial"
- [ ] "Linux kernel modules development"
- [ ] "Linux device drivers basics"
- [ ] "Linux kernel debugging techniques"
- [ ] "Linux system calls programming"
- [ ] "Linux kernel parameters boot"
- [ ] "Linux real-time kernel RT"
- [ ] "eBPF extended Berkeley Packet Filter"

### Week 23-24: Containerization & Virtualization

**Search Keywords để học:**

- [ ] "Linux containers LXC Docker"
- [ ] "Linux namespaces cgroups"
- [ ] "KVM QEMU virtualization Linux"
- [ ] "libvirt virtual machine management"
- [ ] "Linux container security"
- [ ] "Linux virtualization performance"
- [ ] "Xen hypervisor Linux"
- [ ] "Linux container orchestration"

### Week 25-26: High Availability & Clustering

**Search Keywords để học:**

- [ ] "Linux high availability clustering"
- [ ] "Pacemaker Corosync cluster Linux"
- [ ] "Linux load balancing HAProxy"
- [ ] "Linux failover clustering"
- [ ] "DRBD distributed storage Linux"
- [ ] "Linux cluster file systems"
- [ ] "Linux service redundancy"
- [ ] "Linux disaster recovery cluster"

### Week 27-28: Security Advanced

**Search Keywords để học:**

- [ ] "Linux security hardening guide"
- [ ] "Linux intrusion detection systems"
- [ ] "Linux vulnerability assessment"
- [ ] "Linux forensics investigation"
- [ ] "Linux malware analysis"
- [ ] "Linux network security monitoring"
- [ ] "Linux security compliance"
- [ ] "Linux penetration testing"

## 📚 LEARNING RESOURCES BY CATEGORY

### 🎥 Video Courses

- "Linux Command Line Basics" - Search on YouTube/Udemy
- "Linux System Administration" - Linux Academy
- "Red Hat Certified Engineer" - Pluralsight
- "Linux Security" - Cybrary
- "Linux Networking" - CBT Nuggets

### 📖 Books to Read

- "The Linux Command Line" - William Shotts
- "Linux Bible" - Christopher Negus
- "UNIX and Linux System Administration Handbook"
- "Linux Kernel Development" - Robert Love
- "Linux Security Cookbook"

### 🛠️ Practice Platforms

- "VirtualBox Linux labs"
- "AWS EC2 free tier Linux"
- "Google Cloud Platform Linux instances"
- "Linux Academy hands-on labs"
- "Katacoda Linux scenarios"

### 🏅 Certifications Path

1. **CompTIA Linux+** (Month 4)
2. **LPIC-1** (Month 6)
3. **RHCSA** (Month 8)
4. **LPIC-2** (Month 10)
5. **RHCE** (Month 12)

## ✅ DAILY PRACTICE CHECKLIST

### Morning (30 mins)

- [ ] Practice 10 Linux commands
- [ ] Read 1 man page thoroughly
- [ ] Try 1 new command option
- [ ] Review previous day notes

### Evening (30 mins)

- [ ] Complete 1 hands-on lab
- [ ] Write command examples in notes
- [ ] Search and bookmark 1 new resource
- [ ] Plan tomorrow's learning topics

### Weekly Goals

- [ ] Complete 1 major project
- [ ] Write 1 blog post about learning
- [ ] Join 1 Linux discussion forum
- [ ] Practice troubleshooting scenarios

**Linux Learning Philosophy**: "Practice daily, document everything, break things safely!"
