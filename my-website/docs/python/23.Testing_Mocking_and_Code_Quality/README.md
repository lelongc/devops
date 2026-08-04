# 🐍 23.Testing_Mocking_and_Code_Quality: Kiểm Thử Code Automation Với Pytest, Mocking & Code Quality - Giáo Trình Python DevOps Chuyên Sâu Cực Chi Tiết

> 💡 **Bản chất 1 câu**: Kiểm thử & đảm bảo chất lượng code Python cho DevOps: `pytest` framework (fixtures, parametrize, assertions), `unittest.mock` (`@patch`), Static Type Checking (`mypy`), Code formatting (`black`, `flake8`, `isort`) và `pre-commit` hooks.  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững `pytest` fixtures, `@patch` mocking AWS Boto3/HTTP calls, Type Annotations, và tự động hóa linting với `pre-commit`.

---

```mermaid
graph TD
    Pytest[Pytest Runner] -->|@patch boto3.client| MockAWS[Mock AWS Service]
    MockAWS -->|Assert Success| Pytest
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 Kiến Trúc Pytest Fixtures & API Mocking (OBJ 23.1)

```mermaid
graph TD
    PytestRunner[Pytest Test Runner] -->|Execute Test Cases| TestSuite[test_infra_script.py]
    TestSuite -->|@patch boto3.client| MockAWS[Mock AWS Service API]
    TestSuite -->|Call Function Under Test| DevOpsCode[devops_script.py]
    DevOpsCode -->|Call Mocked Method| MockAWS
    MockAWS -->|Return Fake Response & Assert| PytestRunner
```

1. **`pytest` Fixtures (`@pytest.fixture`)**: Cung cấp dữ liệu mẫu hoặc trạng thái khởi tạo sẵn cho các hàm testcase, giúp tái sử dụng code linh hoạt.
2. **`unittest.mock.patch`**: Giả lập (Mock) các hàm gọi API bên ngoài (như Boto3, Requests, Sockets) để test script chạy nhanh và KHÔNG làm ảnh hưởng hạ tầng thật.
3. **`mypy` Static Type Checker**: Phân tích tĩnh phát hiện các lỗi sai kiểu dữ liệu trước khi chạy code.


---

## 3. ⚡ Bảng Tra Cứu Khái Niệm & Hàm / Thư Viện Thực Hành (Reference Table)

| Công cụ / Hàm / Thư viện | Tham số / Module | Ý nghĩa chi tiết bản chất | Ứng dụng thực tế DevOps |
| :--- | :--- | :--- | :--- |
| **`pytest`** | `Testing Framework` | Framework viết và chạy unit test cực tiện lợi | `pytest tests/` |
| **`@pytest.fixture`** | `Pytest Decorator` | Tạo dữ liệu/trạng thái dùng chung cho nhiều test cases | `@pytest.fixture def sample_data():` |
| **`unittest.mock.patch`** | `Built-in Module` | Giả lập hàm/API bên ngoài khi chạy test | `@patch('boto3.client')` |
| **`mypy`** | `Static Analysis` | Kiểm tra lỗi kiểu dữ liệu Type Annotations | `mypy script.py` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps Automation (Real-World Production Scripts)

### 🛠 Các đoạn Script Python thực hành chuyên sâu gõ là ăn ngay:
```python
import pytest
from unittest.mock import patch

def get_ec2_state(instance_id: str) -> str:
    # Hàm giả định gọi Boto3 thật:
    return "running"

# Viết Unit Test với Pytest & Mocking:
@patch('__main__.get_ec2_state')
def test_ec2_state_running(mock_get_state):
    # Cấu hình giá trị giả lập trả về:
    mock_get_state.return_value = "running"
    
    state = get_ec2_state("i-1234567890abcdef0")
    assert state == "running"
    mock_get_state.assert_called_once_with("i-1234567890abcdef0")

```

### 🚀 Kịch bản tự động hóa thực tế khi đi làm (Production DevOps Incident Playbook):
Cấu hình Pre-commit hooks tự động chạy `black`, `flake8`, `mypy` và `pytest` mỗi khi kỹ sư gõ `git commit`, ngăn chặn tuyệt đối việc đẩy code lỗi lên Git.

---

## 5. 🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Python Thực Tế (Middle-Senior Interview Q&A)

> **Q: Tại sao bắt buộc phải dùng Mocking (`unittest.mock`) khi viết Unit Test cho các script tự động hóa hạ tầng?**  
> **A**: Vì nếu không Mocking, Unit Test sẽ gọi trực tiếp ra các dịch vụ thật (như xóa S3 bucket thật, ngắt máy chủ EC2 thật), gây nguy hiểm cho Production và làm test chạy rất chậm.

> **Q: Tác dụng của `@pytest.fixture` trong `pytest` là gì?**  
> **A**: Giúp khởi tạo dữ liệu mẫu, kết nối DB giả lập hoặc thiết lập môi trường test dùng chung cho nhiều test case khác nhau, tránh lặp lại code khởi tạo.



---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] pytest: Framework testing với assert
- [x] unittest.mock.patch: Giả lập API bên ngoài khi test
- [x] mypy: Kiểm tra Static Type Annotations
- [x] pre-commit: Hook tự động format & check code

