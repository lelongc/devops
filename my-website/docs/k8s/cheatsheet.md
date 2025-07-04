# Kubernetes Complete Knowledge Base

## 🎯 Mục tiêu

Trở thành Kubernetes Expert với kiến thức toàn diện về container orchestration, từ cơ bản đến nâng cao.

---

## 📚 **1. KUBERNETES FUNDAMENTALS**

### 1.1 Kubernetes Architecture

```bash
# Kubernetes Components
Master Node (Control Plane):
├── API Server (kube-apiserver)     # REST API endpoint
├── etcd                            # Key-value store
├── Scheduler (kube-scheduler)      # Pod placement
├── Controller Manager              # Control loops
└── Cloud Controller Manager       # Cloud-specific controllers

Worker Node:
├── kubelet                         # Node agent
├── kube-proxy                      # Network proxy
├── Container Runtime               # Docker/containerd/CRI-O
└── Pods                           # Smallest deployable units

# Kubernetes Object Hierarchy
Cluster
├── Namespaces
│   ├── Pods
│   │   └── Containers
│   ├── Services
│   ├── Deployments
│   ├── ConfigMaps
│   ├── Secrets
│   └── PersistentVolumes
```

### 1.2 Installation & Setup

```bash
# kubectl Installation
# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# macOS
brew install kubectl

# Windows
choco install kubernetes-cli

# Verify Installation
kubectl version --client
kubectl cluster-info

# Cluster Setup Options
minikube start                      # Local development
kind create cluster                 # Kubernetes in Docker
kubeadm init                       # Production cluster
```

---

## 🚀 **2. KUBECTL COMMANDS - COMPLETE REFERENCE**

### 2.1 Cluster Management

```bash
# Cluster Information
kubectl cluster-info                # Cluster endpoints
kubectl cluster-info dump          # Detailed cluster info
kubectl get nodes                  # List nodes
kubectl get nodes -o wide          # Detailed node info
kubectl describe node <node-name>  # Node details
kubectl top nodes                  # Node resource usage
kubectl get componentstatuses      # Component health
kubectl get events                 # Cluster events
kubectl get events --sort-by=.metadata.creationTimestamp

# Context Management
kubectl config view                 # View kubeconfig
kubectl config current-context     # Current context
kubectl config get-contexts        # List contexts
kubectl config use-context <context>  # Switch context
kubectl config set-context <context> --namespace=<namespace>
kubectl config delete-context <context>

# Cluster Access
kubectl auth can-i <verb> <resource>  # Check permissions
kubectl auth can-i create pods       # Can I create pods?
kubectl auth can-i "*" "*" --all-namespaces  # Check all permissions
```

### 2.2 Namespace Management

```bash
# Namespace Operations
kubectl get namespaces              # List namespaces
kubectl get ns                      # Short form
kubectl create namespace <name>     # Create namespace
kubectl delete namespace <name>     # Delete namespace
kubectl describe namespace <name>   # Namespace details

# Working with Namespaces
kubectl get pods -n <namespace>     # Pods in namespace
kubectl get all -n <namespace>      # All resources in namespace
kubectl get all --all-namespaces   # All resources in all namespaces
kubectl config set-context --current --namespace=<namespace>  # Set default namespace

# Namespace Resource Quotas
kubectl get resourcequota -n <namespace>
kubectl describe resourcequota -n <namespace>
```

### 2.3 Pod Management

