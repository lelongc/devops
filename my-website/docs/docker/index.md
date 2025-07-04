# Docker Complete Knowledge Base

## 🎯 Mục tiêu

Trở thành Docker Expert với kiến thức toàn diện về containerization, từ cơ bản đến nâng cao.

---

## 📚 **1. DOCKER FUNDAMENTALS**

### 1.1 Docker Architecture

```bash
# Docker Components
Docker Engine           # Core runtime
Docker Daemon          # Background service (dockerd)
Docker Client          # Command-line interface
Docker Images          # Read-only templates
Docker Containers      # Running instances
Docker Registry        # Image storage (Docker Hub)
Docker Networks        # Container networking
Docker Volumes         # Data persistence

# Docker Architecture
┌─────────────────────────────────────────────┐
│                Docker Client               │
│            (docker commands)               │
└─────────────────┬───────────────────────────┘
                  │ REST API
┌─────────────────▼───────────────────────────┐
│              Docker Daemon                 │
│  ┌─────────────┬─────────────┬─────────────┐│
│  │   Images    │ Containers  │  Networks   ││
│  └─────────────┴─────────────┴─────────────┘│
└─────────────────────────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│              Host OS Kernel                │
└─────────────────────────────────────────────┘
```

### 1.2 Installation & Setup

```bash
# Ubuntu/Debian Installation
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker

# CentOS/RHEL Installation
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

# Verify Installation
docker --version
docker info
docker run hello-world
docker system info

# Docker Desktop (Windows/Mac)
# Download from https://www.docker.com/products/docker-desktop
```

---

## 🐳 **2. DOCKER IMAGES**

### 2.1 Image Management Commands

```bash
# List Images
docker images                    # List all images
docker image ls                  # Same as above
docker images -a                 # Include intermediate images
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
docker images --filter "dangling=true"  # List dangling images
docker images --filter "before=ubuntu:18.04"  # Images before ubuntu:18.04

# Pull Images
docker pull ubuntu               # Pull latest ubuntu
docker pull ubuntu:20.04        # Pull specific tag
docker pull nginx:alpine         # Pull alpine version
docker pull mysql:8.0           # Pull specific version
docker pull --all-tags ubuntu   # Pull all tags

# Search Images
docker search nginx              # Search Docker Hub
docker search --limit 5 mysql   # Limit results
docker search --filter stars=3 python  # Filter by stars

# Remove Images
docker rmi image_id              # Remove by ID
docker rmi ubuntu:20.04          # Remove by name:tag
docker rmi $(docker images -q)  # Remove all images
docker image prune               # Remove dangling images
docker image prune -a            # Remove all unused images
docker system prune              # Remove all unused objects
```

### 2.2 Building Images

```bash
# Dockerfile Commands
FROM ubuntu:20.04              # Base image
LABEL maintainer="admin@example.com"  # Metadata
ENV APP_HOME=/app              # Environment variables
WORKDIR /app                   # Working directory
COPY . /app                    # Copy files from host
ADD file.tar.gz /app           # Add and extract
RUN apt-get update && apt-get install -y python3  # Execute commands
EXPOSE 8080                    # Expose port
VOLUME ["/data"]               # Create volume
USER appuser                   # Switch user
CMD ["python3", "app.py"]      # Default command
ENTRYPOINT ["python3"]         # Entry point

# Multi-stage Dockerfile Example
FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Build Commands
docker build .                 # Build from current directory
docker build -t myapp:latest .  # Build with tag
docker build -t myapp:v1.0 -f Dockerfile.prod .  # Custom Dockerfile
docker build --no-cache .      # Build without cache
docker build --build-arg ENV=prod .  # Build arguments
docker build --target builder . # Build specific stage
```

### 2.3 Image Operations

```bash
# Image Information
docker image inspect ubuntu     # Detailed image info
docker image history ubuntu     # Image layers
docker image ls --digests       # Show digests

# Tag Images
docker tag source_image:tag target_image:tag
docker tag myapp:latest myapp:v1.0
docker tag myapp:latest registry.example.com/myapp:latest

# Save/Load Images
docker save -o myapp.tar myapp:latest      # Save to tar file
docker load -i myapp.tar                  # Load from tar file
docker export container_id > container.tar # Export container
docker import container.tar myapp:imported # Import as image

# Push Images
docker login                    # Login to registry
docker push myapp:latest        # Push to Docker Hub
docker push registry.example.com/myapp:latest  # Push to private registry
docker logout                   # Logout
```

---

## 📦 **3. DOCKER CONTAINERS**

### 3.1 Container Lifecycle

```bash
# Run Containers
docker run ubuntu               # Run and exit
docker run -it ubuntu bash     # Interactive with TTY
docker run -d nginx             # Detached (background)
docker run --name mycontainer nginx  # Named container
docker run -p 8080:80 nginx     # Port mapping
docker run -v /host/path:/container/path ubuntu  # Volume mount
docker run --rm ubuntu          # Remove after exit
docker run -e ENV_VAR=value ubuntu  # Environment variable

# Container States
docker ps                       # Running containers
docker ps -a                    # All containers
docker ps -l                    # Last created container
docker ps -n 5                  # Last 5 containers
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Container Control
docker start container_name     # Start stopped container
docker stop container_name      # Graceful stop
docker kill container_name      # Force stop
docker restart container_name   # Restart container
docker pause container_name     # Pause container
docker unpause container_name   # Unpause container
```

