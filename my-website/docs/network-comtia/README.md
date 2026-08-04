# 🌐 Giáo Trình CompTIA Network+ (N10-009 / N10-008): Mạng Máy Tính Chuyên Sâu Cho DevOps

Bộ tài liệu được biên dịch và hệ thống hóa chuyên sâu dựa trên toàn bộ lộ trình khóa học **CompTIA Network+ (N10-009 / N10-008)** từ Udemy, tối ưu hóa dành riêng cho các kỹ sư **DevOps Engineer**, **Cloud / Infrastructure Engineer** và **System Administrator**.

Giáo trình tập trung vào bản chất hệ thống (Under-the-Hood Mechanics), sơ đồ kiến trúc Mermaid, bảng tra cứu lệnh CLI thực chiến, kịch bản xử lý sự cố Production và bộ câu hỏi phỏng vấn tuyển dụng thực tế.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 30 bài học Network+ tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất giao thức/công nghệ mạng trong 1 phút.
2. **📚 Lý Thuyết Chuyên Sâu & Bản Chất Mạng (Under The Hood Architecture)**: Phân tích kiến trúc Mermaid, Header structure, State Machines và nguyên lý hoạt động bên dưới.
3. **⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)**: Bảng tham chiếu lệnh, file config, flags kèm giải thích chi tiết.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps**: Bộ lệnh gõ ăn ngay (`ip`, `ss`, `tcpdump`, `dig`, `nmap`, `mtr`) + Kịch bản xử lý sự cố thực tế.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & Network Thực Tế (Interview Q&A)**: Bộ câu hỏi đào sâu bản chất mạng kèm câu trả lời mẫu chuẩn tuyển dụng Senior.
6. **📝 Cheat Sheet & Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 30 Bài Học CompTIA Network+

### 01. Network Fundamentals (Nền Tảng Mạng)
- [01.1: Thiết Bị Phần Cứng Mạng & Các Thành Phần Cốt Lõi (Router, Switch L2/L3, Firewall, AP)](./01.Network_Fundamentals/01.intro_and_components.md)
- [01.2: Địa Lý Mạng & Kiến Trúc Topology Datacenter (LAN, WAN, Leaf-Spine Datacenter)](./01.Network_Fundamentals/02.network_geography_and_topologies.md)

### 02. OSI Model & Encapsulation (Mô Hình OSI)
- [02.1: Phân Tích Chuyên Sâu Mô Hình 7 Tầng OSI & Phương Pháp Debug Bottom-Up](./02.OSI_Model/01.osi_7_layers_deep_dive.md)
- [02.2: Quá Trình Đóng Gói (Encapsulation) & Giải Gói (Decapsulation) Dữ Liệu](./02.OSI_Model/02.encapsulation_and_decapsulation.md)

### 03. Ports and Protocols (Cổng & Giao Thức Mạng)
- [03.1: Giao Thức L4 & L3 Cốt Lõi: TCP 3-Way Handshake, UDP & ICMP](./03.Ports_and_Protocols/01.tcp_udp_icmp_fundamentals.md)
- [03.2: Bảng Tra Cứu 30+ Network Ports & Protocols Bắt Buộc Thuộc (SSH 22, HTTP 80, K8s 6443...)](./03.Ports_and_Protocols/02.common_network_ports_reference.md)
- [03.3: Rà Soát & Quét Cổng Mạng Chuyên Sâu (Finding Open Ports with Nmap, SS & Lsof)](./03.Ports_and_Protocols/03.finding_open_ports_nmap.md)

### 04. Media and Connectors (Môi Trường Truyền Dẫn & Cáp)
- [04.1: Môi Trường Truyền Dẫn Cáp Đồng & Quy Chuẩn Bấm Cáp Mạng (Cat5e, Cat6, Cat6a, T568B)](./04.Media_and_Connectors/01.copper_media_and_wiring.md)
- [04.2: Truyền Dẫn Cáp Quang & Transceiver Modules (Single-Mode, Multi-Mode, SFP+, QSFP)](./04.Media_and_Connectors/02.fiber_optic_media_and_transceivers.md)

### 05. Wireless Networks (Mạng Không Dây Wi-Fi)
- [05.1: Mạng Không Dây Wi-Fi (802.11 Standards, Wi-Fi 6/7, WPA3-SAE & 802.1X Enterprise)](./05.Wireless_Networks/01.wireless_standards_and_security.md)

### 06. Ethernet Switching (Chuyển Mạch Ethernet & VLANs)
- [06.1: Chuyển Mạch Ethernet & Phân Chia Mạng Ảo VLAN 802.1Q (Access vs Trunk Port)](./06.Ethernet_Switching/01.ethernet_frames_and_vlans.md)
- [06.2: Chống Vòng Lặp STP (Spanning Tree Protocol) & Tối Ưu Băng Thông MTU Jumbo Frames](./06.Ethernet_Switching/02.stp_and_jumbo_frames.md)

