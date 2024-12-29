#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -euo pipefail

# Initialize IPsec tunnel
ipsec up L2TP-PSK

# Initiate L2TP connection
echo "c vpn" > /var/run/xl2tpd/l2tp-control

# Wait for ppp interface with timeout
MAX_ATTEMPTS=30
INTERVAL=0.5
attempt=0

while [ $attempt -lt $MAX_ATTEMPTS ]; do
    if ip link show ppp0 &>/dev/null; then
        break
    fi
    attempt=$((attempt + 1))
    sleep $INTERVAL
done

if [ $attempt -eq $MAX_ATTEMPTS ]; then
    echo "Timeout waiting for ppp0 interface"
    exit 1
fi

# Add routes for VPN subnet
ip route add 10.11.0.0/16 via $(ip route | grep default | awk '{print $3}')
