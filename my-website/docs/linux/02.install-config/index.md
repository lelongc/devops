# Linux Installation & Configuration - Hướng Dẫn Cài Đặt và Cấu Hình

## 🎯 Mục Tiêu Học Tập

Sau khi hoàn thành chương này, bạn sẽ:

- Hiểu được Virtual Machine và các ứng dụng ảo hóa
- Cài đặt và cấu hình VirtualBox/VMware
- Phân biệt CentOS và CentOS Stream
- Biết các cách cài đặt Linux khác nhau
- Thực hiện cài đặt Linux trên máy ảo
- Quản lý máy ảo hiệu quả
- Sử dụng keyboard shortcuts trong Linux

---

## 🖥️ Virtual Machine Là Gì?

### Định Nghĩa

**Virtual Machine (VM)** hay **Máy ảo** là một môi trường máy tính được mô phỏng bằng phần mềm, chạy trên một máy tính vật lý (host machine).

### Lợi Ích Của Máy Ảo

#### ✅ Advantages

- **Isolation**: Các VM độc lập với nhau
- **Testing Safe**: Test phần mềm mà không ảnh hưởng host
- **Multiple OS**: Chạy nhiều hệ điều hành cùng lúc
- **Snapshots**: Lưu trạng thái và khôi phục
- **Resource Control**: Kiểm soát CPU, RAM, Storage

#### ❌ Disadvantages

- **Performance Overhead**: Chậm hơn máy thật 10-15%
- **Resource Intensive**: Cần RAM và CPU cao
- **Hardware Limitations**: Một số hardware không support

### Kiến Trúc Virtual Machine

```
┌─────────────────────────────────────────┐
│            Virtual Machine              │
├─────────────────────────────────────────┤
│          Guest OS (Linux)               │
├─────────────────────────────────────────┤
│        Virtual Hardware Layer           │
├─────────────────────────────────────────┤
│    Hypervisor (VirtualBox/VMware)       │
├─────────────────────────────────────────┤
│          Host OS (Windows)              │
├─────────────────────────────────────────┤
│         Physical Hardware               │
└─────────────────────────────────────────┘
```

---

## 📦 Oracle VirtualBox

### VirtualBox Là Gì?

VirtualBox là phần mềm ảo hóa **miễn phí** và **mã nguồn mở** của Oracle, hỗ trợ chạy nhiều hệ điều hành trên một máy tính.

### Tải Và Cài Đặt VirtualBox

#### Bước 1: Download VirtualBox

1. Truy cập: https://www.virtualbox.org/
2. Click **"Download VirtualBox 7.0"**
3. Chọn **"Windows hosts"** cho Windows
4. Download **Extension Pack** (optional nhưng recommended)

#### Bước 2: Cài Đặt VirtualBox

```bash
# Các bước cài đặt:
1. Chạy file .exe đã download
2. Click "Next" → "Next" → "Next"
3. Chọn thư mục cài đặt (mặc định: C:\Program Files\Oracle\VirtualBox)
4. Tích chọn "Create shortcuts"
5. Click "Install"
6. Reboot máy tính nếu được yêu cầu
```

#### Bước 3: Cài Extension Pack

```bash
1. Mở VirtualBox
2. File → Preferences → Extensions
3. Click icon "+" và chọn Extension Pack đã download
4. Click "Install" và Accept license
```

### System Requirements

| Component          | Minimum            | Recommended |
| ------------------ | ------------------ | ----------- |
| **RAM**            | 4GB                | 8GB+        |
| **CPU**            | Dual-core          | Quad-core+  |
| **Storage**        | 20GB free          | 50GB+       |
| **Virtualization** | VT-x/AMD-V enabled | Required    |

---

## 🔧 VMware Player

### VMware Player vs VirtualBox

| Feature           | VirtualBox | VMware Player       |
| ----------------- | ---------- | ------------------- |
| **Cost**          | Free       | Free (Personal use) |
| **Performance**   | Good       | Better              |
| **3D Support**    | Basic      | Advanced            |
| **USB 3.0**       | Yes        | Yes                 |
| **Snapshots**     | Yes        | Yes (Paid version)  |
| **Linux Support** | Excellent  | Good                |

### Tải Và Cài Đặt VMware Player

#### Bước 1: Download

1. Truy cập: https://www.vmware.com/products/workstation-player.html
2. Click **"Download Now"**
3. Chọn **"VMware Workstation Player for Windows"**

