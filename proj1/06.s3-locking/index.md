# S3 Backend với Native Locking

## Terraform State là gì?

**Terraform State** là file JSON chứa thông tin về:

- Tài nguyên AWS đã tạo (EC2, S3, VPC...)
- Mapping giữa config và tài nguyên thực tế
- Metadata và dependencies

**Ví dụ state file:**

```json
{
  "resources": [
    {
      "type": "aws_s3_bucket",
      "name": "terraform_state",
      "instances": [
        {
          "attributes": {
            "id": "terraform-eks-s3190110long",
            "arn": "arn:aws:s3:::terraform-eks-s3190110long"
          }
        }
      ]
    }
  ]
}
```

## Tại sao cần Remote State?

### Local State (mặc định)

```
project/
├── main.tf
└── terraform.tfstate  ← File local
```

**Vấn đề:**

- Chỉ 1 người làm việc được
- Mất file = mất track tài nguyên
- Không có backup
- Không có locking

### Remote State (S3)

```
S3 Bucket: terraform-eks-s3190110long
└── example-state.tfstate  ← File trên cloud
```

**Lợi ích:**

- Team cùng làm việc
- Backup tự động
- Versioning
- Locking (tránh conflict)

## Vấn đề Bootstrap

- Terraform cần S3 bucket để lưu state
- Nhưng không thể tạo bucket và dùng nó làm backend cùng lúc
- Phải tạo bucket trước, sau đó migrate state lên S3

## Giải pháp: 2 Bước

### Bước 1: Tạo S3 Bucket (Local State)

**File main.tf:**

```hcl
terraform {
  required_version = "~> 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.84.0"
    }
  }

  # COMMENT backend tạm thời
  # backend "s3" {
  #   bucket       = "terraform-eks-s3190110long"
  #   key          = "example-state.tfstate"
  #   region       = "us-east-1"
  #   encrypt      = true
  #   use_lockfile = true
  # }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-eks-s3190110long"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

**Chạy lệnh:**

```bash
terraform init    # Khởi tạo với local state
terraform apply   # Tạo S3 bucket
```

**Kết quả:**

- Bucket được tạo trên AWS
- State lưu ở file local `terraform.tfstate`

### Bước 2: Migrate State lên S3

**Sửa main.tf - UNCOMMENT backend:**

```hcl
terraform {
  required_version = "~> 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.84.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-eks-s3190110long"
    key          = "example-state.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true  # S3 Native Locking
  }
}
```

**Chạy lệnh:**

```bash
terraform init -migrate-state
```

**Terraform sẽ hỏi:**

```
Do you want to copy existing state to the new backend?
Pre-existing state was found while migrating the previous "local" backend to the
newly configured "s3" backend. No existing state was found in the newly
configured "s3" backend. Do you want to copy this state to the new "s3"
backend? Enter "yes" to copy and "no" to start with an empty state.

Enter a value:
```

**Gõ:** `yes`

**Kết quả:**

- State được chuyển từ local lên S3
- S3 native locking được kích hoạt
- File local `terraform.tfstate` có thể xóa

## Kiểm tra

**Xem state trên S3:**

```bash
aws s3 ls s3://terraform-eks-s3190110long/
```

**Test locking:**

```bash
# Terminal 1
terraform plan  # Tạo lock file trên S3

# Terminal 2 (sẽ bị block)
terraform plan  # Chờ terminal 1 xong
```

**Locking hoạt động như thế nào:**

- Terminal 1 chạy → Tạo file `.terraform.tflock` trên S3
- Terminal 2 chạy → Thấy lock file → Chờ
- Terminal 1 xong → Xóa lock file
- Terminal 2 tiếp tục

## Ví dụ thực tế

**Bucket structure sau khi có nhiều project:**

```
terraform-eks-s3190110long/
├── example-state.tfstate          # Project đầu tiên
├── k8s/
│   └── terraform.tfstate          # K8s cluster
├── vpc/
│   └── terraform.tfstate          # VPC setup
└── database/
    └── terraform.tfstate          # RDS setup
```

**Mỗi project sẽ có state riêng, không ảnh hưởng lẫn nhau.**

## Lưu ý

- `use_lockfile = true`: Dùng S3 native locking (không cần DynamoDB)
- Bucket name phải unique toàn cầu
- Versioning được bật để backup state
- Encryption được bật cho bảo mật

## So sánh Local vs Remote State

| Tính năng     | Local State    | Remote State (S3) |
| ------------- | -------------- | ----------------- |
| Collaboration | ❌ Chỉ 1 người | ✅ Cả team        |
| Backup        | ❌ Không có    | ✅ Tự động        |
| Versioning    | ❌ Không có    | ✅ Có             |
| Locking       | ❌ Không có    | ✅ Có             |
| Security      | ❌ Local file  | ✅ Encrypted      |

## Mục đích cuối cùng

**Trước:** State lưu local → Chỉ bạn làm việc được

**Sau:** State lưu S3 → Cả team làm việc được, có backup, có locking
