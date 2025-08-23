#!/bin/bash

# ==============================================================================
# SCRIPT CÀI ĐẶT DOCKER CE (COMMUNITY EDITION) TRÊN UBUNTU
# ==============================================================================

# Dừng script ngay lập tức nếu có bất kỳ lệnh nào thất bại
set -e

echo ">>> Bắt đầu quá trình cài đặt Docker..."

# --- BƯỚC 1: CẬP NHẬT VÀ CÀI ĐẶT CÁC GÓI CẦN THIẾT ---
echo "--> Đang cập nhật danh sách gói và cài đặt các gói phụ thuộc..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# --- BƯỚC 2: THÊM GPG KEY CHÍNH THỨC CỦA DOCKER ---
echo "--> Đang thêm GPG key của Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# --- BƯỚC 3: THÊM REPOSITORY CỦA DOCKER VÀO APT SOURCES ---
echo "--> Đang thêm Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# --- BƯỚC 4: CÀI ĐẶT DOCKER ENGINE VÀ CÁC PLUGIN ---
echo "--> Đang cài đặt Docker Engine, CLI, Containerd và các plugin..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# --- BƯỚC 5: THÊM NGƯỜI DÙNG HIỆN TẠI VÀO NHÓM DOCKER ---
echo "--> Đang thêm người dùng hiện tại vào nhóm Docker..."
sudo usermod -aG docker $USER

echo ""
echo "✅ CÀI ĐẶT DOCKER HOÀN TẤT!"
echo "=========================================="
echo "--> Để kiểm tra, bạn có thể chạy lệnh: sudo docker run hello-world"
echo "--> Đọc phần 'Bước Tiếp theo' để chạy Docker không cần 'sudo'."
echo "=========================================="