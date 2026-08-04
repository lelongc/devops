# 🏛 System Design 101: Thiết Kế Hệ Thống Quy Mô Khổng Lồ (High-Scale System Architecture)

Tài liệu được trích xuất, biên dịch và hệ thống hóa chuyên sâu 100% từ cuốn sách nổi tiếng **System Design 101 (sys0.pdf)** của ByteByteGo (Alex Xu). Bộ giáo trình được cấu trúc lại hoàn chỉnh thành **212 bài học chi tiết + 202 sơ đồ đồ họa trích xuất trực tiếp**, thiết kế chuyên biệt cho **kỹ sư DevOps**, **System Architect**, **Backend Lead** và **kỹ sư phần mềm**.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 212 bài System Design 101 tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất thiết kế hệ thống trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Sơ Đồ Đồ Họa (Under The Hood Architecture)**: Phân tích hình ảnh trích xuất từ PDF, sơ đồ Mermaid, Data Flow & Trade-offs.
3. **⚡ Bảng Tra Cứu Khái Niệm & Tham Số (Reference Table)**: Bảng tham chiếu khái niệm, tầng layer, ý nghĩa bản chất và ứng dụng Production.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps / Architect**: Cấu hình mẫu YAML/Docker/K8s + Incident Playbook xử lý sự cố High Scale thực tế khi đi làm.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn System Architect Thực Tế (Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng đào sâu bài toán Trade-offs (Latency vs Consistency vs Availability).
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 8 Thư Mục Chủ Đề System Design 101

### 📘 [Kiến Trúc & Mẫu Thiết Kế Hệ Thống (Architecture & Design Patterns)](./01.Architecture_and_Design_Patterns/)
> 💡 **Tóm tắt**: Monolith vs Microservices, Event Sourcing, CQRS, Service Mesh, API Gateway, Load Balancers (L4/L7), Reverse Proxy vs Forward Proxy, Serverless/FaaS, MVC.

📂 **Tổng số bài học**: `118 bài học Markdown`

- 📖 [001 Big Endian vs Little Endian](./01.Architecture_and_Design_Patterns/001_Big_Endian_vs_Little_Endian.md)
- 📖 [002 incorporate Event Sourcing into systems](./01.Architecture_and_Design_Patterns/002_incorporate_Event_Sourcing_into_systems.md)
- 📖 [005 recommended materials for cracking next](./01.Architecture_and_Design_Patterns/005_recommended_materials_for_cracking_next.md)
- 📖 [011 Top 8 Programming Paradigms Part](./01.Architecture_and_Design_Patterns/011_Top_8_Programming_Paradigms_Part.md)
- 📖 [012 Data Pipelines Overview](./01.Architecture_and_Design_Patterns/012_Data_Pipelines_Overview.md)
- ... *và 113 bài học khác trong thư mục [01.Architecture_and_Design_Patterns](./01.Architecture_and_Design_Patterns/)*

---

### 📘 [Giao Thức Truyền Thông & Thiết Kế API (Protocols & API Design)](./02.Communication_Protocols_and_API_Design/)
> 💡 **Tóm tắt**: HTTP/1.1 vs HTTP/2 vs HTTP/3 (QUIC), REST API vs GraphQL vs gRPC vs WebSocket vs Webhooks, TCP 3-Way Handshake, UDP vs TCP, OSI 7 Layers, Long Polling vs SSE.

📂 **Tổng số bài học**: `22 bài học Markdown`

- 📖 [007 Top 4 Most Popular Use](./02.Communication_Protocols_and_API_Design/007_Top_4_Most_Popular_Use.md)
- 📖 [010 REST API Cheatsheet](./02.Communication_Protocols_and_API_Design/010_REST_API_Cheatsheet.md)
- 📖 [016 REST API Vs GraphQL](./02.Communication_Protocols_and_API_Design/016_REST_API_Vs_GraphQL.md)
- 📖 [023 HTTP Cookies Explained With Simple](./02.Communication_Protocols_and_API_Design/023_HTTP_Cookies_Explained_With_Simple.md)
- 📖 [028 does REST API work](./02.Communication_Protocols_and_API_Design/028_does_REST_API_work.md)
- ... *và 17 bài học khác trong thư mục [02.Communication_Protocols_and_API_Design](./02.Communication_Protocols_and_API_Design/)*

---

### 📘 [Cơ Sở Dữ Liệu, Lưu Trữ & Đánh Chỉ Mục (Database, Storage & Indexing)](./03.Database_Storage_and_Indexing/)
> 💡 **Tóm tắt**: SQL vs NoSQL, DB Indexing (B-Tree, B+ Tree, LSM Tree), Database Sharding & Partitioning, Replication (Master-Slave, Master-Master), ACID vs BASE, CAP & PACELC Theorem, 2PC.

📂 **Tổng số bài học**: `21 bài học Markdown`

- 📖 [018 Top 6 Firewall Use Cases](./03.Database_Storage_and_Indexing/018_Top_6_Firewall_Use_Cases.md)
- 📖 [027 Visualizing SQL query](./03.Database_Storage_and_Indexing/027_Visualizing_SQL_query.md)
- 📖 [030 Git Merge vs Rebase vsSquash](./03.Database_Storage_and_Indexing/030_Git_Merge_vs_Rebase_vsSquash.md)
- 📖 [034 Understanding Database Types](./03.Database_Storage_and_Indexing/034_Understanding_Database_Types.md)
- 📖 [046 best way to learn SQL](./03.Database_Storage_and_Indexing/046_best_way_to_learn_SQL.md)
- ... *và 16 bài học khác trong thư mục [03.Database_Storage_and_Indexing](./03.Database_Storage_and_Indexing/)*

---

### 📘 [Bộ Bộ Nhớ Đệm Cache, CDN & Tối Ưu Hiệu Năng (Caching & CDN)](./04.Caching_CDN_and_Performance/)
> 💡 **Tóm tắt**: Cache Strategies (Read-Through, Write-Through, Write-Back, Cache-Aside), Cache Eviction Policies (LRU, LFU), Cache Stampede/Penetration/Breakdown, Redis, Memcached, CDN.

📂 **Tổng số bài học**: `7 bài học Markdown`

- 📖 [003 can Cache Systems go wrong](./04.Caching_CDN_and_Performance/003_can_Cache_Systems_go_wrong.md)
- 📖 [009 can Cache Systems go wrong](./04.Caching_CDN_and_Performance/009_can_Cache_Systems_go_wrong.md)
- 📖 [044 Where cache data](./04.Caching_CDN_and_Performance/044_Where_cache_data.md)
- 📖 [095 does Redis architecture evolve](./04.Caching_CDN_and_Performance/095_does_Redis_architecture_evolve.md)
- 📖 [120 Top 8 Cache Eviction Strategies](./04.Caching_CDN_and_Performance/120_Top_8_Cache_Eviction_Strategies.md)
- ... *và 2 bài học khác trong thư mục [04.Caching_CDN_and_Performance](./04.Caching_CDN_and_Performance/)*

---

### 📘 [Hàng Đợi Tin Nhắn & Kiến Trúc Hướng Sự Kiện (Messaging & Event-Driven)](./05.Messaging_Queues_and_Event_Driven/)
> 💡 **Tóm tắt**: Message Queues (Kafka, RabbitMQ, SQS), Pub/Sub Pattern, Kafka Architecture (Brokers, Partitions, Offset, Consumer Groups), Idempotency, Exactly-Once Delivery, DLQ.

📂 **Tổng số bài học**: `5 bài học Markdown`

- 📖 [102 Can Kafka Lose Messages](./05.Messaging_Queues_and_Event_Driven/102_Can_Kafka_Lose_Messages.md)
- 📖 [105 Top 5 Kafka use cases](./05.Messaging_Queues_and_Event_Driven/105_Top_5_Kafka_use_cases.md)
- 📖 [143 Kafka fast](./05.Messaging_Queues_and_Event_Driven/143_Kafka_fast.md)
- 📖 [163 Top 6 Cases to Apply](./05.Messaging_Queues_and_Event_Driven/163_Top_6_Cases_to_Apply.md)
- 📖 [196 Ultimate Kafka 101 Cannot Miss](./05.Messaging_Queues_and_Event_Driven/196_Ultimate_Kafka_101_Cannot_Miss.md)

---

### 📘 [Bảo Mật Hệ Thống, Xác Thực & Giới Hạn Tần Suất (Security & Rate Limiting)](./06.Security_Authentication_and_Rate_Limiting/)
> 💡 **Tóm tắt**: Authentication vs Authorization, OAuth 2.0 & OpenID Connect, JWT, HTTPS & SSL/TLS Handshake, Encryption (Symmetric/Asymmetric), Hashing & Salt, Rate Limiting Algorithms (Token/Leaky Bucket, Sliding Window).

📂 **Tổng số bài học**: `7 bài học Markdown`

- 📖 [035 Cloud Security Cheat Sheet](./06.Security_Authentication_and_Rate_Limiting/035_Cloud_Security_Cheat_Sheet.md)
- 📖 [051 Session Cookie JWT Token SSO](./06.Security_Authentication_and_Rate_Limiting/051_Session_Cookie_JWT_Token_SSO.md)
- 📖 [069 Oauth 20 Explained With Simple](./06.Security_Authentication_and_Rate_Limiting/069_Oauth_20_Explained_With_Simple.md)
- 📖 [100 Roadmap for Learning Cyber Security](./06.Security_Authentication_and_Rate_Limiting/100_Roadmap_for_Learning_Cyber_Security.md)
- 📖 [154 Explaining JSON Web Token JWT](./06.Security_Authentication_and_Rate_Limiting/154_Explaining_JSON_Web_Token_JWT.md)
- ... *và 2 bài học khác trong thư mục [06.Security_Authentication_and_Rate_Limiting](./06.Security_Authentication_and_Rate_Limiting/)*

---

### 📘 [Độ Tin Cậy, DevOps & Giám Sát Observability (Reliability & Observability)](./07.Reliability_DevOps_and_Observability/)
> 💡 **Tóm tắt**: High Availability & Fault Tolerance, Disaster Recovery (RTO/RPO), SLA/SLO/SLI, Circuit Breaker, Retry & Exponential Backoff, Distributed Tracing (OpenTelemetry), Logging & Metrics (Prometheus, ELK).

📂 **Tổng số bài học**: `13 bài học Markdown`

- 📖 [004 Linux file system explained](./07.Reliability_DevOps_and_Observability/004_Linux_file_system_explained.md)
- 📖 [015 nice cheat sheet of different](./07.Reliability_DevOps_and_Observability/015_nice_cheat_sheet_of_different.md)
- 📖 [019 Types of memory Which ones](./07.Reliability_DevOps_and_Observability/019_Types_of_memory_Which_ones.md)
- 📖 [026 Cloud Disaster Recovery Strategies](./07.Reliability_DevOps_and_Observability/026_Cloud_Disaster_Recovery_Strategies.md)
- 📖 [045 Flowchart of slack decides to](./07.Reliability_DevOps_and_Observability/045_Flowchart_of_slack_decides_to.md)
- ... *và 8 bài học khác trong thư mục [07.Reliability_DevOps_and_Observability](./07.Reliability_DevOps_and_Observability/)*

---

### 📘 [Case Studies Thiết Kế Hệ Thống Thực Tế (Real-World System Designs)](./08.Real_World_System_Designs_Case_Studies/)
> 💡 **Tóm tắt**: How Git Works, Push Notification System, ChatGPT / LLM Inference System, URL Shortener, Payment System (Stripe), WhatsApp Chat App, Netflix Video Streaming, Search Engine.

📂 **Tổng số bài học**: `19 bài học Markdown`

- 📖 [006 Git Commands work](./08.Real_World_System_Designs_Case_Studies/006_Git_Commands_work.md)
- 📖 [008 Does Typical Push Notification System](./08.Real_World_System_Designs_Case_Studies/008_Does_Typical_Push_Notification_System.md)
- 📖 [014 handy cheat sheet for most](./08.Real_World_System_Designs_Case_Studies/014_handy_cheat_sheet_for_most.md)
- 📖 [022 does Git work](./08.Real_World_System_Designs_Case_Studies/022_does_Git_work.md)
- 📖 [024 does ChatGPTlike system work](./08.Real_World_System_Designs_Case_Studies/024_does_ChatGPTlike_system_work.md)
- ... *và 14 bài học khác trong thư mục [08.Real_World_System_Designs_Case_Studies](./08.Real_World_System_Designs_Case_Studies/)*

---