### 3.2 Container Operations

```bash
# Execute Commands
docker exec -it container_name bash     # Interactive shell
docker exec container_name ls -la       # Execute command
docker exec -u root container_name bash # Execute as root
docker exec -w /app container_name pwd  # Execute in directory

# Container Information
docker inspect container_name    # Detailed info
docker logs container_name       # Container logs
docker logs -f container_name    # Follow logs
docker logs --tail 50 container_name  # Last 50 lines
docker logs --since "2023-01-01" container_name  # Logs since date
docker stats                     # Real-time stats
docker stats container_name      # Specific container stats
docker top container_name        # Running processes
docker port container_name       # Port mappings

# Copy Files
docker cp file.txt container_name:/path/  # Copy to container
docker cp container_name:/path/file.txt . # Copy from container

# Container Cleanup
docker rm container_name         # Remove stopped container
docker rm -f container_name      # Force remove
docker rm $(docker ps -aq)      # Remove all containers
docker container prune          # Remove stopped containers
```

### 3.3 Advanced Container Options

```bash
# Resource Limits
docker run --memory="256m" ubuntu           # Memory limit
docker run --cpus="1.5" ubuntu              # CPU limit
docker run --cpu-shares=512 ubuntu          # CPU weight
docker run --oom-kill-disable ubuntu        # Disable OOM killer
docker run --ulimit nofile=1024:2048 ubuntu # Ulimit settings

# Security Options
docker run --user 1000:1000 ubuntu          # Run as specific user
docker run --read-only ubuntu               # Read-only filesystem
docker run --cap-add=NET_ADMIN ubuntu       # Add capability
docker run --cap-drop=ALL ubuntu            # Drop all capabilities
docker run --privileged ubuntu              # Privileged mode
docker run --security-opt no-new-privileges ubuntu  # Security options

# Networking Options
docker run --network none ubuntu            # No networking
docker run --network host ubuntu            # Host networking
docker run --network bridge ubuntu          # Bridge networking
docker run --add-host hostname:ip ubuntu    # Add host entry
docker run --dns 8.8.8.8 ubuntu            # Custom DNS

# Volume Options
docker run -v volume_name:/path ubuntu      # Named volume
docker run -v /host:/container ubuntu       # Bind mount
docker run -v /host:/container:ro ubuntu    # Read-only mount
docker run --tmpfs /tmp ubuntu              # Temporary filesystem
docker run --volumes-from container ubuntu  # Mount from container
```

---

## 🌐 **4. DOCKER NETWORKING**

### 4.1 Network Management

```bash
# List Networks
docker network ls               # List all networks
docker network ls --filter driver=bridge  # Filter by driver

# Network Information
docker network inspect bridge   # Inspect network
docker network inspect network_name  # Detailed network info

# Create Networks
docker network create mynetwork           # Create bridge network
docker network create --driver bridge mynetwork  # Specify driver
docker network create --subnet 192.168.1.0/24 mynetwork  # Custom subnet
docker network create --driver overlay mynetwork  # Overlay network
docker network create --driver host mynetwork     # Host network
docker network create --driver none mynetwork     # No network

# Advanced Network Creation
docker network create \
  --driver bridge \
  --subnet 172.20.0.0/16 \
  --ip-range 172.20.240.0/20 \
  --gateway 172.20.0.1 \
  --opt com.docker.network.bridge.name=mybr0 \
  mynetwork

# Connect/Disconnect Containers
docker network connect mynetwork container_name    # Connect container
docker network disconnect mynetwork container_name # Disconnect container

# Remove Networks
docker network rm mynetwork     # Remove network
docker network prune            # Remove unused networks
```

### 4.2 Network Drivers

```bash
# Bridge Network (Default)
docker run --network bridge nginx           # Default bridge
docker run --network mybridge nginx         # Custom bridge

# Host Network
docker run --network host nginx             # Host networking

# None Network
docker run --network none nginx             # No networking

# Overlay Network (Swarm)
docker network create --driver overlay --attachable myoverlay

# MACVLAN Network
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  mymacvlan

# Container Communication
docker run --name app1 --network mynetwork nginx
docker run --name app2 --network mynetwork alpine ping app1
```

### 4.3 Service Discovery

```bash
# DNS Resolution
docker run --name web nginx
docker run --link web:webserver alpine ping webserver  # Legacy linking
docker run --network mynetwork --name web nginx
docker run --network mynetwork alpine nslookup web     # DNS resolution

# Expose Services
docker run -p 8080:80 nginx              # Host port 8080 to container 80
docker run -p 127.0.0.1:8080:80 nginx    # Bind to specific interface
docker run -P nginx                      # Publish all exposed ports
docker run --expose 8080 nginx           # Expose additional port
```

---

## 💾 **5. DOCKER VOLUMES & STORAGE**

### 5.1 Volume Management

