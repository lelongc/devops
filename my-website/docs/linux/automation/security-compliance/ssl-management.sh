#!/bin/bash
# SSL Certificate Management Script
# Quản lý SSL certificates với Let's Encrypt

DOMAIN="$1"
ACTION="${2:-install}"
EMAIL="admin@example.com"
WEBROOT="/var/www/html"

usage() {
    echo "Usage: $0 domain {install|renew|check|revoke}"
    exit 1
}

if [ -z "$DOMAIN" ]; then
    usage
fi

# Install certbot if not present
install_certbot() {
    if ! command -v certbot &> /dev/null; then
        echo "Installing certbot..."
        
        if command -v apt &> /dev/null; then
            apt-get update
            apt-get install -y certbot python3-certbot-nginx
        elif command -v yum &> /dev/null; then
            yum install -y certbot python3-certbot-nginx
        fi
        
        echo "✓ Certbot installed"
    fi
}

# Install SSL certificate
install_cert() {
    DOMAIN="$1"
    
    echo "Installing SSL certificate for $DOMAIN..."
    
    install_certbot
    
    # Request certificate
    certbot certonly --webroot -w "$WEBROOT" \
        -d "$DOMAIN" \
        --email "$EMAIL" \
        --agree-tos \
        --non-interactive
    
    if [ $? -eq 0 ]; then
        echo "✓ Certificate installed successfully"
        configure_nginx "$DOMAIN"
    else
        echo "✗ Certificate installation failed"
        exit 1
    fi
}

# Configure Nginx for SSL
configure_nginx() {
    DOMAIN="$1"
    NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"
    
    cat > "$NGINX_CONF" << EOF
server {
    listen 80;
    server_name $DOMAIN;
    return 301 https://\$server_name\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name $DOMAIN;

    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
    
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    
    root /var/www/html;
    index index.html;
    
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF
    
    ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/
    nginx -t && systemctl reload nginx
    
    echo "✓ Nginx configured for SSL"
}

# Renew certificates
renew_certs() {
    echo "Renewing SSL certificates..."
    
    certbot renew --quiet
    
    if [ $? -eq 0 ]; then
        echo "✓ Certificates renewed"
        systemctl reload nginx
    else
        echo "⚠ Certificate renewal issues"
    fi
}

# Check certificate expiry
check_cert() {
    DOMAIN="$1"
    CERT_FILE="/etc/letsencrypt/live/$DOMAIN/cert.pem"
    
    if [ ! -f "$CERT_FILE" ]; then
        echo "✗ Certificate not found for $DOMAIN"
        exit 1
    fi
    
    EXPIRY_DATE=$(openssl x509 -enddate -noout -in "$CERT_FILE" | cut -d= -f2)
    EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s)
    CURRENT_EPOCH=$(date +%s)
    DAYS_LEFT=$(( ($EXPIRY_EPOCH - $CURRENT_EPOCH) / 86400 ))
    
    echo "Certificate for $DOMAIN expires in $DAYS_LEFT days"
    echo "Expiry date: $EXPIRY_DATE"
    
    if [ "$DAYS_LEFT" -lt 30 ]; then
        echo "⚠ Certificate expiring soon, consider renewal"
    fi
}

# Revoke certificate
revoke_cert() {
    DOMAIN="$1"
    
    echo "Revoking certificate for $DOMAIN..."
    
    certbot revoke --cert-path "/etc/letsencrypt/live/$DOMAIN/cert.pem"
    certbot delete --cert-name "$DOMAIN"
    
    echo "✓ Certificate revoked"
}

# Setup auto-renewal
setup_auto_renew() {
    echo "Setting up auto-renewal..."
    
    # Add cron job
    CRON_JOB="0 3 * * * certbot renew --quiet && systemctl reload nginx"
    
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    
    echo "✓ Auto-renewal configured (daily at 3 AM)"
}

# Main
case "$ACTION" in
    install)
        install_cert "$DOMAIN"
        setup_auto_renew
        ;;
    renew)
        renew_certs
        ;;
    check)
        check_cert "$DOMAIN"
        ;;
    revoke)
        revoke_cert "$DOMAIN"
        ;;
    *)
        usage
        ;;
esac
