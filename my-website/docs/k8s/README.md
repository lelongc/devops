# ☸️ Lộ Trình Kubernetes Cho DevOps Chuyên Sâu Toàn Tập (Kubernetes for DevOps Master Roadmap)

Bộ giáo trình được thiết kế chuyên biệt và đầy đủ nhất dành cho **Kỹ sư DevOps**, **SRE (Site Reliability Engineer)**, **Kubernetes Architect** và **Người mới bắt đầu** muốn thành thạo công nghệ điều phối Container Kubernetes từ căn bản đến trình độ Senior / Chuyên gia để tự động hóa 100% việc vận hành hạ tầng Cloud Native quy mô lớn.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 25 Module Kubernetes tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất công nghệ Kubernetes trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Sơ Đồ Kiến Trúc (Under The Hood Architecture)**: Phân tích kiến trúc K8s Control Plane, etcd, Reconcile Loop, CNI Plugins, Storage CSI, SecurityContext & Sơ đồ Mermaid / Đồ họa trực quan.
3. **⚡ Bảng Tra Cứu Khái Niệm, Câu Lệnh & Tham Số (Reference Table)**: Bảng tham chiếu các câu lệnh `kubectl` CLI, tham số YAML manifests, HPA, RBAC kèm giải thích bản chất.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản Triển Khai Kubernetes (Production Playbook)**: Đoạn Manifest YAML, Helm Chart, ArgoCD Application gõ ăn ngay + Incident Response Playbook xử lý sự cố CrashLoopBackOff, Pending PVC, Node NotReady, OOMKilled thực tế.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps Kubernetes Thực Tế (Middle-Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng vị trí Middle-Senior / Architect và ôn thi chứng chỉ CKA, CKAD, CKS.
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 25 Bài Học Kubernetes Cho DevOps Toàn Tập

### 📘 PHẦN 1: NỀN TẢNG KIẾN TRÚC KUBERNETES & KUBEADM (BÀI 01 - 04)
- 📖 [**Bài 01: Kiến Trúc Cụm Kubernetes & Các Thành Phần Control Plane / Worker Node**](./01.Kubernetes_Architecture_and_Components/README.md) - Control Plane (etcd, kube-apiserver, kube-scheduler, kube-controller-manager), Worker Node (kubelet, kube-proxy, CRI containerd) & Luồng xử lý khi tạo Pod.
- 📖 [**Bài 02: Dựng Cụm K8s Khả Dụng Cao (HA) Bằng Kubeadm & Gia Hạn Chứng Chỉ SSL**](./02.Kubeadm_Cluster_Bootstrap_and_HA/README.md) - Khởi tạo cụm K8s từ đầu: `kubeadm init`, `kubeadm join`, CNI Flannel/Calico, HA Control Plane với HAProxy + Keepalived & Gia hạn chứng chỉ SSL `kubeadm certs renew`.
- 📖 [**Bài 03: Thành Thạo Lệnh Kubectl CLI, Imperative vs Declarative & Krew Plugins**](./03.Kubectl_CLI_Mastery_and_Imperative_Commands/README.md) - `kubectl` CLI thực chiến: Imperative vs Declarative, `kubectl run/create/apply/get/describe/logs/exec/port-forward/edit/top`, Krew plugin manager (ctx, ns, Popeye, Stern).
- 📖 [**Bài 04: Kiến Trúc Pod, Pause Container & Các Pattern Multi-Container**](./04.Pod_Architecture_and_Multi_Container_Patterns/README.md) - Pause Container (IPC/NET Namespace sharing), Multi-container design patterns (Sidecar, Ambassador, Adapter, Init Containers) & Vòng đời Pod Lifecycle.

---

### 📙 PHẦN 2: WORKLOADS, SCALING & STORAGE (BÀI 05 - 09)
- 📖 [**Bài 05: Quản Lý Deployments, ReplicaSets & Các Chiến Lược Rollout**](./05.Deployments_ReplicaSets_and_Rollout_Strategies/README.md) - Deployments, ReplicaSets, RollingUpdate (`maxSurge`, `maxUnavailable`), Recreate, Rollout Status, Rollout History, Rollout Undo / Rollback zero downtime.
- 📖 [**Bài 06: Quản Lý Ứng Dụng Stateful (StatefulSets) & System Daemons (DaemonSets)**](./06.StatefulSets_and_DaemonSets/README.md) - StatefulSet (Ordinal index 0..N, Headless Service, VolumeClaimTemplates), DaemonSet (Log collector Fluentd, CNI agent Calico, Monitoring Node Exporter).
- 📖 [**Bài 07: Tác Vụ Xử Lý Theo Lô (Jobs) & Lập Lịch Tự Động (CronJobs)**](./07.Jobs_CronJobs_and_Batch_Processing/README.md) - Job (`completions`, `parallelism`, `backoffLimit`), CronJob (`schedule` cron format, `concurrencyPolicy` Forbid/Allow/Replace, `successfulJobsHistoryLimit`).
- 📖 [**Bài 08: Tự Động Mở Rộng Tài Nguyên (HPA, VPA, Cluster Autoscaler & Karpenter)**](./08.Autoscaling_HPA_VPA_and_Karpenter/README.md) - Horizontal Pod Autoscaler (HPA v2 Custom Metrics Prometheus), Vertical Pod Autoscaler (VPA), Cluster Autoscaler & AWS Karpenter JIT Node Provisioning.
- 📖 [**Bài 09: Kiến Trúc Lưu Trữ Phân Tán - PV, PVC, StorageClass & CSI Drivers**](./09.Storage_Architecture_PV_PVC_StorageClass_CSI/README.md) - PersistentVolume (PV), PersistentVolumeClaim (PVC), StorageClass (Dynamic Provisioning), CSI Drivers, Access Modes (RWO, ROX, RWX) & Storage (EBS, Longhorn, NFS).

---

### 📕 PHẦN 3: NETWORKING, INGRESS & SERVICE MESH (BÀI 10 - 14)
- 📖 [**Bài 10: Chuyên Sâu Mạng K8s, CNI Plugins & Các Loại Services**](./10.Kubernetes_Networking_CNI_and_Services/README.md) - CNI Plugins (Flannel, Calico, Cilium eBPF), IP-per-Pod model, Service Types (ClusterIP, NodePort, LoadBalancer, ExternalName), Headless Service & EndpointSlices.
- 📖 [**Bài 11: Quản Lý Điều Hướng Ingress & Tự Động Cấp Phát SSL/TLS Cert-Manager**](./11.Ingress_Controllers_and_Cert_Manager/README.md) - Nginx Ingress Controller, Path-based & Host-based Routing, Tự động xin & gia hạn chứng chỉ HTTPS SSL/TLS với `cert-manager` & Let's Encrypt CA.
- 📖 [**Bài 12: Bảo Mật Đường Truyền Mạng Vùng Với NetworkPolicies & Zero-Trust**](./12.Network_Policies_and_Microsegmentation/README.md) - Firewall nội bộ K8s: NetworkPolicy (Ingress & Egress rules, podSelector, namespaceSelector, ipBlock), Cô lập giao tiếp Zero-Trust Network.
- 📖 [**Bài 13: Kiến Trúc Service Mesh Với Istio (Traffic Management, mTLS & Tracing)**](./13.Service_Mesh_Istio_Architecture/README.md) - Service Mesh Istio: Data Plane (Envoy Sidecar Proxy) & Control Plane (Istiod), Traffic Management (VirtualService, DestinationRule, Gateway), mTLS Encryption & Canary Deployment.
- 📖 [**Bài 14: Cơ Chế Phân Giải Tên Miền CoreDNS & Service Discovery**](./14.DNS_CoreDNS_and_Service_Discovery/README.md) - CoreDNS architecture, Cấu trúc FQDN (`service.namespace.svc.cluster.local`), `dnsPolicy`, `dnsConfig`, `autopath` & Troubleshooting lỗi DNS timeout.

---

### 📗 PHẦN 4: CONFIGURATION, SECURITY & RBAC (BÀI 15 - 19)
- 📖 [**Bài 15: Quản Lý Cấu Hình ConfigMaps, Secrets & External Secrets Operator**](./15.ConfigMaps_Secrets_and_External_Secrets/README.md) - ConfigMap, Secret (Opaque, TLS, docker-registry), Env variables / Volume Mounts, Tích hợp HashiCorp Vault / AWS Secrets Manager với External Secrets Operator (ESO).
- 📖 [**Bài 16: Phân Quyền Bảo Mật RBAC, ServiceAccounts & OIDC Authentication**](./16.RBAC_ServiceAccounts_and_Authentication/README.md) - Authentication (X.509 Certs, OIDC), ServiceAccount, RBAC (Role, RoleBinding, ClusterRole, ClusterRoleBinding), `kubectl auth can-i` & IRSA AWS IAM.
- 📖 [**Bài 17: Thâm Nhập Bảo Mật Container với SecurityContext & Pod Security Standards**](./17.SecurityContext_and_Pod_Security_Standards/README.md) - SecurityContext (`runAsNonRoot: true`, `readOnlyRootFilesystem`, `capabilities`), Pod Security Admission (Privileged, Baseline, Restricted) & OPA Gatekeeper / Kyverno Policy.
- 📖 [**Bài 18: Quản Lý Tài Nguyên - Resource Requests/Limits, ResourceQuota & LimitRanges**](./18.Resource_Management_Quotas_and_LimitRanges/README.md) - CPU/Memory Requests & Limits, ResourceQuota (Namespace limit), LimitRange (Default container limits), QoS Classes (Guaranteed, Burstable, BestEffort) & OOM Killer.
- 📖 [**Bài 19: Điều Phối Pod Nâng Cao - Node Affinity, Taints, Tolerations & Topology Spread**](./19.Advanced_Scheduling_Taints_Tolerations_Affinity/README.md) - `nodeSelector`, Taints & Tolerations (`NoSchedule`, `NoExecute`), Node Affinity / Anti-Affinity, Pod Affinity / Anti-Affinity & Topology Spread Constraints.

---

### 📘 PHẦN 5: HELM, GITOPS & OBSERVABILITY (BÀI 20 - 22)
- 📖 [**Bài 20: Thành Thạo Helm V3 Package Manager & Viết Helm Chart Từ Đầu**](./20.Helm_V3_Package_Manager_Mastery/README.md) - Helm Chart (`Chart.yaml`, `values.yaml`, `templates/`), Helm Functions, Helm CLI (`install`, `upgrade`, `rollback`, `uninstall`), Viết Helm Chart Production.
- 📖 [**Bài 21: Triển Khai GitOps Continuous Delivery Với ArgoCD & Argo Rollouts**](./21.GitOps_Continuous_Delivery_ArgoCD/README.md) - ArgoCD architecture, Git Repo Single Source of Truth, Application CRD, Auto-Sync, Self-Healing, Rollback tự động & Progressive Delivery với Argo Rollouts Canary.
- 📖 [**Bài 22: Giám Sát Toàn Diện Observability - Prometheus, Grafana, Loki & Jaeger**](./22.Monitoring_Logging_Tracing_Prometheus_Grafana/README.md) - Prometheus Operator, ServiceMonitor, Grafana Dashboards, Loki Log Aggregation, Jaeger / OpenTelemetry Distributed Tracing & AlertManager.

---

### 📕 PHẦN 6: PRODUCTION TROUBLESHOOTING & CKA/CKS CERTIFICATION (BÀI 23 - 25)
- 📖 [**Bài 23: Sổ Tay Xử Lý Sự Cố Production & Cluster Disaster Recovery (Velero)**](./23.Production_Incident_Response_Playbooks/README.md) - Troubleshooting: `CrashLoopBackOff`, `ImagePullBackOff`, `Pending PVC`, `Node NotReady`, OOMKilled, Pod Disruption Budget (PDB) & Velero Backup/Restore.
- 📖 [**Bài 24: Bảo Mật Cụm K8s Nâng Cao Chuẩn Chứng Chỉ CKS (Certified Security Specialist)**](./24.Hardening_Kubernetes_Security_CKS/README.md) - CIS Benchmarks (`kube-bench`), Falco Runtime Security Threat Detection, mTLS, Image Vulnerability Scanning (Trivy), Seccomp & AppArmor.
- 📖 [**Bài 25: Bí Kíp Ôn Thi Chứng Chỉ Quốc Tế CKA/CKAD/CKS & Senior K8s Architect Summary**](./25.CKA_CKAD_CKS_Exam_Mastery_and_Architecture/README.md) - Lộ trình ôn thi CKA / CKAD / CKS, Mẹo thao tác bàn phím `kubectl` siêu tốc, Chiến thuật quản lý thời gian & Tổng kết kiến trúc Senior Kubernetes Architect.
