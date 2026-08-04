# 🏛 System Design Interview Volume 1: Thiết Kế Các Hệ Thống Thực Tế Khổng Lồ

Tài liệu được biên dịch, hệ thống hóa và diễn giải chi tiết 100% bằng tiếng Việt từ cuốn sách kinh điển **System Design Interview – An Insider's Guide (Volume 1)** của **Alex Xu (sys1.pdf)**.

Bộ giáo trình bao gồm **16 chương bài học master** bao quát toàn bộ các chủ đề thiết kế hệ thống lớn nhất thế giới (như YouTube, Google Drive, WhatsApp, Twitter Newsfeed, Bit.ly, Web Crawler...), nhúng sơ đồ đồ họa gốc trích xuất trực tiếp từ sách PDF độ phân giải cao kèm sơ đồ tương tác Mermaid.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 16 chương System Design Interview Volume 1 tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất thiết kế hệ thống trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Sơ Đồ Đồ Họa (Under The Hood Architecture)**: Phân tích hình ảnh trích xuất từ PDF, sơ đồ Mermaid, Data Flow & Trade-offs.
3. **⚡ Bảng Tra Cứu Khái Niệm & Tham Số (Reference Table)**: Bảng tham chiếu khái niệm, tầng layer, ý nghĩa bản chất và ứng dụng Production.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps / Architect**: Cấu hình mẫu K8s YAML / Docker + Incident Playbook xử lý sự cố High Scale thực tế khi đi làm.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn System Architect Thực Tế (Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng đào sâu bài toán Trade-offs (Latency vs Consistency vs Availability).
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 5 Thư Mục Chủ Đề System Design Volume 1

### 📘 [Nền Tảng Thiết Kế Hệ Thống (System Design Fundamentals)](./01.System_Design_Fundamentals/)
> 💡 **Tóm tắt**: Mở rộng từ 0 đến triệu người dùng, Ước tính nhanh Back-of-the-Envelope & Khung sườn phỏng vấn 4 bước.

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [001 Scale From Zero To Millions Of Users](./01.System_Design_Fundamentals/001_Scale_From_Zero_To_Millions_Of_Users.md)
- 📖 [002 Back Of The Envelope Estimation](./01.System_Design_Fundamentals/002_Back_Of_The_Envelope_Estimation.md)
- 📖 [003 Framework For System Design Interviews](./01.System_Design_Fundamentals/003_Framework_For_System_Design_Interviews.md)

---

### 📘 [Các Thành Phần Xây Dựng Hệ Phân Tán (Distributed Building Blocks)](./02.Distributed_Building_Blocks/)
> 💡 **Tóm tắt**: Rate Limiter (Token/Leaky Bucket), Consistent Hashing ring, Key-Value Store (DynamoDB/Cassandra), Unique ID Generator (Twitter Snowflake).

📂 **Tổng số bài học**: `4 chương bài học Markdown`

- 📖 [004 Design A Rate Limiter](./02.Distributed_Building_Blocks/004_Design_A_Rate_Limiter.md)
- 📖 [005 Design Consistent Hashing](./02.Distributed_Building_Blocks/005_Design_Consistent_Hashing.md)
- 📖 [006 Design A Key Value Store](./02.Distributed_Building_Blocks/006_Design_A_Key_Value_Store.md)
- 📖 [007 Design A Unique ID Generator](./02.Distributed_Building_Blocks/007_Design_A_Unique_ID_Generator.md)

---

### 📘 [Hệ Thống Xử Lý Web & Dữ Liệu (Web & Data Processing Systems)](./03.Web_and_Data_Processing_Systems/)
> 💡 **Tóm tắt**: URL Shortener (bit.ly), Distributed Web Crawler (Google Bot), Notification System (APNs, FCM, SMS, Email).

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [008 Design A URL Shortener](./03.Web_and_Data_Processing_Systems/008_Design_A_URL_Shortener.md)
- 📖 [009 Design A Web Crawler](./03.Web_and_Data_Processing_Systems/009_Design_A_Web_Crawler.md)
- 📖 [010 Design A Notification System](./03.Web_and_Data_Processing_Systems/010_Design_A_Notification_System.md)

---

### 📘 [Hệ Thống Mạng Xã Hội & Truyền Thông (Social & Communication Systems)](./04.Social_and_Communication_Systems/)
> 💡 **Tóm tắt**: News Feed System (Fanout Push/Pull), Chat System thời gian thực (WebSocket, Presence Server), Search Autocomplete System (Trie Data Structure).

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [011 Design A News Feed System](./04.Social_and_Communication_Systems/011_Design_A_News_Feed_System.md)
- 📖 [012 Design A Chat System](./04.Social_and_Communication_Systems/012_Design_A_Chat_System.md)
- 📖 [013 Design A Search Autocomplete System](./04.Social_and_Communication_Systems/013_Design_A_Search_Autocomplete_System.md)

---

### 📘 [Nền Tảng Lưu Trữ & Truyền Tải Đa Phương Tiện (Media & Storage Platforms)](./05.Media_and_Storage_Platforms/)
> 💡 **Tóm tắt**: YouTube Video Streaming (Transcoding DAG, HLS/DASH, CDN), Google Drive Cloud Storage (Block Storage, Block Deduplication, Presigned URL) & Best Practices.

📂 **Tổng số bài học**: `3 chương bài học Markdown`

- 📖 [014 Design YouTube](./05.Media_and_Storage_Platforms/014_Design_YouTube.md)
- 📖 [015 Design Google Drive](./05.Media_and_Storage_Platforms/015_Design_Google_Drive.md)
- 📖 [016 System Design Interview Best Practices](./05.Media_and_Storage_Platforms/016_System_Design_Interview_Best_Practices.md)

---

