#!/usr/bin/env bash
# Create the shared bridge + tap devices that the client and server VMs
# attach their second NIC (eth1) to. Run with sudo.
#
#   sudo ./network-setup.sh
set -euo pipefail

BRIDGE=airbr
NET=10.10.10.0/24
OWNER="${SUDO_USER:-$USER}"

if ! ip link show "$BRIDGE" >/dev/null 2>&1; then
  ip link add "$BRIDGE" type bridge
fi
ip link set "$BRIDGE" up
ip addr flush dev "$BRIDGE"
ip addr add 10.10.10.1/24 dev "$BRIDGE"

for i in 0 1; do
  tap="tap$i"
  if ! ip link show "$tap" >/dev/null 2>&1; then
    ip tuntap add dev "$tap" mode tap user "$OWNER"
  fi
  ip link set "$tap" master "$BRIDGE"
  ip link set "$tap" up
done

echo "Bridge $BRIDGE ready on $NET (host IP 10.10.10.1); taps tap0 (server) and tap1 (client)."