```bash
# Pod Operations
kubectl get pods                    # List pods
kubectl get pods -o wide            # Detailed pod info
kubectl get pods --show-labels      # Show labels
kubectl get pods -l app=myapp       # Filter by label
kubectl get pods --field-selector=status.phase=Running
kubectl get pods --sort-by=.metadata.creationTimestamp

# Pod Details
kubectl describe pod <pod-name>     # Pod details
kubectl get pod <pod-name> -o yaml  # Pod YAML
kubectl get pod <pod-name> -o json  # Pod JSON
kubectl logs <pod-name>             # Pod logs
kubectl logs <pod-name> -c <container>  # Container logs
kubectl logs <pod-name> --previous  # Previous container logs
kubectl logs -f <pod-name>          # Follow logs
kubectl logs <pod-name> --tail=50   # Last 50 lines

# Pod Execution
kubectl exec <pod-name> -- <command>  # Execute command
kubectl exec -it <pod-name> -- /bin/bash  # Interactive shell
kubectl exec -it <pod-name> -c <container> -- /bin/sh  # Specific container
kubectl port-forward <pod-name> 8080:80  # Port forwarding
kubectl cp <pod-name>:/path/file ./file  # Copy from pod
kubectl cp ./file <pod-name>:/path/file  # Copy to pod

# Pod Lifecycle
kubectl run nginx --image=nginx    # Create pod
kubectl run nginx --image=nginx --dry-run=client -o yaml  # Generate YAML
kubectl delete pod <pod-name>       # Delete pod
kubectl delete pods --all          # Delete all pods
kubectl delete pods -l app=myapp    # Delete by label
```

### 2.4 Deployment Management

```bash
# Deployment Operations
kubectl get deployments            # List deployments
kubectl get deploy                 # Short form
kubectl create deployment nginx --image=nginx  # Create deployment
kubectl create deployment nginx --image=nginx --replicas=3
kubectl delete deployment <name>   # Delete deployment

# Deployment Details
kubectl describe deployment <name>  # Deployment details
kubectl get deployment <name> -o yaml  # Deployment YAML
kubectl rollout status deployment/<name>  # Rollout status
kubectl rollout history deployment/<name>  # Rollout history

# Scaling
kubectl scale deployment <name> --replicas=5  # Scale deployment
kubectl autoscale deployment <name> --min=2 --max=10 --cpu-percent=80  # HPA

# Rolling Updates
kubectl set image deployment/<name> <container>=<image>  # Update image
kubectl rollout restart deployment/<name>  # Restart deployment
kubectl rollout undo deployment/<name>     # Rollback deployment
kubectl rollout undo deployment/<name> --to-revision=2  # Rollback to revision

# Deployment Strategies
kubectl patch deployment <name> -p '{"spec":{"strategy":{"type":"RollingUpdate","rollingUpdate":{"maxUnavailable":1,"maxSurge":1}}}}'
```

### 2.5 Service Management

```bash
# Service Operations
kubectl get services               # List services
kubectl get svc                    # Short form
kubectl create service clusterip nginx --tcp=80:80  # ClusterIP service
kubectl expose deployment nginx --port=80 --target-port=8080  # Expose deployment
kubectl delete service <name>      # Delete service

# Service Types
kubectl expose deployment nginx --type=NodePort --port=80
kubectl expose deployment nginx --type=LoadBalancer --port=80
kubectl create service nodeport nginx --tcp=80:80 --node-port=30000

# Service Details
kubectl describe service <name>    # Service details
kubectl get endpoints              # Service endpoints
kubectl get service <name> -o yaml # Service YAML
```

### 2.6 ConfigMap & Secret Management

```bash
# ConfigMap Operations
kubectl get configmaps             # List configmaps
kubectl get cm                     # Short form
kubectl create configmap <name> --from-file=<file>  # From file
kubectl create configmap <name> --from-literal=key=value  # From literal
kubectl describe configmap <name>  # ConfigMap details
kubectl delete configmap <name>    # Delete configmap

# ConfigMap Examples
kubectl create configmap app-config --from-file=app.properties
kubectl create configmap app-config --from-literal=database_url=mongodb://localhost:27017
kubectl create configmap app-config --from-env-file=.env

# Secret Operations
kubectl get secrets                # List secrets
kubectl create secret generic <name> --from-literal=password=secret123
kubectl create secret docker-registry <name> --docker-username=<user> --docker-password=<password> --docker-email=<email>
kubectl create secret tls <name> --cert=cert.crt --key=cert.key
kubectl describe secret <name>     # Secret details
kubectl get secret <name> -o yaml  # Secret YAML (base64 encoded)

# Secret Types
kubectl create secret generic mysecret --from-file=ssh-privatekey=~/.ssh/id_rsa --type=kubernetes.io/ssh-auth
kubectl create secret docker-registry myregistrykey --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD
```

