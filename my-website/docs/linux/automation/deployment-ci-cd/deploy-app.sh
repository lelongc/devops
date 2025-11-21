#!/bin/bash
# CI/CD Deployment Script
# Tự động deploy application

PROJECT_NAME="my-app"
DEPLOY_ENV="${1:-staging}"
GIT_REPO="https://github.com/company/my-app.git"
GIT_BRANCH="${2:-main}"
DEPLOY_DIR="/var/www/${PROJECT_NAME}"
BACKUP_DIR="/backup/deployments"
LOG_FILE="/var/log/deployment.log"

echo "$(date): Starting deployment of $PROJECT_NAME to $DEPLOY_ENV" | tee -a "$LOG_FILE"

# Pre-deployment checks
pre_deploy_checks() {
    echo "Running pre-deployment checks..." | tee -a "$LOG_FILE"
    
    # Check disk space
    DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$DISK_USAGE" -gt 90 ]; then
        echo "Error: Insufficient disk space (${DISK_USAGE}% used)" | tee -a "$LOG_FILE"
        exit 1
    fi
    
    # Check required services
    REQUIRED_SERVICES=("nginx" "docker")
    for SERVICE in "${REQUIRED_SERVICES[@]}"; do
        if ! systemctl is-active --quiet "$SERVICE"; then
            echo "Error: Required service $SERVICE is not running" | tee -a "$LOG_FILE"
            exit 1
        fi
    done
    
    echo "✓ Pre-deployment checks passed" | tee -a "$LOG_FILE"
}

# Backup current version
backup_current_version() {
    if [ -d "$DEPLOY_DIR" ]; then
        BACKUP_NAME="${PROJECT_NAME}_$(date +%Y%m%d_%H%M%S).tar.gz"
        BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"
        
        echo "Creating backup: $BACKUP_NAME" | tee -a "$LOG_FILE"
        mkdir -p "$BACKUP_DIR"
        tar -czf "$BACKUP_PATH" -C "$(dirname $DEPLOY_DIR)" "$(basename $DEPLOY_DIR)"
        
        echo "✓ Backup created: $BACKUP_PATH" | tee -a "$LOG_FILE"
    fi
}

# Pull latest code
pull_code() {
    echo "Pulling latest code from $GIT_BRANCH..." | tee -a "$LOG_FILE"
    
    if [ -d "$DEPLOY_DIR/.git" ]; then
        cd "$DEPLOY_DIR"
        git fetch origin
        git checkout "$GIT_BRANCH"
        git pull origin "$GIT_BRANCH"
    else
        mkdir -p "$DEPLOY_DIR"
        git clone -b "$GIT_BRANCH" "$GIT_REPO" "$DEPLOY_DIR"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✓ Code pulled successfully" | tee -a "$LOG_FILE"
    else
        echo "✗ Failed to pull code" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Install dependencies
install_dependencies() {
    echo "Installing dependencies..." | tee -a "$LOG_FILE"
    cd "$DEPLOY_DIR"
    
    # Node.js
    if [ -f "package.json" ]; then
        npm ci --production
    fi
    
    # Python
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    fi
    
    # PHP
    if [ -f "composer.json" ]; then
        composer install --no-dev --optimize-autoloader
    fi
    
    echo "✓ Dependencies installed" | tee -a "$LOG_FILE"
}

# Build application
build_app() {
    echo "Building application..." | tee -a "$LOG_FILE"
    cd "$DEPLOY_DIR"
    
    if [ -f "package.json" ]; then
        npm run build
    fi
    
    if [ -f "Dockerfile" ]; then
        docker build -t "${PROJECT_NAME}:latest" .
    fi
    
    echo "✓ Build completed" | tee -a "$LOG_FILE"
}

# Run database migrations
run_migrations() {
    echo "Running database migrations..." | tee -a "$LOG_FILE"
    cd "$DEPLOY_DIR"
    
    # Laravel
    if [ -f "artisan" ]; then
        php artisan migrate --force
    fi
    
    # Node.js with Sequelize
    if [ -f "package.json" ] && grep -q "sequelize" package.json; then
        npx sequelize-cli db:migrate
    fi
    
    echo "✓ Migrations completed" | tee -a "$LOG_FILE"
}

# Restart services
restart_services() {
    echo "Restarting services..." | tee -a "$LOG_FILE"
    
    # Docker containers
    if [ -f "docker-compose.yml" ]; then
        docker-compose down
        docker-compose up -d
    fi
    
    # PM2 for Node.js
    if command -v pm2 &> /dev/null; then
        pm2 restart "$PROJECT_NAME" || pm2 start ecosystem.config.js
    fi
    
    # Systemd service
    if systemctl list-units --full -all | grep -q "${PROJECT_NAME}.service"; then
        systemctl restart "$PROJECT_NAME"
    fi
    
    # Nginx
    nginx -t && systemctl reload nginx
    
    echo "✓ Services restarted" | tee -a "$LOG_FILE"
}

# Health check after deployment
post_deploy_check() {
    echo "Running post-deployment health check..." | tee -a "$LOG_FILE"
    
    sleep 10
    
    HEALTH_URL="http://localhost/health"
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$HEALTH_URL")
    
    if [ "$RESPONSE" = "200" ]; then
        echo "✓ Application is healthy" | tee -a "$LOG_FILE"
        return 0
    else
        echo "✗ Application health check failed (HTTP $RESPONSE)" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Rollback on failure
rollback() {
    echo "⚠ Deployment failed. Rolling back..." | tee -a "$LOG_FILE"
    
    LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/*.tar.gz | head -1)
    
    if [ -f "$LATEST_BACKUP" ]; then
        rm -rf "$DEPLOY_DIR"
        tar -xzf "$LATEST_BACKUP" -C "$(dirname $DEPLOY_DIR)"
        restart_services
        
        echo "✓ Rollback completed" | tee -a "$LOG_FILE"
    else
        echo "✗ No backup found for rollback" | tee -a "$LOG_FILE"
    fi
}

# Notification
send_notification() {
    STATUS="$1"
    MESSAGE="$2"
    
    # Slack notification
    if [ -n "$SLACK_WEBHOOK" ]; then
        curl -X POST "$SLACK_WEBHOOK" \
            -H 'Content-Type: application/json' \
            -d "{\"text\":\"Deployment $STATUS: $PROJECT_NAME to $DEPLOY_ENV\n$MESSAGE\"}"
    fi
    
    # Email notification
    echo "$MESSAGE" | mail -s "Deployment $STATUS: $PROJECT_NAME" admin@example.com
}

# Main deployment process
main() {
    pre_deploy_checks
    backup_current_version
    pull_code
    install_dependencies
    build_app
    run_migrations
    restart_services
    
    if post_deploy_check; then
        echo "$(date): ✓ Deployment completed successfully" | tee -a "$LOG_FILE"
        send_notification "SUCCESS" "Deployed $GIT_BRANCH to $DEPLOY_ENV"
        exit 0
    else
        echo "$(date): ✗ Deployment failed" | tee -a "$LOG_FILE"
        rollback
        send_notification "FAILED" "Deployment failed and rolled back"
        exit 1
    fi
}

main
