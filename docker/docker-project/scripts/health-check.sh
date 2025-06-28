#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🏥 Health Check Script${NC}"

# Function to check service health
check_service() {
    local service_name=$1
    local url=$2
    local expected_status=${3:-200}
    
    echo -n "Checking $service_name... "
    
    if curl -f -s -o /dev/null -w "%{http_code}" "$url" | grep -q "$expected_status"; then
        echo -e "${GREEN}✅ Healthy${NC}"
        return 0
    else
        echo -e "${RED}❌ Unhealthy${NC}"
        return 1
    fi
}

# Check all services
FAILED=0

# Application services
check_service "Frontend" "http://localhost:3000" || FAILED=$((FAILED + 1))
check_service "Backend API" "http://localhost:5000/health" || FAILED=$((FAILED + 1))
check_service "Database" "http://localhost:5432" || FAILED=$((FAILED + 1))

# Infrastructure services
check_service "Nginx" "http://localhost/health" || FAILED=$((FAILED + 1))
check_service "Prometheus" "http://localhost:9090/-/healthy" || FAILED=$((FAILED + 1))
check_service "Grafana" "http://localhost:3000/api/health" || FAILED=$((FAILED + 1))
check_service "Elasticsearch" "http://localhost:9200/_cluster/health" || FAILED=$((FAILED + 1))
check_service "Kibana" "http://localhost:5601/api/status" || FAILED=$((FAILED + 1))

# Docker container health
echo -e "\n${YELLOW}Docker Container Status:${NC}"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Check disk space
echo -e "\n${YELLOW}System Resources:${NC}"
df -h | grep -E "(Filesystem|/dev/)"
echo "Memory usage: $(free -h | awk 'NR==2{printf "%.1f%% (%s/%s)", $3*100/$2, $3, $2}')"

if [ $FAILED -eq 0 ]; then
    echo -e "\n${GREEN}✅ All services are healthy!${NC}"
    exit 0
else
    echo -e "\n${RED}❌ $FAILED services failed health check${NC}"
    exit 1
fi