#### Bước 2: Installation

```bash
1. Chạy VMware-player-xxx.exe
2. Accept License Agreement
3. Chọn installation directory
4. Tích "Enhanced Keyboard Driver" (recommended)
5. Untick "Join VMware Customer Experience"
6. Click "Install"
7. Restart when prompted
```

#### Bước 3: Initial Setup

```bash
1. Launch VMware Player
2. Select "Use VMware Workstation Player for free"
3. Click "Continue"
4. Enter email (optional)
5. Click "Finish"
```

---

## 🐧 CentOS vs CentOS Stream

### CentOS Traditional

#### Đặc Điểm

- **Stability**: Rất ổn định, ít thay đổi
- **Enterprise**: Tương thích với RHEL
- **Long-term Support**: 10 năm support
- **Release Model**: Point releases (7.1, 7.2, etc.)

#### Lifecycle

```
CentOS 7: 2014-2024 (10 years)
CentOS 8: 2019-2021 (Discontinued)
```

### CentOS Stream

#### Đặc Điểm

- **Rolling Release**: Updates liên tục
- **Upstream**: Preview của RHEL future
- **Development**: Suitable cho development
- **Testing**: Beta version của enterprise features

#### Positioning

```
Fedora → CentOS Stream → RHEL
   ↓           ↓          ↓
Bleeding    Rolling   Stable
  Edge      Release   Enterprise
```

### So Sánh Chi Tiết

| Aspect            | CentOS Traditional | CentOS Stream       |
| ----------------- | ------------------ | ------------------- |
| **Release Model** | Point releases     | Rolling             |
| **Stability**     | Very High          | Medium-High         |
| **Updates**       | Security only      | Feature + Security  |
| **Use Case**      | Production         | Development/Testing |
| **RHEL Relation** | Clone              | Upstream            |
| **Support**       | 10 years           | Continuous          |

### Nên Chọn Gì?

#### ✅ Chọn CentOS Stream khi:

- Development environment
- Muốn features mới sớm
- Testing applications
- Learning latest tech

#### ✅ Chọn alternatives (Rocky/Alma) khi:

- Production servers
- Maximum stability
- Enterprise requirements
- Long-term support needed

---

## 💿 Các Cách Cài Đặt Linux

### 1. Physical Installation (Bare Metal)

```bash
Pros:
✅ Maximum performance
✅ Full hardware access
✅ No virtualization overhead

Cons:
❌ Risk to existing OS
❌ Hardware compatibility issues
❌ No easy rollback
```

### 2. Virtual Machine Installation

```bash
Pros:
✅ Safe testing environment
✅ Easy snapshots/rollback
✅ Multiple OS on same machine
✅ Resource isolation

Cons:
❌ Performance overhead
❌ Limited hardware access
❌ Requires powerful host
```

### 3. Dual Boot Installation

```bash
Pros:
✅ Native performance
✅ Keep existing Windows
✅ Full hardware access

Cons:
❌ Bootloader complexity
❌ Partition management
❌ Risk of data loss
```

### 4. Cloud Installation

```bash
Pros:
✅ No local hardware needed
✅ Scalable resources
✅ Global accessibility
✅ Professional infrastructure

Cons:
❌ Requires internet
❌ Monthly costs
❌ Limited control
```

### 5. Container Installation (Docker/WSL)

```bash
Pros:
✅ Lightweight
✅ Fast startup
✅ Easy deployment
✅ Resource efficient

Cons:
❌ Shared kernel
❌ Limited system access
❌ Not full OS experience
```

---

## 🚀 Tạo Virtual Machine

### Chuẩn Bị Trước Khi Tạo VM

#### System Requirements Check

```bash
# Kiểm tra Virtualization Support
1. Boot vào BIOS/UEFI
2. Tìm "Virtualization Technology" hoặc "VT-x"
3. Enable nếu chưa bật
4. Save và reboot

# Kiểm tra trong Windows
1. Task Manager → Performance → CPU
2. Xem "Virtualization: Enabled"
```

#### Download Linux ISO

- **CentOS 7**: https://vault.centos.org/7.9.2009/isos/x86_64/
- **CentOS Stream 9**: https://www.centos.org/download/
- **Ubuntu**: https://ubuntu.com/download
- **Rocky Linux**: https://rockylinux.org/download

### Tạo VM Trong VirtualBox

#### Bước 1: Create New VM

