# Hướng dẫn kết nối và cài đặt AWS Load Balancer Controller cho EKS

## Thông tin EKS Cluster

- **Cluster Name**: `my-eks-cluster`
- **Region**: `us-east-1`
- **VPC ID**: `vpc-0e56c7bf8a2de4010`
- **AWS Account ID**: `026090510378`
- **Cluster Endpoint**: `https://EA0C0ECE75EF71A5F8509C95795C2606.gr7.us-east-1.eks.amazonaws.com`

## Bước 1: Cập nhật kubeconfig với EKS Cluster

Sử dụng lệnh sau để cập nhật file kubeconfig với EKS cluster:

```bash
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
kubectl config current-context
kubectl config view

```

## Bước 2: Kiểm tra kết nối

Xác minh rằng file kubeconfig đã được cấu hình đúng và bạn có thể kết nối tới EKS cluster:

```bash
kubectl get nodes
```

Bạn sẽ thấy danh sách các nodes trong EKS cluster.

## Bước 3: Cài đặt AWS Load Balancer Controller

### 3.1. Thiết lập OIDC Connector

#### Cấu hình IAM OIDC provider

```bash
export cluster_name=my-eks-cluster
```

```bash
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
```

#### Kiểm tra xem đã có IAM OIDC provider chưa

```bash
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
```

Nếu chưa có, chạy lệnh sau:

```bash
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

### 3.2. Tạo IAM Policy và Role

#### Tải xuống IAM policy

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json
```

#### Tạo IAM Policy

```bash
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```

#### Tạo IAM Role và Service Account

```bash
eksctl create iamserviceaccount \
  --cluster=my-eks-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::026090510378:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

### 3.3. Deploy AWS Load Balancer Controller

#### Cài đặt Helm v3

```bash
# Cài đặt Helm v3
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Kiểm tra version
helm version

# Thêm repository
helm repo add eks https://aws.github.io/eks-charts
```

#### Cập nhật repository

```bash
helm repo update eks
```

#### Cài đặt AWS Load Balancer Controller

```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=vpc-0e56c7bf8a2de4010
```

#### Kiểm tra deployment

```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

## Bước 4: Khắc phục sự cố (nếu cần)

Nếu bạn gặp vấn đề không thể thấy địa chỉ load balancer khi chạy `kubectl get ingress`, có thể do thiếu quyền `elasticloadbalancing:DescribeListenerAttributes`.

### 4.1. Kiểm tra policy hiện tại

```bash
aws iam get-policy-version \
    --policy-arn arn:aws:iam::026090510378:policy/AWSLoadBalancerControllerIAMPolicy \
    --version-id $(aws iam get-policy --policy-arn arn:aws:iam::026090510378:policy/AWSLoadBalancerControllerIAMPolicy --query 'Policy.DefaultVersionId' --output text)
```

### 4.2. Tải xuống policy hiện tại

```bash
aws iam get-policy-version \
    --policy-arn arn:aws:iam::026090510378:policy/AWSLoadBalancerControllerIAMPolicy \
    --version-id $(aws iam get-policy --policy-arn arn:aws:iam::026090510378:policy/AWSLoadBalancerControllerIAMPolicy --query 'Policy.DefaultVersionId' --output text) \
    --query 'PolicyVersion.Document' --output json > policy.json
```

### 4.3. Thêm quyền thiếu vào policy.json

Thêm đoạn sau vào policy.json nếu chưa có:

```json
{
  "Effect": "Allow",
  "Action": "elasticloadbalancing:DescribeListenerAttributes",
  "Resource": "*"
}
```

### 4.4. Tạo phiên bản policy mới

```bash
aws iam create-policy-version \
    --policy-arn arn:aws:iam::026090510378:policy/AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://policy.json \
    --set-as-default
```

## Bước 5: Kiểm tra hoạt động

Sau khi hoàn thành, bạn có thể kiểm tra:

```bash
# Kiểm tra pods của load balancer controller
kubectl get pods -n kube-system | grep aws-load-balancer-controller

# Kiểm tra logs
kubectl logs -n kube-system deployment/aws-load-balancer-controller
```

# chạy ingress

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
name: frontend-proxy
annotations:
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
spec:
ingressClassName: alb
rules: - host: drashop.online
http:
paths: - path: "/"
pathType: Prefix
backend:
service:
name: opentelemetry-demo-frontendproxy
port:
number: 8080

kubectl apply -f ...
rồi sau đó nslookup cái dns của alb để xem ip
nslookup dns.com
sau đó dùng địa chỉ ip truy cập web thì không được do trong ingress chỉ cho qua domain
nên có thể map ip qua file host trên máy cá nhân
hoặc tạo hosted zone và map đến alb và chờ vài tiếng nếu bạn đủ kiên nhẫn

## Lưu ý quan trọng

- Đảm bảo AWS CLI đã được cấu hình với đúng credentials
- Đảm bảo `kubectl` và `eksctl` đã được cài đặt
- Đảm bảo `helm` đã được cài đặt
- Cluster phải có ít nhất 2 subnets ở 2 AZ khác nhau để ALB hoạt động

## Tài nguyên tham khảo

- [AWS Load Balancer Controller Documentation](https://kubernetes-sigs.github.io/aws-load-balancer-controller/)
- [EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/)
