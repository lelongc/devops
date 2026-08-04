# 🐧 Giáo Trình Linux Cho DevOps: Bản Chất Hệ Thống & Thực Chiến (Dễ Nhớ & Phỏng Vấn)

Bộ tài liệu Linux được xây dựng theo tiêu chuẩn **Chuyên sâu Bản chất Hệ thống (Deep Mechanics under the Hood)** kết hợp với **Phương pháp Ghi nhớ Nhanh** dành riêng cho người mới bắt đầu và các kỹ sư **DevOps Engineer**.

Tất cả **42 bài học** giải thích tường tận nguyên lý hoạt động của Kernel, Tiến trình, Hệ thống file, Bộ nhớ RAM, Mạng TCP/IP, Security và Systemd đi kèm bảng lệnh thực chiến và bộ câu hỏi phỏng vấn tuyển dụng thực tế.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong bộ tài liệu tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp nắm bắt bức tranh tổng quan trong 1 phút.
2. **📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Mechanics)**: Giải thích chi tiết Kernel, Data Structures (Inode, PCB, File Descriptor, Socket Table, Systemd Targets, LVM PE) và nguyên lý hoạt động bên dưới.
3. **⚡ Bảng Tra Cứu Câu Lệnh Thực Hành (CLI Command Reference)**: Liệt kê các lệnh, cờ (flags) bắt buộc phải thuộc kèm giải thích chi tiết.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps**: Các lệnh gõ là ăn ngay + Kịch bản xử lý sự cố thực tế (Troubleshooting).
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Thực Tế (Interview Q&A)**: Bộ câu hỏi đào sâu bản chất kèm câu trả lời chuẩn chuyên gia.
6. **📝 Cheat Sheet & Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt trong 30 giây.

---

## 📌 Danh Sách 42 Bài Học Theo Chủ Đề LPIC-1

### 📘 PHẦN 1: KIẾN TRÚC HỆ THỐNG & DÒNG LỆNH CƠ BẢN (Topics 101 - 103)
- [101.1: Quản Lý Phần Cứng & Thư Mục Ảo Linux (/proc, /sys, /dev, Kernel Modules)](./topic-101-system-architecture/101.1-determine-and-configure-hardware-settings.md)
- [101.2: Tiến Trình Khởi Động Linux & Diagnostic Logs (BIOS/UEFI, GRUB2, Kernel, dmesg)](./topic-101-system-architecture/101.2-boot-the-system.md)
- [101.3: Quản Lý Runlevels, Boot Targets & Shutdown (multi-user.target, systemctl)](./topic-101-system-architecture/101.3-change-runlevels-boot-targets-and-shutdown.md)
- [102.1: Phân Đĩa Ổ Đĩa Cứng & Quản Lý LVM (PV -> VG -> LV, lvextend)](./topic-102-installation-and-package-management/102.1-design-hard-disk-layout.md)
- [102.2: Cấu Hình GRUB2 Bootloader & Khôi Phục Root Pass (update-grub, init=/bin/bash)](./topic-102-installation-and-package-management/102.2-install-a-boot-manager.md)
- [102.3: Quản Lý Thư Viện Dùng Chung Shared Libraries (.so, ldd, ldconfig)](./topic-102-installation-and-package-management/102.3-manage-shared-libraries.md)
- [102.4: Trình Quản Lý Gói Debian (dpkg & APT, sources.list)](./topic-102-installation-and-package-management/102.4-use-debian-package-management.md)
- [102.5: Trình Quản Lý Gói Red Hat (RPM & DNF/YUM, yum.repos.d)](./topic-102-installation-and-package-management/102.5-use-rpm-and-yum-package-management.md)
- [102.6: Linux Trong Máy Ảo & Cloud Instance (Hypervisor, cloud-init)](./topic-102-installation-and-package-management/102.6-linux-as-a-virtualization-guest.md)
- [103.1: Làm Việc Dòng Lệnh Bash & Biến Môi Trường (export, PATH, quotes)](./topic-103-gnu-and-unix-commands/103.1-work-on-the-command-line.md)
- [103.2: Xử Lý Luồng Văn Bản Bằng Bộ Lọc (head, tail -f, cut, sort, uniq)](./topic-103-gnu-and-unix-commands/103.2-process-text-streams-using-filters.md)
- [103.3: Quản Lý File & Nén Dữ Liệu (cp -rp, tar -czvf, rm -rf)](./topic-103-gnu-and-unix-commands/103.3-perform-basic-file-management.md)
- [103.4: Streams, Pipes & Redirects (STDIN 0, STDOUT 1, STDERR 2, tee)](./topic-103-gnu-and-unix-commands/103.4-use-streams-pipes-and-redirects.md)
- [103.5: Quản Lý Tiến Trình (ps aux, top/htop, kill -9 vs -15, tmux)](./topic-103-gnu-and-unix-commands/103.5-create-monitor-and-kill-processes.md)
- [103.6: Điều Chỉnh Độ Ưu Tiên Tiến Trình (Niceness -20 đến 19, nice, renice)](./topic-103-gnu-and-unix-commands/103.6-modify-process-execution-priorities.md)
- [103.7: Biểu Thức Chính Quy & Thay Thế Chuỗi (grep -E, sed -i)](./topic-103-gnu-and-unix-commands/103.7-search-text-files-using-regular-expressions.md)
- [103.8: Chỉnh Sửa File Bằng Vi / Vim Editor (i, Esc, :wq, :q!, dd, yy)](./topic-103-gnu-and-unix-commands/103.8-basic-file-editing.md)

