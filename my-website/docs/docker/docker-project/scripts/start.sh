#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ENVIRONMENT=${1:-development}

echo -e "${BLUE}🚀 Starting Docker Project${NC}"
echo -e "${YELLOW}Environment: $ENVIRONMENT${NC}"

# Load environment variables
if [ -f "env/.env.$ENVIRONMENT" ]; then
    export $(cat env/.env.$ENVIRONMENT | xargs)
    echo -e "${GREEN}✅ Loaded $ENVIRONMENT environment${NC}"
fi

# Create networks
echo -e "${YELLOW}Creating Docker networks...${NC}"
docker network create app-network 2>/dev/null || true
docker network create monitoring 2>/dev/null || true
docker network create logging 2>/dev/null || true

# Start based on environment
case $ENVIRONMENT in
    "development")
        echo -e "${YELLOW}Starting development environment...${NC}"
        docker-compose -f docker-compose/docker-compose.dev.yml up -d
        ;;
    "production")
        echo -e "${YELLOW}Starting production environment...${NC}"
        docker-compose -f docker-compose/docker-compose.yml up -d
        ;;
    "test")
        echo -e "${YELLOW}Starting test environment...${NC}"
        docker-compose -f docker-compose/docker-compose.test.yml up --abort-on-container-exit
        ;;
    *)
        echo -e "${YELLOW}Starting default environment...${NC}"
        docker-compose -f docker-compose/docker-compose.yml up -d
        ;;
esac

# Wait for services
echo -e "${YELLOW}Waiting for services to start...${NC}"
sleep 20

# Health check
echo -e "${YELLOW}Running health checks...${NC}"
./scripts/health-check.sh

echo -e "${GREEN}✅ Project started successfully!${NC}"
echo -e "${GREEN}🌐 Access URLs:${NC}"
echo -e "Frontend: http://localhost:3000"
echo -e "Backend: http://localhost:5000"
echo -e "Database: localhost:5432"
echo -e "Redis: localhost:6379"

if [ "$ENVIRONMENT" != "test" ]; then
    echo -e "\n${YELLOW}To view logs: make logs${NC}"
    echo -e "${YELLOW}To stop: make stop${NC}"
    echo -e "${YELLOW}To monitor: make monitor${NC}"
fi