```bash
1. Mở VirtualBox
2. Click "New" (Ctrl+N)
3. Name: "CentOS-Lab"
4. Type: "Linux"
5. Version: "Red Hat (64-bit)"
6. Click "Next"
```

#### Bước 2: Memory Configuration

```bash
# Recommended Memory:
- Minimum: 1024 MB (1 GB)
- Recommended: 2048 MB (2 GB)
- Optimal: 4096 MB (4 GB)

Note: Không nên vượt quá 50% RAM của host
```

#### Bước 3: Hard Disk Setup

```bash
1. Select "Create a virtual hard disk now"
2. Hard disk file type: "VDI"
3. Storage: "Dynamically allocated"
4. Size: 20 GB (minimum), 50 GB (recommended)
5. Click "Create"
```

#### Bước 4: VM Settings Configuration

```bash
# System Settings:
1. Right-click VM → Settings
2. System → Motherboard:
   - Boot Order: Optical, Hard Disk
   - Chipset: ICH9
   - Enable I/O APIC: ✓

3. System → Processor:
   - Processors: 2 CPUs
   - Enable PAE/NX: ✓
   - Enable VT-x/AMD-V: ✓

# Display Settings:
4. Display → Screen:
   - Video Memory: 128 MB
   - Graphics Controller: VBoxSVGA
   - Enable 3D Acceleration: ✓

# Network Settings:
5. Network → Adapter 1:
   - Enable Network Adapter: ✓
   - Attached to: NAT
```

### Tạo VM Trong VMware

#### Bước 1: New Virtual Machine

```bash
1. Open VMware Player
2. "Create a New Virtual Machine"
3. Select "I will install OS later"
4. Guest OS: "Linux"
5. Version: "CentOS 7 64-bit"
6. VM Name: "CentOS-Lab"
```

#### Bước 2: Hardware Configuration

```bash
# Disk Configuration:
- Disk Size: 20 GB
- Split into multiple files: ✓

# Customize Hardware:
- Memory: 2048 MB
- Processors: 2
- Network: NAT
- USB: USB 3.0
```

---

## 📀 Cài Đặt CentOS 7

### Bước 1: Boot Từ ISO

```bash
1. Select VM → Settings → Storage
2. Click "Empty" CD icon
3. Click CD icon → "Choose a disk file"
4. Select CentOS-7-x86_64-DVD.iso
5. Start VM
```

### Bước 2: Installation Process

#### Welcome Screen

```bash
1. Select Language: "English (United States)"
2. Click "Continue"
```

#### Installation Summary

```bash
# DATE & TIME:
- Timezone: Asia/Ho_Chi_Minh
- NTP: Enable

# KEYBOARD:
- Layout: English (US)

# LANGUAGE SUPPORT:
- Additional: Vietnamese (optional)

# INSTALLATION SOURCE:
- Local media (default)

# SOFTWARE SELECTION:
- Base Environment: "Server with GUI" hoặc "Minimal Install"
- Add-ons: Development Tools, System Administration Tools

# INSTALLATION DESTINATION:
- Select hard disk
- Partitioning: "Automatically configure"
- Click "Done"

# NETWORK & HOST NAME:
- Ethernet: ON
- Hostname: centos7.local
- Click "Apply"
```

#### User Settings

```bash
# ROOT PASSWORD:
- Set strong password: "P@ssw0rd123"
- Confirm password

# USER CREATION:
- Full name: "Admin User"
- Username: "admin"
- Password: "admin123"
- Make this user administrator: ✓
```

### Bước 3: Post-Installation

```bash
# Reboot và login
1. Remove installation media
2. Reboot VM
3. Login với user đã tạo

# Update system:
sudo yum update -y

# Install useful packages:
sudo yum install -y wget curl vim net-tools
```

---

## 📀 Cài Đặt CentOS 8

### Lưu Ý Quan Trọng

```bash
⚠️  CentOS 8 đã End-of-Life (EOL) vào 31/12/2021
💡 Nên sử dụng:
   - Rocky Linux 8
   - AlmaLinux 8
   - CentOS Stream 8
```

### Migration Path

```bash
# Nếu đang dùng CentOS 8:
1. Migrate to Rocky Linux: sudo dnf install rocky-release
2. Migrate to AlmaLinux: curl -O https://raw.githubusercontent.com/AlmaLinux/almalinux-deploy/master/almalinux-deploy.sh
3. Continue with CentOS Stream: sudo dnf swap centos-repos centos-stream-repos
```

