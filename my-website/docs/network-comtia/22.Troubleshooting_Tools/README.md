# 🌐 22.Troubleshooting_Tools: Bộ Công Cụ CLI Chẩn Đoán Sự Cố Mạng Thần Thánh - Chuyên Sâu CompTIA Network+ Cho DevOps

> 💡 **Bản chất 1 câu**: Hướng dẫn chi tiết bộ công cụ chẩn đoán sự cố mạng dòng lệnh CLI: `ip`, `ping`, `mtr`, `traceroute`, `dig`, `nslookup`, ...  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững lý thuyết chuyên sâu, sơ đồ kiến trúc, bộ lệnh CLI chẩn đoán thực tế và bộ câu hỏi phỏng vấn tuyển dụng.

---

## 1. 🧠 Hình Hình Dung Nhanh (Intuitive Mindset)

Hướng dẫn chi tiết bộ công cụ chẩn đoán sự cố mạng dòng lệnh CLI: `ip`, `ping`, `mtr`, `traceroute`, `dig`, `nslookup`, `arp`, `ss`, `netstat`, `lsof`, `tcpdump` và `nmap`.

```bash
# Bắt gói tin HTTPS live trên cạc eth0:
sudo tcpdump -i eth0 -nn 'tcp port 443' -w https.pcap
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 Bộ Lệnh CLI Troubleshooting Mạng Cần Thuộc (OBJ 5.5)
- **`ip addr` / `ip route` / `ip neighbor`**: Kiểm tra IP, Bảng định tuyến và Bảng ARP Cache.
- **`ping -c 3 IP` / `mtr --report IP`**: Đo độ trễ latency và tỷ lệ mất gói packet loss.
- **`traceroute -n IP`**: Kiểm tra các Hops đường đi của gói tin.
- **`nc -zvw3 IP Port`**: Test thấu cổng TCP từ xa xem có bị Firewall chặn.
- **`ss -tulpn` / `lsof -i :PORT`**: Kiểm tra các Port đang listening và tìm PID tiến trình.
- **`dig domain TXT +short`**: Tra cứu bản ghi DNS chi tiết.
- **`tcpdump -i eth0 -nn 'port 80'`**: Bắt và soi chi tiết nội dung gói tin mạng live.
- **`nmap -sV IP`**: Quét port mở và nhận diện phiên bản dịch vụ.


---

## 3. ⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)

| Công cụ / Khái niệm | Loại / Protocol | Ý nghĩa chi tiết | Ứng dụng thực tế |
| :--- | :--- | :--- | :--- |
| **`ip`** | `iproute2` | Quản lý IP, cạc mạng, routing table và ARP | `ip addr, ip route, ip neigh` |
| **`mtr`** | `ICMP Diagnostic` | Đo độ trễ latency và tỉ lệ rớt gói packet loss theo hop | `mtr --report 8.8.8.8` |
| **`nc`** | `L4 Test Tool` | Test thấu cổng TCP/UDP từ xa cực nhanh | `nc -zvw3 10.0.0.1 3306` |
| **`tcpdump`** | `Packet Sniffer` | Bắt và phân tích gói tin mạng theo thời gian thực | `tcpdump -i eth0 port 80` |
| **`nmap`** | `Network Scanner` | Quét port mở và nhận diện dịch vụ mạng | `nmap -sV 10.0.0.10` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps

### 🛠 Các lệnh thực hành gõ là ăn ngay:
```bash
ip addr && ip route && ping -c 3 8.8.8.8 && nc -zvw3 google.com 443
```

### 🚀 Kịch bản xử lý sự cố thực tế khi đi làm:
Troubleshoot lỗi Web App ngốn CPU không phản hồi: Dùng `ss -tulpn` xem port 8080 -> Dùng `tcpdump` soi gói tin xem có bị tấn công SYN Flood.

---

## 5. 🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & Network Thực Tế (Interview Q&A)

> **Q: Lệnh `mtr` mang lại ưu điểm vượt trội gì so với lệnh `ping` hay `traceroute` riêng lẻ?**  
> **A**: Lệnh `mtr` kết hợp cả `ping` và `traceroute`, liên tục gửi gói tin để đo lường tỷ lệ mất gói (Loss %) và độ trễ (Latency) chi tiết tại từng Hop trên đường truyền.

> **Q: Cờ `-nn` trong lệnh `tcpdump` có tác dụng gì quan trọng?**  
> **A**: Cờ `-nn` ngăn `tcpdump` phân giải địa chỉ IP sang Hostname và số Port sang Tên dịch vụ, giúp tiết kiệm tải CPU và hiển thị output tức thì.



---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] ip addr / ip route / ip neigh: Bộ lệnh IP
- [x] mtr --report: Đo latency & packet loss
- [x] nc -zvw3: Test thấu port từ xa
- [x] dig: Tra cứu DNS
- [x] tcpdump -i eth0 -nn: Bắt gói tin live
- [x] nmap -sV: Quét port mở

