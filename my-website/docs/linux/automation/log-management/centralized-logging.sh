#!/bin/bash
# Centralized Logging Script
# Tập trung logs từ nhiều servers về central server

CENTRAL_SERVER="logs.example.com"
CENTRAL_USER="logcollector"
LOG_DIRS=("/var/log/nginx" "/var/log/applications" "/var/log/mysql")
REMOTE_DIR="/var/log/centralized/$(hostname)"
SSH_KEY="/root/.ssh/log_key"

echo "$(date): Starting log collection from $(hostname)"

# Sync logs to central server
sync_logs() {
    for LOG_DIR in "${LOG_DIRS[@]}"; do
        if [ -d "$LOG_DIR" ]; then
            echo "Syncing $LOG_DIR..."
            
            rsync -avz --compress-level=9 \
                --exclude='*.tmp' \
                --exclude='*.[0-9]' \
                -e "ssh -i $SSH_KEY" \
                "$LOG_DIR/" \
                "${CENTRAL_USER}@${CENTRAL_SERVER}:${REMOTE_DIR}/$(basename $LOG_DIR)/"
            
            if [ $? -eq 0 ]; then
                echo "✓ Synced $LOG_DIR successfully"
            else
                echo "✗ Failed to sync $LOG_DIR"
            fi
        fi
    done
}

# Ship logs using rsyslog
configure_rsyslog() {
    cat >> /etc/rsyslog.d/central.conf << EOF
# Forward all logs to central server
*.* @@${CENTRAL_SERVER}:514
EOF
    
    systemctl restart rsyslog
    echo "Configured rsyslog forwarding"
}

# Ship logs using syslog-ng
configure_syslog_ng() {
    cat >> /etc/syslog-ng/conf.d/central.conf << EOF
destination d_central {
    tcp("${CENTRAL_SERVER}" port(514));
};

log {
    source(s_src);
    destination(d_central);
};
EOF
    
    systemctl restart syslog-ng
    echo "Configured syslog-ng forwarding"
}

# Ship application logs using filebeat
configure_filebeat() {
    cat > /etc/filebeat/filebeat.yml << EOF
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/applications/*.log
    - /var/log/nginx/*.log
  fields:
    hostname: $(hostname)
    
output.logstash:
  hosts: ["${CENTRAL_SERVER}:5044"]
  
logging.level: info
EOF
    
    systemctl restart filebeat
    echo "Configured filebeat"
}

# Main
sync_logs

echo "$(date): Log collection completed"