```bash
# Volume Commands
docker volume ls                # List volumes
docker volume create myvolume   # Create volume
docker volume inspect myvolume  # Volume details
docker volume rm myvolume       # Remove volume
docker volume prune             # Remove unused volumes

# Volume Types
docker run -v myvolume:/data ubuntu          # Named volume
docker run -v /host/path:/data ubuntu        # Bind mount
docker run --tmpfs /tmp ubuntu               # Temporary filesystem
docker run --mount type=volume,source=myvolume,target=/data ubuntu

# Advanced Volume Options
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt o=addr=192.168.1.1,rw \
  --opt device=:/path/to/share \
  mynfsvolume

# Volume Drivers
docker volume create --driver local myvolume        # Local driver
docker volume create --driver nfs myvolume          # NFS driver
docker volume create --driver rexray myvolume       # REX-Ray driver
```

### 5.2 Mount Types

```bash
# Bind Mounts
docker run -v /host/data:/container/data ubuntu     # Basic bind mount
docker run -v /host/data:/container/data:ro ubuntu  # Read-only
docker run -v /host/data:/container/data:rw ubuntu  # Read-write
docker run --mount type=bind,source=/host/data,target=/container/data ubuntu

# Named Volumes
docker run -v datavolume:/data ubuntu              # Named volume
docker run --mount type=volume,source=datavolume,target=/data ubuntu

# Temporary Filesystems
docker run --tmpfs /tmp ubuntu                     # tmpfs mount
docker run --mount type=tmpfs,target=/tmp ubuntu   # tmpfs mount (new syntax)

# Volume from Container
docker run --volumes-from container_name ubuntu    # Mount volumes from container
```

### 5.3 Volume Backup & Restore

```bash
# Backup Volume
docker run --rm -v myvolume:/data -v $(pwd):/backup ubuntu tar czf /backup/backup.tar.gz -C /data .

# Restore Volume
docker run --rm -v myvolume:/data -v $(pwd):/backup ubuntu tar xzf /backup/backup.tar.gz -C /data

# Copy Volume Data
docker run --rm -v source_volume:/source -v target_volume:/target ubuntu cp -a /source/. /target/

# Volume Migration
docker volume create newvolume
docker run --rm -v oldvolume:/old -v newvolume:/new ubuntu cp -a /old/. /new/
```

---

## 🔧 **6. DOCKER COMPOSE**

### 6.1 Docker Compose Basics

```yaml
# docker-compose.yml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "8080:80"
    volumes:
      - .:/code
    environment:
      - FLASK_ENV=development
    depends_on:
      - db
    networks:
      - mynetwork

  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - mynetwork

volumes:
  postgres_data:

networks:
  mynetwork:
    driver: bridge
```

### 6.2 Compose Commands

```bash
# Basic Commands
docker-compose up                    # Start services
docker-compose up -d                 # Start in background
docker-compose down                  # Stop and remove containers
docker-compose start                 # Start existing containers
docker-compose stop                  # Stop containers
docker-compose restart               # Restart services
docker-compose pause                 # Pause services
docker-compose unpause               # Unpause services

# Build Commands
docker-compose build                 # Build images
docker-compose build --no-cache      # Build without cache
docker-compose up --build            # Build and start

# Service Management
docker-compose ps                    # List containers
docker-compose logs                  # View logs
docker-compose logs -f web           # Follow logs for service
docker-compose exec web bash         # Execute command in service
docker-compose run web python manage.py migrate  # Run one-off command

# Scaling
docker-compose up --scale web=3      # Scale web service to 3 instances
docker-compose scale web=3 worker=2  # Scale multiple services
```

### 6.3 Advanced Compose Features

```yaml
# Advanced docker-compose.yml
version: "3.8"

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.prod
      args:
        - ENV=production
    ports:
      - target: 80
        published: 8080
        protocol: tcp
        mode: host
    volumes:
      - type: bind
        source: ./static
        target: /app/static
      - type: volume
        source: logs
        target: /app/logs
    environment:
      - DEBUG=false
    env_file:
      - .env
    secrets:
      - db_password
    configs:
      - app_config
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
      resources:
        limits:
          cpus: "0.5"
          memory: 512M
        reservations:
          cpus: "0.25"
          memory: 256M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s

secrets:
  db_password:
    file: ./db_password.txt

configs:
  app_config:
    file: ./app.conf

volumes:
  logs:
    driver: local
```

### 6.4 Compose Profiles & Environments

```yaml
# Profiles
version: "3.8"

services:
  web:
    image: nginx
    profiles: ["frontend"]

  api:
    image: node:alpine
    profiles: ["backend"]

  db:
    image: postgres
    profiles: ["backend", "testing"]

  test:
    image: test-runner
    profiles: ["testing"]
```

```bash
# Profile Usage
docker-compose --profile frontend up    # Start frontend services
docker-compose --profile backend up     # Start backend services
docker-compose --profile testing up     # Start testing services
```

---

## 🎭 **7. DOCKER SWARM**

### 7.1 Swarm Initialization

```bash
# Initialize Swarm
docker swarm init                       # Initialize swarm on current node
docker swarm init --advertise-addr 192.168.1.100  # Specify IP
docker swarm join-token worker          # Get worker join token
docker swarm join-token manager         # Get manager join token

# Join Swarm
docker swarm join --token SWMTKN-... 192.168.1.100:2377  # Join as worker
docker swarm join --token SWMTKN-... 192.168.1.100:2377  # Join as manager

# Swarm Management
docker node ls                          # List nodes
docker node inspect node_id             # Node details
docker node update --availability drain node_id  # Drain node
docker node promote node_id             # Promote to manager
docker node demote node_id               # Demote to worker
docker swarm leave                       # Leave swarm
docker swarm leave --force               # Force leave (manager)
```