---

## 📀 Cài Đặt CentOS Stream 9

### System Requirements

```bash
# Minimum Requirements:
- CPU: 64-bit x86 processor
- RAM: 2 GB (4 GB recommended)
- Storage: 20 GB
- Network: Internet connection for updates
```

### Installation Steps

#### Bước 1: Download ISO

```bash
# Official download:
https://www.centos.org/download/

# Select: CentOS Stream 9
# Choose: x86_64 architecture
# Download: Boot.iso hoặc DVD.iso
```

#### Bước 2: Installation Process

```bash
# Similar to CentOS 7 but with differences:

SOFTWARE SELECTION:
- Server: Minimal Install
- Workstation: Workstation
- Custom: Custom Operating System

PARTITIONING:
- Automatic: Recommended
- Custom: Advanced users
- LVM: Default và recommended

SECURITY POLICY:
- SCAP Security Guide: Available
- Profile: Standard/STIG (optional)
```

#### Bước 3: First Boot Setup

```bash
# Cockpit Web Console:
sudo systemctl enable --now cockpit.socket
# Access: https://localhost:9090

# Firewall configuration:
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# SELinux status:
sestatus
```

---

## ☁️ Option 2 - Linux Installation trên Cloud

### Amazon Web Services (AWS)

#### EC2 Instance Launch

```bash
# Steps:
1. Login to AWS Console
2. Launch EC2 Instance
3. Choose AMI: Amazon Linux 2023
4. Instance Type: t2.micro (Free tier)
5. Key Pair: Create new
6. Security Group: Allow SSH (port 22)
7. Launch Instance

# Connect:
ssh -i keyfile.pem ec2-user@public-ip
```

### Google Cloud Platform (GCP)

#### Compute Engine VM

```bash
# gcloud CLI:
gcloud compute instances create linux-vm \
  --image-family=centos-stream-9 \
  --image-project=centos-cloud \
  --machine-type=e2-micro \
  --zone=asia-southeast1-a

# Connect:
gcloud compute ssh linux-vm --zone=asia-southeast1-a
```

### Microsoft Azure

#### Virtual Machine Creation

```bash
# Azure CLI:
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image CentOS85Gen2 \
  --admin-username azureuser \
  --generate-ssh-keys

# Connect:
ssh azureuser@public-ip
```

### Digital Ocean

#### Droplet Creation

```bash
# Via Web Interface:
1. Create → Droplets
2. Distribution: CentOS Stream 9
3. Plan: Basic $5/month
4. Authentication: SSH Key
5. Create Droplet

# Connect:
ssh root@droplet-ip
```

---

## 🎩 Red Hat Enterprise Linux (RHEL)

### RHEL vs CentOS

```bash
Feature Comparison:
┌─────────────────┬─────────────┬─────────────┐
│     Feature     │    RHEL     │   CentOS    │
├─────────────────┼─────────────┼─────────────┤
│ Cost            │ $349-2499/yr│ Free        │
│ Support         │ Official    │ Community   │
│ Updates         │ Enterprise  │ Upstream    │
│ Certification   │ Yes         │ No          │
│ Stability       │ Production  │ Production  │
└─────────────────┴─────────────┴─────────────┘
```

### RHEL Installation (Optional)

#### Developer Subscription (Free)

```bash
1. Register: https://developers.redhat.com
2. Download RHEL 9
3. Get free developer subscription
4. Install similar to CentOS
5. Register system: sudo subscription-manager register
```

#### Evaluation License

```bash
# 30-day trial:
1. Download from Red Hat Customer Portal
2. Install without registration
3. Limited to evaluation use
4. All features available
```

---

## 🍃 Ubuntu Linux Installation (Optional)

### Ubuntu Advantages

```bash
Pros:
✅ Beginner-friendly
✅ Large community
✅ Excellent hardware support
✅ Regular LTS releases
✅ Snap packages
✅ Ubuntu Software Center

Use Cases:
🖥️  Desktop workstation
👨‍💻 Development environment
🎓 Learning Linux
🏠 Home server
```

### Ubuntu Installation Steps

#### Download Ubuntu

```bash
# LTS Versions (Recommended):
- Ubuntu 22.04 LTS (Jammy Jellyfish)
- Ubuntu 20.04 LTS (Focal Fossa)

# Download from: https://ubuntu.com/download
```

