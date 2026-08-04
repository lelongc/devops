# 🐍 Lộ Trình Python Cho DevOps Chuyên Sâu Toàn Tập (Python for DevOps & Automation Master Roadmap)

Bộ giáo trình được thiết kế chuyên biệt và đầy đủ nhất dành cho **Kỹ sư DevOps**, **SRE (Site Reliability Engineer)**, **Cloud/SecOps Automation Engineer** và **Người mới bắt đầu** muốn thành thạo Python từ căn bản đến trình độ Senior để tự động hóa 100% mọi tác vụ hạ tầng thực tế.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 25 Module Python cho DevOps tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất lập trình trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Bản Sắc Hệ Thống (Under The Hood Architecture)**: Phân tích sơ đồ Mermaid, Python Execution Flow, PVM Memory Management, Data Structures & Concurrency Mechanics.
3. **⚡ Bảng Tra Cứu Khái Niệm & Hàm / Thư Viện Thực Hành (Reference Table)**: Bảng tham chiếu các module, hàm, tham số kèm giải thích bản chất.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản DevOps Automation**: Đoạn code gõ ăn ngay (`boto3`, `kubernetes`, `psutil`, `requests`, `asyncio`, `fastapi`) + Kịch bản tự động hóa hạ tầng thực tế.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Python Thực Tế (Middle-Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng vị trí Middle-Senior DevOps kèm câu trả lời chuẩn mực.
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 25 Bài Học Python Cho DevOps Toàn Tập

### 📘 PHẦN 1: NỀN TẢNG PYTHON CƠ BẢN & NÂNG CAO (BÀI 01 - 09)
- 📖 [**Bài 01: Python Setup, Interpreter & Virtual Environments**](./01.Python_Setup_Interpreter_and_Environment/README.md) - CPython Architecture, PVM, Memory Management (Reference Counting & GC), venv, pip, pyproject.toml & PEP8.
- 📖 [**Bài 02: Variables, Data Types & Operators**](./02.Variables_Data_Types_and_Operators/README.md) - Dynamic Typing, Mutability vs Immutability, String operations, Slicing `[start:stop:step]`, Memory IDs (`id()`), Bitwise & Logical operators.
- 📖 [**Bài 03: Control Flow, Loops & Exception Handling**](./03.Control_Flow_Loops_and_Error_Handling/README.md) - `if/elif/else`, `for`, `while`, `try/except/else/finally`, Custom Exceptions, `raise` và `traceback` logging.
- 📖 [**Bài 04: Functions, Closures, Decorators & Generators**](./04.Functions_Lambda_Decorators_and_Generators/README.md) - Scope LEGB, Higher-order functions, Closures, Decorators (`@functools.wraps`), Generators (`yield`) & Iterators.
- 📖 [**Bài 05: Object-Oriented Programming (OOP)**](./05.Object_Oriented_Programming_OOP/README.md) - Classes, Objects, 4 trụ cột OOP, Dunder Magic Methods (`__init__`, `__str__`, `__repr__`, `__call__`), `@classmethod`, `@staticmethod` & Abstract Base Classes (`abc.ABC`).
- 📖 [**Bài 06: Context Managers & Resource Management**](./06.Context_Managers_and_Resource_Management/README.md) - Quản lý tài nguyên với `with`, Dunder `__enter__` / `__exit__`, `contextlib` (`@contextmanager`), chống rò rỉ File Handles, Sockets & DB locks.
- 📖 [**Bài 07: Built-in Data Structures Deep Dive**](./07.Builtin_Data_Structures_Deep_Dive/README.md) - Lists ($O(1)$ amortized append), Tuples, Dictionaries (Hash tables $O(1)$), Sets ($O(1)$ deduplication), List/Dict Comprehensions, Slicing & Sorting.
- 📖 [**Bài 08: Advanced Data Structures Collections & Dataclasses**](./08.Advanced_Data_Structures_Collections/README.md) - `collections` (`defaultdict`, `Counter`, `deque` sliding window log), `heapq` priority queue & `@dataclass` Struct.
- 📖 [**Bài 09: File I/O, UTF-8 Encoding & Pathlib**](./09.File_IO_and_Path_Management/README.md) - `open()` modes (`r`, `w`, `a`, `b`), Encoding UTF-8, `pathlib.Path` Object, file tạm `tempfile` & file locking `fcntl.flock`.

---

### 📙 PHẦN 2: LẬP TRÌNH MẠNG, API & CLI TOOLS (BÀI 10 - 17)
- 📖 [**Bài 10: OS Integration, Subprocess & Signals**](./10.OS_Integration_and_Subprocess/README.md) - `os`, `sys`, `shutil`, `glob`, `subprocess.run` vs `subprocess.Popen` stream output realtime, Graceful Shutdown với `signal` (`SIGTERM`/`SIGINT`).
- 📖 [**Bài 11: Regular Expressions & Log Parsing**](./11.Regular_Expressions_and_Log_Parsing/README.md) - Module `re` (`compile`, `search`, `findall`, `finditer`, `sub`), Named Groups `(?P<name>...)`, Quantifiers & Log Parsing Nginx/Syslog.
- 📖 [**Bài 12: Data Formats Parsing (JSON, YAML, CSV, TOML)**](./12.Data_Formats_JSON_YAML_CSV_TOML/README.md) - `json` (Custom JSONEncoder), `yaml` (`PyYAML` vs `ruamel.yaml` giữ comment), `csv` (`DictReader`/`DictWriter`) & `tomllib`.
- 📖 [**Bài 13: Network Programming & Sockets**](./13.Network_Programming_Sockets/README.md) - Socket TCP/UDP (`socket.socket`, `bind`, `listen`, `accept`, `connect_ex`), IP Subnetting với `ipaddress`, Socket Timeouts & Non-blocking.
- 📖 [**Bài 14: SSH & SFTP Automation (Paramiko)**](./14.SSH_Automation_Paramiko_Netmiko/README.md) - Tự động hóa SSH & SFTP với `paramiko` SDK (`SSHClient`, `AutoAddPolicy`, `exec_command`, `open_sftp`), nạp RSA Key & chạy lệnh remote song song.
- 📖 [**Bài 15: HTTP Clients & REST APIs (Requests)**](./15.HTTP_Clients_REST_APIs_Requests/README.md) - `requests.Session()` Keep-Alive, Auto-Retry với `urllib3`, Headers Authorization Bearer Token, Timeouts & `raise_for_status()`.
- 📖 [**Bài 16: Building CLI Tools (Click & Rich)**](./16.Building_CLI_Tools_Click_Rich/README.md) - Framework `click` (`@click.group`, `@click.option`), định dạng màu sắc & bảng dữ liệu với `rich` (Table, Progress bar) & đóng gói `setup.py`.
- 📖 [**Bài 17: System Metrics Monitoring & Psutil**](./17.System_Metrics_Monitoring_Psutil/README.md) - Thu thập CPU, RAM, Disk, Net với `psutil`, xuất Prometheus Exporter (`prometheus_client` Gauges/Counters) & Alerting Telegram/Slack.

---

### 📕 PHẦN 3: CLOUD, KUBERNETES & GITOPS AUTOMATION (BÀI 18 - 22)
- 📖 [**Bài 18: Cloud Automation with Boto3 AWS (EC2 & S3)**](./18.Cloud_Automation_Boto3_AWS_EC2_S3/README.md) - AWS Boto3 SDK (`client` vs `resource`), quản lý EC2 (start, stop, terminate, tag, filter), S3 Buckets & Objects, Presigned URLs.
- 📖 [**Bài 19: Boto3 Advanced: Paginators, Waiters & Lambda**](./19.Cloud_Automation_Boto3_AWS_Advanced/README.md) - Boto3 Paginators (`get_paginator`), Waiters (`get_waiter`), DynamoDB, CloudWatch query & AWS Lambda Python Handler.
- 📖 [**Bài 20: Container Automation with Docker SDK**](./20.Container_Automation_Docker_SDK/README.md) - Docker SDK (`docker.from_env()`), Containers (run, stop, exec_run, logs), Images (build, pull, push), Volumes & Prune.
- 📖 [**Bài 21: Kubernetes Automation with Python Client**](./21.Kubernetes_Automation_Python_Client/README.md) - K8s Python SDK, `config.load_kube_config()` vs `load_incluster_config()`, `CoreV1Api` (Pods/Services), `AppsV1Api` (Deployments), Watch Events.
- 📖 [**Bài 22: Git Automation & GitOps Workflow**](./22.Git_Automation_and_GitOps/README.md) - `GitPython` SDK (`git.Repo()`, clone, checkout, commit, push, diff), GitOps Single Source of Truth, Semantic Versioning (`semver`), GitHub/GitLab API.

---

### 📗 PHẦN 4: CODE QUALITY, ASYNC & MICROSERVICES (BÀI 23 - 25)
- 📖 [**Bài 23: Testing, Mocking & Code Quality**](./23.Testing_Mocking_and_Code_Quality/README.md) - Unit Testing với `pytest` (fixtures, parametrize, assert), API Mocking với `unittest.mock.patch`, static type check `mypy`, format `black` & `pre-commit`.
- 📖 [**Bài 24: Async Programming Asyncio & Concurrency**](./24.Async_Programming_Asyncio_Aiohttp/README.md) - Multithreading (`ThreadPoolExecutor`), Multiprocessing (Bypass GIL), `asyncio` Event Loop (`async/await`, `asyncio.gather()`), `aiohttp` async HTTP client.
- 📖 [**Bài 25: Web Microservices with FastAPI & Pydantic**](./25.Web_Microservices_FastAPI_Pydantic/README.md) - FastAPI Web Framework, Pydantic Data Models (`BaseModel`), CORS, `BackgroundTasks`, Uvicorn ASGI Server & Dockerizing Python Microservice.