### 2.7 Volume & Storage Management

```bash
# PersistentVolume Operations
kubectl get pv                     # List persistent volumes
kubectl get persistentvolumes      # Full name
kubectl describe pv <name>         # PV details
kubectl delete pv <name>           # Delete PV

# PersistentVolumeClaim Operations
kubectl get pvc                    # List PVCs
kubectl get persistentvolumeclaims # Full name
kubectl describe pvc <name>        # PVC details
kubectl delete pvc <name>          # Delete PVC

# StorageClass Operations
kubectl get storageclass           # List storage classes
kubectl get sc                     # Short form
kubectl describe storageclass <name>  # StorageClass details
kubectl get sc -o yaml             # All StorageClasses YAML
```

### 2.8 Ingress Management

```bash
# Ingress Operations
kubectl get ingress                # List ingress
kubectl get ing                    # Short form
kubectl describe ingress <name>    # Ingress details
kubectl delete ingress <name>      # Delete ingress

# Ingress Controllers
kubectl get pods -n ingress-nginx  # Nginx ingress controller
kubectl logs -n ingress-nginx <pod-name>  # Ingress controller logs
```

### 2.9 Resource Management

```bash
# Resource Quotas
kubectl get resourcequota          # List resource quotas
kubectl describe resourcequota <name>  # Quota details
kubectl top pods                   # Pod resource usage
kubectl top nodes                  # Node resource usage

# Limit Ranges
kubectl get limitrange             # List limit ranges
kubectl describe limitrange <name> # Limit range details

# Horizontal Pod Autoscaler
kubectl get hpa                    # List HPAs
kubectl describe hpa <name>        # HPA details
kubectl autoscale deployment nginx --min=1 --max=10 --cpu-percent=80
```

---

## 📝 **3. KUBERNETES YAML MANIFESTS**

### 3.1 Pod Manifests

```yaml
# Basic Pod
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:1.21
      ports:
        - containerPort: 80
      resources:
        requests:
          memory: "64Mi"
          cpu: "250m"
        limits:
          memory: "128Mi"
          cpu: "500m"
      env:
        - name: ENV_VAR
          value: "production"
      volumeMounts:
        - name: config-volume
          mountPath: /etc/config
  volumes:
    - name: config-volume
      configMap:
        name: app-config
  restartPolicy: Always
  nodeSelector:
    kubernetes.io/os: linux
```

### 3.2 Deployment Manifests

```yaml
# Deployment with Rolling Update
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.21
          ports:
            - containerPort: 80
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
```

### 3.3 Service Manifests

```yaml
# ClusterIP Service
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

---
# NodePort Service
apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30000
  type: NodePort

---
# LoadBalancer Service
apiVersion: v1
kind: Service
metadata:
  name: nginx-loadbalancer
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```

### 3.4 ConfigMap & Secret Manifests

```yaml
# ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_url: "mongodb://localhost:27017"
  api_key: "your-api-key"
  config.yaml: |
    server:
      port: 8080
      host: 0.0.0.0
    database:
      driver: postgres
      host: localhost

---
# Secret
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  username: YWRtaW4= # base64 encoded 'admin'
  password: MWYyZDFlMmU2N2Rm # base64 encoded password
stringData:
  config.yaml: |
    apiUrl: "https://my.api.com/api/v1"
    username: "admin"
    password: "password"
```

### 3.5 Ingress Manifests

```yaml
# Basic Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80

---
# TLS Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-ingress
spec:
  tls:
    - hosts:
        - example.com
      secretName: tls-secret
  rules:
    - host: example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
```

### 3.6 PersistentVolume Manifests

```yaml
# PersistentVolume
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-storage
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: slow
  hostPath:
    path: /mnt/data

---
# PersistentVolumeClaim
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-storage
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: slow
```