### 7.2 Service Management

```bash
# Create Services
docker service create --name web nginx             # Basic service
docker service create --name web --replicas 3 nginx  # With replicas
docker service create --name web -p 8080:80 nginx    # With port
docker service create --name web --mount type=volume,src=data,dst=/data nginx

# Service Operations
docker service ls                       # List services
docker service ps web                   # Service tasks
docker service inspect web              # Service details
docker service logs web                 # Service logs
docker service update --replicas 5 web  # Scale service
docker service rm web                   # Remove service

# Service Updates
docker service update --image nginx:alpine web     # Update image
docker service update --publish-add 9090:80 web    # Add port
docker service update --env-add ENV=prod web       # Add environment
docker service update --rollback web               # Rollback service
```

### 7.3 Stack Deployment

```yaml
# stack.yml
version: "3.8"

services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
      placement:
        constraints:
          - node.role == worker
    networks:
      - webnet

  visualizer:
    image: dockersamples/visualizer:stable
    ports:
      - "8081:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      placement:
        constraints:
          - node.role == manager
    networks:
      - webnet

networks:
  webnet:
    driver: overlay
```

```bash
# Stack Commands
docker stack deploy -c stack.yml myapp     # Deploy stack
docker stack ls                            # List stacks
docker stack ps myapp                      # Stack tasks
docker stack services myapp                # Stack services
docker stack rm myapp                      # Remove stack
```

### 7.4 Swarm Networking & Secrets

```bash
# Overlay Networks
docker network create --driver overlay myoverlay    # Create overlay network
docker network create --driver overlay --attachable myoverlay  # Attachable

# Secrets Management
echo "mysecretpassword" | docker secret create db_password -
docker secret ls                           # List secrets
docker secret inspect db_password          # Secret details
docker secret rm db_password               # Remove secret

# Config Management
docker config create app_config app.conf   # Create config
docker config ls                           # List configs
docker config inspect app_config           # Config details
docker config rm app_config                # Remove config

# Using Secrets in Services
docker service create \
  --name web \
  --secret db_password \
  --config app_config \
  nginx
```

---

## 🏗️ **8. DOCKERFILE BEST PRACTICES**

### 8.1 Optimization Techniques

```dockerfile
# Multi-stage Build
FROM node:16-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:16-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]

# Layer Optimization
FROM ubuntu:20.04

# Combine RUN commands to reduce layers
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy source code last
COPY . .

# Use specific versions
FROM node:16.14.2-alpine3.15

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001
USER nextjs

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

### 8.2 Security Best Practices

```dockerfile
# Security-focused Dockerfile
FROM alpine:3.15

# Install security updates
RUN apk update && apk upgrade

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Install only necessary packages
RUN apk add --no-cache python3 py3-pip

# Set working directory
WORKDIR /app

# Copy files with proper ownership
COPY --chown=appuser:appgroup requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appgroup . .

# Switch to non-root user
USER appuser

# Remove unnecessary permissions
RUN chmod -R 750 /app

# Use COPY instead of ADD
COPY config.json /app/config.json

# Minimize attack surface
RUN rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

# Use specific CMD
CMD ["python3", "app.py"]
```

### 8.3 Performance Optimization

```dockerfile
# Performance-optimized Dockerfile
FROM python:3.9-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
WORKDIR /app
COPY . .

# Set proper permissions
RUN useradd --create-home --shell /bin/bash app && \
    chown -R app:app /app
USER app

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD python healthcheck.py

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:application"]
```

---

## 📊 **9. MONITORING & LOGGING**

### 9.1 Container Monitoring

```bash
# Basic Monitoring
docker stats                        # Real-time stats all containers
docker stats container_name         # Specific container stats
docker stats --no-stream           # One-time stats
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# System Information
docker system df                    # Disk usage
docker system events               # Real-time events
docker system info                 # System information
docker system prune                # Clean up

# Container Inspection
docker inspect container_name       # Full container info
docker top container_name           # Running processes
docker port container_name          # Port mappings
docker exec container_name ps aux   # Process list inside container
```

### 9.2 Logging

```bash
# Log Commands
docker logs container_name          # Container logs
docker logs -f container_name       # Follow logs
docker logs --tail 50 container_name  # Last 50 lines
docker logs --since "2023-01-01" container_name  # Logs since date
docker logs --until "2023-12-31" container_name  # Logs until date
docker logs -t container_name       # Show timestamps

# Log Drivers
docker run --log-driver=json-file nginx        # JSON file (default)
docker run --log-driver=syslog nginx           # Syslog
docker run --log-driver=journald nginx         # systemd journal
docker run --log-driver=gelf nginx             # GELF
docker run --log-driver=fluentd nginx          # Fluentd
docker run --log-driver=awslogs nginx          # AWS CloudWatch
docker run --log-driver=none nginx             # No logging

# Log Options
docker run --log-opt max-size=10m --log-opt max-file=3 nginx  # Log rotation
docker run --log-opt syslog-address=tcp://localhost:514 nginx  # Syslog address
```

### 9.3 Monitoring Stack

```yaml
# Monitoring with Prometheus & Grafana
version: "3.8"

