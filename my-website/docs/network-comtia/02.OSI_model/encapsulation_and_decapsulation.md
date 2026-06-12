# Encapsulation and Decapsulation

### 1. Định nghĩa Encapsulation và Decapsulation

Trong lĩnh vực mạng máy tính, **Encapsulation** (Đóng gói) và **Decapsulation** (Mở gói) là hai quá trình cốt lõi quyết định cách dữ liệu được truyền tải thông qua mô hình OSI.

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_0.jpg)

*   **Encapsulation (Đóng gói):** Là quá trình thêm các **Header** (tiêu đề) và đôi khi là **Trailer** (phần đuôi) bao quanh dữ liệu gốc khi nó di chuyển từ tầng ứng dụng (tầng 7) xuống tầng vật lý (tầng 1) của mô hình OSI.
*   **Decapsulation (Mở gói):** Là quá trình ngược lại, diễn ra khi dữ liệu di chuyển từ tầng 1 lên tầng 7 tại thiết bị nhận. Các Header và Trailer lần lượt được loại bỏ để trích xuất dữ liệu gốc ban đầu.

> **💡 Ví dụ nhớ đời:** Hãy tưởng tượng bạn viết một bức thư (Dữ liệu). Bạn đặt nó vào phong bì (Header tầng 7), rồi cho phong bì đó vào một chiếc hộp giấy (Header tầng 6), tiếp tục cho vào thùng carton lớn hơn (Header tầng 5). Quá trình đó là **Encapsulation**. Khi người nhận lấy thùng carton ra, mở hộp, rồi lấy thư trong phong bì, đó là **Decapsulation**.

---

### 2. Đơn vị dữ liệu giao thức (PDU)

Trong mô hình OSI, mỗi đơn vị thông tin được truyền tải được gọi là **Protocol Data Unit (PDU)**. 

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_1.jpg)

Tên gọi của PDU thay đổi tùy thuộc vào tầng mà nó đang đi qua:

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_2.jpg)

*   **Quy tắc chung:** Được gọi là **Ln PDU** (ví dụ: L7 PDU cho tầng 7).
*   **Tên gọi đặc biệt tại các tầng quan trọng:**
    *   **Tầng 4 (Transport):** **Segment** (nếu dùng TCP) hoặc **Datagram** (nếu dùng UDP).
    *   **Tầng 3 (Network):** **Packet**.
    *   **Tầng 2 (Data Link):** **Frame**.
    *   **Tầng 1 (Physical):** **Bits**.

---

### 3. Quy trình Đóng gói dữ liệu (Di chuyển xuống từ tầng 7 đến 1)

Khi người dùng gửi dữ liệu, quy trình diễn ra như sau:

1.  **Tầng 7 (Application):** Người dùng nhập dữ liệu vào ứng dụng. Tầng này thêm **Layer 7 Header** chứa metadata.
2.  **Tầng 6 (Presentation):** Đóng gói toàn bộ L7 Header + dữ liệu, gắn thêm **Layer 6 Header** về định dạng/mã hóa.
3.  **Tầng 5 (Session):** Tiếp nhận dữ liệu, gắn thêm **Layer 5 Header** quản lý phiên.
4.  **Các tầng dưới (4, 3, 2, 1):** Quá trình tương tự tiếp tục diễn ra.

> **💡 Ví dụ nhớ đời:** Hãy coi dữ liệu là một "vật phẩm giá trị". Mỗi tầng là một bộ phận kiểm soát trong dây chuyền sản xuất dán nhãn (Header) cho kiện hàng.

---

### 4. Phân tích chi tiết: Header tầng 4 (Transport Layer)

Tầng 4 đóng vai trò cực kỳ quan trọng với các giao thức TCP hoặc UDP.

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_3.jpg)

#### Cơ chế "Three-way Handshake" (Bắt tay 3 bước):

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_4.jpg)
![Hình minh họa](./image/encapsulation_and_decapsulation_anh_5.jpg)

1.  **SYN:** Client gửi gói tin SYN để yêu cầu kết nối. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_6.jpg)
2.  **SYN-ACK:** Server phản hồi bằng gói tin SYN-ACK để xác nhận.
3.  **ACK:** Client gửi gói tin ACK để xác nhận hoàn tất thiết lập kết nối. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_7.jpg)

---

### 5. GHI CHÚ HỌC TẬP: CẤU TRÚC GÓI TIN TCP, UDP VÀ CÁC TẦNG MẠNG (P2)

#### 1. Các cờ điều khiển (Flags) trong TCP

*   **SYN (Synchronization):** Đồng bộ hóa kết nối.
*   **ACK (Acknowledgement):** Xác nhận nhận thành công. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_7.jpg)
*   **RST (Reset):** Ngắt kết nối lỗi/không mong muốn. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_8.jpg)
*   **FIN (Finished):** Kết thúc phiên kết nối. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_9.jpg)
*   **PSH (Push):** Ưu tiên đẩy dữ liệu ngay lập tức. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_10.jpg)
*   **URG (Urgent):** Dữ liệu khẩn cấp, bỏ qua hàng đợi. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_11.jpg)

#### 2. Giao thức UDP (User Datagram Protocol)

UDP là giao thức không hướng kết nối, header rất tinh gọn (8 byte).

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_12.jpg)

#### 3. Tầng mạng (Network Layer - Layer 3) và IP Header

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_13.jpg)

#### 4. Tầng liên kết dữ liệu (Data Link Layer - Layer 2) và Ethernet

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_14.jpg)

*   **Ethernet Header:** Chứa địa chỉ MAC (vật lý) để định danh thiết bị. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_15.jpg)
*   **EtherType:** Xác định giao thức lớp trên. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_16.jpg)
*   **Payload:** Kích thước tối thiểu tùy thuộc vào VLAN. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_17.jpg)

---

### 6. Khái niệm MTU và Jumbo Frames

![Hình minh họa](./image/encapsulation_and_decapsulation_anh_18.jpg)

*   **MTU (Maximum Transmission Unit):** Mặc định là 1500 bytes.
*   **Jumbo Frames:** Cấu hình cho khung lớn hơn 1500 bytes (đến 9000 bytes) để giảm tải CPU.

---

### 7. Quy trình đóng gói & xử lý thiết bị

*   **Đóng gói L4:** Thêm port. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_19.jpg)
*   **Đóng gói L3:** Thêm IP. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_20.jpg)
*   **Đóng gói L2:** Thêm MAC. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_21.jpg)
*   **Đóng gói L1:** Chuyển sang bit. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_22.jpg)

*   **Xử lý tại Switch (L2):** Đọc địa chỉ MAC để chuyển tiếp. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_23.jpg)
*   **Xử lý tại Router (L3):** Đọc địa chỉ IP để định tuyến. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_24.jpg)
*   **Decapsulation tại đích:** Bóc tách từng lớp header. ![Hình minh họa](./image/encapsulation_and_decapsulation_anh_25.jpg)


---
*Ghi chú: 26 hình ảnh minh họa (.jpg) đã được tải về và lưu tự động vào thư mục con `image/` cùng cấp với file này. Để ảnh hiển thị tự động, hãy đảm bảo bạn sao chép cả thư mục `image/` nếu bạn muốn di chuyển file markdown sang nơi khác!*