---

## 🔧 **4. ADVANCED KUBERNETES CONCEPTS**

### 4.1 StatefulSet

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres-statefulset
spec:
  serviceName: postgres-service
  replicas: 3
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:13
          env:
            - name: POSTGRES_DB
              value: mydb
            - name: POSTGRES_USER
              value: admin
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: password
          volumeMounts:
            - name: postgres-storage
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: postgres-storage
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 10Gi
```

### 4.2 DaemonSet

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-daemonset
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      containers:
        - name: fluentd
          image: fluentd:latest
          volumeMounts:
            - name: varlog
              mountPath: /var/log
            - name: varlibdockercontainers
              mountPath: /var/lib/docker/containers
              readOnly: true
      volumes:
        - name: varlog
          hostPath:
            path: /var/log
        - name: varlibdockercontainers
          hostPath:
            path: /var/lib/docker/containers
```

### 4.3 Job & CronJob

```yaml
# Job
apiVersion: batch/v1
kind: Job
metadata:
  name: backup-job
spec:
  template:
    spec:
      containers:
        - name: backup
          image: backup-tool:latest
          command: ["sh", "-c", "backup-script.sh"]
      restartPolicy: Never
  backoffLimit: 4

---
# CronJob
apiVersion: batch/v1
kind: CronJob
metadata:
  name: backup-cronjob
spec:
  schedule: "0 2 * * *" # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: backup
              image: backup-tool:latest
              command: ["sh", "-c", "backup-script.sh"]
          restartPolicy: OnFailure
```

### 4.4 HorizontalPodAutoscaler

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: nginx-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
```

---

## 🛡️ **5. KUBERNETES SECURITY**

### 5.1 RBAC (Role-Based Access Control)

```yaml
# Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "watch", "list"]

---
# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
  - kind: User
    name: jane
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io

---
# ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: secret-reader
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    verbs: ["get", "watch", "list"]

---
# ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-secrets-global
subjects:
  - kind: User
    name: manager
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

### 5.2 Security Commands

```bash
# RBAC Commands
kubectl get roles               # List roles
kubectl get rolebindings        # List role bindings
kubectl get clusterroles        # List cluster roles
kubectl get clusterrolebindings # List cluster role bindings
kubectl describe role <name>    # Role details
kubectl auth can-i create pods  # Check permissions
kubectl auth can-i create pods --as=jane  # Check as user

# Service Account
kubectl get serviceaccounts     # List service accounts
kubectl get sa                  # Short form
kubectl create serviceaccount <name>  # Create service account
kubectl describe sa <name>      # Service account details

# Security Context
kubectl get pod <name> -o yaml | grep -A 10 securityContext
```

### 5.3 Pod Security Standards

```yaml
# Pod Security Policy
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: app
      image: nginx:1.21
      securityContext:
        allowPrivilegeEscalation: false
        readOnlyRootFilesystem: true
        capabilities:
          drop:
            - ALL
          add:
            - NET_BIND_SERVICE
```

---

## 📊 **6. MONITORING & OBSERVABILITY**

### 6.1 Monitoring Commands

```bash
# Resource Usage
kubectl top nodes               # Node resource usage
kubectl top pods                # Pod resource usage
kubectl top pods --containers   # Container resource usage
kubectl top pods -l app=nginx   # Pods with label
kubectl top pods --sort-by=cpu  # Sort by CPU
kubectl top pods --sort-by=memory  # Sort by memory

# Metrics Server
kubectl get apiservices | grep metrics
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes
kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods

# Events
kubectl get events              # List events
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get events --field-selector type=Warning
kubectl get events --watch     # Watch events
```

### 6.2 Logging Commands