services:
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
      - "--storage.tsdb.path=/prometheus"

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana-data:/var/lib/grafana

  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    ports:
      - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro

  node-exporter:
    image: prom/node-exporter:latest
    ports:
      - "9100:9100"
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro

volumes:
  grafana-data:
```

---

## 🔒 **10. DOCKER SECURITY**

### 10.1 Image Security

```bash
# Image Scanning
docker scan image_name              # Docker scan (requires login)
trivy image nginx:latest            # Trivy scanner
clair-scanner image_name            # Clair scanner
anchore-cli image add nginx:latest  # Anchore scanner

# Trusted Images
docker trust inspect nginx         # Inspect image trust
docker trust sign myimage:tag      # Sign image
export DOCKER_CONTENT_TRUST=1      # Enable content trust

# Image Best Practices
# Use official base images
FROM node:16-alpine

# Use specific tags, not latest
FROM nginx:1.21.6-alpine

# Use minimal base images
FROM alpine:3.15
FROM scratch                       # Empty image
FROM distroless/java:11            # Distroless image

# Verify image integrity
docker pull nginx@sha256:abc123... # Pull by digest
```

### 10.2 Runtime Security

```bash
# Security Options
docker run --read-only nginx                    # Read-only filesystem
docker run --user 1000:1000 nginx              # Non-root user
docker run --cap-drop=ALL nginx                # Drop all capabilities
docker run --cap-add=NET_BIND_SERVICE nginx    # Add specific capability
docker run --no-new-privileges nginx           # No new privileges
docker run --security-opt=no-new-privileges nginx  # Security options

# AppArmor/SELinux
docker run --security-opt apparmor=docker-default nginx  # AppArmor profile
docker run --security-opt label=type:container_t nginx   # SELinux label

# Seccomp Profiles
docker run --security-opt seccomp=unconfined nginx      # Disable seccomp
docker run --security-opt seccomp=profile.json nginx    # Custom profile

# Resource Limits
docker run --memory=256m nginx                 # Memory limit
docker run --cpus=0.5 nginx                   # CPU limit
docker run --pids-limit=100 nginx             # Process limit
docker run --ulimit nofile=1024:2048 nginx    # File descriptor limit
```

### 10.3 Network Security

```bash
# Network Isolation
docker network create --internal mynetwork     # Internal network
docker run --network none nginx                # No network access
docker run --add-host=host.docker.internal:host-gateway nginx  # Host access

# Firewall Rules
iptables -A DOCKER-USER -i ext_if ! -s 192.168.1.0/24 -j DROP  # Block external access
iptables -A DOCKER-USER -p tcp --dport 22 -j DROP              # Block SSH

# TLS/SSL
docker run -v $(pwd)/certs:/certs nginx        # Mount certificates
docker run -e DOCKER_TLS_CERTDIR=/certs docker:dind  # Docker-in-Docker with TLS
```

### 10.4 Secrets Management

```bash
# Docker Secrets (Swarm)
echo "mysecret" | docker secret create db_password -
docker service create --secret db_password nginx

# External Secrets
docker run -e SECRET_KEY=$(cat secret.txt) nginx       # File-based
docker run -e SECRET_KEY=$(vault kv get -field=key secret/myapp) nginx  # Vault

# Environment File
echo "SECRET_KEY=mysecret" > .env
docker run --env-file .env nginx

# Init Containers for Secrets
version: '3.8'
services:
  secret-fetcher:
    image: vault:latest
    command: sh -c "vault read -field=password secret/db > /shared/password"
    volumes:
      - shared-data:/shared

  app:
    image: myapp:latest
    depends_on:
      - secret-fetcher
    volumes:
      - shared-data:/secrets
```

---

## 🚀 **11. DOCKER REGISTRY**

### 11.1 Docker Hub

```bash
# Docker Hub Operations
docker login                        # Login to Docker Hub
docker login -u username -p password # Login with credentials
docker logout                       # Logout

# Push/Pull Images
docker tag myapp:latest username/myapp:latest  # Tag for push
docker push username/myapp:latest              # Push to Docker Hub
docker pull username/myapp:latest              # Pull from Docker Hub

# Private Repositories
docker tag myapp:latest username/private-repo:latest
docker push username/private-repo:latest

# Repository Management
# Access Docker Hub web interface for:
# - Repository settings
# - Automated builds
# - Webhooks
# - Access permissions
```

### 11.2 Private Registry

```bash
# Run Local Registry
docker run -d -p 5000:5000 --name registry registry:2
docker run -d -p 5000:5000 --restart=always --name registry registry:2

# With Persistent Storage
docker run -d -p 5000:5000 --restart=always --name registry \
  -v /opt/registry:/var/lib/registry \
  registry:2

# With Authentication
docker run -d -p 5000:5000 --restart=always --name registry \
  -v /opt/registry:/var/lib/registry \
  -v /opt/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
  registry:2

# Create htpasswd file
htpasswd -Bbn username password > /opt/auth/htpasswd

# Use Private Registry
docker tag myapp:latest localhost:5000/myapp:latest
docker push localhost:5000/myapp:latest
docker pull localhost:5000/myapp:latest
```

### 11.3 Registry Configuration

```yaml
# Registry config.yml
version: 0.1
log:
  fields:
    service: registry
storage:
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
auth:
  htpasswd:
    realm: basic-realm
    path: /etc/docker/registry/htpasswd
