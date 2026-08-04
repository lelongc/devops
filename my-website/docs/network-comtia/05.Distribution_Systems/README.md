# 🌐 05.Distribution_Systems: Hệ Thống Phân Phối Cáp, Nguồn UPS & Điện Lạnh HVAC - Chuyên Sâu CompTIA Network+ Cho DevOps

> 💡 **Bản chất 1 câu**: Hệ thống tủ Rack, Patch Panel, Punchdown Block, kiểm tra cáp TDR/OTDR, nguồn điện UPS/PDU, hệ thống làm mát HVAC và chữa...  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững lý thuyết chuyên sâu, sơ đồ kiến trúc, bộ lệnh CLI chẩn đoán thực tế và bộ câu hỏi phỏng vấn tuyển dụng.

---

## 1. 🧠 Hình Hình Dung Nhanh (Intuitive Mindset)

Hệ thống tủ Rack, Patch Panel, Punchdown Block, kiểm tra cáp TDR/OTDR, nguồn điện UPS/PDU, hệ thống làm mát HVAC và chữa cháy Datacenter.

```mermaid
graph LR
    Server[Server Rack] --> PatchPanel[Patch Panel] --> Switch[Core Switch]
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 Hệ Thống Phân Phối Cáp & Nguồn Datacenter (OBJ 2.4 & 5.5)
1. **Patch Panel & Cable Distribution**:
   - Patch Panel gom các đầu cáp âm tường từ khắp văn phòng về tủ Rack. Dùng dây dẻo Patch Cord nối ngắn từ Patch Panel sang Switch Port để tránh hỏng cáp chính.
2. **Thiết Bị Đo Kiểm Cáp TDR & OTDR**:
   - **TDR (Time-Domain Reflectometer)**: Bắn xung điện để đo khoảng cách vị trí cáp đồng bị đứt đè ngầm.
   - **OTDR (Optical TDR)**: Bắn xung ánh sáng đo suy hao dBm và tìm vị trí cáp quang bị gãy đứt ngầm.
3. **Hệ Thống Điện & Làm Mát**:
   - **UPS (Uninterruptible Power Supply)**: Bộ lưu điện dự phòng chuyển sang ắc quy instant khi mất điện lưới.
   - **PDU (Power Distribution Unit)**: Tủ phân phối nguồn thông minh trong Rack.
   - **HVAC**: Hệ thống điều hòa chính xác duy trì nhiệt độ 18-22°C và độ ẩm 40-50% cho Datacenter.
   - **Fire Suppression (FM-200 / Novec 1230)**: Hệ thống khí chữa cháy sạch dập lửa không dùng nước để bảo vệ linh kiện điện tử.


---


### 2.4 Cơ Chế Hoạt Động Bên Dưới Kernel & Kiến Trúc Hệ Thống Chi Tiết (Deep Under The Hood Architecture)
- **Tầng Giao Tiếp Mạng & Bắt Gói Tin**: Mọi gói tin đi qua Network Interface Card (NIC) đều trải qua quá trình xử lý Ring Buffer, ngắt phần cứng (Hardware Interrupts), Ring Buffer DMA và chồng giao thức Socket Buffers (`sk_buff`) trong Linux Kernel.
- **Tối Ưu Hóa & Cấu Trúc Dữ Liệu**: Hệ thống duy trì các bảng băm dữ liệu (Routing Table, ARP Cache Table, Connection Tracking Table `conntrack`, Socket Inode Tables) giúp chuyển tiếp gói tin ở tốc độ dây (Line-rate processing).
- **Phân Lập An Ninh & Phân Vùng**: Sử dụng cơ chế Linux Network Namespaces (`ip netns`), iptables/nftables hooks và mã hóa phần cứng để cách ly lưu lượng mạng tuyệt đối.

---

## 3. ⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)

| Công cụ / Khái niệm | Loại / Protocol | Ý nghĩa chi tiết | Ứng dụng thực tế |
| :--- | :--- | :--- | :--- |
| **`Patch Panel`** | `Hardware` | Bảng cắm chuyển tiếp cáp âm tường tập trung trong Tủ Rack | `Quản lý gọn gàng dây cáp Datacenter` |
| **`TDR / OTDR`** | `Testing Tool` | Máy đo xác định chính xác khoảng cách mét vị trí đứt cáp | `Tìm điểm cáp ngầm bị đứt` |
| **`UPS / PDU`** | `Power System` | Bộ lưu điện dự phòng và thanh phân phối nguồn trong Rack | `Duy trì nguồn điện liên tục cho Server` |
| **`FM-200 / Novec`** | `Fire Suppression` | Hệ thống khí dập lửa sạch không dùng nước | `Chữa cháy an toàn cho Datacenter` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps

### 🛠 Các lệnh thực hành gõ là ăn ngay:
```bash
# Đọc thông số nhiệt độ cảm biến Server Linux:
sensors
```

### 🚀 Kịch bản xử lý sự cố thực tế khi đi làm:
Sự cố điều hòa HVAC Datacenter hỏng khiến nhiệt độ Server Rack vọt lên 40°C gây tự động shutdown khẩn cấp.

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

> **Q: Máy đo OTDR (Optical Time-Domain Reflectometer) dùng để làm gì?**  
> **A**: Dùng để bắn tia sáng đo suy hao dBm và xác định vị trí mét chính xác bị đứt gãy trên tuyến cáp quang.

> **Q: Tại sao Datacenter không dùng hệ thống chữa cháy phun nước Sprinkler thông thường?**  
> **A**: Vì nước gây chập cháy hỏng hoàn toàn linh kiện điện tử. Datacenter bắt buộc dùng hệ thống khí sạch FM-200 hoặc Novec 1230 dập tắt lửa bằng cách rút oxy mà không gây hư hại thiết bị.





> **Q: Làm thế nào để điều tra và dập tắt sự cố một Server bị tấn công làm tràn bộ đệm kết nối TCP SYN Flood DoS?**  
> **A**:  
> 1. **Nhận biết**: Lệnh `ss -ant | grep SYN_RECV | wc -l` trả về hàng ngàn kết nối ở trạng thái `SYN_RECV`.  
> 2. **Xử lý khẩn cấp**: Bật ngay cơ chế **SYN Cookies** của Linux Kernel bằng lệnh `sudo sysctl -w net.ipv4.tcp_syncookies=1`. Kích hoạt bộ lọc Firewall drop các gói tin SYN có tần suất bất thường: `sudo iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT`.

> **Q: Sự khác biệt về mặt bản chất giữa Stateful Firewall và Stateless Firewall là gì?**  
> **A**: Stateless Firewall chỉ kiểm tra từng gói tin riêng rẻ dựa trên IP nguồn/đích và Port mà KHÔNG nhớ ngữ cảnh. Stateful Firewall duy trì một bảng theo dõi trạng thái kết nối (**Connection Tracking Table `conntrack`**), tự động nhận diện gói tin thuộc về một kết nối hợp lệ đã được chấp nhận trước đó (như trạng thái `ESTABLISHED,RELATED`), giúp bảo mật và tối ưu hiệu năng vượt trội.

---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] Patch Panel: Nối chuyển tiếp cáp âm tường
- [x] OTDR: Đo điểm đứt cáp quang
- [x] HVAC: Điều hòa duy trì 18-22°C
- [x] FM-200: Khí dập lửa sạch cho Datacenter

