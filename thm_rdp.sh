#!/bin/bash

# --- CONFIGURATION ---
TARGET_IP="10.81.171.249"
USERNAME="ElfMcBlue"
PASSWORD="TryH@cKMe1!"
# ---------------------

echo "[*] Optimizing VPN connection (MTU fix)..."
# This prevents the "Connection Timed Out" / "Broken Pipe" errors
sudo ip link set dev tun0 mtu 1200

echo "[*] Launching RDP for $USERNAME..."
echo "[*] Tip: Use Right-Ctrl + Enter to toggle Fullscreen if needed."

xfreerdp3 /u:"$USERNAME" \
          /p:"$PASSWORD" \
          /v:"$TARGET_IP" \
        #   /w:1280 /h:720 \
          /dynamic-resolution \
        #   /cert:ignore \
          /timeout:30000 \
          +clipboard \
        #   /gfx:avc444 +gfx-progressive
