# 🐍 06.Context_Managers_and_Resource_Management: Context Managers (`with`) & Quản Lý Tài Nguyên An Toàn - Giáo Trình Python DevOps Chuyên Sâu Cực Chi Tiết

> 💡 **Bản chất 1 câu**: Quản lý tài nguyên hệ thống an toàn chống rò rỉ: Câu lệnh `with`, Dunder methods `__enter__` & `__exit__`, module `contextlib` (`@contextmanager`), giải phóng File Handles, Sockets & DB locks.  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững cơ chế `with`, tự tạo Custom Context Manager bằng Class hoặc Decorator `@contextmanager`, xử lý giải phóng tài nguyên khi có sập lỗi Exception.

---

```mermaid
graph TD
    WithStmt[with Resource() as r:] --> Enter[__enter__: Open & Alloc]
    Enter --> Exec[Code Block Execution]
    Exec --> Exit[__exit__: Always Release & Close]
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 Cơ Chế Hoạt Động Của Khối With & Context Manager Methods (OBJ 6.1)

```mermaid
graph TD
    WithStmt[with MyContextManager() as resource:] --> Enter[1. Gọi __enter__: Khởi tạo tài nguyên & Mở kết nối]
    Enter --> Execute[2. Thực thi khối code bên trong with]
    Execute --> ErrorCheck{Có nổ Exception lỗi không?}
    ErrorCheck -->|Không hoặc Có| Exit[3. Gọi __exit__: BẮT BUỘC ĐÓNG tài nguyên & Dọn dẹp]
```

1. **Hàm `__enter__(self)`**: Thực thi trước khi vào khối `with`. Giá trị trả về từ `__enter__` được gán vào biến đằng sau từ khóa `as`.
2. **Hàm `__exit__(self, exc_type, exc_val, exc_tb)`**: Tự động kích hoạt khi thoát khỏi khối `with` (kể cả khi bị nổ lỗi Exception). Nếu `__exit__` trả về `True`, Exception sẽ bị dập tắt không giật ra ngoài.
3. **`contextlib.contextmanager`**: Decorator cho phép tạo Context Manager cực gọn bằng cú pháp `yield`.


---

## 3. ⚡ Bảng Tra Cứu Khái Niệm & Hàm / Thư Viện Thực Hành (Reference Table)

| Công cụ / Hàm / Thư viện | Tham số / Module | Ý nghĩa chi tiết bản chất | Ứng dụng thực tế DevOps |
| :--- | :--- | :--- | :--- |
| **`with`** | `Syntax` | Câu lệnh quản lý ngữ cảnh tài nguyên tự động dọn dẹp | `with open('file.txt') as f:` |
| **`__enter__`** | `Dunder Method` | Khởi tạo tài nguyên trước khi vào khối with | `def __enter__(self):` |
| **`__exit__`** | `Dunder Method` | Dọn dẹp giải phóng tài nguyên khi thoát khối with | `def __exit__(self, exc_type, exc_val, exc_tb):` |
| **`@contextmanager`** | `Contextlib Tool` | Tạo Context Manager bằng hàm generator yield | `@contextmanager def my_resource():` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps Automation (Real-World Production Scripts)

### 🛠 Các đoạn Script Python thực hành chuyên sâu gõ là ăn ngay:
```python
import time
from contextlib import contextmanager

# Custom Context Manager bằng Class:
class DirectoryChanger:
    def __init__(self, target_dir):
        self.target_dir = target_dir
        self.old_dir = None

    def __enter__(self):
        import os
        self.old_dir = os.getcwd()
        os.chdir(self.target_dir)
        print(f"[CD] Moved to: {self.target_dir}")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        import os
        os.chdir(self.old_dir)
        print(f"[CD] Restored original dir: {self.old_dir}")

# Custom Context Manager bằng Decorator @contextmanager:
@contextmanager
def timer(label):
    start = time.time()
    try:
        yield
    finally:
        print(f"[TIMER] {label}: {time.time() - start:.4f}s")

# Sử dụng:
with timer("Backup Execution"):
    with DirectoryChanger("/tmp"):
        time.sleep(0.5)

```

### 🚀 Kịch bản tự động hóa thực tế khi đi làm (Production DevOps Incident Playbook):
Viết Context Manager tự động khóa (Lock) file cấu hình shared trong khi ghi dữ liệu và tự động gỡ Lock để tránh xung đột giữa nhiều tiến trình DevOps.

---

## 5. 🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Python Thực Tế (Middle-Senior Interview Q&A)

> **Q: Điều gì xảy ra nếu hàm `__exit__` trong Custom Context Manager trả về giá trị `True`?**  
> **A**: Nếu `__exit__` trả về `True`, Exception xảy ra bên trong khối `with` sẽ bị dập tắt hoàn toàn (suppressed) và script tiếp tục chạy bình thường mà không bị ngắt.

> **Q: Ưu điểm của việc dùng `@contextmanager` từ module `contextlib` là gì?**  
> **A**: Giúp viết Context Manager ngắn gọn chỉ bằng một hàm chứa câu lệnh `yield` nằm trong khối `try...finally` thay vì phải định nghĩa nguyên một Class với hai hàm `__enter__` và `__exit__`.



---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] with: Quản lý tài nguyên an toàn tự động dọn dẹp
- [x] __enter__: Khởi tạo tài nguyên
- [x] __exit__: Dọn dẹp tài nguyên kể cả khi nổ lỗi
- [x] @contextmanager: Viết context manager bằng yield

