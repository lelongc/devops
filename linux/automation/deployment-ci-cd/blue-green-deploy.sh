#!/bin/bash
# Blue-Green Deployment Script
# Zero-downtime deployment với blue-green strategy

APP_NAME="my-app"
BLUE_PORT=3000
GREEN_PORT=3001
NGINX_UPSTREAM_CONF="/etc/nginx/conf.d/upstream.conf"
HEALTH_ENDPOINT="/health"

echo "Starting Blue-Green deployment..."

# Determine current active environment
get_active_env() {
    CURRENT_UPSTREAM=$(grep -oP "localhost:\K\d+" "$NGINX_UPSTREAM_CONF" | head -1)
    
    if [ "$CURRENT_UPSTREAM" = "$BLUE_PORT" ]; then
        echo "blue"
    else
        echo "green"
    fi
}

# Deploy to inactive environment
deploy_to_inactive() {
    ACTIVE=$(get_active_env)
    
    if [ "$ACTIVE" = "blue" ]; then
        INACTIVE="green"
        INACTIVE_PORT=$GREEN_PORT
    else
        INACTIVE="blue"
        INACTIVE_PORT=$BLUE_PORT
    fi
    
    echo "Active: $ACTIVE, Deploying to: $INACTIVE (port $INACTIVE_PORT)"
    
    # Deploy new version to inactive environment
    cd "/var/www/${APP_NAME}-${INACTIVE}"
    git pull origin main
    npm ci --production
    npm run build
    
    # Restart inactive service
    pm2 restart "${APP_NAME}-${INACTIVE}"
    
    echo "✓ Deployed to $INACTIVE environment"
}

# Health check on new environment
health_check() {
    INACTIVE_PORT="$1"
    MAX_RETRIES=30
    RETRY_COUNT=0
    
    echo "Checking health on port $INACTIVE_PORT..."
    
    while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
        RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${INACTIVE_PORT}${HEALTH_ENDPOINT}")
        
        if [ "$RESPONSE" = "200" ]; then
            echo "✓ Health check passed"
            return 0
        fi
        
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "Waiting for service to be healthy... ($RETRY_COUNT/$MAX_RETRIES)"
        sleep 2
    done
    
    echo "✗ Health check failed"
    return 1
}

# Switch traffic to new environment
switch_traffic() {
    INACTIVE_PORT="$1"
    
    echo "Switching traffic to port $INACTIVE_PORT..."
    
    # Update nginx upstream
    cat > "$NGINX_UPSTREAM_CONF" << EOF
upstream app_backend {
    server localhost:${INACTIVE_PORT};
}
EOF
    
    # Test nginx config
    nginx -t
    
    if [ $? -eq 0 ]; then
        # Reload nginx
        systemctl reload nginx
        echo "✓ Traffic switched successfully"
        return 0
    else
        echo "✗ Nginx config test failed"
        return 1
    fi
}

# Rollback to previous environment
rollback() {
    OLD_PORT="$1"
    
    echo "⚠ Rolling back to port $OLD_PORT..."
    
    cat > "$NGINX_UPSTREAM_CONF" << EOF
upstream app_backend {
    server localhost:${OLD_PORT};
}
EOF
    
    nginx -t && systemctl reload nginx
    
    echo "✓ Rollback completed"
}

# Main deployment flow
main() {
    ACTIVE=$(get_active_env)
    
    if [ "$ACTIVE" = "blue" ]; then
        INACTIVE_PORT=$GREEN_PORT
        ACTIVE_PORT=$BLUE_PORT
    else
        INACTIVE_PORT=$BLUE_PORT
        ACTIVE_PORT=$GREEN_PORT
    fi
    
    # Deploy to inactive environment
    deploy_to_inactive
    
    # Health check on new deployment
    if health_check "$INACTIVE_PORT"; then
        # Switch traffic
        if switch_traffic "$INACTIVE_PORT"; then
            echo "✓ Blue-Green deployment completed successfully"
            
            # Keep old environment running for quick rollback if needed
            echo "Old environment still running on port $ACTIVE_PORT for rollback"
        else
            rollback "$ACTIVE_PORT"
            echo "✗ Deployment failed during traffic switch"
            exit 1
        fi
    else
        echo "✗ Deployment failed health check"
        exit 1
    fi
}

main