```bash
# Pod Logs
kubectl logs <pod-name>         # Container logs
kubectl logs <pod-name> -c <container>  # Specific container
kubectl logs -f <pod-name>      # Follow logs
kubectl logs --previous <pod-name>  # Previous container logs
kubectl logs <pod-name> --tail=100  # Last 100 lines
kubectl logs <pod-name> --since=1h  # Logs from last hour
kubectl logs -l app=nginx       # Logs from all pods with label

# Multiple Pods
kubectl logs -l app=nginx --prefix=true  # With pod name prefix
kubectl logs -f deployment/nginx        # Follow deployment logs
```

### 6.3 Troubleshooting Commands

```bash
# Debug Pods
kubectl describe pod <pod-name>  # Pod details and events
kubectl get pod <pod-name> -o yaml  # Full pod specification
kubectl explain pod.spec         # Pod specification help
kubectl get events --field-selector involvedObject.name=<pod-name>

# Debug Services
kubectl describe service <service-name>
kubectl get endpoints <service-name>
kubectl run debug --image=busybox -it --rm -- /bin/sh  # Debug pod

# Debug Networking
kubectl exec <pod-name> -- nslookup <service-name>
kubectl exec <pod-name> -- wget -qO- <service-name>:<port>
kubectl port-forward <pod-name> 8080:80  # Port forwarding for testing

# Debug Storage
kubectl describe pv <pv-name>
kubectl describe pvc <pvc-name>
kubectl get events --field-selector reason=VolumeMount
```

---

## 🔄 **7. HELM PACKAGE MANAGER**

### 7.1 Helm Commands

```bash
# Helm Installation
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Repository Management
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update                # Update repositories
helm repo list                  # List repositories
helm search repo nginx          # Search charts
helm search hub wordpress       # Search Helm Hub

# Chart Management
helm install nginx stable/nginx-ingress  # Install chart
helm install myrelease bitnami/nginx    # Install with release name
helm install myapp ./mychart            # Install local chart
helm install myapp ./mychart --values values.yaml  # With custom values
helm install myapp ./mychart --set image.tag=latest  # Set values

# Release Management
helm list                       # List releases
helm list --all-namespaces     # All namespaces
helm status <release-name>      # Release status
helm get values <release-name>  # Release values
helm get manifest <release-name>  # Release manifests
helm history <release-name>     # Release history

# Upgrade and Rollback
helm upgrade <release-name> <chart>  # Upgrade release
helm upgrade <release-name> <chart> --values values.yaml
helm rollback <release-name> 1      # Rollback to revision 1
helm uninstall <release-name>       # Uninstall release

# Chart Development
helm create mychart             # Create new chart
helm template mychart           # Render templates locally
helm lint mychart               # Lint chart
helm package mychart            # Package chart
helm dependency update          # Update dependencies
```

### 7.2 Helm Chart Structure

```bash
mychart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default values
├── charts/             # Chart dependencies
├── templates/          # Kubernetes templates
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   ├── _helpers.tpl    # Template helpers
│   └── NOTES.txt       # Installation notes
└── .helmignore         # Files to ignore
```

### 7.3 Helm Chart Example

```yaml
# Chart.yaml
apiVersion: v2
name: myapp
description: A Helm chart for myapp
type: application
version: 0.1.0
appVersion: "1.0"

# values.yaml
replicaCount: 2
image:
  repository: nginx
  tag: "1.21"
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  port: 80
ingress:
  enabled: false
  annotations: {}
  hosts:
    - host: chart-example.local
      paths: []
  tls: []
resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

---

## 🏗️ **8. KUBERNETES NETWORKING**

### 8.1 Network Policies

```yaml
# Network Policy Example
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: web-netpol
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: frontend
        - namespaceSelector:
            matchLabels:
              name: production
      ports:
        - protocol: TCP
          port: 80
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: database
      ports:
        - protocol: TCP
          port: 5432
```

### 8.2 Service Mesh (Istio)

```bash
# Istio Installation
istioctl install --set values.defaultRevision=default
kubectl label namespace default istio-injection=enabled

# Istio Resources
kubectl get virtualservices
kubectl get destinationrules
kubectl get gateways
kubectl get serviceentries
kubectl get peerauthentication

