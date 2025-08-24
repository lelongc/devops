#!/bin/bash

# Dừng script ngay lập tức nếu có bất kỳ lệnh nào thất bại
set -e

echo ">>> Bắt đầu quá trình cài đặt kubectl..."

# --- BƯỚC 1: TẢI VỀ KUBECTL VÀ FILE CHECKSUM ---
echo "--> Đang tải về phiên bản kubectl ổn định mới nhất..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

echo "--> Đang tải về file checksum SHA256..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# --- BƯỚC 2: KIỂM TRA TÍNH TOÀN VẸN CỦA FILE (QUAN TRỌNG) ---
echo "--> Đang xác thực file đã tải về bằng checksum..."
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# Nếu file tải về bị lỗi hoặc không khớp, script sẽ dừng lại ở đây nhờ 'set -e'

# --- BƯỚC 3: CÀI ĐẶT KUBECTL ---
echo "--> Đang cài đặt kubectl vào /usr/local/bin..."
# Lệnh 'install' sẽ copy file, cấp quyền chủ sở hữu (root) và quyền thực thi (0755) trong 1 bước
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# --- BƯỚC 4: DỌN DẸP ---
echo "--> Đang dọn dẹp các file đã tải về..."
rm kubectl kubectl.sha256

# --- BƯỚC 5: KIỂM TRA LẠI ---
echo "--> Đang kiểm tra phiên bản kubectl..."
kubectl version --client

echo ""
echo "✅ CÀI ĐẶT KUBECTL HOÀN TẤT VÀ THÀNH CÔNG!"



---

#!/bin/bash

set -e

echo ">>> Bắt đầu quá trình cài đặt kubectl cho người dùng hiện tại..."

# --- BƯỚC 1 & 2: TẢI VỀ VÀ KIỂM TRA (Tương tự như trên) ---
echo "--> Đang tải về kubectl và checksum..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "--> Đang xác thực file..."
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# --- BƯỚC 3: CÀI ĐẶT VÀO THƯ MỤC CỦA USER ---
echo "--> Đang cài đặt kubectl vào ~/.local/bin..."
# Cấp quyền thực thi cho file
chmod +x kubectl
# Tạo thư mục nếu nó chưa tồn tại
mkdir -p ~/.local/bin
# Di chuyển file vào
mv ./kubectl ~/.local/bin/kubectl

# --- BƯỚC 4: DỌN DẸP ---
echo "--> Đang dọn dẹp..."
rm kubectl.sha256

# --- BƯỚC 5: HƯỚNG DẪN CẤU HÌNH PATH ---
echo ""
echo "✅ CÀI ĐẶT KUBECTL HOÀN TẤT!"
echo "=========================================="
echo "!!! QUAN TRỌNG: Bạn cần thêm ~/.local/bin vào biến môi trường PATH."
echo "Chạy lệnh sau:"
echo "echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
echo ""
echo "Sau đó, hãy chạy 'source ~/.bashrc' hoặc mở lại terminal để có thể sử dụng lệnh 'kubectl'."
echo "=========================================="

# Kiểm tra lại (có thể sẽ báo lỗi 'command not found' nếu PATH chưa được cập nhật)
~/.local/bin/kubectl version --client