# Troubleshooting Guide

## Common Issues

### Container Won't Start

```bash
# Check container logs
docker-compose logs service-name

# Check container status
docker-compose ps

# Restart specific service
docker-compose restart service-name
```

### Database Connection Issues

```bash
# Check database connectivity
docker-compose exec backend ping postgres

# Check database logs
docker-compose logs postgres

# Reset database
docker-compose down -v
docker-compose up -d postgres
```

### Performance Issues

```bash
# Monitor resource usage
docker stats

# Check container limits
docker inspect container-name | grep -A 10 "Memory"

# Analyze slow queries
docker-compose exec postgres pg_stat_statements
```

### Network Issues

```bash
# List networks
docker network ls

# Inspect network
docker network inspect network-name

# Test connectivity
docker-compose exec backend ping frontend
```

### Storage Issues

```bash
# Check disk usage
docker system df

# Clean up unused resources
docker system prune -a

# Check volume usage
docker volume ls
```

## Monitoring Alerts

### High CPU Usage

- Scale services: `docker-compose up -d --scale backend=3`
- Check resource limits
- Optimize application code

### Memory Leaks

- Restart affected containers
- Check application logs
- Monitor memory patterns

### Database Performance

- Analyze slow queries
- Check connection pool settings
- Consider read replicas

## Emergency Procedures

### Complete System Recovery

```bash
# Stop all services
./scripts/cleanup.sh production

# Restore from backup
./scripts/restore.sh backup-file

# Redeploy
./scripts/deploy.sh production
```

### Rollback Deployment

```bash
# Rollback to previous version
./scripts/deploy.sh production v1.0.0

# Verify rollback
./scripts/health-check.sh
```