# Istio Traffic Management
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    route:
    - destination:
        host: reviews
        subset: v2
  - route:
    - destination:
        host: reviews
        subset: v1
EOF
```

---

## 🏭 **9. PRODUCTION OPERATIONS**

### 9.1 Cluster Management

```bash
# Node Management
kubectl cordon <node-name>      # Mark node unschedulable
kubectl uncordon <node-name>    # Mark node schedulable
kubectl drain <node-name>       # Evict pods and mark unschedulable
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data

# Cluster Upgrade
kubeadm upgrade plan            # Check upgrade options
kubeadm upgrade apply v1.25.0   # Upgrade control plane
kubectl get nodes               # Verify node versions

# Backup and Restore
etcdctl snapshot save backup.db # Backup etcd
etcdctl snapshot restore backup.db  # Restore etcd
```

### 9.2 Resource Management

```yaml
# Resource Quota
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: myapp
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    persistentvolumeclaims: "10"
    count/pods: "20"

---
# Limit Range
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
    - default:
        memory: "512Mi"
        cpu: "500m"
      defaultRequest:
        memory: "256Mi"
        cpu: "200m"
      type: Container
```

### 9.3 High Availability

```yaml
# Pod Disruption Budget
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: myapp-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: myapp

---
# Anti-Affinity Example
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values:
                      - web
              topologyKey: "kubernetes.io/hostname"
      containers:
        - name: web
          image: nginx:1.21
```

---

## 🔍 **10. TROUBLESHOOTING GUIDE**

### 10.1 Common Issues & Solutions

```bash
# Pod Issues
# Pod stuck in Pending
kubectl describe pod <pod-name>  # Check events
kubectl get nodes                # Check node availability
kubectl top nodes                # Check node resources

# Pod stuck in CrashLoopBackOff
kubectl logs <pod-name>          # Check logs
kubectl logs <pod-name> --previous  # Previous container logs
kubectl describe pod <pod-name>  # Check events

# Image Pull Errors
kubectl describe pod <pod-name>  # Check events
kubectl get events | grep Failed # Failed events
docker pull <image>              # Test image locally

# Service Issues
# Service not accessible
kubectl get endpoints <service-name>  # Check endpoints
kubectl describe service <service-name>  # Service details
kubectl get pods -l app=<label>  # Check pod labels

# DNS Issues
kubectl exec -it <pod-name> -- nslookup kubernetes.default
kubectl exec -it <pod-name> -- cat /etc/resolv.conf
kubectl get services -n kube-system | grep dns

# Storage Issues
# PVC stuck in Pending
kubectl describe pvc <pvc-name>  # Check events
kubectl get pv                   # Check available PVs
kubectl get storageclass         # Check storage classes

# Network Issues
kubectl get networkpolicies      # Check network policies
kubectl describe networkpolicy <policy-name>
kubectl exec -it <pod-name> -- ping <target-ip>
```

### 10.2 Debug Tools

```bash
# Debug Pod
kubectl run debug --image=busybox -it --rm -- /bin/sh
kubectl run debug --image=nicolaka/netshoot -it --rm -- /bin/bash
kubectl run debug --image=alpine/curl -it --rm -- /bin/sh

# Debug with specific privileges
kubectl run debug --image=busybox --privileged -it --rm -- /bin/sh
kubectl run debug --image=busybox --overrides='{"spec":{"hostNetwork":true}}' -it --rm -- /bin/sh

# Copy files for debugging
kubectl cp <pod-name>:/path/to/file ./local-file
kubectl cp ./local-file <pod-name>:/path/to/file

# Port forwarding for debugging
kubectl port-forward pod/<pod-name> 8080:80
kubectl port-forward service/<service-name> 8080:80
kubectl port-forward deployment/<deployment-name> 8080:80
```

---

## 📚 **11. KUBERNETES EXTENSIONS & TOOLS**

### 11.1 Essential Tools

```bash
# kubectl Plugins
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx
curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens
kubectx                         # Switch contexts
kubens                          # Switch namespaces

