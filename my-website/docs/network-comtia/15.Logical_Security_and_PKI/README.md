# 🌐 15.Logical_Security_and_PKI: Bảo Mật Logic, IAM, AAA, Mã Hóa & Hạ Tầng PKI - Chuyên Sâu CompTIA Network+ Cho DevOps

> 💡 **Bản chất 1 câu**: IAM, MFA, AAA Protocols (RADIUS, TACACS+), Mã hóa Đối xứng (AES) vs Bất đối xứng (RSA/ECC), IPsec (AH vs ESP, IKEv1/v2) ...  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững lý thuyết chuyên sâu, sơ đồ kiến trúc, bộ lệnh CLI chẩn đoán thực tế và bộ câu hỏi phỏng vấn tuyển dụng.

---

## 1. 🧠 Hình Hình Dung Nhanh (Intuitive Mindset)

IAM, MFA, AAA Protocols (RADIUS, TACACS+), Mã hóa Đối xứng (AES) vs Bất đối xứng (RSA/ECC), IPsec (AH vs ESP, IKEv1/v2) và PKI X.509 Digital Certificates.

```mermaid
graph TD
    Client -->|1. Request CSR| CA[Certificate Authority]
    CA -->|2. Issue X.509 Cert| Client -->|3. HTTPS SSL/TLS| Server
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 AAA, Mã Hóa & Hạ Tầng PKI (OBJ 4.1)
1. **Mô Hình AAA**: **Authentication** (Bạn là ai?) - **Authorization** (Bạn được làm gì?) - **Accounting** (Bạn đã làm gì?). Triển khai qua **RADIUS** (Wi-Fi) và **TACACS+** (Router/Switch Cisco).
2. **Mã Hóa Đối Xứng vs Bất Đối Xứng**:
   - **Mã hóa Đối xứng (AES-256)**: Dùng **CÙNG 1 KHÓA** để mã hóa và giải mã. Tốc độ cực nhanh.
   - **Mã hóa Bất đối xứng (RSA/ECC)**: Dùng **CẶP KHÓA** (Public Key / Private Key). Dùng xác thực và chữ ký số.
3. **IPsec VPN (Layer 3)**:
   - **AH (Authentication Header)**: Xác thực nguồn gốc (KHÔNG mã hóa).
   - **ESP (Encapsulating Security Payload)**: **MÃ HÓA DỮ LIỆU** + Xác thực.
4. **PKI & X.509 Certificate**: Máy chủ chứng thực **CA** ký số cấp chứng chỉ X.509 để xác thực SSL/TLS HTTPS.


---


### 2.4 Cơ Chế Hoạt Động Bên Dưới Kernel & Kiến Trúc Hệ Thống Chi Tiết (Deep Under The Hood Architecture)
- **Tầng Giao Tiếp Mạng & Bắt Gói Tin**: Mọi gói tin đi qua Network Interface Card (NIC) đều trải qua quá trình xử lý Ring Buffer, ngắt phần cứng (Hardware Interrupts), Ring Buffer DMA và chồng giao thức Socket Buffers (`sk_buff`) trong Linux Kernel.
- **Tối Ưu Hóa & Cấu Trúc Dữ Liệu**: Hệ thống duy trì các bảng băm dữ liệu (Routing Table, ARP Cache Table, Connection Tracking Table `conntrack`, Socket Inode Tables) giúp chuyển tiếp gói tin ở tốc độ dây (Line-rate processing).
- **Phân Lập An Ninh & Phân Vùng**: Sử dụng cơ chế Linux Network Namespaces (`ip netns`), iptables/nftables hooks và mã hóa phần cứng để cách ly lưu lượng mạng tuyệt đối.

---

## 3. ⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)

| Công cụ / Khái niệm | Loại / Protocol | Ý nghĩa chi tiết | Ứng dụng thực tế |
| :--- | :--- | :--- | :--- |
| **`AAA`** | `RADIUS / TACACS+` | Authentication - Authorization - Accounting | `Xác thực user Wi-Fi / Router` |
| **`AES-256`** | `Symmetric` | Mã hóa đối xứng siêu tốc chuẩn quân đội | `Mã hóa đĩa cứng / TLS Payload` |
| **`RSA / ECC`** | `Asymmetric` | Mã hóa bất đối xứng cặp Public/Private Key | `Chữ ký số, HTTPS Handshake, SSH Key` |
| **`IPsec ESP`** | `Layer 3 Security` | Mã hóa toàn bộ dữ liệu IP Packet cho VPN | `Site-to-Site VPN giữa 2 chi nhánh` |
| **`X.509`** | `PKI Cert Standard` | Chứng chỉ số chứa Public Key và con dấu ký của CA | `HTTPS SSL/TLS Certificate` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps

### 🛠 Các lệnh thực hành gõ là ăn ngay:
```bash
openssl req -new -newkey rsa:4096 -nodes -keyout app.key -out app.csr
sudo certbot --nginx -d app.company.com
```

### 🚀 Kịch bản xử lý sự cố thực tế khi đi làm:
Sự cố kênh VPN Site-to-Site giữa 2 chi nhánh bị đứt do cấu hình lệch Phase 1/Phase 2 IKE proposal.

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

> **Q: Sự khác biệt cốt lõi giữa IPsec AH và IPsec ESP là gì?**  
> **A**: IPsec AH chỉ xác thực nguồn gốc (KHÔNG mã hóa dữ liệu). IPsec ESP vừa **MÃ HÓA DỮ LIỆU** bảo mật vừa xác thực nguồn gốc.

> **Q: Ba thành phần của mô hình AAA đại diện cho các từ nào?**  
> **A**: Authentication (Xác thực danh tính), Authorization (Cấp quyền thao tác), và Accounting (Ghi nhật ký audit).





> **Q: Làm thế nào để điều tra và dập tắt sự cố một Server bị tấn công làm tràn bộ đệm kết nối TCP SYN Flood DoS?**  
> **A**:  
> 1. **Nhận biết**: Lệnh `ss -ant | grep SYN_RECV | wc -l` trả về hàng ngàn kết nối ở trạng thái `SYN_RECV`.  
> 2. **Xử lý khẩn cấp**: Bật ngay cơ chế **SYN Cookies** của Linux Kernel bằng lệnh `sudo sysctl -w net.ipv4.tcp_syncookies=1`. Kích hoạt bộ lọc Firewall drop các gói tin SYN có tần suất bất thường: `sudo iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT`.

> **Q: Sự khác biệt về mặt bản chất giữa Stateful Firewall và Stateless Firewall là gì?**  
> **A**: Stateless Firewall chỉ kiểm tra từng gói tin riêng rẻ dựa trên IP nguồn/đích và Port mà KHÔNG nhớ ngữ cảnh. Stateful Firewall duy trì một bảng theo dõi trạng thái kết nối (**Connection Tracking Table `conntrack`**), tự động nhận diện gói tin thuộc về một kết nối hợp lệ đã được chấp nhận trước đó (như trạng thái `ESTABLISHED,RELATED`), giúp bảo mật và tối ưu hiệu năng vượt trội.

---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] AAA: Authentication - Authorization - Accounting
- [x] Mã hóa đối xứng (AES): Cùng 1 khóa, nhanh
- [x] Mã hóa bất đối xứng (RSA/ECC): Public/Private Key
- [x] IPsec ESP: Mã hóa IP packet cho VPN
- [x] X.509: Chứng chỉ số SSL/TLS

