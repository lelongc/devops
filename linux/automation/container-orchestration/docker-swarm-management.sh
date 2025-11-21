#!/bin/bash
# Docker Swarm Management Script
# Quản lý Docker Swarm cluster

ACTION="$1"
SERVICE_NAME="$2"

usage() {
    echo "Usage: $0 {init|join|deploy|scale|update|remove|status}"
    exit 1
}

# Initialize swarm
swarm_init() {
    echo "Initializing Docker Swarm..."
    
    docker swarm init
    
    if [ $? -eq 0 ]; then
        echo "✓ Swarm initialized"
        echo "Join token for workers:"
        docker swarm join-token worker
    else
        echo "✗ Swarm initialization failed"
        exit 1
    fi
}

# Deploy service
swarm_deploy() {
    STACK_NAME="$1"
    COMPOSE_FILE="${2:-docker-compose.yml}"
    
    echo "Deploying stack: $STACK_NAME"
    
    docker stack deploy -c "$COMPOSE_FILE" "$STACK_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ Stack deployed"
        docker stack services "$STACK_NAME"
    else
        echo "✗ Deployment failed"
        exit 1
    fi
}

# Scale service
swarm_scale() {
    SERVICE_NAME="$1"
    REPLICAS="$2"
    
    echo "Scaling $SERVICE_NAME to $REPLICAS replicas..."
    
    docker service scale "$SERVICE_NAME=$REPLICAS"
    
    if [ $? -eq 0 ]; then
        echo "✓ Service scaled"
    else
        echo "✗ Scaling failed"
        exit 1
    fi
}

# Update service
swarm_update() {
    SERVICE_NAME="$1"
    IMAGE="$2"
    
    echo "Updating $SERVICE_NAME with image: $IMAGE"
    
    docker service update --image "$IMAGE" "$SERVICE_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ Service updated"
    else
        echo "✗ Update failed"
        exit 1
    fi
}

# Remove service
swarm_remove() {
    STACK_NAME="$1"
    
    echo "Removing stack: $STACK_NAME"
    
    docker stack rm "$STACK_NAME"
    
    echo "✓ Stack removed"
}

# Get swarm status
swarm_status() {
    echo "Docker Swarm Status"
    echo "==================="
    
    echo -e "\nNodes:"
    docker node ls
    
    echo -e "\nServices:"
    docker service ls
    
    echo -e "\nStacks:"
    docker stack ls
}

# Main
case "$ACTION" in
    init)
        swarm_init
        ;;
    deploy)
        swarm_deploy "myapp" "docker-compose.yml"
        ;;
    scale)
        swarm_scale "$SERVICE_NAME" 5
        ;;
    update)
        swarm_update "$SERVICE_NAME" "myapp:latest"
        ;;
    remove)
        swarm_remove "myapp"
        ;;
    status)
        swarm_status
        ;;
    *)
        usage
        ;;
esac
