# 🐳 Lộ Trình Docker Cho DevOps Chuyên Sâu Toàn Tập (Docker for DevOps Master Roadmap)

Bộ giáo trình được thiết kế chuyên biệt và đầy đủ nhất dành cho **Kỹ sư DevOps**, **SRE (Site Reliability Engineer)**, **Cloud Engineer** và **Người mới bắt đầu** muốn thành thạo công nghệ Containerization Docker từ căn bản đến trình độ Senior để tự động hóa 100% việc đóng gói và vận hành ứng dụng chuẩn Cloud Native.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 20 Module Docker tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất công nghệ Container trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Sơ Đồ Kiến Trúc (Under The Hood Architecture)**: Phân tích Linux Kernel Namespaces, cgroups v1/v2, OverlayFS, Layer Caching & Sơ đồ Mermaid / Đồ họa trực quan.
3. **⚡ Bảng Tra Cứu Khái Niệm, Câu Lệnh & Tham Số (Reference Table)**: Bảng tham chiếu các câu lệnh Docker CLI, tham số cgroups, volume drivers kèm giải thích bản chất.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản Triển Khai Container (Production Playbook)**: Đoạn code Dockerfile, `docker-compose.yml`, K8s YAML gõ ăn ngay + Incident Response Playbook xử lý sự cố OOM Killed, Connection Timeout thực tế.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Docker Thực Tế (Middle-Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng vị trí Middle-Senior DevOps đào sâu bản chất công nghệ.
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 20 Bài Học Docker Cho DevOps Toàn Tập

### 📘 PHẦN 1: NỀN TẢNG CONTAINER & DOCKER ENGINE (BÀI 01 - 05)
- 📖 [**Bài 01: Kiến Trúc Docker Engine, Kernel Namespaces & Cgroups**](./01.Docker_Architecture_and_Kernel_Namespaces/README.md) - Linux Kernel Namespaces (PID, NET, MNT, IPC, UTS, USER), Control Groups (cgroups v1/v2), OverlayFS, CoW, Docker Daemon, Containerd & runC.
- 📖 [**Bài 02: Thành Thạo Docker CLI & Vòng Đời Container**](./02.Docker_CLI_Fundamentals_and_Container_Lifecycle/README.md) - `docker run`, `exec`, `stop`, `start`, `restart`, `rm`, `logs`, `inspect`, `stats`, `commit` & Vòng đời 5 trạng thái (Created, Running, Paused, Stopped, Dead).
- 📖 [**Bài 03: Quản Lý Docker Images, Layers & Cơ Chế Layer Caching**](./03.Image_Management_and_Layer_Caching/README.md) - Cấu trúc Docker Image, Image Layers bất biến (Read-Only Layers), Manifests, Layer Caching khi Build, `docker history`, Docker Hub & Enterprise Registries.
- 📖 [**Bài 04: Lưu Trữ Trong Docker - Named Volumes, Bind Mounts & Tmpfs**](./04.Storage_Volumes_and_Bind_Mounts/README.md) - Quản lý dữ liệu bền vững (Data Persistence): Named Volumes, Bind Mounts, `tmpfs` in-memory mount & Kịch bản chọn lưu trữ cho Database vs Dev Code.
- 📖 [**Bài 05: Phân Tích Chuyên Sâu Mạng Trong Docker (Bridge, Host, Overlay & Macvlan)**](./05.Docker_Networking_Deep_Dive/README.md) - Bridge Driver (Default docker0), Host Driver, None Driver, Overlay Driver (Swarm), Macvlan Driver, DNS Resolution nội bộ Container & Port Mapping iptables.

---

### 📙 PHẦN 2: DOCKERFILE MASTERCLASS & MULTI-STAGE BUILDS (BÀI 06 - 10)
- 📖 [**Bài 06: Thành Thạo Chỉ Thị Dockerfile (FROM, RUN, CMD vs ENTRYPOINT)**](./06.Dockerfile_Directives_Mastery/README.md) - Cú pháp Dockerfile chuẩn mực: `FROM`, `RUN`, `CMD` vs `ENTRYPOINT` (Exec Form vs Shell Form), `COPY` vs `ADD`, `WORKDIR`, `ENV`, `ARG`, `EXPOSE`, `USER`, `VOLUME`.
- 📖 [**Bài 07: Kỹ Thuật Build Đa Tầng Multi-Stage Builds Tối Ưu Size Image Khổng Lồ**](./07.Multi_Stage_Builds_Optimization/README.md) - Tối ưu hóa kích thước Docker Image: Kỹ thuật Multi-Stage Builds, phân tách Build Stage & Runtime Stage, nén size Image từ 1.2GB xuống < 15MB cho Golang, Node.js, Python, Java.
- 📖 [**Bài 08: Bảo Mật Container & Chuẩn Hóa Dockerfile Best Practices**](./08.Best_Practices_and_Security_Hardening/README.md) - Security Hardening: Chạy với Non-root User (`USER 10001`), loại bỏ Shell rác, `.dockerignore`, Quét lỗ hổng bảo mật (Trivy, Grype, Docker Scout), Chống lọt lộ Secrets.
- 📖 [**Bài 09: Bộ Dockerfile Chẩn Production Cho Python, Node.js, Golang, Java, PHP, .NET**](./09.Language_Specific_Dockerfiles/README.md) - Xây dựng Dockerfile chuẩn Production gõ ăn ngay cho 6 ngôn ngữ phổ biến nhất DevOps: Python (FastAPI), Node.js (NestJS), Golang, Java (Spring Boot), PHP (Laravel), .NET 8.
- 📖 [**Bài 10: Giám Sát Sức Khỏe Container (HEALTHCHECK) & Graceful Shutdown**](./10.Container_Health_Checks_and_Signals/README.md) - Cấu hình chỉ thị `HEALTHCHECK`, Xử lý ngắt tín hiệu `SIGTERM` / `SIGINT` cho ứng dụng thoát an toàn không mất dữ liệu.

---

### 📕 PHẦN 3: DOCKER COMPOSE & MULTI-CONTAINER ORCHESTRATION (BÀI 11 - 15)
- 📖 [**Bài 11: Thành Thạo Docker Compose V2 & Cấu Trúc YAML Multi-Container**](./11.Docker_Compose_Architecture_and_YAML/README.md) - Tổng quan Docker Compose V2: Cấu trúc tệp `docker-compose.yml`, khai báo `services`, `networks`, `volumes`, quản lý biến môi trường `.env` & các lệnh CLI.
- 📖 [**Bài 12: Dựng Môi Trường Development Đa Dịch Vụ Với Docker Compose**](./12.Multi_Container_Dev_Environment/README.md) - Thực hành dựng môi trường Development hoàn chỉnh 5 container: Nginx Reverse Proxy + Web App + Node.js API + PostgreSQL DB + Redis Cache + Adminer.
- 📖 [**Bài 13: Quản Lý Thứ Tự Khởi Động Dịch Vụ Với depends_on & Healthcheck Wait**](./13.Compose_Dependencies_and_Health_Wait/README.md) - Giải quyết bài toán ứng dụng sập do DB chưa khởi động xong: `depends_on` với `condition: service_healthy`, cấu hình Wait-for-it Script & Retry connection pattern.
- 📖 [**Bài 14: Tối Ưu Môi Trường Với Compose Profiles & File Overrides**](./14.Compose_Profiles_and_Overrides/README.md) - Quản lý nhiều môi trường Dev/Staging/Prod: Compose Profiles (`--profile dev`), Kỹ thuật đè file cấu hình `docker-compose.override.yml`, `docker-compose.prod.yml`.
- 📖 [**Bài 15: Cụm Swarm Orchestration & Mở Rộng Dịch Vụ (Scaling Replicas)**](./15.Docker_Swarm_Basics_and_Service_Scaling/README.md) - Tổng quan Docker Swarm Orchestration: Manager Node vs Worker Node, `docker swarm init`, `docker service create`, Mở rộng `replicas`, Rolling Updates, Service Discovery & Overlay Networks.

---

### 📗 PHẦN 4: DEVOPS CI/CD, OBSERVABILITY & PRODUCTION OPS (BÀI 16 - 20)
- 📖 [**Bài 16: Tích Hợp Docker Vào Pipeline CI/CD (GitHub Actions, GitLab CI)**](./16.Docker_in_CICD_Pipelines/README.md) - Tự động hóa Build & Push Image trong CI/CD: Docker Buildx, Multi-architecture builds (`linux/amd64`, `linux/arm64`), Caching Layer CI (`cache-from/to`), Push ECR / Docker Hub.
- 📖 [**Bài 17: Giám Sát Tài Nguyên (CPU/RAM Limits) & Quản Lý Log Container**](./17.Logging_Monitoring_and_Resource_Limits/README.md) - Quản lý log & tài nguyên Container: Logging Drivers (json-file, syslogs, fluentd, loki), Giới hạn tài nguyên RAM/CPU (`--memory`, `--cpus`), cgroup OOM Killer & `docker stats`.
- 📖 [**Bài 18: Kỹ Thuật Điều Tra & Khắc Phục Sự Cố Container In Production**](./18.Debugging_and_Troubleshooting_Containers/README.md) - Troubleshooting Container Production: `docker exec`, `docker logs --tail`, `docker inspect`, `docker diff`, `nsenter` chui vào container namespace, `tcpdump` bắt gói tin & OOM debug.
- 📖 [**Bài 19: Triển Khai Private Registry Riêng Cho Doanh Nghiệp (Harbor)**](./19.Private_Registries_and_Authentication/README.md) - Xây dựng Enterprise Private Registry: Docker Registry V2, Enterprise Harbor Registry, TLS/SSL Certificates, RBAC Access Control, Image Scanning & Garbage Collection.
- 📖 [**Bài 20: Chuẩn Hóa Container Sẵn Sàng Đẩy Lên Kubernetes (K8s Ready)**](./20.Migration_to_Kubernetes_Ready_Containers/README.md) - Chuẩn hóa Container đạt chuẩn Cloud Native / K8s Ready: 12-Factor App methodology, ConfigMaps/Secrets injection, Readiness & Liveness probes alignment, Pod Security Context.