---

### 📙 PHẦN 2: HỆ THỐNG FILE, LẬP TRÌNH BASH & BẢO MẬT (Topics 104 - 110)
- [104.1: Phân Đĩa & Định Dạng Filesystem (MBR vs GPT, fdisk, mkfs.ext4/xfs)](./topic-104-devices-filesystems-fhs/104.1-create-partitions-and-filesystems.md)
- [104.2: Kiểm Tra Dung Lượng & Sửa Lỗi Filesystem (df -h, df -i, du -sh, fsck)](./topic-104-devices-filesystems-fhs/104.2-maintain-the-integrity-of-filesystems.md)
- [104.3: Gắn Mount Ổ Đĩa & File /etc/fstab (mount, umount, blkid, UUID)](./topic-104-devices-filesystems-fhs/104.3-control-mounting-and-unmounting-filesystems.md)
- [104.5: Quản Lý Quyền File & Owner (chmod 755, chown, umask, SUID/SGID)](./topic-104-devices-filesystems-fhs/104.5-manage-file-permissions-and-ownership.md)
- [104.6: Quản Lý Hard Link & Symbolic Link (ln & ln -s, Inodes)](./topic-104-devices-filesystems-fhs/104.6-create-and-change-hard-and-symbolic-links.md)
- [104.7: Chuẩn Phân Cấp FHS & Tìm Kiếm File (FHS, find, locate, which)](./topic-104-devices-filesystems-fhs/104.7-find-system-files-and-place-files-in-correct-location.md)
- [105.1: Tùy Biến Môi Trường Shell & Alias (~/.bashrc, alias, source)](./topic-105-shells-and-shell-scripting/105.1-customize-and-use-the-shell-environment.md)
- [105.2: Lập Trình Bash Script Tự Động Hóa (Shebang, $?, if/for, set -e)](./topic-105-shells-and-shell-scripting/105.2-customize-or-write-simple-scripts.md)
- [106.1: Giao Diện Đồ Họa X11 & SSH Forwarding (X11 Protocol, ssh -X)](./topic-106-user-interfaces-and-desktops/106.1-install-and-configure-x11.md)
- [106.2: Môi Trường Desktop & Remote Desktop (GNOME, RDP / xrdp 3389)](./topic-106-user-interfaces-and-desktops/106.2-graphical-desktops.md)
- [106.3: Hỗ Trợ Truy Cập (Orca Screen Reader)](./topic-106-user-interfaces-and-desktops/106.3-accessibility.md)
- [107.1: Quản Lý Tài Khoản User & Group (/etc/passwd, /etc/shadow, useradd, usermod -aG)](./topic-107-administrative-tasks/107.1-manage-user-and-group-accounts.md)
- [107.2: Tự Động Hóa Tác Vụ Bằng Lịch Cron & At Job (Crontab 5 trường, at)](./topic-107-administrative-tasks/107.2-automate-system-administration-tasks.md)
- [107.3: Quản Lý Múi Giờ & Ngôn Ngữ (timedatectl set-timezone, locale)](./topic-107-administrative-tasks/107.3-localisation-and-internationalisation.md)
- [108.1: Đồng Bộ Thời Gian Hệ Thống (NTP, chrony, hwclock --systohc)](./topic-108-essential-system-services/108.1-maintain-system-time.md)
- [108.2: Quản Lý Log Hệ Thống (journalctl -u -f, rsyslog, logrotate)](./topic-108-essential-system-services/108.2-system-logging.md)
- [108.3: Cơ Bản Về Mail Transfer Agent (MTA Postfix, mailq, /etc/aliases)](./topic-108-essential-system-services/108.3-mail-transfer-agent-basics.md)
- [108.4: Quản Lý Hệ Thống In Ấn (CUPS Port 631, lpstat)](./topic-108-essential-system-services/108.4-manage-printers-and-printing.md)
- [109.1: Căn Bản Mạng Máy Tính, IP & Ports Cho DevOps (IPv4, CIDR /24, Ports)](./topic-109-networking-fundamentals/109.1-fundamentals-of-internet-protocols.md)
- [109.2: Cấu Hình Mạng Cố Định (Netplan YAML, NetworkManager nmcli)](./topic-109-networking-fundamentals/109.2-persistent-network-configuration.md)
- [109.3: Chẩn Đoán & Debug Sự Cố Mạng (ping, ss -tulpn, nc -zvw3, tcpdump)](./topic-109-networking-fundamentals/109.3-basic-network-troubleshooting.md)
- [109.4: Cấu Hình Phân Giải Tên Miền DNS Khách (/etc/resolv.conf, /etc/hosts, dig)](./topic-109-networking-fundamentals/109.4-configure-client-side-dns.md)
- [110.1: Quản Trị Bảo Mật Hệ Thống (SUID Audit, ulimit -n 65535, chage)](./topic-110-security/110.1-perform-security-administration-tasks.md)
- [110.2: Hardening Bảo Mật SSH & Firewall (/etc/ssh/sshd_config, ufw)](./topic-110-security/110.2-setup-host-security.md)
- [110.3: Mã Hóa SSH Keypair & SSH Tunnel Port Forwarding (ssh-keygen, authorized_keys, ssh -L)](./topic-110-security/110.3-securing-data-with-encryption.md)
