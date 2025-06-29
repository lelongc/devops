# Docker Complete Learning Guide - Toàn Bộ Kiến Thức Docker Chi Tiết

## 📚 Mục Lục

1. [Docker Fundamentals](#1-docker-fundamentals)
2. [Docker Architecture](#2-docker-architecture)
3. [Docker Images](#3-docker-images)
4. [Docker Containers](#4-docker-containers)
5. [Dockerfile](#5-dockerfile)
6. [Docker Networking](#6-docker-networking)
7. [Docker Volumes](#7-docker-volumes)
8. [Docker Compose](#8-docker-compose)
9. [Docker Registry](#9-docker-registry)
10. [Docker Security](#10-docker-security)
11. [Docker Monitoring](#11-docker-monitoring)
12. [Docker Production](#12-docker-production)
13. [Advanced Topics](#13-advanced-topics)

---

## 1. Docker Fundamentals

### 1.1 Container vs Virtual Machine

**Virtual Machine Architecture:**

```

┌─────────────────────────────────────┐
│ Application 1 │
├─────────────────────────────────────┤
│ Guest OS (Linux) │ ← Full OS (1-2GB RAM)
├─────────────────────────────────────┤
│ Hypervisor │ ← VMware/VirtualBox
├─────────────────────────────────────┤
│ Host OS (Windows) │
├─────────────────────────────────────┤
│ Hardware │
└─────────────────────────────────────┘

```

**Container Architecture:**

```

┌─────────────────────────────────────┐
│ App 1 │ App 2 │ ← Applications only
├─────────────────┼─────────────────────┤
│ Container Engine (Docker) │ ← Shared runtime
├─────────────────────────────────────┤
│ Host OS (Linux) │ ← Single OS kernel
├─────────────────────────────────────┤
│ Hardware │
└─────────────────────────────────────┘

```

**Chi tiết so sánh:**

| Khía cạnh               | Virtual Machine               | Container                         |
| ----------------------- | ----------------------------- | --------------------------------- |
| **Kích thước**          | 1-10GB (bao gồm full OS)      | 10-100MB (chỉ app + dependencies) |
| **Thời gian khởi động** | 30-60 giây                    | 1-3 giây                          |
| **Tài nguyên RAM**      | 512MB - 8GB                   | 10-100MB                          |
| **Isolation level**     | Complete (hardware level)     | Process level (OS kernel shared)  |
| **Security**            | Very high (full OS isolation) | Good (process isolation)          |
| **Performance**         | Có overhead đáng kể           | Gần như native performance        |
| **Portability**         | Dependent on hypervisor       | Runs anywhere Docker installed    |

### 1.2 Docker Core Concepts

**Image (Hình ảnh):**

- Template chỉ đọc (read-only) để tạo containers
- Chứa application code, runtime, libraries, environment variables
- Được xây dựng từ layers (lớp)
- Bất biến (immutable) - không thể thay đổi sau khi tạo

**Container (Thùng chứa):**

- Runtime instance của image
- Có thể được start, stop, move, delete
- Isolated từ host và containers khác
- Có writable layer riêng

**Dockerfile:**

- Text file chứa instructions để build image
- Mỗi instruction tạo ra một layer mới
- Declarative approach - mô tả muốn gì thay vì làm thế nào

**Registry (Kho lưu trữ):**

- Centralized place để store và distribute images
- Docker Hub là public registry lớn nhất
- Có thể setup private registry

**Volume (Ổ đĩa):**

- Persistent storage outside container filesystem
- Dữ liệu tồn tại khi container bị xóa
- Có thể share giữa multiple containers

### 1.3 Docker Benefits Chi Tiết

**✅ Consistency (Tính nhất quán):**

```bash
# Trước Docker
Developer: "It works on my machine!"
QA: "But it fails in testing environment!"
DevOps: "Production is different from staging!"

# Với Docker
Developer: "Here's the container image"
QA: "Same image runs perfectly in testing"
DevOps: "Production uses identical image"
```

**✅ Portability (Tính di động):**

- Chạy trên bất kỳ OS nào có Docker (Linux, Windows, macOS)
- Cloud agnostic (AWS, Azure, GCP, on-premise)
- Dev laptop → Staging → Production với cùng image

**✅ Efficiency (Hiệu quả):**

- Chia sẻ OS kernel → ít tài nguyên hơn VMs
- Fast startup time
- Higher density (nhiều containers hơn VMs trên cùng hardware)

**✅ Scalability (Khả năng mở rộng):**

- Horizontal scaling dễ dàng
- Container orchestration (Kubernetes, Docker Swarm)
- Auto-scaling based on metrics

**✅ DevOps Integration:**

- CI/CD pipelines
- Infrastructure as Code
- Microservices architecture
- Blue-green deployments

### 1.4 Docker Use Cases

**Development:**

```bash
# Thay vì cài đặt local
npm install
python -m pip install
composer install

# Chỉ cần
docker run -v $(pwd):/app node:18 npm install
docker run -v $(pwd):/app python:3.11 pip install -r requirements.txt
docker run -v $(pwd):/app composer install
```

**Testing:**

```bash
# Test với multiple versions
docker run -v $(pwd):/app node:16 npm test
docker run -v $(pwd):/app node:18 npm test
docker run -v $(pwd):/app node:20 npm test
```

**Production:**

```bash
# Consistent deployment
docker run -d --name web myapp:v1.2.3
docker run -d --name api myapi:v2.1.0
```

---

## 2. Docker Architecture

### 2.1 Docker Engine Components Chi Tiết

```
┌─────────────────────────────────────┐
│           Docker Client             │  ← CLI (docker command)
│        (docker commands)            │
└──────────────┬──────────────────────┘
               │ REST API calls
┌──────────────▼──────────────────────┐
│           Docker Daemon             │  ← dockerd process
│             (dockerd)               │
│  ┌─────────────────────────────────┐│
│  │     Image Management           ││
│  │     Container Management       ││
│  │     Network Management         ││
│  │     Volume Management          ││
│  └─────────────────────────────────┘│
└──────────────┬──────────────────────┘
               │ gRPC calls
┌──────────────▼──────────────────────┐
│        Container Runtime            │  ← High-level runtime
│         (containerd)                │
│  ┌─────────────────────────────────┐│
│  │     Image Store                ││
│  │     Container Store            ││
│  │     Snapshot Management        ││
│  └─────────────────────────────────┘│
└──────────────┬──────────────────────┘
               │ Calls
┌──────────────▼──────────────────────┐
│             runC                    │  ← Low-level runtime
│      (OCI Runtime Spec)             │  ← Creates containers
└─────────────────────────────────────┘
```

**Docker Client:**

- Command-line interface (CLI)
- Gửi commands tới Docker daemon via REST API
- Có thể connect tới remote daemon

**Docker Daemon (dockerd):**

- Background service quản lý Docker objects
- Listens cho Docker API requests
- Manages images, containers, networks, volumes

**containerd:**

- Industry-standard container runtime
- Manages container lifecycle
- Image management và storage
- Network namespace management

**runC:**

- Low-level container runtime
- OCI (Open Container Initiative) compliant
- Actually creates và runs containers
- Handles Linux namespaces và cgroups

### 2.2 Docker Installation Chi Tiết

**Ubuntu/Debian Installation:**

```bash
# 1. Update package index
sudo apt-get update

# 2. Install prerequisites
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 3. Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 4. Set up stable repository
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 6. Verify installation
sudo docker run hello-world

# 7. Add user to docker group (optional)
sudo usermod -aG docker $USER
newgrp docker  # Or logout/login

# 8. Configure Docker to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

**CentOS/RHEL Installation:**

```bash
# 1. Install required packages
sudo yum install -y yum-utils

# 2. Add Docker repository
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 3. Install Docker Engine
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 4. Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# 5. Verify installation
sudo docker run hello-world
```

**Docker Desktop (Windows/macOS):**

- Download từ docker.com
- GUI application với integrated development experience
- Includes Docker Engine, Docker CLI client, Docker Compose
- Kubernetes integration built-in

**Post-Installation Configuration:**

```bash
# Docker daemon configuration
sudo nano /etc/docker/daemon.json
```

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2",
  "exec-opts": ["native.cgroupdriver=systemd"],
  "insecure-registries": ["myregistry.com:5000"],
  "registry-mirrors": ["https://mirror.gcr.io"]
}
```

```bash
# Restart Docker service
sudo systemctl restart docker
```

---

## 3. Docker Images

### 3.1 Image Architecture Chi Tiết

**Image Layers System:**

```
┌─────────────────────┐ ← Layer 4: ADD app.js /app/     (5MB)
├─────────────────────┤ ← Layer 3: RUN npm install     (150MB)
├─────────────────────┤ ← Layer 2: COPY package.json   (1KB)
├─────────────────────┤ ← Layer 1: RUN apt-get update  (30MB)
└─────────────────────┘ ← Base Layer: FROM node:18     (300MB)
                        Total: 485MB
```

**Layer Sharing:**

```
Image A (485MB)          Image B (355MB)
┌─────────────────────┐  ┌─────────────────────┐
│ App A files         │  │ App B files         │
├─────────────────────┤  ├─────────────────────┤
│                     │  │ Python packages     │
├─────────────────────┤  ├─────────────────────┤
│ Shared layers       │  │                     │
│ (only stored once)  │◄─┤ Shared layers       │
└─────────────────────┘  └─────────────────────┘
Total disk usage: 485MB + 70MB = 555MB (not 840MB)
```

### 3.2 Image Commands Chi Tiết

**Image Management:**

```bash
# List all images
docker images
docker image ls

# Detailed listing
docker images --all           # Include intermediate images
docker images --digests       # Show digests
docker images --filter "dangling=true"  # Show dangling images
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

# Pull images
docker pull nginx:latest      # Pull latest tag
docker pull nginx:1.21        # Pull specific version
docker pull --all-tags nginx  # Pull all tags

# Pull from different registries
docker pull gcr.io/my-project/my-image:v1.0
docker pull myregistry.com:5000/my-image:latest

# Remove images
docker rmi nginx:latest       # Remove by name:tag
docker rmi $(docker images -q) # Remove all images
docker image prune            # Remove dangling images
docker image prune -a         # Remove all unused images

# Image inspection
docker inspect nginx:latest   # Detailed JSON output
docker history nginx:latest   # Show layers and commands
docker image ls --tree        # Show image hierarchy (if supported)
```

**Image Building:**

```bash
# Basic build
docker build -t myapp:latest .

# Build with specific Dockerfile
docker build -t myapp:v1.0 -f Dockerfile.prod .

# Build with build arguments
docker build --build-arg NODE_VERSION=18 -t myapp:latest .

# Build with no cache
docker build --no-cache -t myapp:latest .

# Build with target stage (multi-stage)
docker build --target production -t myapp:prod .

# Build with custom context
docker build -t myapp:latest https://github.com/user/repo.git#main

# Build with .dockerignore
echo "node_modules" > .dockerignore
echo "*.log" >> .dockerignore
docker build -t myapp:latest .
```

**Image Tagging và Distribution:**

```bash
# Tag images
docker tag myapp:latest myregistry.com/myapp:v1.0
docker tag myapp:latest myregistry.com/myapp:latest

# Push to registry
docker push myregistry.com/myapp:v1.0
docker push myregistry.com/myapp:latest

# Save/Load images (for offline transfer)
docker save myapp:latest > myapp.tar
docker save myapp:latest | gzip > myapp.tar.gz

# Load image from file
docker load < myapp.tar
gunzip -c myapp.tar.gz | docker load

# Export/Import containers as images
docker export container_name > container.tar
docker import container.tar myapp:imported
```

### 3.3 Base Images Strategy

**Choosing Base Images:**

**1. Distroless Images (Google):**

```dockerfile
# Minimal attack surface
FROM gcr.io/distroless/java:11
COPY app.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

**2. Alpine Linux:**

```dockerfile
# Small size (~5MB)
FROM alpine:3.18
RUN apk add --no-cache nodejs npm
WORKDIR /app
COPY . .
CMD ["node", "app.js"]
```

**3. Ubuntu/Debian:**

```dockerfile
# Full-featured, larger size
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*
```

**4. Language-specific Official Images:**

```dockerfile
# Optimized for specific language
FROM node:18-alpine     # Node.js on Alpine
FROM python:3.11-slim   # Python on Debian slim
FROM openjdk:17-jre     # Java runtime only
```

**Base Image Comparison:**

| Base Image               | Size   | Security  | Use Case                |
| ------------------------ | ------ | --------- | ----------------------- |
| `scratch`                | 0B     | Highest   | Static binaries only    |
| `gcr.io/distroless/java` | ~50MB  | Very High | Java apps, no shell     |
| `alpine:3.18`            | ~5MB   | High      | Minimal Linux apps      |
| `debian:bookworm-slim`   | ~70MB  | Good      | Balanced choice         |
| `ubuntu:22.04`           | ~70MB  | Good      | Full Linux features     |
| `centos:8`               | ~200MB | Good      | Enterprise environments |

---

## 4. Docker Containers

### 4.1 Container Lifecycle Chi Tiết

```
┌─────────┐  docker create  ┌─────────┐  docker start  ┌─────────┐
│ Image   │ ──────────────→ │ Created │ ─────────────→ │ Running │
└─────────┘                 └─────────┘                └────┬────┘
                                                            │
    ┌─────────┐  docker run (create + start)                │
    │ Image   │ ─────────────────────────────────────────────┘
    └─────────┘                                              │
                                                            │
┌─────────┐  docker restart  ┌─────────┐ ←─────────────────────┘
│ Stopped │ ←──────────────── │ Running │
└────▲────┘                  └────┬────┘
     │                            │
     │ docker start               │ docker stop/kill
     │                            │
     └────────────────────────────▼
     ┌─────────┐  docker pause   ┌─────────┐
     │ Exited  │                 │ Paused  │
     └─────────┘                 └─────────┘
```

### 4.2 Container Run Options Chi Tiết

**Basic Container Operations:**

```bash
# Create và start container
docker run nginx                           # Foreground mode
docker run -d nginx                        # Detached mode (background)
docker run -it ubuntu bash                 # Interactive mode với terminal
docker run --rm nginx                      # Auto-remove khi exit
docker run --name webserver nginx          # Custom container name

# Container lifecycle management
docker create --name web nginx             # Create only (not start)
docker start web                          # Start existing container
docker stop web                           # Graceful stop (SIGTERM)
docker kill web                           # Force kill (SIGKILL)
docker restart web                        # Stop then start
docker pause web                          # Pause all processes
docker unpause web                        # Resume paused container
```

**Port Mapping và Networking:**

```bash
# Port mapping
docker run -p 8080:80 nginx               # Host 8080 → Container 80
docker run -p 127.0.0.1:8080:80 nginx     # Bind to specific interface
docker run -p 3000-3005:3000-3005 nginx   # Range of ports
docker run -P nginx                       # Auto-map all exposed ports

# Network options
docker run --network=host nginx           # Use host's network
docker run --network=none nginx           # No network access
docker run --network=bridge nginx         # Default bridge network
docker run --network=my-network nginx     # Custom network

# Hostname và DNS
docker run --hostname=webserver nginx
docker run --dns=8.8.8.8 nginx
docker run --dns-search=example.com nginx
docker run --add-host=db:192.168.1.100 nginx
```

**Environment Variables:**

```bash
# Single environment variable
docker run -e NODE_ENV=production nginx

# Multiple environment variables
docker run -e NODE_ENV=production -e PORT=3000 nginx

# From file
docker run --env-file production.env nginx

# Show container environment
docker exec container_name env
```

**Volume Mounts:**

```bash
# Named volume
docker run -v myvolume:/data nginx

# Bind mount
docker run -v /host/path:/container/path nginx
docker run -v $(pwd):/app nginx              # Current directory

# Read-only mount
docker run -v /host/path:/container/path:ro nginx

# tmpfs mount (memory-based)
docker run --tmpfs /tmp nginx
```

**Resource Limits:**

```bash
# Memory limits
docker run -m 512m nginx                  # 512MB memory limit
docker run --memory=1g nginx              # 1GB memory limit
docker run --memory=1g --memory-swap=2g nginx  # Memory + swap limit

# CPU limits
docker run --cpus="1.5" nginx             # 1.5 CPU cores
docker run --cpu-shares=512 nginx         # Relative CPU weight
docker run --cpuset-cpus="0,1" nginx      # Specific CPU cores

# Combined resource limits
docker run --memory=512m --cpus="1.0" --name web nginx

# Check resource usage
docker stats                              # Live resource usage
docker stats web                          # Specific container
```

**Security Options:**

```bash
# User options
docker run --user 1000:1000 nginx         # Run as specific UID:GID
docker run --user nobody nginx            # Run as nobody user

# Security options
docker run --read-only nginx              # Read-only filesystem
docker run --cap-drop=ALL nginx           # Drop all capabilities
docker run --cap-add=NET_ADMIN nginx      # Add specific capability
docker run --security-opt=no-new-privileges nginx
docker run --privileged nginx             # Full privileges (avoid in production)

# SELinux/AppArmor
docker run --security-opt label:type:container_t nginx
docker run --security-opt apparmor:unconfined nginx
```

**Restart Policies:**

```bash
docker run --restart=no nginx             # Never restart (default)
docker run --restart=always nginx         # Always restart
docker run --restart=unless-stopped nginx # Restart unless explicitly stopped
docker run --restart=on-failure:3 nginx   # Restart on failure, max 3 attempts
```

### 4.3 Container Management Chi Tiết

**Container Inspection:**

```bash
# List containers
docker ps                                 # Running containers
docker ps -a                              # All containers
docker ps -q                              # Only container IDs
docker ps --filter "status=running"       # Filter by status
docker ps --filter "name=web"             # Filter by name
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Container details
docker inspect container_name             # Detailed JSON info
docker inspect --format='{{.State.Status}}' container_name
docker inspect --format='{{.NetworkSettings.IPAddress}}' container_name

# Container processes
docker top container_name                 # Running processes
docker exec container_name ps aux         # Processes inside container

# Container logs
docker logs container_name                # All logs
docker logs -f container_name             # Follow logs
docker logs --tail=100 container_name     # Last 100 lines
docker logs --since="2023-01-01T00:00:00" container_name
docker logs --until="2023-12-31T23:59:59" container_name
```

**Executing Commands:**

```bash
# Interactive shell
docker exec -it container_name bash       # Bash shell
docker exec -it container_name sh         # Shell (for Alpine)
docker exec -it container_name /bin/bash  # Explicit path

# Run commands
docker exec container_name ls -la         # List files
docker exec container_name pwd            # Current directory
docker exec -w /app container_name ls     # Run in specific directory

# Run as different user
docker exec -u root container_name whoami
docker exec -u 1000:1000 container_name id

# Environment variables
docker exec -e VAR=value container_name env
```

**File Operations:**

```bash
# Copy files to/from container
docker cp file.txt container_name:/path/
docker cp container_name:/path/file.txt ./
docker cp container_name:/app/logs/ ./logs/

# Container filesystem changes
docker diff container_name                # Show changed files

# Create image from container
docker commit container_name new_image:tag
docker commit -m "Added configuration" container_name myimage:v1.1
```

**Container Cleanup:**

```bash
# Remove containers
docker rm container_name                  # Remove stopped container
docker rm -f container_name               # Force remove running container
docker rm $(docker ps -aq)               # Remove all containers

# Cleanup commands
docker container prune                    # Remove stopped containers
docker container prune --filter "until=24h"  # Remove containers older than 24h

# System cleanup
docker system prune                       # Remove unused objects
docker system prune -a                    # Remove all unused objects
docker system prune --volumes             # Include unused volumes
```

---

## 5. Dockerfile

### 5.1 Dockerfile Instructions Chi Tiết

**FROM - Base Image:**

```dockerfile
# Single-stage
FROM node:18-alpine

# Multi-stage with alias
FROM node:18-alpine AS builder

# Using specific digest
FROM node:18-alpine@sha256:abc123...

# Using ARG for dynamic base
ARG NODE_VERSION=18
FROM node:${NODE_VERSION}-alpine

# Scratch image (empty)
FROM scratch
```

**LABEL - Metadata:**

```dockerfile
LABEL maintainer="developer@example.com"
LABEL version="1.0.0"
LABEL description="My web application"
LABEL org.opencontainers.image.title="My App"
LABEL org.opencontainers.image.description="Production web application"
LABEL org.opencontainers.image.vendor="My Company"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.created="2023-01-01T00:00:00Z"
LABEL org.opencontainers.image.source="https://github.com/user/repo"
```

**WORKDIR - Working Directory:**

```dockerfile
WORKDIR /app                    # Set working directory
WORKDIR /var/log               # Can use multiple times
WORKDIR relative/path          # Relative to previous WORKDIR

# Using variables
ENV APP_HOME /app
WORKDIR $APP_HOME
```

**COPY vs ADD:**

```dockerfile
# COPY - Preferred for local files
COPY package.json .            # Copy single file
COPY package*.json ./          # Copy with wildcards
COPY src/ ./src/               # Copy directory
COPY --chown=node:node . .     # Copy with ownership

# ADD - Advanced features
ADD https://example.com/file.tar.gz /tmp/    # Download from URL
ADD file.tar.gz /tmp/          # Auto-extract archives
ADD file.txt /tmp/             # Same as COPY for regular files

# Best practice: Use COPY unless you need ADD's special features
COPY . .
```

**RUN - Execute Commands:**

```dockerfile
# Single command
RUN npm install

# Multiple commands (creates multiple layers - not optimal)
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN rm -rf /var/lib/apt/lists/*

# Combined commands (single layer - optimal)
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Using exec form
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "curl"]

# Cache busting
RUN apt-get update && apt-get install -y \
    package1=1.0.0 \
    package2=2.0.0 \
    && rm -rf /var/lib/apt/lists/*
```

**ENV - Environment Variables:**

```dockerfile
# Single variable
ENV NODE_ENV=production

# Multiple variables
ENV NODE_ENV=production \
    PORT=3000 \
    DEBUG=false

# Using ARG to set ENV
ARG APP_ENV=production
ENV NODE_ENV=$APP_ENV

# Complex variables
ENV PATH="/app/bin:${PATH}"
ENV DATABASE_URL="postgres://user:pass@db:5432/myapp"
```

**ARG - Build Arguments:**

```dockerfile
# Define build argument
ARG NODE_VERSION=18
ARG BUILD_DATE
ARG GIT_COMMIT

# Use in FROM
FROM node:${NODE_VERSION}-alpine

# Use in other instructions
RUN echo "Built on: $BUILD_DATE"
RUN echo "Git commit: $GIT_COMMIT"

# Set default values
ARG APP_ENV=production
ARG DEBUG=false

# Multi-stage args
FROM node:18-alpine AS base
ARG NODE_ENV=production

FROM base AS development
ARG NODE_ENV=development
```

**EXPOSE - Port Documentation:**

```dockerfile
# TCP ports (default)
EXPOSE 3000
EXPOSE 8080

# UDP ports
EXPOSE 53/udp

# Multiple ports
EXPOSE 80 443

# Using variables
ARG PORT=3000
EXPOSE $PORT

# Note: EXPOSE is documentation only, doesn't actually publish ports
```

**VOLUME - Mount Points:**

```dockerfile
# Single volume
VOLUME ["/data"]

# Multiple volumes
VOLUME ["/data", "/logs", "/config"]

# Using variables
ENV DATA_DIR=/data
VOLUME ["$DATA_DIR"]

# Note: Creates anonymous volume if not explicitly mounted
```

**USER - Security:**

```dockerfile
# Switch to non-root user
USER node

# Using UID:GID
USER 1000:1000

# Create and switch user
RUN addgroup -g 1001 -S appgroup && \
    adduser -S appuser -u 1001 -G appgroup
USER appuser

# Switch user for specific commands
USER root
RUN apt-get update && apt-get install -y package
USER appuser
```

**ENTRYPOINT vs CMD:**

```dockerfile
# CMD - Can be overridden
CMD ["node", "app.js"]                    # Exec form (preferred)
CMD node app.js                           # Shell form

# ENTRYPOINT - Cannot be overridden
ENTRYPOINT ["node"]                       # Fixed entry point
CMD ["app.js"]                           # Default argument

# Combined - flexible but fixed entry point
ENTRYPOINT ["node"]
CMD ["app.js"]
# docker run myimage server.js → node server.js

# Complex entrypoint
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["start"]
```

### 5.2 Multi-Stage Builds Chi Tiết

**Basic Multi-Stage Pattern:**

```dockerfile
# Stage 1: Build environment
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy source and build
COPY . .
RUN npm run build

# Stage 2: Production environment
FROM nginx:alpine AS production

# Copy built assets
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Advanced Multi-Stage với Multiple Targets:**

```dockerfile
# Base stage - common dependencies
FROM node:18-alpine AS base
WORKDIR /app
RUN apk add --no-cache git python3 make g++

# Dependencies stage
FROM base AS dependencies
COPY package*.json ./
RUN npm ci --only=production

# Development stage
FROM dependencies AS development
RUN npm ci
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]

# Test stage
FROM development AS test
RUN npm run lint
RUN npm run test
RUN npm run test:coverage

# Build stage
FROM development AS builder
RUN npm run build

# Security scan stage
FROM builder AS security
RUN npm audit --audit-level=high
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/
RUN trivy fs --exit-code 1 .

# Production stage
FROM nginx:alpine AS production

# Install security updates
RUN apk upgrade --no-cache

# Create non-root user
RUN addgroup -g 1001 -S appgroup && \
    adduser -S appuser -u 1001 -G appgroup

# Copy built application
COPY --from=builder --chown=appuser:appgroup /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY --chown=appuser:appgroup nginx.conf /etc/nginx/conf.d/default.conf

# Set ownership and permissions
RUN chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    mkdir -p /var/cache/nginx/client_temp && \
    chown -R appuser:appgroup /var/cache/nginx

USER appuser

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
```

**Build Different Targets:**

```bash
# Build development image
docker build --target development -t myapp:dev .

# Build production image
docker build --target production -t myapp:prod .

# Build and run tests
docker build --target test -t myapp:test .

# Build with security scanning
docker build --target security -t myapp:secure .
```

### 5.3 Dockerfile Optimization

**Layer Optimization:**

```dockerfile
# ❌ Bad: Multiple layers
FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN rm -rf /var/lib/apt/lists/*

# ✅ Good: Single layer
FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        vim \
    && rm -rf /var/lib/apt/lists/*
```

**Dependency Caching:**

```dockerfile
# ❌ Bad: Dependencies installed every time source changes
FROM node:18-alpine
WORKDIR /app
COPY . .
RUN npm install

# ✅ Good: Cache dependencies separately
FROM node:18-alpine
WORKDIR /app

# Copy package files first
COPY package*.json ./
RUN npm ci --only=production

# Copy source files after dependencies
COPY . .
```

**Image Size Optimization:**

```dockerfile
FROM node:18-alpine AS builder

# Use build dependencies in separate layer
RUN apk add --no-cache --virtual .build-deps \
    python3 \
    make \
    g++

COPY package*.json ./
RUN npm ci --only=production

# Remove build dependencies
RUN apk del .build-deps

# Final stage without build tools
FROM node:18-alpine AS production
COPY --from=builder /app/node_modules ./node_modules
COPY . .
```

**Security Optimization:**

```dockerfile
FROM node:18-alpine

# Update packages
RUN apk upgrade --no-cache

# Create non-root user early
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 -G nodejs

# Set working directory and ownership
WORKDIR /app
RUN chown nodejs:nodejs /app

# Switch to non-root user
USER nodejs

# Copy with proper ownership
COPY --chown=nodejs:nodejs package*.json ./
RUN npm ci --only=production

COPY --chown=nodejs:nodejs . .

# Use exec form for signals
CMD ["node", "app.js"]
```

### 5.4 .dockerignore File

**Comprehensive .dockerignore:**

```dockerignore
# Version control
.git
.gitignore
.gitattributes
.gitmodules
.svn

# Dependencies
node_modules
bower_components
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
dist
build
.next
out
target
*.tgz
*.tar.gz

# Environment files
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
.env.staging

# Runtime data
pids
*.pid
*.seed
*.pid.lock
logs
*.log

# IDE and editor files
.vscode
.idea
*.swp
*.swo
*~
.project
.classpath
.settings
*.sublime-project
*.sublime-workspace

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Testing
coverage
.nyc_output
test-results
junit.xml

# Documentation
README.md
CHANGELOG.md
docs/
*.md

# Docker files
Dockerfile*
docker-compose*
.dockerignore

# CI/CD
.github
.gitlab-ci.yml
.travis.yml
Jenkinsfile
azure-pipelines.yml

# Temporary files
tmp
temp
.tmp
.temp

# Language specific
# Python
__pycache__
*.pyc
*.pyo
*.pyd
.Python
pip-log.txt
pip-delete-this-directory.txt

# Java
*.class
*.jar
*.war
*.ear

# Go
vendor/
```

**Conditional .dockerignore:**

```bash
# Create different .dockerignore for different environments
# .dockerignore.dev
node_modules
.git

# .dockerignore.prod
node_modules
.git
src/
tests/
docs/

# Use in build
cp .dockerignore.prod .dockerignore
docker build -t myapp:prod .
```

---

## 6. Docker Networking

### 6.1 Network Types Chi Tiết

**Bridge Network (Default):**

```bash
# Default bridge network
docker network ls
# NETWORK ID     NAME      DRIVER    SCOPE
# 12345678...    bridge    bridge    local

# Create custom bridge network
docker network create mynetwork
docker network create --driver bridge \
  --subnet=172.20.0.0/16 \
  --gateway=172.20.0.1 \
  mynetwork

# Advanced bridge configuration
docker network create \
  --driver=bridge \
  --subnet=172.20.0.0/16 \
  --ip-range=172.20.240.0/20 \
  --gateway=172.20.0.1 \
  --opt com.docker.network.bridge.name=docker1 \
  --opt com.docker.network.bridge.enable_ip_masquerade=true \
  --opt com.docker.network.bridge.enable_icc=true \
  --opt com.docker.network.driver.mtu=1450 \
  mynetwork
```

**Host Network:**

```bash
# Use host's network stack directly
docker run --network=host nginx

# Container shares host's IP address
# No network isolation
# Better performance for network-intensive apps
# Port conflicts possible
```

**None Network:**

```bash
# No network access
docker run --network=none alpine

# Useful for:
# - Batch processing jobs
# - Security-sensitive applications
# - Applications that don't need network
```

**Overlay Network (Swarm Mode):**

```bash
# Initialize Swarm
docker swarm init

# Create overlay network
docker network create --driver overlay myoverlay

# Encrypted overlay
docker network create \
  --driver overlay \
  --opt encrypted \
  secure-overlay
```

### 6.2 Network Management

**Network Operations:**

```bash
# Create networks
docker network create mynet                    # Default bridge
docker network create -d bridge mynet         # Explicit bridge
docker network create -d host mynet           # Host network
docker network create -d none mynet           # None network

# List networks
docker network ls
docker network ls --filter driver=bridge
docker network ls --format "table {{.Name}}\t{{.Driver}}\t{{.Scope}}"

# Inspect network
docker network inspect bridge                 # Default bridge
docker network inspect mynet                  # Custom network

# Remove networks
docker network rm mynet                       # Remove specific network
docker network prune                          # Remove unused networks
```

**Container Network Operations:**

```bash
# Connect container to network
docker network connect mynet container_name
docker network connect --ip 172.20.0.100 mynet container_name

# Disconnect container from network
docker network disconnect mynet container_name

# Run container on specific network
docker run --network=mynet nginx
docker run --network=mynet --ip 172.20.0.50 nginx

# Multiple networks
docker run --network=net1 nginx
docker network connect net2 container_name    # Connect to second network
```

### 6.3 Service Discovery

**DNS Resolution:**

```bash
# Create network
docker network create myapp

# Run containers on same network
docker run -d --name db --network=myapp postgres
docker run -d --name web --network=myapp nginx

# Containers can reach each other by name
docker exec web ping db                       # Works!
docker exec web curl http://db:5432          # Database connection
```

**Custom DNS Configuration:**

```bash
# Custom DNS servers
docker run --dns=8.8.8.8 --dns=8.8.4.4 nginx

# DNS search domains
docker run --dns-search=example.com nginx

# Custom hosts entries
docker run --add-host=database:192.168.1.100 nginx

# Custom hostname
docker run --hostname=webserver nginx
```

**Service Discovery in Practice:**

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx
    networks:
      - frontend
      - backend
    depends_on:
      - api

  api:
    image: myapi
    networks:
      - backend
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/myapp

  db:
    image: postgres
    networks:
      - backend
    environment:
      - POSTGRES_DB=myapp

networks:
  frontend:
  backend:
    internal: true # No external access
```

### 6.4 Load Balancing

**Nginx Load Balancer:**

```nginx
# nginx.conf
upstream backend {
    least_conn;                    # Load balancing method
    server web1:80 weight=3;       # Higher weight
    server web2:80 weight=1;
    server web3:80 backup;         # Backup server

    # Health checks
    server web4:80 max_fails=3 fail_timeout=30s;
}

server {
    listen 80;

    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Health check
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;
    }

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
}
```

**HAProxy Load Balancer:**

```haproxy
# haproxy.cfg
global
    daemon
    maxconn 4096

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms
    option httplog
    option redispatch
    retries 3

frontend web_frontend
    bind *:80
    option httplog
    capture request header X-Forwarded-For len 64
    default_backend web_servers

backend web_servers
    balance roundrobin
    option httpchk GET /health

    server web1 web1:80 check weight 1
    server web2 web2:80 check weight 1
    server web3 web3:80 check weight 2 backup

    # Health check configuration
    option httpchk GET /health HTTP/1.1\r\nHost:\ example.com
    http-check expect status 200

listen stats
    bind *:8404
    stats enable
    stats uri /stats
    stats refresh 30s
```

**Docker Compose Load Balancer Setup:**

```yaml
version: "3.8"

services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - web
    networks:
      - frontend

  web:
    image: myapp:latest
    deploy:
      replicas: 3
    networks:
      - frontend
      - backend
    depends_on:
      - db

  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_PASSWORD: secret
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - backend

networks:
  frontend:
  backend:
    internal: true

volumes:
  db_data:
```

---

## 7. Docker Volumes

### 7.1 Volume Types Chi Tiết

**Named Volumes:**

```bash
# Create named volume
docker volume create mydata
docker volume create --driver local mydata
docker volume create --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.1,rw \
  --opt device=:/path/to/dir \
  nfsvolume

# Use named volume
docker run -v mydata:/data nginx
docker run --mount source=mydata,target=/data nginx

# Volume inspection
docker volume ls
docker volume inspect mydata
```

**Bind Mounts:**

```bash
# Bind mount host directory
docker run -v /host/path:/container/path nginx
docker run -v $(pwd):/app node:18

# Windows paths
docker run -v C:\host\path:/container/path nginx
docker run -v ${PWD}:/app node:18  # PowerShell

# Read-only bind mount
docker run -v /host/path:/container/path:ro nginx

# Advanced bind mount options
docker run --mount type=bind,source=/host/path,target=/container/path,readonly nginx
docker run --mount type=bind,source=/host/path,target=/container/path,bind-propagation=shared nginx
```

**tmpfs Mounts:**

```bash
# Memory-based filesystem
docker run --tmpfs /tmp nginx
docker run --tmpfs /tmp:rw,size=100m,mode=1777 nginx

# Using mount syntax
docker run --mount type=tmpfs,destination=/tmp,tmpfs-size=100m nginx

# Use cases:
# - Temporary files
# - Sensitive data that shouldn't persist
# - High-performance temporary storage
```

### 7.2 Volume Management

**Volume Operations:**

```bash
# Create volumes
docker volume create mydata
docker volume create --name mydata --driver local

# List volumes
docker volume ls
docker volume ls --filter dangling=true
docker volume ls --format "table {{.Name}}\t{{.Driver}}\t{{.Mountpoint}}"

# Inspect volume
docker volume inspect mydata
docker volume inspect --format '{{.Mountpoint}}' mydata

# Remove volumes
docker volume rm mydata
docker volume prune                    # Remove unused volumes
docker volume prune --filter "label!=keep"

# Volume backup and restore
docker run --rm -v mydata:/data -v $(pwd):/backup alpine \
  tar czf /backup/backup.tar.gz /data

docker run --rm -v mydata:/data -v $(pwd):/backup alpine \
  tar xzf /backup/backup.tar.gz -C /
```

### 7.3 Volume Plugins và Drivers

**Popular Volume Plugins:**

```bash
# Install volume plugins
docker plugin install store/sumologic/docker-logging-driver:1.0.0
docker plugin install vieux/sshfs

# List installed plugins
docker plugin ls

# Use plugin
docker volume create -d vieux/sshfs \
  -o sshcmd=user@192.168.1.1:/remote/path \
  -o password=secret \
  sshvolume
```

**Storage Drivers:**

| Driver       | Use Case           | Performance | Persistence |
| ------------ | ------------------ | ----------- | ----------- |
| `local`      | Single host        | High        | Yes         |
| `nfs`        | Network storage    | Medium      | Yes         |
| `cifs`       | Windows shares     | Medium      | Yes         |
| `sshfs`      | SSH-based          | Low         | Yes         |
| `aws-ebs`    | AWS EBS volumes    | High        | Yes         |
| `azure-file` | Azure File Storage | Medium      | Yes         |

### 7.4 Volume Best Practices

**Data Persistence Patterns:**

```yaml
# docker-compose.yml
version: "3.8"

services:
  app:
    image: myapp
    volumes:
      # Configuration files (read-only)
      - ./config:/app/config:ro

      # Application data (persistent)
      - app_data:/app/data

      # Logs (persistent, but can be cleaned)
      - app_logs:/app/logs

      # Cache (can be ephemeral)
      - app_cache:/app/cache

      # Temporary files (memory-based)
      - type: tmpfs
        target: /app/tmp
        tmpfs:
          size: 100M

  db:
    image: postgres:13
    volumes:
      # Database data (critical persistence)
      - db_data:/var/lib/postgresql/data

      # Database backups
      - db_backups:/backups

    environment:
      POSTGRES_DB: myapp
      POSTGRES_PASSWORD: secret

volumes:
  app_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/data

  app_logs:
    driver: local

  app_cache:
    driver: local

  db_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/postgres

  db_backups:
    driver: local
```

**Volume Security:**

```dockerfile
# In Dockerfile
FROM alpine
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser && \
    mkdir -p /app/data && \
    chown appuser:appgroup /app/data
USER appuser
VOLUME ["/app/data"]
```

```bash
# Set proper permissions on host
sudo mkdir -p /opt/myapp/data
sudo chown 1001:1001 /opt/myapp/data
sudo chmod 755 /opt/myapp/data
```

---

## 8. Docker Compose

### 8.1 Compose File Format

**Basic Structure:**

```yaml
# docker-compose.yml
version: "3.8" # Compose file version

services: # Define services
  web:
    # Service configuration

networks:# Define networks (optional)
  # Network configuration

volumes:# Define volumes (optional)
  # Volume configuration

configs:# Define configs (optional)
  # Config configuration

secrets:# Define secrets (optional)
  # Secret configuration
```

**Service Configuration Options:**

```yaml
services:
  web:
    # Image options
    image: nginx:alpine # Use existing image
    build: # Or build from source
      context: .
      dockerfile: Dockerfile
      args:
        - NODE_VERSION=18
      target: production

    # Container options
    container_name: web-server
    hostname: webserver

    # Network options
    ports:
      - "80:80" # Port mapping
      - "443:443"
    expose:
      - "8080" # Expose to other services
    networks:
      - frontend
      - backend

    # Environment
    environment:
      - NODE_ENV=production
      - DEBUG=false
    env_file:
      - .env
      - .env.production

    # Volumes
    volumes:
      - ./config:/etc/nginx/conf.d:ro
      - web_data:/var/www/html
      - type: tmpfs
        target: /tmp

    # Dependencies
    depends_on:
      - db
      - redis

    # Resource limits
    deploy:
      resources:
        limits:
          cpus: "0.5"
          memory: 512M
        reservations:
          cpus: "0.25"
          memory: 256M

    # Health check
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s

    # Restart policy
    restart: unless-stopped

    # Logging
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

### 8.2 Advanced Compose Features

**Environment Variables:**

```yaml
# docker-compose.yml
version: "3.8"

services:
  web:
    image: nginx:${NGINX_VERSION:-latest}
    ports:
      - "${WEB_PORT:-80}:80"
    environment:
      - API_URL=${API_URL}
      - DEBUG=${DEBUG:-false}

  db:
    image: postgres:${POSTGRES_VERSION:-13}
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
```

**.env File:**

```bash
# .env
NGINX_VERSION=1.21
WEB_PORT=8080
API_URL=https://api.example.com
DEBUG=true
POSTGRES_VERSION=13
DB_NAME=myapp
DB_USER=appuser
DB_PASSWORD=secret123
```

**Multiple Environment Files:**

```bash
# .env.development
NODE_ENV=development
DEBUG=true
DB_HOST=localhost

# .env.production
NODE_ENV=production
DEBUG=false
DB_HOST=production-db.example.com

# .env.staging
NODE_ENV=staging
DEBUG=true
DB_HOST=staging-db.example.com
```

**Override Files:**

```yaml
# docker-compose.yml (base)
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "80:80"

# docker-compose.override.yml (development overrides)
version: '3.8'
services:
  web:
    volumes:
      - .:/app
    environment:
      - DEBUG=true

# docker-compose.prod.yml (production overrides)
version: '3.8'
services:
  web:
    deploy:
      replicas: 3
    environment:
      - DEBUG=false
```

**Using Override Files:**

```bash
# Default: uses docker-compose.yml + docker-compose.override.yml
docker-compose up

# Specific files
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up

# Environment-specific
docker-compose --env-file .env.production up
```

### 8.3 Compose Commands

**Basic Operations:**

```bash
# Start services
docker-compose up                         # Foreground
docker-compose up -d                      # Background (detached)
docker-compose up --build                 # Build images first
docker-compose up --force-recreate        # Recreate containers

# Stop services
docker-compose down                       # Stop and remove containers
docker-compose down -v                    # Also remove volumes
docker-compose down --rmi all             # Also remove images

# Service management
docker-compose start                      # Start stopped services
docker-compose stop                       # Stop running services
docker-compose restart                    # Restart services
docker-compose pause                      # Pause services
docker-compose unpause                    # Unpause services

# Individual services
docker-compose up web                     # Start specific service
docker-compose stop web                   # Stop specific service
docker-compose restart web                # Restart specific service
```

**Scaling và Management:**

```bash
# Scale services
docker-compose up --scale web=3           # Scale to 3 instances
docker-compose up --scale web=3 --scale api=2

# View status
docker-compose ps                         # List containers
docker-compose ps web                     # Specific service
docker-compose top                        # Running processes
docker-compose top web                    # Processes in specific service

# Logs
docker-compose logs                       # All service logs
docker-compose logs -f                    # Follow logs
docker-compose logs web                   # Specific service
docker-compose logs -f --tail=100 web     # Follow last 100 lines

# Execute commands
docker-compose exec web bash              # Interactive shell
docker-compose exec web ls -la           # Run command
docker-compose run web npm test          # Run one-off command
docker-compose run --rm web npm test     # Run and remove container
```

**Configuration và Validation:**

```bash
# Validate configuration
docker-compose config                     # Parse and validate
docker-compose config --services          # List services
docker-compose config --volumes           # List volumes
docker-compose config --quiet             # Only show errors

# Show resolved configuration
docker-compose config --resolve-image-digests
docker-compose config --no-interpolate    # Don't resolve variables

# Pull images
docker-compose pull                       # Pull all service images
docker-compose pull web                   # Pull specific service image

# Build images
docker-compose build                      # Build all services
docker-compose build --no-cache          # Build without cache
docker-compose build web                 # Build specific service
```

### 8.4 Production Compose

**Production-Ready Configuration:**

```yaml
# docker-compose.prod.yml
version: "3.8"

x-common-variables: &common-variables
  POSTGRES_DB: ${DB_NAME}
  POSTGRES_USER: ${DB_USER}
  POSTGRES_PASSWORD_FILE: /run/secrets/db_password

services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/ssl/certs:ro
      - static_files:/var/www/html:ro
    depends_on:
      - web
    networks:
      - frontend
    restart: unless-stopped
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  web:
    build:
      context: .
      dockerfile: Dockerfile.prod
    environment:
      <<: *common-variables
      NODE_ENV: production
    depends_on:
      - db
      - redis
    networks:
      - frontend
      - backend
    restart: unless-stopped
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
        failure_action: rollback
        order: start-first
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
        window: 120s
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  db:
    image: postgres:13-alpine
    environment:
      <<: *common-variables
    secrets:
      - db_password
    volumes:
      - db_data:/var/lib/postgresql/data
      - db_backups:/backups
    networks:
      - backend
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER} -d ${DB_NAME}"]
      interval: 30s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    command: redis-server --appendonly yes --requirepass ${REDIS_PASSWORD}
    volumes:
      - redis_data:/data
    networks:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 3s
      retries: 3

  # Backup service
  backup:
    image: postgres:13-alpine
    environment:
      <<: *common-variables
    secrets:
      - db_password
    volumes:
      - db_backups:/backups
    networks:
      - backend
    entrypoint: |
      bash -c 'bash -s <<EOF
      trap "break;exit" SIGHUP SIGINT SIGTERM
      sleep 30s
      while /bin/true; do
        pg_dump -h db -U ${DB_USER} -d ${DB_NAME} | gzip -9 > /backups/backup_$$(date +%Y%m%d_%H%M%S).sql.gz
        find /backups -name "*.sql.gz" -mtime +7 -delete
        sleep 86400
      done
      EOF'
    restart: unless-stopped

secrets:
  db_password:
    file: ./secrets/db_password.txt

volumes:
  db_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/postgres
  db_backups:
    driver: local
  redis_data:
    driver: local
  static_files:
    driver: local

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true # No external access
```

**Deployment Scripts:**

```bash
#!/bin/bash
# deploy.sh

set -e

ENVIRONMENT=${1:-production}
COMPOSE_FILE="docker-compose.${ENVIRONMENT}.yml"

echo "🚀 Deploying to ${ENVIRONMENT}..."

# Pull latest images
docker-compose -f ${COMPOSE_FILE} pull

# Build services that need building
docker-compose -f ${COMPOSE_FILE} build

# Start services
docker-compose -f ${COMPOSE_FILE} up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
timeout=300
while [ $timeout -gt 0 ]; do
if docker-compose -f ${COMPOSE_FILE} ps | grep -q "healthy\|Up"; then
        echo "✅ Services are healthy!"
        break
    fi
    sleep 10
    timeout=$((timeout-10))
done

echo "🎉 Deployment completed successfully!"
```

---

## 9. Docker Registry

### 9.1 Docker Hub

**Authentication:**

```bash
# Login to Docker Hub
docker login
docker login --username=yourhubusername

# Logout
docker logout
```

**Repository Management:**

```bash
# Push to Docker Hub
docker tag myapp:latest yourusername/myapp:latest
docker push yourusername/myapp:latest

# Pull from Docker Hub
docker pull yourusername/myapp:latest

# Search images
docker search nginx
docker search --limit=10 --filter=stars=100 nginx
```

### 9.2 Private Registry

**Deploy Private Registry:**

```bash
# Run registry container
docker run -d \
  --name registry \
  --restart=always \
  -p 5000:5000 \
  -v registry_data:/var/lib/registry \
  registry:2

# With authentication
docker run -d \
  --name registry \
  --restart=always \
  -p 5000:5000 \
  -v registry_data:/var/lib/registry \
  -v $(pwd)/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
  registry:2
```

---

## 10. Docker Security

### 10.1 Image Security

**Security Scanning:**

```bash
# Docker Scout (built-in)
docker scout cves nginx:latest
docker scout recommendations nginx:latest

# Trivy scanner
trivy image nginx:latest
trivy image --severity HIGH,CRITICAL nginx:latest
```

**Secure Base Images:**

```dockerfile
# Use minimal base images
FROM alpine:3.18
FROM scratch
FROM gcr.io/distroless/java:11

# Use specific versions
FROM node:18.17.0-alpine3.18

# Multi-stage build to reduce attack surface
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM alpine:3.18 AS production
RUN apk add --no-cache nodejs npm
COPY --from=builder /app/node_modules ./node_modules
COPY . .
CMD ["node", "app.js"]
```

### 10.2 Runtime Security

**Container Hardening:**

```bash
# Run as non-root user
docker run --user 1000:1000 nginx

# Read-only filesystem
docker run --read-only nginx

# Drop capabilities
docker run --cap-drop=ALL nginx
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx

# No new privileges
docker run --security-opt=no-new-privileges nginx

# Limit resources
docker run --memory=512m --cpus="1.0" nginx
```

---

## 11. Docker Monitoring

### 11.1 Container Monitoring

**Built-in Monitoring:**

```bash
# Resource usage
docker stats
docker stats --no-stream
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Container processes
docker top container_name
docker exec container_name ps aux

# Container logs
docker logs container_name
docker logs -f --since=1h container_name
docker logs --tail=100 container_name

# System information
docker system df
docker system info
docker system events
```

### 11.2 Prometheus Monitoring

**Prometheus Configuration:**

```yaml
# docker-compose.monitoring.yml
version: "3.8"

services:
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
      - "--storage.tsdb.path=/prometheus"
      - "--web.console.libraries=/etc/prometheus/console_libraries"
      - "--web.console.templates=/etc/prometheus/consoles"
      - "--storage.tsdb.retention.time=15d"
      - "--web.enable-lifecycle"

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana_data:/var/lib/grafana

volumes:
  prometheus_data:
  grafana_data:
```

---

## 12. Docker Production

### 12.1 Production Deployment

**Docker Swarm:**

```bash
# Initialize swarm
docker swarm init --advertise-addr=192.168.1.100

# Join worker nodes
docker swarm join --token TOKEN 192.168.1.100:2377

# Deploy stack
docker stack deploy -c docker-compose.yml myapp

# Scale services
docker service scale myapp_web=5

# Update services
docker service update --image nginx:1.21 myapp_web

# Monitor services
docker service ls
docker service ps myapp_web
```

### 12.2 CI/CD Integration

**GitLab CI/CD:**

```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - deploy

variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"

services:
  - docker:dind

build:
  stage: build
  image: docker:latest
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

test:
  stage: test
  image: docker:latest
  script:
    - docker run --rm $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA npm test

deploy:
  stage: deploy
  image: docker:latest
  script:
    - docker service update --image $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA myapp_web
  only:
    - main
```

---

## 13. Advanced Topics

### 13.1 Docker Swarm Mode

**Swarm Management:**

```bash
# Initialize swarm cluster
docker swarm init

# Add worker nodes
docker swarm join-token worker
docker swarm join-token manager

# Node management
docker node ls
docker node inspect node-1
docker node update --availability drain node-1

# Service management
docker service create --name web --replicas 3 nginx
docker service ls
docker service ps web
docker service scale web=5
docker service update --image nginx:1.21 web
```

### 13.2 Docker API

**Using Docker API:**

```bash
# Enable Docker API
sudo systemctl edit docker.service

# Add:
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375

# Restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# API calls
curl http://localhost:2375/version
curl http://localhost:2375/containers/json
curl -X POST http://localhost:2375/containers/create \
  -H "Content-Type: application/json" \
  -d '{"Image": "nginx", "name": "web"}'
```

### 13.3 Docker Machine

**Provisioning Docker Hosts:**

```bash
# Install Docker Machine
curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
chmod +x /tmp/docker-machine &&
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

# Create Docker host
docker-machine create --driver virtualbox my-host

# Connect to remote Docker
eval $(docker-machine env my-host)
docker ps

# Manage hosts
docker-machine ls
docker-machine start my-host
docker-machine stop my-host
docker-machine rm my-host
```

### 13.4 Multi-Platform Builds

**BuildKit và Buildx:**

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1

# Install buildx
docker buildx install

# Create builder
docker buildx create --name mybuilder --use
docker buildx inspect --bootstrap

# Multi-platform build
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --tag myapp:latest \
  --push .

# Build for specific platform
docker buildx build \
  --platform linux/arm64 \
  --tag myapp:arm64 \
  --load .
```

---

## 🎯 Kết Luận

**Docker Mastery Checklist:**

✅ **Fundamentals** - Container concepts, architecture  
✅ **Images** - Building, optimizing, distributing  
✅ **Containers** - Running, managing, debugging  
✅ **Networking** - Service discovery, load balancing  
✅ **Storage** - Volumes, persistence, backup  
✅ **Compose** - Multi-container orchestration  
✅ **Security** - Hardening, scanning, compliance  
✅ **Monitoring** - Logging, metrics, alerting  
✅ **Production** - Deployment, scaling, CI/CD  
✅ **Advanced** - Swarm, API, multi-platform builds

**Next Steps:**

1. **Kubernetes** - Container orchestration at scale
2. **Service Mesh** - Advanced networking and security
3. **GitOps** - Git-based deployment workflows
4. **Cloud-Native** - CNCF ecosystem integration

**Resources:**

- [Docker Official Documentation](https://docs.docker.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [CNCF Landscape](https://landscape.cncf.io/)
- [Container Training](https://container.training/)

🚀 **Congratulations! Bạn đã complete Docker mastery journey!**

```

Made changes.

Similar code found with 3 license types
```
