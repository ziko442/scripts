#!/bin/bash

# 1. Configuration
# We search for the drive by its specific UUID to be 100% safe
TARGET_UUID="38a7c54d-a121-45e4-bd10-b0bd7552c691"
MOUNT_NAME="black_drive"
MOUNT_POINT="$HOME/$MOUNT_NAME"

echo "--- Permanent Drive Mounter ---"

# 2. Check if the drive is physically connected
if ! lsblk -no UUID | grep -q "$TARGET_UUID"; then
    echo "ERROR: Drive with UUID $TARGET_UUID not found!"
    echo "Please check if the 1.8TB SSD is plugged in."
    exit 1
fi

# 3. Create the mount directory
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating directory: $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# 4. Add to /etc/fstab if not already there
if grep -q "$TARGET_UUID" /etc/fstab; then
    echo "Entry already exists in /etc/fstab. Checking mount status..."
else
    echo "Adding drive to /etc/fstab..."
    # Using 'nofail' so the OS still boots if the drive is disconnected
    echo "UUID=$TARGET_UUID  $MOUNT_POINT  ext4  defaults,noatime,nofail  0  2" | sudo tee -a /etc/fstab
fi

# 5. Mount the drive
echo "Mounting drive..."
sudo mount -a

# 6. Set Permissions
# This ensures YOU own the drive, not the system (root)
sudo chown "$USER":"$USER" "$MOUNT_POINT"

echo "--- SUCCESS ---"
echo "Drive is mounted at: $MOUNT_POINT"
df -h | grep "$MOUNT_NAME"
