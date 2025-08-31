## Sử dụng S3 Backend cho dự án khác

### Cấu hình backend trong main.tf:

```hcl
terraform {
  backend "s3" {
    bucket       = "terraform-eks-s3190110long"
    key          = "project-name/terraform.tfstate"  # Đường dẫn riêng cho từng project
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true  # S3 Native Locking
  }
}
```

### Ví dụ key cho các project khác nhau:

- K8s project: `key = "k8s/terraform.tfstate"`
- VPC project: `key = "vpc/terraform.tfstate"`
- Database project: `key = "database/terraform.tfstate"`

## Cách xem State File trên S3

### 1. Qua AWS CLI:

```bash
# Liệt kê files trong bucket
aws s3 ls s3://terraform-eks-s3190110long/

# Xem nội dung state file
aws s3 cp s3://terraform-eks-s3190110long/k8s/terraform.tfstate - | jq .

# Download về xem
aws s3 cp s3://terraform-eks-s3190110long/k8s/terraform.tfstate ./state.json
```

### 2. Qua Terraform:

```bash
# Xem state hiện tại
terraform show

# Liệt kê resources trong state
terraform state list

# Xem chi tiết 1 resource
terraform state show aws_s3_bucket.terraform_state
```

### 3. Qua AWS Console:

1. Vào S3 Console
2. Mở bucket `terraform-eks-s3190110long`
3. Vào thư mục project (vd: `k8s/`)
4. Click file `terraform.tfstate`
5. Click "Download" hoặc "Open"

### 4. Cấu trúc State File:

```json
{
  "version": 4,
  "terraform_version": "1.10.0",
  "resources": [
    {
      "type": "aws_eks_cluster",
      "name": "main",
      "instances": [
        {
          "attributes": {
            "name": "my-cluster",
            "arn": "arn:aws:eks:us-east-1:123456789:cluster/my-cluster"
          }
        }
      ]
    }
  ]
}
```

## Lưu ý khi sử dụng

- **Key path**: Mỗi project nên có key riêng để tránh conflict
- **Permissions**: Đảm bảo IAM user có quyền đọc/ghi S3 bucket
- **Backup**: S3 versioning đã được bật để backup state
- **Security**: State file chứa thông tin nhạy cảm, nên encrypt