#### Installation Process

```bash
# Key Differences from CentOS:
1. Language selection
2. Keyboard layout
3. Installation type:
   - Normal installation (recommended)
   - Minimal installation
4. Other options:
   - Download updates while installing: ✓
   - Install third-party software: ✓
5. User creation (no root password needed)
```

#### Post-Installation

```bash
# Update system:
sudo apt update && sudo apt upgrade -y

# Install essential packages:
sudo apt install -y curl wget vim git tree htop

# Install snap packages:
sudo snap install code --classic
sudo snap install discord
```

---

## 📸 VM Snapshot Management

### Tạo Snapshot

#### VirtualBox

```bash
1. Select VM (powered off)
2. Machine → Take Snapshot
3. Name: "Fresh Install - CentOS 7"
4. Description: "Clean installation before configuration"
5. Click "OK"

# Hoặc sử dụng running snapshot:
- VM đang chạy → Machine → Take Snapshot
```

#### VMware

```bash
1. VM → Snapshot → Take Snapshot
2. Name: "Baseline Configuration"
3. Description: "Initial setup completed"
4. Include memory: ✓ (if VM is running)
5. Click "OK"
```

### Quản Lý Snapshots

#### Snapshot Best Practices

```bash
✅ Naming Convention:
- "01-Fresh-Install"
- "02-Updates-Applied"
- "03-Software-Installed"
- "04-Before-Config-Change"

✅ When to Snapshot:
- Before major updates
- Before software installation
- Before configuration changes
- Before testing

❌ Avoid:
- Too many snapshots (impacts performance)
- Large snapshots with running VMs
- Snapshots as backup solution
```

#### Restore from Snapshot

```bash
# VirtualBox:
1. Right-click VM → Snapshots
2. Select snapshot
3. Click "Restore"
4. Choose restore type

# VMware:
1. VM → Snapshot → Snapshot Manager
2. Select snapshot
3. Click "Go To"
4. Confirm restore
```

---

## 🎛️ Virtual Machine Management

### VM Performance Optimization

#### CPU Optimization

```bash
# VirtualBox Settings:
- Processors: 2-4 cores (max 50% of host)
- Enable VT-x/AMD-V: ✓
- Enable PAE/NX: ✓
- Enable Nested Paging: ✓

# VMware Settings:
- Processors: 2-4 cores
- Virtualize Intel VT-x/AMD-V: ✓
- Virtualize CPU performance counters: ✓
```

#### Memory Optimization

```bash
# RAM Allocation:
Host RAM    VM RAM Recommendation
8 GB    →   2-3 GB
16 GB   →   4-6 GB
32 GB   →   8-12 GB

# Linux Memory Tuning:
echo 'vm.swappiness=10' >> /etc/sysctl.conf
echo 'vm.vfs_cache_pressure=50' >> /etc/sysctl.conf
```

#### Storage Optimization

```bash
# VirtualBox:
- Use SSD if available
- Enable TRIM for SSD
- VDI format for better performance
- Dynamically allocated for space efficiency

# VMware:
- Thin provisioning
- SCSI controller for better performance
- Defragment virtual disks regularly
```

### Network Configuration

#### Network Modes Comparison

```bash
┌─────────────────┬─────────────┬─────────────┬─────────────┐
│      Mode       │   Internet  │  Host Access│  VM to VM   │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ NAT             │     Yes     │     No      │     No      │
│ Bridged         │     Yes     │     Yes     │     Yes     │
│ Host-only       │     No      │     Yes     │     Yes     │
│ Internal        │     No      │     No      │     Yes     │
└─────────────────┴─────────────┴─────────────┴─────────────┘
```

#### Network Setup Examples

```bash
# Development Environment:
- Adapter 1: NAT (internet access)
- Adapter 2: Host-only (host communication)

# Server Environment:
- Adapter 1: Bridged (network access)

# Lab Environment:
- Internal network for VM-to-VM communication
```

### VM Backup Strategies

#### Export/Import VMs

```bash
# VirtualBox Export:
1. File → Export Appliance
2. Select VM
3. Format: OVF
4. Save location

# VirtualBox Import:
1. File → Import Appliance
2. Select .ova file
3. Configure settings
4. Import
```

#### File-level Backup

```bash
# Backup VM files:
# VirtualBox: ~/.VirtualBox/Machines/
# VMware: ~/vmware/

# Important files:
- .vdi/.vmdk (disk files)
- .vbox/.vmx (configuration)
- .vdi-prev (snapshots)
```

