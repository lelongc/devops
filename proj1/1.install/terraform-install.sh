#!/bin/bash

# Dừng script ngay lập tức nếu có bất kỳ lệnh nào thất bại
set -e

echo ">>> Bắt đầu quá trình cài đặt Terraform..."

# --- BƯỚC 1: CẬP NHẬT VÀ CÀI ĐẶT CÁC GÓI CẦN THIẾT ---
echo "--> Đang cập nhật danh sách gói và cài đặt các gói phụ thuộc..."
sudo apt-get update
sudo apt-get install -y gpg

# --- BƯỚC 2: THÊM GPG KEY CHÍNH THỨC CỦA HASHICORP ---
echo "--> Đang thêm GPG key của HashiCorp..."
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# --- BƯỚC 3: THÊM REPOSITORY CỦA HASHICORP VÀO APT SOURCES ---
echo "--> Đang thêm HashiCorp repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# --- BƯỚC 4: CÀI ĐẶT TERRAFORM ---
echo "--> Đang cập nhật lại và cài đặt Terraform..."
sudo apt-get update
sudo apt-get install -y terraform

# --- BƯỚC 5: KIỂM TRA LẠI ---
echo "--> Đang kiểm tra phiên bản Terraform..."
terraform -v

echo ""
echo "✅ CÀI ĐẶT TERRAFORM HOÀN TẤT!"