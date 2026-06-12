# Network Packet Analysis

### 1. Tổng quan về Wireshark và Mục đích học tập

Wireshark là một công cụ **Packet Analyzer** (phân tích gói tin) chuyên dụng. Mục đích chính của việc sử dụng công cụ này trong bài học là để "mổ xẻ" các luồng dữ liệu mạng thực tế, từ đó minh họa cụ thể cho mô hình OSI.

* **Lưu ý quan trọng cho kỳ thi Network+:** Người học không cần biết cách sử dụng thành thạo Wireshark để thi, nhưng cần hiểu rõ khái niệm "Packet Analyzer" là gì và các ứng dụng cơ bản của nó trong xử lý sự cố (troubleshooting).
* **Mục tiêu chính:** Sử dụng Wireshark như một "kính hiển vi" để quan sát các lớp (layers) của mô hình OSI hoạt động như thế nào trong một kết nối mạng thực tế.

> **💡 Ví dụ nhớ đời:** Hãy tưởng tượng Wireshark giống như một chiếc máy soi hành lý tại sân bay. Thay vì chỉ nhìn thấy chiếc vali (gói tin) đi qua, bạn có thể nhìn xuyên thấu từng lớp quần áo, vật dụng bên trong (các lớp OSI) để biết chính xác món đồ đó là gì, từ đâu đến và sẽ đi đâu.

---

### 2. Cách đọc thông tin cơ bản trong Wireshark

Khi mở một tệp tin Capture (bắt gói tin), bảng điều khiển chính sẽ hiển thị theo trình tự thời gian của luồng giao tiếp giữa các thiết bị:

* **Time:** Thời điểm gói tin được ghi nhận (bắt đầu từ 0).
* **Source IP:** Địa chỉ IP của thiết bị gửi yêu cầu (nguồn).
* **Destination IP:** Địa chỉ IP của máy chủ nhận yêu cầu (đích).
* **Protocol:** Giao thức mạng đang sử dụng (ví dụ: TCP, HTTP).
* **Info:** Tóm tắt hành động xảy ra (ví dụ: yêu cầu kết nối, phản hồi dữ liệu).

Quy trình đọc một kết nối mạng là sự trao đổi hai chiều giữa Host và Server. Dữ liệu này được hiển thị dưới dạng các "dòng", mỗi dòng là một gói tin được chuyển dịch trên mạng.

---

### 3. Giải phẫu cấu trúc gói tin qua mô hình OSI

#### A. Layer 2: Data Link Layer

* **Định nghĩa:** Nơi các **Frame** (khung dữ liệu) hoạt động.
* **Thông tin:** Loại đóng gói (Ethernet) và địa chỉ vật lý (MAC Address).

#### B. Layer 3: Network Layer

* **Định nghĩa:** Nơi giao thức **IPv4** hoạt động. Cung cấp địa chỉ logic (IP Source/Destination) để định tuyến gói tin.

#### C. Layer 4: Transport Layer

* **Định nghĩa:** Nơi các giao thức **TCP/UDP** hoạt động. Đảm bảo tính đáng tin cậy của dữ liệu qua cơ chế phản hồi (ACK).

#### D. Layer 7: Application Layer

* **Định nghĩa:** Lớp tương tác trực tiếp (HTTP). Giải mã dữ liệu thô thành thông tin con người đọc được.

---

### 4. Quy trình vận hành kết nối (Session)

1. **SYN:** Máy trạm gửi yêu cầu kết nối.
2. **SYN ACK:** Máy chủ xác nhận yêu cầu.
3. **HTTP GET:** Máy trạm yêu cầu dữ liệu.

### PHẦN 2: PHÂN TÍCH GÓI TIN VỚI WIRESHARK - TỪ HTTP, FTP ĐẾN TELNET

#### 1. Phân tích luồng dữ liệu HTTP (Web Traffic)

Sử dụng tính năng **Follow TCP Stream** để tái lập lại toàn bộ chuỗi gói tin thành dữ liệu có nghĩa. Tệp PCAP đóng vai trò là "dấu vết" mạng cho phép xem lại toàn bộ nội dung gốc.

#### 2. File Transfer Protocol (FTP) và Phân tích Forensics

Việc bắt được toàn bộ gói tin FTP cho phép tái tạo lại file người dùng tải xuống. Đây là minh chứng cho thấy dữ liệu không mã hóa rất dễ bị "nhìn thấy".

#### 3. Phân tích phiên làm việc Telnet

* **Tính chất "Clear Text":** Mọi thông tin (Username, Password) đều hiển thị dưới dạng văn bản thuần.
* **Rủi ro:** Telnet giống như gửi một tấm bưu thiếp không bao thư, ai cũng có thể đọc được nội dung trên đường truyền.

---

### PHẦN 3: PHÂN TÍCH LƯU LƯỢNG MẠNG

#### 1. Phân tích luồng dữ liệu: Client-side vs. Server-side

* **Full Conversation:** Nghe cả hai phía trao đổi.
* **Client-side:** Tập trung vào các yêu cầu, đầu vào (username/password).
* **Server-side:** Tập trung vào các phản hồi, kết quả thực thi.

#### 2. Tầm quan trọng của Wireshark trong nghề nghiệp

* **Cybersecurity Analyst:** Dùng để điều tra sự cố (Incident Response).
* **PenTest+:** Dùng để thu thập thông tin (Reconnaissance) và tìm lỗ hổng.
* **Network Technician:** Dùng để chẩn đoán sự cố mạng dựa trên các tầng OSI.

> **💡 Ví dụ nhớ đời:** Hãy coi Wireshark là "chiếc hộp đen" của hệ thống mạng. Dù là lỗi kỹ thuật hay sự cố bảo mật, Wireshark sẽ cho bạn biết chính xác "xương sống" của dữ liệu đang bị gãy ở tầng nào.