### 07. IP Addressing & Subnetting (Địa Chỉ IP & Subnetting)
- [07.1: Địa Chỉ IPv4, Phân Lớp & Các Dải IP Private (RFC 1918, Loopback, APIPA)](./07.IP_Addressing_and_Subnetting/01.ipv4_addressing_and_classes.md)
- [07.2: Bậc Thầy Subnetting & Ký Hiệu CIDR (Tính Network ID, Broadcast ID, Usable IPs)](./07.IP_Addressing_and_Subnetting/02.subnetting_and_cidr_mastery.md)
- [07.3: Thế Hệ Địa Chỉ IPv6 & Cơ Chế Tương Thích Dual-Stack (Global Unicast, Link-Local, SLAAC)](./07.IP_Addressing_and_Subnetting/03.ipv6_addressing_and_coexistence.md)

### 08. Routing and Protocols (Định Tuyến Router)
- [08.1: Định Tuyến Router, Routing Table, OSPF, BGP & Cơ Chế NAT / PAT / Masquerade](./08.Routing_and_Protocols/01.routing_tables_and_protocols.md)

### 09. Network Services (Các Dịch Vụ Mạng Core)
- [09.1: Các Dịch Vụ Mạng Cốt Lõi: DNS Resolution, DHCP DORA Handshake, NTP & QoS](./09.Network_Services/01.dns_dhcp_and_network_services.md)

### 10. Wide Area Networks (Mạng Diện Rộng WAN)
- [10.1: Các Công Nghệ Mạng Diện Rộng WAN (MPLS Layer 2.5, Cellular 5G, SD-WAN)](./10.Wide_Area_Networks/01.wan_technologies.md)

### 11. Cloud and Datacenter (Điện Toán Đám Mây & Datacenter)
- [11.1: Kiến Trúc Đám Mây Cloud (IaaS/PaaS/SaaS), SDN Control Plane, VXLAN Overlay & SASE](./11.Cloud_and_Datacenter/01.cloud_architecture_sdn_vxlan.md)

### 12. Network Security Fundamentals (Bảo Mật Mạng Cơ Bản)
- [12.1: Bảo Mật Mạng Căn Bản, Tam Giác CIA & Thiết Lập Device Hardening Máy Chủ](./12.Network_Security_Fundamentals/01.security_fundamentals_hardening.md)

### 13. Network Attacks (Các Hình Thức Tấn Công Mạng)
- [13.1: Các Loại Tấn Công Mạng & Biện Pháp Phòng Thủ (ARP Spoofing, MAC Flooding, DDoS)](./13.Network_Attacks/01.network_attacks_and_defenses.md)

### 14. Logical Security and PKI (Bảo Mật Logic & Chữ Ký Số)
- [14.1: Bảo Mật Logic, IAM, AAA (RADIUS/TACACS+), Mã Hóa AES/RSA, IPsec & PKI X.509](./14.Logical_Security_and_PKI/01.iam_encryption_pki.md)

### 15. Network Segmentation & Firewalls (Tường Lửa & Phân Vùng)
- [15.1: Tường Lửa Firewalls (Stateful/NGFW), Phân Vùng DMZ, Bastion Host & Kiến Trúc Zero-Trust](./15.Network_Segmentation_and_Firewalls/01.firewalls_segmentation_vpn.md)

### 16. Network Monitoring & SIEM (Giám Sát Mạng & Log)
- [16.1: Giám Sát Mạng, Phân Biệt IDS vs IPS, SNMP v3, NetFlow Metadata & Hệ Thống SIEM](./16.Network_Monitoring_and_SIEM/01.monitoring_tools_snmp_siem.md)

### 17. Orchestration & Automation (Tự Động Hóa Mạng)
- [17.1: Tự Động Hóa Mạng, Infrastructure as Code (Ansible, Terraform), NETCONF & RESTCONF](./17.Orchestration_and_Automation/01.network_automation_iac_apis.md)

### 18. Documentation & Processes (Tài Liệu & Quy Trình)
- [18.1: Tài Liệu Mạng, Quản Lý Địa Chỉ IP (NetBox IPAM) & Quy Trình Change Management (CAB)](./18.Documentation_and_Processes/01.documentation_ipam_change_management.md)

### 19. Disaster Recovery (Khôi Phục Sau Thảm Họa)
- [19.1: Khôi Phục Sau Thảm Họa (Disaster Recovery), Chỉ Số RTO / RPO & Mô Hình Hot/Cold Site](./19.Disaster_Recovery/01.disaster_recovery_ha.md)

### 20. Troubleshooting Methodology & Tools (Phương Pháp & Công Cụ Sửa Lỗi)
- [20.1: Quy Trình 7 Bước Giải Quyết Sự Cố Mạng Tiêu Chuẩn CompTIA](./20.Troubleshooting_Methodology_and_Tools/01.comptia_troubleshooting_methodology.md)
- [20.2: Bộ Công Cụ CLI Chẩn Đoán Sự Cố Mạng (tcpdump, nmap, ip, dig, ss, mtr)](./20.Troubleshooting_Methodology_and_Tools/02.network_troubleshooting_cli_tools.md)
- [20.3: Kịch Bản Chẩn Đoán Sự Cố Mạng Thực Tế (Duplicate IP, DHCP Exhaustion, MTU Mismatch)](./20.Troubleshooting_Methodology_and_Tools/03.physical_wireless_service_troubleshooting.md)
