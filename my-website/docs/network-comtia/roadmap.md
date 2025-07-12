# 📡 Roadmap Học Networking & Security Toàn Diện (Zero → Hero)

## 🎯 Mục tiêu

- Nắm vững kiến thức nền tảng, thực hành cấu hình/vận hành các hệ thống mạng thực tế.
- Sẵn sàng phỏng vấn mọi vị trí DevOps/Network/Security Engineer.
- Thành thạo troubleshooting và bảo mật hệ thống trong môi trường on-premise & cloud.

---

## 1️⃣ Nền tảng Mạng Máy Tính

### 1.1. Mô hình OSI & TCP/IP

- Hiểu vai trò từng tầng (Physical → Application), quá trình encapsulation/decapsulation.
- So sánh OSI và TCP/IP, ví dụ thực tế khi truyền dữ liệu (gõ google.com trên trình duyệt).
- **Tài liệu:** [OSI Model Explained](https://www.cloudflare.com/learning/ddos/glossary/open-systems-interconnection-model-osi/)
- **Thực hành:** Vẽ sơ đồ mô hình OSI, phân tích lỗi qua các tầng khi troubleshooting.

### 1.2. Địa chỉ IP, Subnet, Routing

- IP Address: Cấu trúc IPv4/IPv6, phân biệt địa chỉ Private/Public, Loopback, Multicast.
- Subnetting: Tính toán subnet mask, CIDR, phân chia mạng doanh nghiệp.
- Routing: Static/Dynamic, routing table, gateway, default route.
- **Tài liệu:** [Subnet Calculator](https://www.subnet-calculator.com/)
- **Thực hành:** Tự chia subnet cho một mạng công ty giả lập.

### 1.3. Giao thức mạng cơ bản

- TCP vs UDP: Đặc điểm, handshake 3 bước, kiểm soát luồng, ứng dụng thực tế.
- ICMP, ARP, DHCP, DNS, NAT, HTTP/HTTPS, FTP/SFTP, SMTP, SNMP, Telnet/SSH.
- **Tài liệu:** [TCP vs UDP](https://www.imperva.com/learn/application-security/tcp-vs-udp/)
- **Thực hành:** Sử dụng Wireshark/tcpdump để bắt handshake TCP, truy vấn DNS, ARP.

### 1.4. Thiết bị mạng

- Router, Switch (L2/L3), Firewall, Load Balancer, Access Point, Proxy Server, IDS/IPS.
- Chức năng, vị trí trong kiến trúc mạng doanh nghiệp.
- **Tài liệu:** [Cisco Networking Basics](https://www.netacad.com/courses/networking/networking-basics)
- **Thực hành:** Sơ đồ hóa kiến trúc mạng văn phòng (2 phòng ban, VLAN, firewall).

---

## 2️⃣ Switching & Routing Chuyên Sâu

### 2.1. Switch & VLAN

- Khái niệm VLAN, cấu hình VLAN, trunking (802.1Q), native VLAN, port security.
- Spanning Tree Protocol (STP, RSTP, MSTP): Chống loop, root bridge, BPDU.
- EtherChannel, Link Aggregation.
- **Tài liệu:** [VLANs Explained](https://www.networklessons.com/cisco/ccna-routing-switching/vlan-configuration/)
- **Thực hành:** Cấu hình VLAN & trunking trên Packet Tracer/GNS3.

### 2.2. Routing Chi Tiết

- Static vs Dynamic Routing: Ưu nhược điểm, khi nào dùng.
- Routing Protocols: RIP, OSPF, EIGRP, BGP. Thuật toán, cấu hình, troubleshooting.
- Route Redistribution, Policy Based Routing.
- **Tài liệu:** [OSPF Fundamentals](https://www.cisco.com/c/en/us/support/docs/ip/open-shortest-path-first-ospf/7039-ospf.html)
- **Thực hành:** Cấu hình OSPF/BGP trong lab giả lập.

### 2.3. Wireless Networking

- Chuẩn Wi-Fi (802.11 a/b/g/n/ac/ax), SSID, Channel, Band, Security (WEP, WPA, WPA2, WPA3).
- Enterprise Wi-Fi: Radius, captive portal.
- **Thực hành:** Cấu hình Access Point, kiểm tra bảo mật WPA2-Enterprise.

---

## 3️⃣ Dịch vụ & Giao thức tầng ứng dụng

### 3.1. DNS

- Phân giải DNS (recursive/iterative), các loại server (root, TLD, authoritative).
- Các record: A, AAAA, MX, NS, CNAME, PTR, TXT.
- DNSSEC, DNS Poisoning.
- **Tài liệu:** [DNS Deep Dive](https://www.cloudflare.com/learning/dns/what-is-dns/)
- **Thực hành:** Thiết lập Bind DNS server, cấu hình các record, debug bằng nslookup/dig.

### 3.2. DHCP

- Quy trình DORA (Discover, Offer, Request, Acknowledge).
- Lease time, reservation, relay agent.
- **Thực hành:** Cấu hình DHCP server, kiểm tra cấp IP động/tĩnh.

### 3.3. NAT & Port Forwarding

- Static NAT, Dynamic NAT, PAT, ứng dụng thực tế (chuyển đổi địa chỉ, truy cập Internet).
- Port forwarding (Expose dịch vụ nội bộ ra ngoài).
- **Thực hành:** Thiết lập NAT trên router/firewall trong lab.

### 3.4. Các giao thức tầng ứng dụng khác

- HTTP/HTTPS: Quy trình TLS handshake, các phương thức, status code, header.
- SMTP/POP3/IMAP: Gửi/nhận email.
- SFTP vs FTP, Telnet vs SSH.
- **Thực hành:** Sử dụng curl, wget, telnet, ssh để kiểm tra dịch vụ.

---

## 4️⃣ Network Security Toàn Diện

### 4.1. Firewall & ACL

- Các loại firewall: Packet filtering, stateful, proxy, NGFW.
- Cấu hình ACL (Access Control List), rule security, zone concept.
- **Thực hành:** Cấu hình iptables (Linux), Windows Firewall, ACL trên Cisco.

### 4.2. VPN

- Các loại VPN: Remote Access, Site-to-Site, SSL, IPsec.
- Cấu hình VPN server (OpenVPN, WireGuard).
- **Thực hành:** Thiết lập VPN, kiểm tra traffic qua VPN tunnel.

### 4.3. IDS/IPS & WAF

- IDS vs IPS, signature-based vs anomaly-based.
- WAF (Web Application Firewall): Cấu hình rule, lọc truy cập web.
- **Thực hành:** Cài đặt Suricata/Snort, cấu hình WAF trên Nginx/AWS.

### 4.4. Authentication & Authorization

- MFA, SSO, RBAC, Security Token.
- Principle of Least Privilege (PoLP).
- **Thực hành:** Thiết lập MFA trên hệ thống, cấu hình RBAC trong Kubernetes.

### 4.5. Network Hardening

- Disable các dịch vụ/cổng không cần thiết, sử dụng giao thức quản trị an toàn (SSH, HTTPS).
- Network segmentation, DMZ, Zero Trust, honeypot.
- **Thực hành:** Phân đoạn mạng, triển khai DMZ cho web server.

### 4.6. Các tấn công phổ biến & phòng chống

- DDoS, MITM, ARP/DNS Spoofing, SSRF, SQL Injection, XSS, OWASP Top 10.
- Phòng chống: Rate limiting, monitoring, DNSSEC, HSTS, CSP.
- **Thực hành:** Mô phỏng tấn công và phòng thủ trong lab.

---

## 5️⃣ Networking in Cloud & Modern Infrastructure

### 5.1. Cloud Networking (AWS, Azure, GCP)

- VPC/VNet, Subnet, Route Table, Security Group, Network ACL, Load Balancer, Direct Connect, Peering.
- Cloud WAF, cloud IDS/IPS.
- **Thực hành:** Tạo VPC, cấu hình Security Group, thử nghiệm peering trên AWS/Azure.

### 5.2. Container & Kubernetes Networking

- Docker networking: Bridge, host, overlay, macvlan.
- Kubernetes: Pod-to-pod networking, Service, Ingress, Network Policy, CNI (Calico, Flannel, Weave).
- Service Mesh (Istio, Linkerd): mTLS, traffic control, observability.
- **Thực hành:** Cấu hình Network Policy trong Kubernetes, triển khai Istio demo.

### 5.3. SDN (Software Defined Networking)

- Khái niệm tách biệt control plane và data plane.
- OpenFlow, SDN controller (OpenDaylight).
- **Thực hành:** Demo SDN controller trong lab ảo hóa.

### 5.4. Network Automation & IaC

- Ansible, Terraform cho cấu hình thiết bị mạng.
- Python (Netmiko, Paramiko) cho automation.
- **Thực hành:** Viết playbook Ansible cấu hình switch/router, script Python kiểm tra trạng thái thiết bị.

---

## 6️⃣ Monitoring, Troubleshooting & Best Practice

### 6.1. Monitoring & Alert

- SNMP, syslog, SIEM (ELK, Splunk), Zabbix, Nagios, Prometheus, Grafana.
- **Thực hành:** Cài đặt Zabbix/Nagios, cấu hình giám sát thiết bị mạng/server.

### 6.2. Troubleshooting Network

- Quy trình: Top-down, bottom-up, divide & conquer.
- Các lệnh thiết yếu: ping, traceroute, nslookup/dig, ifconfig/ip, netstat/ss, tcpdump, nmap, telnet/nc, arp.
- Phân tích lưu lượng: Wireshark, tcpdump.
- **Thực hành:** Xử lý các case: mất mạng, chậm mạng, lỗi DNS/DHCP, port closed, loop switch...

### 6.3. High Availability & Scalability

- HA: VRRP/HSRP, clustering, failover, redundancy.
- Load Balancer: L4/L7, health check, sticky session.
- Scalability: Mô hình scale-out, scale-up.
- **Thực hành:** Triển khai HAProxy, thiết kế hệ thống HA cho web server.

### 6.4. Backup & Disaster Recovery

- Kế hoạch backup, snapshot, restore, DR site.
- **Thực hành:** Thiết lập backup định kỳ cho hệ thống mạng/server.

---

## 7️⃣ Chuẩn bị Phỏng vấn & Case Study

### 7.1. Câu hỏi phỏng vấn mẫu (theo cấp độ)

- Beginner: Khái niệm, định nghĩa, ứng dụng thực tế.
- Intermediate: Phân tích, so sánh, troubleshooting, thiết kế nhỏ.
- Advanced: Thiết kế hệ thống lớn, security, cloud/container networking, automation.

### 7.2. Scenario & System Design

- Xử lý sự cố mạng, thiết kế mạng doanh nghiệp, HA/DR, bảo mật hệ thống, phân tích log...

### 7.3. Kỹ năng trình bày, giải thích, vẽ sơ đồ, dẫn chứng thực tế.

---

## 8️⃣ Tài nguyên học tập & Chứng chỉ

- Sách: "Computer Networking: A Top-Down Approach", "Network Warrior", "TCP/IP Illustrated".
- Lab: Cisco Packet Tracer, GNS3, EVE-NG, VirtualBox/KVM.
- Online: [Cisco NetAcad](https://www.netacad.com/), [NetworkLessons](https://networklessons.com/), [Freecodecamp Network](https://www.freecodecamp.org/news/networking-for-web-developers/)
- Chứng chỉ: CompTIA Network+, Cisco CCNA, AWS/Azure/GCP Certified (Cloud Networking/Security).

---

## 🔥 Tips học hiệu quả

- Học lý thuyết luôn đi kèm thực hành lab.
- Ghi chú lại lỗi thực tế, case study, giải pháp đã áp dụng.
- Thực hiện các bài tập thiết kế, troubleshooting thật nhiều.
- Nắm vững các lệnh, công cụ chẩn đoán - đây là "vũ khí" khi đi phỏng vấn.

---

## 🚀 Lộ trình này là kim chỉ nam để chinh phục mọi kiến thức, kỹ năng & phỏng vấn Networking/Security!