---

## ⌨️ Keyboard Keys Sử Dụng Trong Linux

### Basic Navigation Keys

#### Terminal Navigation

```bash
# Command Line Movement:
Ctrl + A     → Move to beginning of line
Ctrl + E     → Move to end of line
Ctrl + U     → Delete from cursor to beginning
Ctrl + K     → Delete from cursor to end
Ctrl + L     → Clear screen
Ctrl + C     → Cancel current command
Ctrl + Z     → Suspend current process
Ctrl + D     → Exit terminal/logout
```

#### History Navigation

```bash
↑ Arrow      → Previous command
↓ Arrow      → Next command
Ctrl + R     → Search command history
!!           → Repeat last command
!n           → Repeat command number n
!string      → Repeat last command starting with string
```

### File Operations

```bash
# Directory Navigation:
Tab          → Auto-complete
Tab Tab      → Show all possibilities
Ctrl + Alt + T → Open new terminal
Alt + F4     → Close window
```

### Text Editors

#### Vi/Vim Keys

```bash
# Mode Switching:
i            → Insert mode
Esc          → Command mode
:w           → Save file
:q           → Quit
:wq          → Save and quit
:q!          → Quit without saving

# Navigation:
h,j,k,l      → Left, Down, Up, Right
w            → Next word
b            → Previous word
0            → Beginning of line
$            → End of line
```

#### Nano Editor

```bash
Ctrl + O     → Save file
Ctrl + X     → Exit nano
Ctrl + W     → Search
Ctrl + K     → Cut line
Ctrl + U     → Paste line
Ctrl + C     → Show cursor position
```

### System Operations

```bash
# Process Management:
Ctrl + Alt + Del → System monitor (GUI)
Alt + F2     → Run command dialog
Alt + Tab    → Switch between applications
Ctrl + Shift + T → New terminal tab
Ctrl + Shift + N → New terminal window
```

### Desktop Environment (GNOME/KDE)

```bash
# GNOME Shortcuts:
Super        → Activities overview
Super + L    → Lock screen
Super + A    → Show applications
Alt + F2     → Run command
Ctrl + Alt + T → Terminal

# KDE Shortcuts:
Alt + Space  → Application launcher
Ctrl + Alt + L → Lock screen
Ctrl + Alt + D → Show desktop
Meta + E     → File manager
```

### Emergency Keys

```bash
# System Recovery:
Ctrl + Alt + F1-F6 → Switch to TTY
Ctrl + Alt + F7    → Return to GUI
Alt + SysRq + R    → Switch keyboard from raw mode
Alt + SysRq + E    → Send SIGTERM to all processes
Alt + SysRq + I    → Send SIGKILL to all processes
Alt + SysRq + S    → Sync all filesystems
Alt + SysRq + U    → Remount filesystems read-only
Alt + SysRq + B    → Reboot system
```

---

## 🎯 Tổng Kết

### Key Takeaways

1. **Virtual Machines** cung cấp môi trường an toàn để học Linux
2. **VirtualBox** miễn phí và đủ mạnh cho học tập
3. **CentOS Stream** là lựa chọn tốt cho môi trường development
4. **Snapshots** quan trọng để backup và rollback
5. **Cloud installation** phù hợp cho production và testing

### Best Practices

- ✅ Luôn tạo snapshot trước khi thay đổi lớn
- ✅ Cấp phát tài nguyên hợp lý cho VM
- ✅ Enable virtualization trong BIOS
- ✅ Keep VM tools updated
- ✅ Regular backup quan trọng VMs

### Next Steps

- Practice với command line interface
- Learn basic system administration
- Explore different desktop environments
- Set up development environment
- Join Linux communities

---

## 📚 Resources

### Official Documentation

- [VirtualBox Manual](https://www.virtualbox.org/manual/)
- [VMware Documentation](https://docs.vmware.com/)
- [CentOS Documentation](https://docs.centos.org/)

### Video Tutorials

- [VirtualBox Installation Guide](https://youtube.com/virtualbox)
- [Linux Installation Walkthroughs](https://youtube.com/linux-install)

### Communities

- [r/virtualbox](https://reddit.com/r/virtualbox)
- [CentOS Forums](https://forums.centos.org/)
- [Ubuntu Community](https://community.ubuntu.com/)