middleware:
  registry:
    - name: AliasMiddleware
      options:
        aliases:
          "/": "/v2/"
```

### 11.4 Registry API

```bash
# Registry API Calls
curl -X GET http://localhost:5000/v2/_catalog                    # List repositories
curl -X GET http://localhost:5000/v2/myapp/tags/list             # List tags
curl -X GET http://localhost:5000/v2/myapp/manifests/latest      # Get manifest
curl -X DELETE http://localhost:5000/v2/myapp/manifests/sha256:abc123  # Delete image

# Registry Garbage Collection
docker exec registry bin/registry garbage-collect /etc/docker/registry/config.yml

# Registry Health Check
curl -X GET http://localhost:5000/v2/
```

---

## 🔄 **12. CI/CD WITH DOCKER**

### 12.1 Jenkins Pipeline

```groovy
// Jenkinsfile
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "myapp"
        DOCKER_TAG = "${BUILD_NUMBER}"
        REGISTRY = "localhost:5000"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").inside {
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry("http://${REGISTRY}") {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push("latest")
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh """
                docker service update --image ${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG} myapp_web
                """
            }
        }
    }

    post {
        always {
            sh "docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || true"
        }
    }
}
```

### 12.2 GitLab CI/CD

```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - security
  - deploy

variables:
  DOCKER_IMAGE: $CI_REGISTRY_IMAGE
  DOCKER_TAG: $CI_COMMIT_SHORT_SHA

before_script:
  - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY

build:
  stage: build
  script:
    - docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
    - docker push $DOCKER_IMAGE:$DOCKER_TAG

test:
  stage: test
  script:
    - docker run --rm $DOCKER_IMAGE:$DOCKER_TAG npm test

security_scan:
  stage: security
  script:
    - docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image $DOCKER_IMAGE:$DOCKER_TAG

deploy_staging:
  stage: deploy
  script:
    - docker service update --image $DOCKER_IMAGE:$DOCKER_TAG staging_app
  environment:
    name: staging
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - docker service update --image $DOCKER_IMAGE:$DOCKER_TAG production_app
  environment:
    name: production
  only:
    - master
  when: manual
```

### 12.3 GitHub Actions

```yaml
# .github/workflows/docker.yml
name: Docker Build and Deploy

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Log in to Container Registry
        uses: docker/login-action@v2
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=sha

      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}

      - name: Run security scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          format: "sarif"
          output: "trivy-results.sarif"

      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: "trivy-results.sarif"
```

---

## 🧪 **13. TESTING & DEBUGGING**

### 13.1 Container Testing

```bash
# Unit Testing
docker run --rm -v $(pwd):/app -w /app node:16 npm test
docker run --rm -v $(pwd):/app -w /app python:3.9 python -m pytest

# Integration Testing
docker-compose -f docker-compose.test.yml up --abort-on-container-exit
docker-compose -f docker-compose.test.yml down

# Health Checks
docker run --health-cmd="curl -f http://localhost/" --health-interval=30s nginx
docker inspect --format='{{.State.Health.Status}}' container_name

# Test Dockerfile
hadolint Dockerfile                # Dockerfile linter
dive myimage:latest               # Image layer analyzer
docker-bench-security             # Security benchmark
```

### 13.2 Debugging Techniques

```bash
# Debug Container
docker run -it --entrypoint /bin/bash myimage:latest     # Override entrypoint
docker exec -it container_name /bin/bash                 # Execute shell
docker run --rm -it --pid=container:target alpine       # Share PID namespace

# Debug Networking
docker run --rm --net container:target nicolaka/netshoot # Network debugging
docker exec container_name netstat -tlnp                 # Network connections
docker exec container_name ss -tlnp                      # Socket statistics

# Debug Storage
docker exec container_name df -h                         # Disk usage
docker exec container_name mount                         # Mount points
docker inspect container_name | grep -i mounts           # Volume mounts

# Debug Processes
docker exec container_name ps aux                        # Running processes
docker exec container_name top                           # Process monitor
docker stats container_name                              # Resource usage
```

### 13.3 Troubleshooting

```bash
# Common Issues
docker logs container_name                      # Check logs
docker inspect container_name                   # Detailed info
docker events                                   # Real-time events
docker system prune                            # Clean up

# Container Won't Start
docker run --rm -it myimage:latest /bin/bash   # Test interactively
docker run --rm myimage:latest /bin/ls -la     # Test command
docker history myimage:latest                  # Check image layers

# Networking Issues
docker network ls                              # List networks
docker network inspect bridge                  # Network details
docker port container_name                     # Port mappings
ping $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name)

# Performance Issues
docker stats --no-stream                       # Resource usage
docker exec container_name free -h             # Memory usage
docker exec container_name iostat              # I/O statistics
docker system df                               # Disk usage
```

---

## 📈 **14. PERFORMANCE OPTIMIZATION**

### 14.1 Image Optimization

```dockerfile
# Multi-stage builds
FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:16-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
CMD ["node", "index.js"]

# Layer caching optimization
FROM python:3.9-slim

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy source code last
COPY . .

# Use .dockerignore
# .dockerignore file:
node_modules
.git
.gitignore
README.md
Dockerfile
.dockerignore
```

### 14.2 Runtime Optimization

```bash
# Resource Limits
docker run --memory=512m --cpus=1.5 myapp      # Limit resources
docker run --oom-kill-disable myapp            # Disable OOM killer
docker run --kernel-memory=50m myapp           # Kernel memory limit

