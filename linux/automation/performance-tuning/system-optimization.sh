#!/bin/bash
# Performance Tuning Script
# Tối ưu hiệu suất hệ thống Linux

LOG_FILE="/var/log/performance-tuning.log"

echo "$(date): Starting performance tuning..." | tee -a "$LOG_FILE"

# Optimize kernel parameters
optimize_kernel() {
    echo "Optimizing kernel parameters..." | tee -a "$LOG_FILE"
    
    cat >> /etc/sysctl.conf << EOF

# Performance tuning
vm.swappiness=10
vm.dirty_ratio=15
vm.dirty_background_ratio=5
fs.file-max=65535
net.core.somaxconn=65535
net.core.netdev_max_backlog=5000
net.ipv4.tcp_max_syn_backlog=4096
net.ipv4.tcp_fin_timeout=30
net.ipv4.tcp_keepalive_time=300
net.ipv4.tcp_tw_reuse=1
EOF
    
    sysctl -p
    echo "✓ Kernel parameters optimized" | tee -a "$LOG_FILE"
}

# Optimize disk I/O
optimize_disk_io() {
    echo "Optimizing disk I/O..." | tee -a "$LOG_FILE"
    
    # Set I/O scheduler
    for disk in /sys/block/sd*/queue/scheduler; do
        echo "deadline" > "$disk" 2>/dev/null
        echo "Set deadline scheduler for $(dirname $disk)" | tee -a "$LOG_FILE"
    done
    
    # Enable disk readahead
    for disk in /dev/sd?; do
        blockdev --setra 4096 "$disk" 2>/dev/null
    done
    
    echo "✓ Disk I/O optimized" | tee -a "$LOG_FILE"
}

# Optimize MySQL
optimize_mysql() {
    if systemctl is-active --quiet mysql; then
        echo "Optimizing MySQL..." | tee -a "$LOG_FILE"
        
        # Get total RAM
        TOTAL_RAM=$(free -m | awk '/^Mem:/{print $2}')
        INNODB_BUFFER=$(echo "$TOTAL_RAM * 0.7 / 1" | bc)
        
        cat >> /etc/mysql/mysql.conf.d/performance.cnf << EOF
[mysqld]
innodb_buffer_pool_size = ${INNODB_BUFFER}M
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
max_connections = 500
query_cache_size = 64M
query_cache_limit = 2M
thread_cache_size = 50
table_open_cache = 4000
EOF
        
        systemctl restart mysql
        echo "✓ MySQL optimized" | tee -a "$LOG_FILE"
    fi
}

# Optimize Nginx
optimize_nginx() {
    if systemctl is-active --quiet nginx; then
        echo "Optimizing Nginx..." | tee -a "$LOG_FILE"
        
        WORKER_PROCESSES=$(nproc)
        
        cat > /etc/nginx/conf.d/performance.conf << EOF
worker_processes $WORKER_PROCESSES;
worker_rlimit_nofile 65535;

events {
    worker_connections 4096;
    use epoll;
    multi_accept on;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    keepalive_requests 100;
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
    
    # Cache
    open_file_cache max=10000 inactive=30s;
    open_file_cache_valid 60s;
    open_file_cache_min_uses 2;
}
EOF
        
        nginx -t && systemctl reload nginx
        echo "✓ Nginx optimized" | tee -a "$LOG_FILE"
    fi
}

# Optimize Apache
optimize_apache() {
    if systemctl is-active --quiet apache2; then
        echo "Optimizing Apache..." | tee -a "$LOG_FILE"
        
        a2enmod deflate
        a2enmod expires
        a2enmod headers
        
        cat > /etc/apache2/conf-available/performance.conf << EOF
<IfModule mpm_prefork_module>
    StartServers 5
    MinSpareServers 5
    MaxSpareServers 10
    MaxRequestWorkers 150
    MaxConnectionsPerChild 3000
</IfModule>

<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>
EOF
        
        a2enconf performance
        systemctl restart apache2
        echo "✓ Apache optimized" | tee -a "$LOG_FILE"
    fi
}

# Optimize Redis
optimize_redis() {
    if systemctl is-active --quiet redis; then
        echo "Optimizing Redis..." | tee -a "$LOG_FILE"
        
        cat >> /etc/redis/redis.conf << EOF

# Performance tuning
maxmemory 2gb
maxmemory-policy allkeys-lru
save ""
appendonly no
tcp-backlog 511
EOF
        
        systemctl restart redis
        echo "✓ Redis optimized" | tee -a "$LOG_FILE"
    fi
}

# Disable unnecessary services
disable_unnecessary_services() {
    echo "Disabling unnecessary services..." | tee -a "$LOG_FILE"
    
    SERVICES_TO_DISABLE=("bluetooth" "cups" "avahi-daemon")
    
    for SERVICE in "${SERVICES_TO_DISABLE[@]}"; do
        if systemctl is-enabled --quiet "$SERVICE" 2>/dev/null; then
            systemctl disable "$SERVICE"
            systemctl stop "$SERVICE"
            echo "Disabled: $SERVICE" | tee -a "$LOG_FILE"
        fi
    done
}

# Performance benchmark
run_benchmark() {
    echo "Running performance benchmark..." | tee -a "$LOG_FILE"
    
    echo "CPU Benchmark:"
    sysbench cpu --cpu-max-prime=20000 run
    
    echo "Memory Benchmark:"
    sysbench memory --memory-total-size=10G run
    
    echo "Disk I/O Benchmark:"
    sysbench fileio --file-total-size=2G prepare
    sysbench fileio --file-total-size=2G --file-test-mode=rndrw run
    sysbench fileio --file-total-size=2G cleanup
}

# Main
optimize_kernel
optimize_disk_io
optimize_mysql
optimize_nginx
optimize_apache
optimize_redis
disable_unnecessary_services

echo "$(date): Performance tuning completed" | tee -a "$LOG_FILE"
echo "System will require a reboot for all changes to take effect"