# kubectl aliases
alias k=kubectl
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias ke='kubectl exec -it'

# Useful Tools
stern <pod-pattern>             # Multi-pod log tailing
k9s                            # Terminal-based K8s UI
lens                           # Desktop K8s IDE
kubefwd                        # Port forwarding tool
```

### 11.2 Operators

```bash
# Operator Examples
kubectl get operators           # List operators
kubectl get csv                 # ClusterServiceVersions
kubectl get crd                 # Custom Resource Definitions
kubectl get customresources    # Custom resources

# Popular Operators
# Prometheus Operator
# Grafana Operator
# MongoDB Operator
# PostgreSQL Operator
# Cert-Manager Operator
```

### 11.3 Custom Resources

```yaml
# Custom Resource Definition
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: applications.example.com
spec:
  group: example.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                replicas:
                  type: integer
                image:
                  type: string
            status:
              type: object
  scope: Namespaced
  names:
    plural: applications
    singular: application
    kind: Application
```

---

## 🎓 **12. LEARNING PATH & CERTIFICATION**

### 12.1 Learning Timeline

```bash
# Beginner (2-3 months)
Month 1: Kubernetes basics, Pods, Services
Month 2: Deployments, ConfigMaps, Secrets
Month 3: Volumes, Networking, Basic troubleshooting

# Intermediate (3-4 months)
Month 4: Advanced workloads (StatefulSets, DaemonSets)
Month 5: Security (RBAC, Network Policies)
Month 6: Monitoring, Logging, Helm
Month 7: Operators, Custom Resources

# Advanced (4-6 months)
Month 8: Multi-cluster management
Month 9: Service mesh (Istio/Linkerd)
Month 10: GitOps (ArgoCD/Flux)
Month 11: Platform engineering
Month 12: Certification preparation
```

### 12.2 Certifications

```bash
# Kubernetes Certifications
- Certified Kubernetes Administrator (CKA)
- Certified Kubernetes Application Developer (CKAD)
- Certified Kubernetes Security Specialist (CKS)

# Related Certifications
- Docker Certified Associate (DCA)
- AWS Certified Solutions Architect
- Google Cloud Professional Cloud Architect
- Azure Solutions Architect Expert
```

### 12.3 Practice Environments

```bash
# Local Development
minikube start                  # Single-node cluster
kind create cluster             # Kubernetes in Docker
k3s                            # Lightweight Kubernetes

# Cloud Platforms
# Google Kubernetes Engine (GKE)
# Amazon Elastic Kubernetes Service (EKS)
# Azure Kubernetes Service (AKS)
# DigitalOcean Kubernetes

# Learning Platforms
# Katacoda Kubernetes Scenarios
# Play with Kubernetes
# Kubernetes the Hard Way
```

---

## 📖 **13. BEST PRACTICES**

### 13.1 Deployment Best Practices

```yaml
# Production-Ready Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  labels:
    app: myapp
    version: v1.0.0
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
        version: v1.0.0
    spec:
      containers:
        - name: myapp
          image: myapp:1.0.0
          ports:
            - containerPort: 8080
          resources:
            requests:
              memory: "256Mi"
              cpu: "200m"
            limits:
              memory: "512Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          securityContext:
            runAsNonRoot: true
            runAsUser: 1000
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
          env:
            - name: PORT
              value: "8080"
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: database-secret
                  key: url
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - myapp
                topologyKey: kubernetes.io/hostname
```

### 13.2 Security Best Practices

```bash
# Security Checklist
1. Use non-root containers
2. Set resource limits
3. Use read-only root filesystem
4. Drop unnecessary capabilities
5. Use network policies
6. Implement RBAC
7. Scan images for vulnerabilities
8. Use secrets for sensitive data
9. Enable audit logging
10. Keep Kubernetes updated
```

---

_Đây là tài liệu toàn diện về Kubernetes. Hãy thực hành thường xuyên với các cluster thực tế và không ngừng cập nhật kiến thức về container orchestration!_