# Storage Optimization
docker run --storage-opt size=10G myapp        # Limit container size
docker run --tmpfs /tmp:rw,noexec,nosuid,size=100m myapp  # tmpfs mount

# Network Optimization
docker run --net=host myapp                    # Host networking
docker run --dns=8.8.8.8 myapp                # Custom DNS
```

### 14.3 Monitoring Performance

```bash
# Container Metrics
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"

# System Metrics
docker system df -v                            # Detailed disk usage
docker system events --filter container=myapp  # Container events

# Performance Tools
ctop                                           # Container top
lazydocker                                     # Terminal UI for Docker
```

---

## 🎯 **15. PRODUCTION DEPLOYMENT**

### 15.1 Production Best Practices

```yaml
# Production docker-compose.yml
version: "3.8"

services:
  web:
    image: myapp:${VERSION}
    restart: unless-stopped
    ports:
      - "80:8080"
    environment:
      - NODE_ENV=production
    volumes:
      - /var/log/myapp:/app/logs
    networks:
      - frontend
      - backend
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: 1G
        reservations:
          cpus: "1"
          memory: 512M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  db:
    image: postgres:13
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - /etc/postgresql/postgresql.conf:/etc/postgresql/postgresql.conf
    networks:
      - backend
    secrets:
      - db_password
    deploy:
      resources:
        limits:
          memory: 2G
        reservations:
          memory: 1G

secrets:
  db_password:
    file: ./secrets/db_password.txt

volumes:
  postgres_data:
    external: true

networks:
  frontend:
  backend:
    internal: true
```

### 15.2 High Availability

```bash
# Docker Swarm HA
docker swarm init --advertise-addr 192.168.1.10
docker swarm join-token manager

# Multiple replicas
docker service create --name web --replicas 3 nginx
docker service update --replicas 5 web

# Health checks
docker service create --name web \
  --health-cmd "curl -f http://localhost/" \
  --health-interval 30s \
  --health-retries 3 \
  nginx

# Rolling updates
docker service update --image nginx:alpine web
docker service update --update-parallelism 1 --update-delay 10s web
```

### 15.3 Backup & Recovery

```bash
# Volume Backup
docker run --rm -v myapp_data:/data -v $(pwd):/backup alpine \
  tar czf /backup/backup-$(date +%Y%m%d).tar.gz -C /data .

# Database Backup
docker exec postgres_container pg_dump -U postgres mydb > backup.sql
docker exec mysql_container mysqldump -u root -p mydb > backup.sql

# Image Backup
docker save myapp:latest | gzip > myapp-latest.tar.gz
docker load < myapp-latest.tar.gz

# Automated Backup Script
#!/bin/bash
DATE=$(date +%Y%m%d)
docker exec postgres pg_dump -U postgres mydb | gzip > /backup/db-$DATE.sql.gz
docker run --rm -v myapp_data:/data -v /backup:/backup alpine \
  tar czf /backup/app-data-$DATE.tar.gz -C /data .
find /backup -name "*.gz" -mtime +7 -delete
```

---

## 🎓 **16. ADVANCED TOPICS**

### 16.1 Docker BuildKit

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1
docker build .

# BuildKit features in Dockerfile
# syntax=docker/dockerfile:1
FROM alpine:latest

# Cache mounts
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --update git

# Secret mounts
RUN --mount=type=secret,id=mypassword cat /run/secrets/mypassword

# SSH mounts
RUN --mount=type=ssh git clone git@github.com:myorg/myproject.git

# Build with BuildKit
docker build --secret id=mypassword,src=./password.txt .
docker build --ssh default .
```

### 16.2 Docker Content Trust

```bash
# Enable Content Trust
export DOCKER_CONTENT_TRUST=1

# Generate keys
docker trust key generate mykey
docker trust signer add --key mykey.pub myuser myimage

# Sign images
docker trust sign myimage:latest

# Verify signatures
docker trust inspect myimage:latest
```

### 16.3 Container Runtime Alternatives

```bash
# containerd
ctr images pull docker.io/library/nginx:latest
ctr run docker.io/library/nginx:latest nginx

# CRI-O (with crictl)
crictl pull nginx:latest
crictl run nginx-config.json nginx-sandbox.json

# Podman (Docker alternative)
podman run -d nginx
podman generate systemd nginx > nginx.service
```

---

## 📋 **17. DOCKER COMMANDS REFERENCE**

### 17.1 Complete Command List

