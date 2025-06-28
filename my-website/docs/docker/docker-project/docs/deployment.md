# Deployment Guide

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- Minimum 4GB RAM
- 20GB disk space

## Environment Setup

### Development

```bash
# Start development environment
./scripts/deploy.sh development

# Access services
Frontend: http://localhost:3000
Backend: http://localhost:8080
Database: localhost:5432
Redis: localhost:6379
```

### Staging

```bash
# Deploy to staging
./scripts/build.sh v1.0.0
./scripts/deploy.sh staging

# Run tests
docker-compose exec backend pytest
```

### Production

```bash
# Build production images
./scripts/build.sh v1.0.0 push

# Deploy to production
./scripts/deploy.sh production

# Verify deployment
./scripts/health-check.sh
```

## Monitoring

- **Grafana**: http://localhost:3000 (admin/admin123)
- **Prometheus**: http://localhost:9090
- **AlertManager**: http://localhost:9093

## Logging

- **Kibana**: http://localhost:5601
- **Elasticsearch**: http://localhost:9200

## Backup & Recovery

```bash
# Database backup
docker-compose exec postgres pg_dump -U appuser myapp > backup.sql

# Volume backup
docker run --rm -v postgres_data:/data -v $(pwd):/backup alpine tar czf /backup/postgres_backup.tar.gz /data
```

## Scaling

```bash
# Scale backend services
docker-compose up -d --scale backend=5

# Monitor resource usage
docker stats
```

## Troubleshooting

See [troubleshooting.md](troubleshooting.md) for common issues and solutions.
