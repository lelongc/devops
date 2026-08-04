# 🌐 Giáo Trình CompTIA Network+ (N10-009 / N10-008): Mạng Máy Tính Toàn Tập Cho Người Mới Bắt Đầu & DevOps

Bộ tài liệu được biên dịch và hệ thống hóa chuyên sâu 100% dựa trên toàn bộ 23 phần lộ trình chính thức của khóa học **CompTIA Network+ (N10-009 / N10-008)** trên Udemy (`rm.txt`), thiết kế dành cho **người mới chưa từng học mạng**, **DevOps Engineer**, **Cloud Engineer** và **System Administrator**.

Giáo trình hướng tới việc **hiểu bản chất gốc rễ (Under-the-Hood Mechanics)**, ứng dụng **sơ đồ Mermaid / ASCII**, hình ảnh minh họa thực tế, bảng lệnh CLI gõ ăn ngay và bộ câu hỏi phỏng vấn tuyển dụng Senior.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 23 Module Network+ tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất giao thức/công nghệ mạng trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Bản Chất Mạng (Under The Hood Architecture)**: Phân tích sơ đồ Mermaid, Header structure, State Machines và nguyên lý hoạt động bên dưới.
3. **⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)**: Bảng tham chiếu lệnh, file config, flags kèm giải thích chi tiết.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps**: Bộ lệnh gõ ăn ngay (`ip`, `ss`, `tcpdump`, `dig`, `nmap`, `mtr`) + Kịch bản xử lý sự cố thực tế khi đi làm.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & Network Thực Tế (Interview Q&A)**: Bộ câu hỏi đào sâu bản chất mạng kèm câu trả lời mẫu chuẩn tuyển dụng Senior.
6. **📝 Cheat Sheet & Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 23 Module CompTIA Network+ Chi Tiết

### 📘 PHẦN 1: NỀN TẢNG MẠNG & PHẦN CỨNG (MODULE 01 - 06)
- 📖 [**Module 01: Network Fundamentals**](./01.Network_Fundamentals/README.md) - Thiết bị phần cứng (Router, Switch L2/L3, Firewall, AP), Địa lý mạng (LAN, WAN, SAN) & Kiến trúc Datacenter Leaf-Spine.
- 📖 [**Module 02: OSI Model & Encapsulation**](./02.OSI_Model/README.md) - Phân tích chuyên sâu 7 tầng OSI, PDU tương ứng, Đóng gói Encapsulation / Decapsulation & Debug Bottom-Up (L1->L7).
- 📖 [**Module 03: Ports and Protocols**](./03.Ports_and_Protocols/README.md) - Bắt tay 3 bước TCP (SYN, SYN-ACK, ACK), UDP connectionless, ICMP, Bảng 30+ Ports tiêu chuẩn & Quét Port với Nmap / SS.
- 📖 [**Module 04: Media and Connectors**](./04.Media_and_Connectors/README.md) - Cáp đồng UTP/STP Cat5e/Cat6/Cat6a, chuẩn T568B, Cáp quang Single-Mode vs Multi-Mode & Mô-đun Transceivers SFP+/QSFP.
- 📖 [**Module 05: Distribution Systems**](./05.Distribution_Systems/README.md) - Tủ Rack, Patch Panel, đo kiểm cáp TDR/OTDR, nguồn UPS/PDU, điều hòa HVAC & Khí chữa cháy sạch FM-200.
- 📖 [**Module 06: Wireless Networks**](./06.Wireless_Networks/README.md) - Chuẩn Wi-Fi 802.11 (Wi-Fi 4/5/6/6E/7), băng tần (2.4/5/6GHz), bảo mật WPA3-SAE & 802.1X Enterprise RADIUS.

---

