#!/bin/bash
# Docker Container Deployment Script
# Deploy và quản lý Docker containers

PROJECT_NAME="my-app"
DOCKER_IMAGE="mycompany/my-app:latest"
CONTAINER_NAME="${PROJECT_NAME}-prod"
REGISTRY="registry.example.com"
ENV_FILE=".env.production"

echo "Starting Docker deployment..."

# Build Docker image
build_image() {
    echo "Building Docker image..."
    
    docker build -t "$DOCKER_IMAGE" .
    
    if [ $? -eq 0 ]; then
        echo "✓ Image built successfully"
    else
        echo "✗ Build failed"
        exit 1
    fi
}

# Push to registry
push_to_registry() {
    echo "Pushing image to registry..."
    
    docker tag "$DOCKER_IMAGE" "${REGISTRY}/${DOCKER_IMAGE}"
    docker push "${REGISTRY}/${DOCKER_IMAGE}"
    
    if [ $? -eq 0 ]; then
        echo "✓ Image pushed to registry"
    else
        echo "✗ Push failed"
        exit 1
    fi
}

# Pull latest image
pull_image() {
    echo "Pulling latest image..."
    
    docker pull "${REGISTRY}/${DOCKER_IMAGE}"
    
    if [ $? -eq 0 ]; then
        echo "✓ Image pulled successfully"
    else
        echo "✗ Pull failed"
        exit 1
    fi
}

# Stop and remove old container
stop_old_container() {
    if docker ps -a | grep -q "$CONTAINER_NAME"; then
        echo "Stopping old container..."
        docker stop "$CONTAINER_NAME"
        docker rm "$CONTAINER_NAME"
        echo "✓ Old container removed"
    fi
}

# Run new container
run_container() {
    echo "Starting new container..."
    
    docker run -d \
        --name "$CONTAINER_NAME" \
        --restart=unless-stopped \
        --env-file "$ENV_FILE" \
        -p 3000:3000 \
        -v /var/log/${PROJECT_NAME}:/app/logs \
        --memory="1g" \
        --cpus="1.0" \
        "${REGISTRY}/${DOCKER_IMAGE}"
    
    if [ $? -eq 0 ]; then
        echo "✓ Container started successfully"
    else
        echo "✗ Container start failed"
        exit 1
    fi
}

# Use docker-compose
deploy_with_compose() {
    echo "Deploying with docker-compose..."
    
    docker-compose pull
    docker-compose down
    docker-compose up -d
    
    if [ $? -eq 0 ]; then
        echo "✓ Docker compose deployment completed"
    else
        echo "✗ Docker compose deployment failed"
        exit 1
    fi
}

# Clean up old images
cleanup_images() {
    echo "Cleaning up old images..."
    
    docker image prune -af --filter "until=24h"
    
    echo "✓ Cleanup completed"
}

# Health check
check_container_health() {
    echo "Checking container health..."
    
    sleep 5
    
    if docker ps | grep -q "$CONTAINER_NAME"; then
        echo "✓ Container is running"
        
        # Check logs for errors
        if docker logs "$CONTAINER_NAME" 2>&1 | grep -qi "error"; then
            echo "⚠ Errors found in container logs"
        fi
        
        return 0
    else
        echo "✗ Container is not running"
        return 1
    fi
}

# Main
if [ -f "docker-compose.yml" ]; then
    deploy_with_compose
else
    build_image
    push_to_registry
    stop_old_container
    run_container
    check_container_health
    cleanup_images
fi

echo "Docker deployment completed"
