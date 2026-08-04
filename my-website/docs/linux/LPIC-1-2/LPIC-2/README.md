# 🐧 Giáo Trình LPIC-2 Linux Engineer: Bản Chất Hệ Thống & Quản Trị Nâng Cao (Exam 201-450 & Exam 202-450)

Bộ tài liệu LPIC-2 (Linux Professional Institute Certification Level 2) được biên dịch và hệ thống hóa chuyên sâu dựa trên sách chuẩn **LPIC-2 Linux Professional Institute Certification Study Guide (2nd Edition)**.

Giáo trình hướng tới các kỹ sư **Senior DevOps Engineer**, **Linux Systems Administrator** và **Site Reliability Engineer (SRE)** cần thành thạo quản trị hệ thống phức tạp, hạ tầng mạng doanh nghiệp, dịch vụ web/mail/DNS/file server, bảo mật nâng cao và tối ưu hiệu năng Kernel.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 35 bài học LPIC-2 tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất dịch vụ trong 1 phút.
2. **📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Mechanics)**: Phân tích kiến trúc Kernel, Protocols, Data Structures, State Machines và nguyên lý hoạt động bên dưới.
3. **⚡ Bảng Tra Cứu Câu Lệnh & Cấu Hình Thực Hành (CLI Reference)**: Bảng tham chiếu lệnh, file config, cờ (flags) kèm giải thích chi tiết.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps**: File config chuẩn Production + Kịch bản xử lý sự cố thực tế (Troubleshooting).
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & SysAdmin Thực Tế (Interview Q&A)**: Bộ câu hỏi đào sâu bản chất hệ thống kèm câu trả lời mẫu chuẩn tuyển dụng Senior.
6. **📝 Cheat Sheet & Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 35 Bài Học LPIC-2

### 📘 PHẦN 1: LPIC-2 EXAM 201-450 (Quản Trị Hệ Thống, Kernel & Storage)

#### Topic 200: Capacity Planning (Quy Hoạch Dung Lượng)
- [200.1: Đo Lường & Giám Sát Tài Nguyên Hệ Thống (sar, vmstat, iostat)](./exam-201/topic-200-capacity-planning/200.1-measure-and-predict-resource-usage.md)
- [200.2: Dự Báo Nhu Cầu Tài Nguyên & Capacity Planning (Trend Analysis, Scaling)](./exam-201/topic-200-capacity-planning/200.2-predict-future-resource-needs.md)

#### Topic 201: Linux Kernel (Quản Trị Kernel)
- [201.1: Thành Phần Kernel & Quản Lý Modules Chuyên Sâu (lsmod, modprobe, sysctl)](./exam-201/topic-201-linux-kernel/201.1-kernel-components-and-modules.md)
- [201.2: Biên Dịch Kernel Linux Từ Source Code (make menuconfig, make -j, install)](./exam-201/topic-201-linux-kernel/201.2-compiling-a-linux-kernel.md)
- [201.3: Quản Lý Kernel Runtime & Debug Lỗi Kernel Panic (SysRq REISUB, udevadm, kdump)](./exam-201/topic-201-linux-kernel/201.3-kernel-runtime-management-and-troubleshooting.md)

#### Topic 202: System Startup (Tiến Trình Boot & Cứu Hộ)
- [202.1: Tiến Trình Khởi Động SysVinit & Systemd Chuyên Sâu (cgroups, systemd-analyze)](./exam-201/topic-202-system-startup/202.1-sysvinit-systemd-boot-process.md)
- [202.2: Cứu Hộ Hệ Thống & Sửa Lỗi Boot (rescue.target, chroot, remount rw)](./exam-201/topic-202-system-startup/202.2-system-recovery-and-troubleshooting.md)

#### Topic 203: Filesystem and Devices (Hệ Thống Tệp & Thiết Bị)
- [203.1: Quản Lý Phân Đĩa & Filesystems Cao Cấp (Ext4, XFS, Btrfs Snapshots)](./exam-201/topic-203-filesystem-and-devices/203.1-operating-the-linux-filesystem.md)
- [203.2: Bảo Trì & Sửa Lỗi Filesystem Chuyên Sâu (tune2fs -m, xfs_repair, btrfs scrub)](./exam-201/topic-203-filesystem-and-devices/203.2-maintaining-a-linux-filesystem.md)
- [203.3: Tùy Chọn Mount Nâng Cao & Tự Động Mount AutoFS (noatime, nosuid, AutoFS)](./exam-201/topic-203-filesystem-and-devices/203.3-creating-and-configuring-filesystem-options.md)

#### Topic 204: Advanced Storage Device Administration (Lưu Trữ Nâng Cao)
- [204.1: Quản Lý Software RAID Chuyên Sâu (mdadm, RAID 0/1/5/6/10, Hot-Spare)](./exam-201/topic-204-advanced-storage-device-administration/204.1-configuring-software-raid.md)
- [204.2: Tinh Chỉnh Tham Số Ổ Đĩa & S.M.A.R.T (smartctl, nvme-cli, hdparm)](./exam-201/topic-204-advanced-storage-device-administration/204.2-adjusting-storage-device-parameters.md)
- [204.3: LVM2 Quản Lý Lưu Trữ Nâng Cao & Snapshots (CoW Snapshots, Thin Provisioning, pvmove)](./exam-201/topic-204-advanced-storage-device-administration/204.3-logical-volume-manager-lvm2.md)

#### Topic 205: Network Configuration (Cấu Hình Mạng Nâng Cao)
- [205.1: Mạng Máy Tính Nâng Cao & Cấu Hình Giao Diện (iproute2, ip addr, ip route, ARP)](./exam-201/topic-205-network-configuration/205.1-basic-networking-and-troubleshooting.md)
- [205.2: Cấu Hình Mạng Nâng Cao: Network Bonding & VLANs 802.1q (LACP Mode 4, VLAN Tagging)](./exam-201/topic-205-network-configuration/205.2-advanced-network-configuration-and-bonding.md)