### 📙 PHẦN 2: CHUYỂN MẠCH, ĐỊA CHỈ IP & ĐỊNH TUYẾN (MODULE 07 - 11)
- 📖 [**Module 07: Ethernet Switching**](./07.Ethernet_Switching/README.md) - Ethernet Frame, MAC Table, VLANs 802.1Q Tagging (Access/Trunk), Chống loop STP/RSTP & MTU Jumbo Frames 9000 bytes.
- 📖 [**Module 08: IP Addressing and Subnetting**](./08.IP_Addressing_and_Subnetting/README.md) - IPv4 32-bit, IP Private RFC 1918, Bậc thầy Subnetting CIDR ($2^H-2$), IPv6 128-bit (Global Unicast, Link-Local fe80::, SLAAC) & Dual-Stack.
- 📖 [**Module 09: Routing and Protocols**](./09.Routing_and_Protocols/README.md) - Routing Table, Administrative Distance (AD), OSPF (Link-State AD 110), BGP (Path-Vector AD 20), PAT / Masquerade & VRRP.
- 📖 [**Module 10: Network Services**](./10.Network_Services/README.md) - DNS Resolution Hierarchy, các bản ghi DNS (A, AAAA, CNAME, MX, TXT, PTR), DHCP DORA, NTP time sync (Port 123) & QoS.
- 📖 [**Module 11: Wide Area Networks (WAN)**](./11.Wide_Area_Networks/README.md) - Công nghệ WAN: Fiber, DOCSIS, DSL, Starlink, Cellular 5G, MPLS (Layer 2.5 Label Switching) & SD-WAN.

---

### 📕 PHẦN 3: ĐÁM MÂY, BẢO MẬT & TỰ ĐỘNG HÓA (MODULE 12 - 18)
- 📖 [**Module 12: Cloud and Datacenter**](./12.Cloud_and_Datacenter/README.md) - Cloud IaaS/PaaS/SaaS, Software-Defined Networking (SDN Control vs Data Plane), VXLAN Overlay (UDP 4789, 16 triệu VNI) & SASE.
- 📖 [**Module 13: Network Security Fundamentals**](./13.Network_Security_Fundamentals/README.md) - Tam giác bảo mật CIA Triad, Quản lý Rủi ro (Risk Management), Device Hardening & Honeypots.
- 📖 [**Module 14: Network Attacks**](./14.Network_Attacks/README.md) - Tấn công ARP Spoofing (DAI), MAC Flooding (Port Security), DHCP Spoofing (DHCP Snooping), DoS/DDoS & MitM.
- 📖 [**Module 15: Logical Security and PKI**](./15.Logical_Security_and_PKI/README.md) - IAM, AAA (RADIUS/TACACS+), Mã hóa AES-256 vs RSA/ECC, IPsec VPN (AH/ESP) & Hạ tầng PKI X.509.
- 📖 [**Module 16: Network Segmentation and Firewalls**](./16.Network_Segmentation_and_Firewalls/README.md) - Firewalls (Stateless/Stateful/NGFW), Vùng đệm DMZ, Bastion Host / Jumpbox & Zero-Trust Architecture.
- 📖 [**Module 17: Network Monitoring and SIEM**](./17.Network_Monitoring_and_SIEM/README.md) - IDS (Out-of-Band) vs IPS (Inline), SNMP v3 (UDP 161/162), NetFlow Metadata & Hệ thống SIEM (Wazuh, Splunk).
- 📖 [**Module 18: Orchestration and Automation**](./18.Orchestration_and_Automation/README.md) - Network Automation, Infrastructure as Code (Ansible, Terraform), NETCONF (XML/SSH 830) & RESTCONF (JSON/HTTP 443).

---

### 📗 PHẦN 4: QUY TRÌNH & CHẨN ĐOÁN SỰ CỐ (MODULE 19 - 23)
- 📖 [**Module 19: Documentation and Processes**](./19.Documentation_and_Processes/README.md) - Physical vs Logical Diagram, NetBox IPAM, SLA 99.99% & Quy trình Change Management (CR, CAB, Rollback Plan).
- 📖 [**Module 20: Disaster Recovery**](./20.Disaster_Recovery/README.md) - High Availability (HA), Chỉ số RTO / RPO & Mô hình Redundant DR Sites (Hot Site vs Warm Site vs Cold Site).
- 📖 [**Module 21: Troubleshooting Methodology**](./21.Troubleshooting_Methodology/README.md) - Quy trình 7 bước giải quyết sự cố mạng chuẩn CompTIA (Identify -> Theory -> Test -> Fix -> Verify -> Document).
- 📖 [**Module 22: Troubleshooting Tools**](./22.Troubleshooting_Tools/README.md) - Bộ công cụ chẩn đoán CLI (`ip`, `ping`, `mtr`, `traceroute`, `dig`, `nc`, `ss`, `tcpdump`, `nmap`).
- 📖 [**Module 23: Troubleshooting Scenarios**](./23.Troubleshooting_Scenarios/README.md) - Kịch bản chẩn đoán sự cố thực tế (Trùng IP, Cạn dải DHCP, Sai lệch MTU Mismatch, Routing Loops).