```bash
# Container Lifecycle
docker create          # Create container
docker start           # Start container
docker stop            # Stop container
docker restart         # Restart container
docker kill            # Kill container
docker rm              # Remove container
docker pause           # Pause container
docker unpause         # Unpause container

# Container Information
docker ps              # List running containers
docker ps -a           # List all containers
docker inspect         # Inspect container
docker logs            # Container logs
docker top             # Running processes
docker stats           # Resource usage
docker port            # Port mappings
docker diff            # Filesystem changes

# Container Interaction
docker exec            # Execute command
docker attach          # Attach to container
docker cp              # Copy files
docker export          # Export container
docker import          # Import container

# Image Management
docker images          # List images
docker pull            # Pull image
docker push            # Push image
docker build           # Build image
docker tag             # Tag image
docker rmi             # Remove image
docker save            # Save image
docker load            # Load image
docker history         # Image history
docker inspect         # Inspect image

# Registry
docker login           # Login to registry
docker logout          # Logout from registry
docker search          # Search images

# Network Management
docker network ls      # List networks
docker network create  # Create network
docker network rm      # Remove network
docker network inspect # Inspect network
docker network connect # Connect container
docker network disconnect # Disconnect container

# Volume Management
docker volume ls       # List volumes
docker volume create   # Create volume
docker volume rm       # Remove volume
docker volume inspect  # Inspect volume
docker volume prune    # Remove unused volumes

# System Management
docker info            # System information
docker version         # Version information
docker system df       # Disk usage
docker system prune    # Clean up
docker system events   # System events

# Swarm Management
docker swarm init      # Initialize swarm
docker swarm join      # Join swarm
docker swarm leave     # Leave swarm
docker node ls         # List nodes
docker service create  # Create service
docker service ls      # List services
docker service ps      # Service tasks
docker service update  # Update service
docker service rm      # Remove service
docker stack deploy    # Deploy stack
docker stack ls        # List stacks
docker stack ps        # Stack tasks
docker stack rm        # Remove stack
docker secret create   # Create secret
docker secret ls       # List secrets
docker config create   # Create config
docker config ls       # List configs
```

### 17.2 Docker Compose Commands

```bash
# Compose Lifecycle
docker-compose up      # Start services
docker-compose down    # Stop services
docker-compose start   # Start existing containers
docker-compose stop    # Stop containers
docker-compose restart # Restart services
docker-compose pause   # Pause services
docker-compose unpause # Unpause services

# Compose Build
docker-compose build   # Build images
docker-compose pull    # Pull images
docker-compose push    # Push images

# Compose Information
docker-compose ps      # List containers
docker-compose logs    # View logs
docker-compose top     # Running processes
docker-compose port    # Port information

# Compose Execution
docker-compose exec    # Execute command
docker-compose run     # Run one-off command

# Compose Management
docker-compose config  # Validate and view config
docker-compose scale   # Scale services
docker-compose kill    # Kill containers
docker-compose rm      # Remove containers
```

---

## 🎯 **18. LEARNING PATH & CERTIFICATION**

### 18.1 Learning Timeline

```bash
# Beginner (1-2 months)
Week 1-2: Docker basics, containers, images
Week 3-4: Dockerfile, docker-compose
Week 5-6: Networking, volumes
Week 7-8: Registry, basic deployment

# Intermediate (2-3 months)
Month 3: Docker Swarm, orchestration
Month 4: Security, monitoring
Month 5: CI/CD integration

# Advanced (3-6 months)
Month 6: Performance optimization
Month 7: Production deployment
Month 8: Advanced features (BuildKit, multi-arch)
Month 9-11: Kubernetes integration
Month 12: Certification preparation
```

### 18.2 Certifications

```bash
# Docker Certifications
- Docker Certified Associate (DCA)
- Docker Certified Professional

# Related Certifications
- Certified Kubernetes Administrator (CKA)
- Certified Kubernetes Application Developer (CKAD)
- AWS Certified Solutions Architect
- Google Cloud Professional Cloud Architect
```

### 18.3 Practice Projects

```bash
# Beginner Projects
1. Containerize a simple web application
2. Multi-container application with database
3. Docker Compose for development environment
4. Basic CI/CD pipeline

# Intermediate Projects
1. Microservices architecture
2. Docker Swarm cluster
3. Monitoring stack (Prometheus + Grafana)
4. Log aggregation system

# Advanced Projects
1. Multi-environment deployment pipeline
2. High-availability web application
3. Container security implementation
4. Performance optimization case study
```

---

## 📚 **19. RESOURCES & TOOLS**

### 19.1 Essential Tools

```bash
# Docker Desktop         # GUI for Docker
# Portainer             # Web-based Docker management
# Watchtower            # Automated container updates
# Dive                  # Image layer analyzer
# Hadolint              # Dockerfile linter
# Trivy                 # Vulnerability scanner
# ctop                  # Container monitoring
# lazydocker            # Terminal UI for Docker
# docker-compose        # Multi-container applications
# docker-machine        # Provision Docker hosts
```

### 19.2 Documentation & Learning

```bash
# Official Documentation
- Docker Documentation: https://docs.docker.com/
- Docker Hub: https://hub.docker.com/
- Docker Blog: https://www.docker.com/blog/

# Learning Resources
- Play with Docker: https://labs.play-with-docker.com/
- Docker 101 Tutorial: https://www.docker.com/101-tutorial
- Katacoda Docker Scenarios: https://katacoda.com/courses/docker

# Books
- "Docker: Up & Running" by Karl Matthias
- "Docker in Action" by Jeff Nickoloff
- "Docker Deep Dive" by Nigel Poulton
```

### 19.3 Community & Support

```bash
# Community
- Docker Community Forums
- Stack Overflow (docker tag)
- Reddit r/docker
- Docker Community Slack

# Events
- DockerCon
- Local Docker Meetups
- Docker Birthday celebrations
- Online webinars
```

---

_Đây là tài liệu toàn diện về Docker. Hãy thực hành thường xuyên, xây dựng projects thực tế, và không ngừng cập nhật kiến thức!_
