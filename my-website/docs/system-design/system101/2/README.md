# 🏛 System Design Interview Volume 2: Thiết Kế Các Hệ Thống Phân Tán Siêu Siêu Khổng Lồ

Tài liệu được biên dịch, hệ thống hóa và diễn giải chi tiết 100% bằng tiếng Việt từ cuốn sách kinh điển **System Design Interview – An Insider's Guide (Volume 2)** của **Alex Xu & Sudipto Sengupta (sys2.pdf)**.

Bộ giáo trình bao gồm **13 chương bài học master** bao quát toàn bộ các chủ đề thiết kế hệ thống lớn nhất thế giới ở quy mô hàng trăm triệu người dùng và siêu độ trễ (như Google Maps, Sàn giao dịch chứng khoán, Ví điện tử, Stripe Payment, Apache Kafka, Prometheus Monitoring, S3 Storage...), nhúng sơ đồ đồ họa gốc trích xuất trực tiếp từ sách PDF độ phân giải cao kèm sơ đồ tương tác Mermaid.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 13 chương System Design Interview Volume 2 tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất thiết kế hệ thống trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Sơ Đồ Đồ Họa (Under The Hood Architecture)**: Phân tích hình ảnh trích xuất từ PDF, sơ đồ Mermaid, Data Flow & Trade-offs.
3. **⚡ Bảng Tra Cứu Khái Niệm & Tham Số (Reference Table)**: Bảng tham chiếu khái niệm, tầng layer, ý nghĩa bản chất và ứng dụng Production.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps / Architect**: Cấu hình mẫu K8s YAML / Docker + Incident Playbook xử lý sự cố High Scale thực tế khi đi làm.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn System Architect Thực Tế (Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng đào sâu bài toán Trade-offs (Latency vs Consistency vs Availability).
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 5 Thư Mục Chủ Đề System Design Volume 2

### 📘 [Dịch Vụ Địa Lý & Định Vị Vị Trí (Geospatial & Location-Based Services)](./01.Geospatial_and_Location_Based_Services/)
> 💡 **Tóm tắt**: Proximity Service (Yelp/Google Places), Nearby Friends (Realtime GPS Tracking, Redis Pub/Sub), Google Maps (Tile Server, Dijkstra/A* Routing).

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [001 Proximity Service Yelp Nearby](./01.Geospatial_and_Location_Based_Services/001_Proximity_Service_Yelp_Nearby.md)
- 📖 [002 Nearby Friends Realtime Location Tracking](./01.Geospatial_and_Location_Based_Services/002_Nearby_Friends_Realtime_Location_Tracking.md)
- 📖 [003 Google Maps Route Planning Tile Server](./01.Geospatial_and_Location_Based_Services/003_Google_Maps_Route_Planning_Tile_Server.md)

---

### 📘 [Hạ Tầng Phân Tán & Xử Lý Luồng (Distributed Infrastructure & Streaming)](./02.Distributed_Infrastructure_and_Streaming/)
> 💡 **Tóm tắt**: Apache Kafka Architecture, Metrics Monitoring & Alerting (Prometheus, TSDB), Ad Click Event Aggregation (Flink, Watermarks, ClickHouse).

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [004 Distributed Message Queue Kafka Architecture](./02.Distributed_Infrastructure_and_Streaming/004_Distributed_Message_Queue_Kafka_Architecture.md)
- 📖 [005 Metrics Monitoring and Alerting System Prometheus](./02.Distributed_Infrastructure_and_Streaming/005_Metrics_Monitoring_and_Alerting_System_Prometheus.md)
- 📖 [006 Ad Click Event Aggregation Flink ClickHouse](./02.Distributed_Infrastructure_and_Streaming/006_Ad_Click_Event_Aggregation_Flink_ClickHouse.md)

---

### 📘 [Thương Mại Điện Tử & Hệ Thống Đặt Phòng (E-Commerce & Reservation)](./03.ECommerce_and_Reservation_Systems/)
> 💡 **Tóm tắt**: Hotel Reservation System (Pessimistic/Optimistic Locking, 2PC/Saga), Distributed Email Service (Gmail, S3 + Metadata DB), S3-like Object Storage (Erasure Coding 8+4).

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [007 Hotel Reservation System Concurrency Control](./03.ECommerce_and_Reservation_Systems/007_Hotel_Reservation_System_Concurrency_Control.md)
- 📖 [008 Distributed Email Service SMTP IMAP Storage](./03.ECommerce_and_Reservation_Systems/008_Distributed_Email_Service_SMTP_IMAP_Storage.md)
- 📖 [009 S3 Like Object Storage Block Erasure Coding](./03.ECommerce_and_Reservation_Systems/009_S3_Like_Object_Storage_Block_Erasure_Coding.md)

---

### 📘 [Game & Bảng Xếp Hạng Thời Gian Thực (Gaming & Real-time Leaderboard)](./04.Gaming_and_Realtime_Leaderboards/)
> 💡 **Tóm tắt**: Real-time Gaming Leaderboard (Redis Sorted Sets ZADD/ZREVRANGE, Async Database Flush).

📂 **Tổng số bài học**: `1 chương bài học Markdown`

- 📖 [010 Realtime Gaming Leaderboard Redis Sorted Sets](./04.Gaming_and_Realtime_Leaderboards/010_Realtime_Gaming_Leaderboard_Redis_Sorted_Sets.md)

---

### 📘 [Tài Chính, Thanh Toán & Sàn Giao Dịch (Financial, Payment & Trading)](./05.Financial_Payment_and_Trading_Platforms/)
> 💡 **Tóm tắt**: Payment System (Idempotency Key, Double-Entry Ledger), Digital Wallet (In-memory Balance, Raft Consensus), Stock Exchange (Matching Engine $O(1)$, Order Book, FIX Protocol).

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [011 Payment System Gateway Ledger Idempotency](./05.Financial_Payment_and_Trading_Platforms/011_Payment_System_Gateway_Ledger_Idempotency.md)
- 📖 [012 Digital Wallet Double Entry Raft Consensus](./05.Financial_Payment_and_Trading_Platforms/012_Digital_Wallet_Double_Entry_Raft_Consensus.md)
- 📖 [013 Stock Exchange Matching Engine Order Book](./05.Financial_Payment_and_Trading_Platforms/013_Stock_Exchange_Matching_Engine_Order_Book.md)

---