#### Topic 206: System Maintenance (Bảo Trì Hệ Thống)
- [206.1: Biên Dịch Phần Mềm Từ Source Code (configure, make, checkinstall)](./exam-201/topic-206-system-maintenance/206.1-installing-and-compiling-programs-from-source.md)
- [206.2: Chiến Lược Backup & Phục Hồi Dữ Liệu (Full/Incremental/Differential, rsync -avz)](./exam-201/topic-206-system-maintenance/206.2-backup-operations-and-strategies.md)
- [206.3: Thông Báo Hệ Thống Cho Người Dùng (wall, /etc/issue, /etc/motd)](./exam-201/topic-206-system-maintenance/206.3-system-notifications.md)

---

### 📙 PHẦN 2: LPIC-2 EXAM 202-450 (Máy Chủ Dịch Vụ, Mạng & Bảo Mật)

#### Topic 207: Domain Name Server (Dịch Vụ DNS BIND 9)
- [207.1: Cấu Hình Máy Chủ Tên Miền BIND 9 Cơ Bản (named.conf, SOA, NS, A, MX, PTR)](./exam-202/topic-207-domain-name-server/207.1-bind9-basic-configuration.md)
- [207.2: Quản Lý BIND 9 Zone Replication & Bảo Mật TSIG / Chroot (AXFR/IXFR, TSIG keys, Chroot Jail)](./exam-202/topic-207-domain-name-server/207.2-bind9-zone-management-and-security.md)
- [207.3: Cấu Hình DNSSEC & Advanced DNS Views (ZSK/KSK Keys, RRSIG, Split-Horizon DNS)](./exam-202/topic-207-domain-name-server/207.3-dnssec-and-advanced-dns.md)

#### Topic 208: Web Services (Dịch Vụ Web & Proxy)
- [208.1: Quản Trị Máy Chủ Web Apache HTTP Server (VirtualHost, .htaccess, mod_ssl, mod_rewrite)](./exam-202/topic-208-web-services/208.1-apache-http-server-configuration.md)
- [208.2: Quản Trị Nginx Web Server & Reverse Proxy / PHP-FPM (proxy_pass, upstream, PHP-FPM socket)](./exam-202/topic-208-web-services/208.2-nginx-web-server-and-reverse-proxy.md)
- [208.3: Quản Trị Máy Chủ Proxy & Caching Squid (squid.conf, ACLs, Transparent Proxy)](./exam-202/topic-208-web-services/208.3-squid-proxy-and-caching.md)

#### Topic 209: File Sharing (Dịch Vụ Chia Sẻ File)
- [209.1: Quản Trị Máy Chủ Chia Sẻ File Samba (smb.conf, smbpasswd, CIFS mount)](./exam-202/topic-209-file-sharing/209.1-samba-file-server-configuration.md)
- [209.2: Quản Trị Máy Chủ Chia Sẻ File Nội Bộ NFS (NFSv4, /etc/exports, exportfs, root_squash)](./exam-202/topic-209-file-sharing/209.2-nfs-file-server-configuration.md)

#### Topic 210: Client Management (Quản Lý Client & Xác Thực)
- [210.1: Cấu Hình Máy Chủ Cấp Phát IP Tự Động DHCP Server (DORA process, dhcpd.conf, dhcrelay)](./exam-202/topic-210-client-management/210.1-dhcp-server-configuration.md)
- [210.2: Kiến Trúc Xác Thực Khung PAM (PAM Groups, Control Flags, pam_faillock, pam_wheel)](./exam-202/topic-210-client-management/210.2-pam-authentication-modules.md)
- [210.3: Quản Trị Dịch Vụ Thư Mục Tập Trung OpenLDAP (DIT tree, LDIF, ldapsearch, slapcat)](./exam-202/topic-210-client-management/210.3-openldap-directory-services.md)

#### Topic 211: E-Mail Services (Dịch Vụ Email Postfix & Dovecot)
- [211.1: Quản Trị Máy Chủ Thư Postfix MTA Chuyên Sâu (main.cf, postmap, virtual domains, mailq)](./exam-202/topic-211-email-services/211.1-postfix-mta-configuration.md)
- [211.2: Quản Trị Máy Chủ Nhận Thư Dovecot (IMAP/POP3, Maildir format, SSL/TLS, doveadm)](./exam-202/topic-211-email-services/211.2-dovecot-imap-pop3-server.md)
- [211.3: Bảo Mật Email: Chống SPAM & Xác Thực SPF, DKIM, DMARC (OpenDKIM, SpamAssassin, sa-learn)](./exam-202/topic-211-email-services/211.3-email-security-spamassassin-dkim-spf.md)

#### Topic 212: System Security (Tường Lửa, VPN & Audit Bảo Mật)
- [212.1: Quản Trị Tường Lửa Netfilter (IPTables tables/chains, DNAT/SNAT, nftables, UFW)](./exam-202/topic-212-system-security/212.1-firewalling-iptables-nftables-ufw.md)
- [212.2: Triển Khai Mạng Diện Rộng Ảo VPN (WireGuard, OpenVPN, IPsec strongSwan)](./exam-202/topic-212-system-security/212.2-virtual-private-networks-openvpn-wireguard.md)
- [212.3: Audit Bảo Mật & Hệ Thống Phát Hiện Xâm Nhập (Nmap, RKHunter, Fail2ban)](./exam-202/topic-212-system-security/212.3-security-audit-and-intrusion-detection.md)
