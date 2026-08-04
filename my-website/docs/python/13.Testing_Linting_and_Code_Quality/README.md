# 🐍 13.Testing_Linting_and_Code_Quality: Kiểm Thử Code Pytest, Mocking & Code Quality - Python Chuyên Sâu Cho DevOps

> 💡 **Bản chất 1 câu**: Kiểm thử và đảm bảo chất lượng Code Python cho DevOps: `pytest` framework, `unittest.mock` (Mocking AWS Boto3 / HTTP requests), `flake8`, `black` formatter, `mypy` type hinting và `pre-commit` hooks.  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững `pytest` fixtures, `@patch` mocking, test kiềm tra script automation mà KHÔNG làm ảnh hưởng tới hạ tầng thật, Type Annotations (`def func(x: int) -> str:`).

---

```mermaid
graph TD
    Pytest[Pytest Runner] -->|@patch boto3.client| MockAWS[Mock AWS Service]
    MockAWS -->|Assert Success| Pytest
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Sắc Hệ Thống (Under The Hood Architecture)

### 2.1 Kiến Trúc Kiểm Thử Pytest & Mocking Với Unittest.mock (OBJ 13.1)

```mermaid
graph TD
    PytestRunner[Pytest Test Runner] -->|Execute Test Cases| TestFile[test_aws_automation.py]
    TestFile -->|@patch boto3.client| MockAWS[Mock AWS API Service - Fake Response]
    TestFile -->|Call Code Under Test| DevOpsCode[devops_script.py]
    DevOpsCode -->|Interacts with| MockAWS
    MockAWS -->|Assert Success| PytestRunner
```

1. **`pytest`**: Framework testing hiện đại, viết test case đơn giản bằng câu lệnh `assert`.
2. **`unittest.mock.patch`**: Giả lập (Mock) các hàm gọi API bên ngoài (như Boto3, Requests) để test script chạy nhanh và KHÔNG gọi thật ra bên ngoài làm hỏng hạ tầng.
3. **`mypy` Static Type Checker**: Kiểm tra lỗi kiểu dữ liệu (Type hinting) trước khi chạy.


---

## 3. ⚡ Bảng Tra Cứu Khái Niệm & Hàm / Thư Viện Thực Hành (Reference Table)

| Công cụ / Hàm / Thư viện | Tham số / Module | Ý nghĩa bản chất | Ứng dụng thực tế DevOps |
| :--- | :--- | :--- | :--- |
| **`pytest`** | `Testing Framework` | Framework viết và chạy unit test cực tiện lợi | `pytest tests/` |
| **`unittest.mock.patch`** | `Built-in Module` | Giả lập hàm/API bên ngoài khi chạy test | `@patch('boto3.client')` |
| **`mypy`** | `Static Analysis` | Kiểm tra lỗi kiểu dữ liệu Type Annotations | `mypy script.py` |
| **`black`** | `Code Formatter` | Tự động định dạng code Python chuẩn PEP8 | `black .` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps Automation (Real-World Scenarios)

### 🛠 Các đoạn Script Python thực hành gõ là ăn ngay:
```python
import pytest
from unittest.mock import patch

def get_server_status(host: str) -> str:
    # Hàm giả định gọi API thật:
    return "HEALTHY"

# Viết Test Case với Pytest & Mocking:
@patch('__main__.get_server_status')
def test_server_status_healthy(mock_status):
    mock_status.return_value = "HEALTHY"
    
    status = get_server_status("10.0.0.1")
    assert status == "HEALTHY"
    mock_status.assert_called_once_with("10.0.0.1")

```

### 🚀 Kịch bản tự động hóa thực tế khi đi làm (Production DevOps Scripting):
Cấu hình Pre-commit hooks tự động chạy `black`, `flake8` và `pytest` mỗi khi kỹ sư gõ `git commit`, ngăn chặn đẩy code lỗi lên Git.

---

## 5. 🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Python Thực Tế (Interview Q&A)

> **Q: Tại sao bắt buộc phải dùng Mocking (`unittest.mock`) khi viết Unit Test cho các script tự động hóa hạ tầng?**  
> **A**: Vì nếu không Mocking, Unit Test sẽ gọi trực tiếp ra các dịch vụ thật (như xóa S3 bucket thật, ngắt máy chủ thật), gây nguy hiểm cho Production và làm test chạy rất chậm.

> **Q: Tác dụng của Type Hinting (Type Annotations) trong Python là gì?**  
> **A**: Giúp code minh bạch dễ đọc, hỗ trợ IDE autocomplete chuẩn xác và cho phép các công cụ như `mypy` phát hiện sớm các lỗi sai kiểu dữ liệu trước khi chạy code.



---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] pytest: Framework testing với assert
- [x] unittest.mock.patch: Giả lập API bên ngoài khi test
- [x] mypy: Kiểm tra Static Type Annotations
- [x] pre-commit: Hook tự động format & check code

