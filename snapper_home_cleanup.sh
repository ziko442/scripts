#!/usr/bin/env bash

set -e

# Safety note: do not force-delete snapshot IDs in an automated script.
# like sudo snapper -c home delete 1-999999
# Let the configured Snapper retention policy decide what is old enough to remove.


echo "Current disk usage:"
df -h /

echo
echo "Home snapshots before cleanup:"
sudo snapper -c home list

echo
read -rp "Run Snapper timeline cleanup for HOME? [y/N] " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    sudo snapper -c home cleanup timeline
    echo
    echo "Home snapshots after cleanup:"
    sudo snapper -c home list
else
    echo "No snapshots deleted."
fi

echo
echo "Final disk usage:"
df -h /