#!/bin/bash
# Network Configuration Script
# Tự động cấu hình network interfaces và firewall

ACTION="$1"
INTERFACE="${2:-eth0}"

usage() {
    echo "Usage: $0 {configure-static|configure-dhcp|firewall-setup|port-forward}"
    exit 1
}

# Configure static IP
configure_static_ip() {
    INTERFACE="$1"
    IP_ADDRESS="$2"
    NETMASK="$3"
    GATEWAY="$4"
    DNS="$5"
    
    echo "Configuring static IP for $INTERFACE..."
    
    # Backup current config
    cp /etc/network/interfaces /etc/network/interfaces.backup
    
    # Ubuntu/Debian netplan
    if [ -d "/etc/netplan" ]; then
        cat > /etc/netplan/01-netcfg.yaml << EOF
network:
  version: 2
  ethernets:
    $INTERFACE:
      addresses:
        - $IP_ADDRESS/$NETMASK
      gateway4: $GATEWAY
      nameservers:
        addresses: [$DNS]
EOF
        netplan apply
    else
        # Traditional config
        cat > /etc/network/interfaces << EOF
auto $INTERFACE
iface $INTERFACE inet static
    address $IP_ADDRESS
    netmask $NETMASK
    gateway $GATEWAY
    dns-nameservers $DNS
EOF
        systemctl restart networking
    fi
    
    echo "✓ Static IP configured"
}

# Configure DHCP
configure_dhcp() {
    INTERFACE="$1"
    
    echo "Configuring DHCP for $INTERFACE..."
    
    if [ -d "/etc/netplan" ]; then
        cat > /etc/netplan/01-netcfg.yaml << EOF
network:
  version: 2
  ethernets:
    $INTERFACE:
      dhcp4: true
EOF
        netplan apply
    else
        cat > /etc/network/interfaces << EOF
auto $INTERFACE
iface $INTERFACE inet dhcp
EOF
        systemctl restart networking
    fi
    
    echo "✓ DHCP configured"
}

# Setup firewall rules
setup_firewall() {
    echo "Setting up firewall rules..."
    
    # Install ufw if not present
    if ! command -v ufw &> /dev/null; then
        apt-get install -y ufw
    fi
    
    # Reset firewall
    ufw --force reset
    
    # Default policies
    ufw default deny incoming
    ufw default allow outgoing
    
    # Allow SSH
    ufw allow 22/tcp
    
    # Allow HTTP/HTTPS
    ufw allow 80/tcp
    ufw allow 443/tcp
    
    # Allow custom ports
    ufw allow 3000/tcp
    ufw allow 8080/tcp
    
    # Enable firewall
    ufw --force enable
    
    echo "✓ Firewall configured"
    ufw status verbose
}

# Configure port forwarding
configure_port_forward() {
    SRC_PORT="$1"
    DEST_IP="$2"
    DEST_PORT="$3"
    
    echo "Configuring port forwarding: $SRC_PORT -> $DEST_IP:$DEST_PORT"
    
    # Enable IP forwarding
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    sysctl -p
    
    # Add iptables rule
    iptables -t nat -A PREROUTING -p tcp --dport "$SRC_PORT" -j DNAT --to-destination "$DEST_IP:$DEST_PORT"
    iptables -t nat -A POSTROUTING -p tcp -d "$DEST_IP" --dport "$DEST_PORT" -j MASQUERADE
    
    # Save rules
    iptables-save > /etc/iptables/rules.v4
    
    echo "✓ Port forwarding configured"
}

# Network diagnostics
network_diagnostics() {
    echo "Running network diagnostics..."
    echo "========================================"
    
    echo "Network Interfaces:"
    ip addr show
    
    echo -e "\nRouting Table:"
    ip route show
    
    echo -e "\nDNS Configuration:"
    cat /etc/resolv.conf
    
    echo -e "\nActive Connections:"
    netstat -tuln | head -20
    
    echo -e "\nFirewall Status:"
    ufw status verbose 2>/dev/null || iptables -L -n
}

# Main
case "$ACTION" in
    configure-static)
        configure_static_ip "$INTERFACE" "192.168.1.100" "255.255.255.0" "192.168.1.1" "8.8.8.8"
        ;;
    configure-dhcp)
        configure_dhcp "$INTERFACE"
        ;;
    firewall-setup)
        setup_firewall
        ;;
    port-forward)
        configure_port_forward "8080" "192.168.1.10" "80"
        ;;
    diagnostics)
        network_diagnostics
        ;;
    *)
        usage
        ;;
esac
