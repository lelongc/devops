# 🌐 23.Troubleshooting_Scenarios: Kịch Bản Chẩn Đoán Sự Cố Mạng Thực Tế Cho DevOps - Chuyên Sâu CompTIA Network+ Cho DevOps

> 💡 **Bản chất 1 câu**: Chẩn đoán và khắc phục sự cố mạng thực tế: Trùng địa chỉ IP (Duplicate IP), Cạn dải IP DHCP (DHCP Pool Exhaustion), Sai ...  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững lý thuyết chuyên sâu, sơ đồ kiến trúc, bộ lệnh CLI chẩn đoán thực tế và bộ câu hỏi phỏng vấn tuyển dụng.

---

## 1. 🧠 Hình Hình Dung Nhanh (Intuitive Mindset)

Chẩn đoán và khắc phục sự cố mạng thực tế: Trùng địa chỉ IP (Duplicate IP), Cạn dải IP DHCP (DHCP Pool Exhaustion), Sai lệch MTU (MTU Mismatch / PMTUD Failure), Vòng lập Routing (Routing Loops) và Broadcast Storms.

```mermaid
graph TD
    Issue[Packet treoo khi truyền file lớn] --> Cause[MTU Mismatch / DF Flag Set] --> Fix[Hạ MTU xuống 1420 / Clamping TCPMSS]
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 Chẩn Đoán Các Sự Cố Mạng Thực Tế (OBJ 5.2, 5.3 & 5.4)
1. **Trùng Địa Chỉ IP (Duplicate IP Address)**: 2 máy tính cùng dùng 1 IP làm chập chờn rớt mạng -> Check `ip neighbor` và đổi IP / giải phóng DHCP lease.
2. **Cạn Dải Địa Chỉ IP DHCP (DHCP Pool Exhaustion)**: Máy tính mới nhận IP APIPA `169.254.x.x` -> Mở rộng dải IP range hoặc giảm DHCP Lease Time.
3. **Sai Khớp Kích Thước MTU (MTU Mismatch)**: Ping gói tin nhỏ thông bình thường, nhưng khi tải file lớn/HTTPS thì bị treo cứng đơ! -> Hạ MTU xuống `1420` bytes: `ip link set dev eth0 mtu 1420` hoặc bật `TCP MSS Clamping`.
4. **Vòng Lập Routing (Routing Loop)**: Gói tin chạy lặp vòng tròn giữa 2 Router cho tới khi hết TTL -> Kiểm tra bằng `traceroute -n`.


---


### 2.4 Cơ Chế Hoạt Động Bên Dưới Kernel & Kiến Trúc Hệ Thống Chi Tiết (Deep Under The Hood Architecture)
- **Tầng Giao Tiếp Mạng & Bắt Gói Tin**: Mọi gói tin đi qua Network Interface Card (NIC) đều trải qua quá trình xử lý Ring Buffer, ngắt phần cứng (Hardware Interrupts), Ring Buffer DMA và chồng giao thức Socket Buffers (`sk_buff`) trong Linux Kernel.
- **Tối Ưu Hóa & Cấu Trúc Dữ Liệu**: Hệ thống duy trì các bảng băm dữ liệu (Routing Table, ARP Cache Table, Connection Tracking Table `conntrack`, Socket Inode Tables) giúp chuyển tiếp gói tin ở tốc độ dây (Line-rate processing).
- **Phân Lập An Ninh & Phân Vùng**: Sử dụng cơ chế Linux Network Namespaces (`ip netns`), iptables/nftables hooks và mã hóa phần cứng để cách ly lưu lượng mạng tuyệt đối.

---

## 3. ⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)

| Công cụ / Khái niệm | Loại / Protocol | Ý nghĩa chi tiết | Ứng dụng thực tế |
| :--- | :--- | :--- | :--- |
| **`Duplicate IP`** | `L3 Error` | 2 thiết bị trùng IP làm rớt kết nối chập chờn | `Kiểm tra ARP table và DHCP pool` |
| **`DHCP Exhaustion`** | `L7 Error` | Hết IP khả dụng trong pool làm client nhận APIPA 169.254 | `Mở rộng dải IP range / Giảm lease time` |
| **`MTU Mismatch`** | `L3 Error` | Sai lệch MTU làm đứt kết nối khi truyền file lớn | `Chỉnh MTU 1420 hoặc bật TCP MSS Clamping` |
| **`Routing Loop`** | `L3 Error` | Gói tin chạy lặp vòng tròn giữa 2 Router | `Kiểm tra traceroute và sửa Routing Table` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps

### 🛠 Các lệnh thực hành gõ là ăn ngay:
```bash
ping -M do -s 1472 8.8.8.8
sudo iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
```

### 🚀 Kịch bản xử lý sự cố thực tế khi đi làm:
Troubleshoot lỗi SSH/Web bị treo khi kết nối qua IPSec VPN Tunnel: Hạ MTU trên VPN interface xuống 1412 bytes và ép TCP MSS Clamping.

---


### 4.2 Chi Tiết Các Lỗi Thường Gặp & Kịch Bản Khắc Phục Lỗi (Troubleshooting Deep-Dive)
1. **Sự cố 1: Lỗi Mất Gói Tin & Mất Kết Nối Cổng Mạng (Packet Loss & Port Unreachable)**:
   - **Triệu chứng**: Gửi HTTP Request bị Timeout, SSH không kết nối được hoặc gói tin bị nảy rải rác.
   - **Các bước xử lý khẩn cấp**:
     ```bash
     # 1. Kiểm tra trạng thái cổng mạng TCP/UDP đang lắng nghe:
     sudo ss -tulpn | grep :80
     
     # 2. Bắt gói tin trực tiếp trên Interface để kiểm tra bắt tay 3 bước TCP:
     sudo tcpdump -i eth0 port 80 -nn -vv
     
     # 3. Phân tích đường đi của gói tin tìm điểm đứt gãy bằng MTR:
     mtr -n --report --report-cycles=10 8.8.8.8
     
     # 4. Kiểm tra xem gói tin có bị Firewall Drop không:
     sudo iptables -L -n -v | grep DROP
     ```

2. **Sự cố 2: Lỗi Sai Cấu Hình DNS & Chuyển Tiếp IP (DNS Resolution & IP Routing Error)**:
   - **Triệu chứng**: Ping IP thành công nhưng ping Domain Name báo `Could not resolve host`.
   - **Các bước xử lý khẩn cấp**:
     ```bash
     # 1. Tra cứu thử nghiệm phân giải DNS qua server cụ thể:
     dig @8.8.8.8 company.com +trace
     
     # 2. Kiểm tra file cấu hình DNS resolver địa phương:
     cat /etc/resolv.conf
     
     # 3. Kiểm tra bảng định tuyến Kernel IP Routing Table:
     ip route show default
     ```

---

## 5. 🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & Network Thực Tế (Interview Q&A)

> **Q: Triệu chứng đặc trưng nào giúp nhận biết sự cố sai lệch MTU (MTU Mismatch)?**  
> **A**: Ping gói tin nhỏ (mặc định) thông bình thường, nhưng khi thực hiện giao dịch nạp dữ liệu lớn (như tải file, HTTPS handshake hoặc SSH) thì kết nối bị treo đơ không phản hồi.

> **Q: Làm sao phát hiện sự cố Routing Loop giữa các Router bằng dòng lệnh?**  
> **A**: Sử dụng lệnh `traceroute <destination_IP>`, nếu thấy gói tin chạy lặp lại liên tục qua lại giữa 2 địa chỉ IP Router thì chắc chắn đang bị Routing Loop.





> **Q: Làm thế nào để điều tra và dập tắt sự cố một Server bị tấn công làm tràn bộ đệm kết nối TCP SYN Flood DoS?**  
> **A**:  
> 1. **Nhận biết**: Lệnh `ss -ant | grep SYN_RECV | wc -l` trả về hàng ngàn kết nối ở trạng thái `SYN_RECV`.  
> 2. **Xử lý khẩn cấp**: Bật ngay cơ chế **SYN Cookies** của Linux Kernel bằng lệnh `sudo sysctl -w net.ipv4.tcp_syncookies=1`. Kích hoạt bộ lọc Firewall drop các gói tin SYN có tần suất bất thường: `sudo iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT`.

> **Q: Sự khác biệt về mặt bản chất giữa Stateful Firewall và Stateless Firewall là gì?**  
> **A**: Stateless Firewall chỉ kiểm tra từng gói tin riêng rẻ dựa trên IP nguồn/đích và Port mà KHÔNG nhớ ngữ cảnh. Stateful Firewall duy trì một bảng theo dõi trạng thái kết nối (**Connection Tracking Table `conntrack`**), tự động nhận diện gói tin thuộc về một kết nối hợp lệ đã được chấp nhận trước đó (như trạng thái `ESTABLISHED,RELATED`), giúp bảo mật và tối ưu hiệu năng vượt trội.

---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] IP Duplicate: Trùng IP rớt mạng (Check ARP)
- [x] DHCP Exhaustion: Nhận IP 169.254 APIPA
- [x] MTU Mismatch: Treo khi truyền file lớn (Fix MTU 1420 / TCPMSS)
- [x] Routing Loop: Traceroute thấy IP chạy lặp

