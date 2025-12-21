#!/bin/bash
# -----------------------------------------------
# Script: run_kali_vm.sh
# Purpose: Run Kali Linux QEMU image with libvirt
# Environment: libvirt / QEMU on Arch Linux
# -----------------------------------------------

VM_NAME="kali-linux"
VM_DIR="/home/zaki442/black_drive/vms"
DISK_PATH="$VM_DIR/kali-linux-2025.4-qemu-amd64.qcow2"

RAM=4096       # MB
VCPUS=4

# -----------------------------------------------
# STEP 1: Check if disk exists
# -----------------------------------------------
if [ ! -f "$DISK_PATH" ]; then
    echo "❌ QCOW2 disk not found: $DISK_PATH"
    exit 1
fi

# -----------------------------------------------
# STEP 2: Create VM (first time only)
# -----------------------------------------------
# This step is needed to define the VM in libvirt if not already defined
# Uncomment the first time you run this VM

# Remove --boot uefi
# sudo virt-install \
#   --connect qemu:///system \
#   --name "$VM_NAME" \
#   --memory "$RAM" \
#   --vcpus "$VCPUS" \
#   --cpu host-model \
#   --machine q35 \
#   --disk path="$DISK_PATH",format=qcow2,bus=virtio \
#   --os-variant linux2024 \
#   --network network=default,model=virtio \
#   --graphics spice \
#   --video virtio \
#   --sound ich9 \
#   --channel spicevmc \
#   --rng /dev/urandom \
#   --import


# Note: '--import' is used since the image is pre-installed

# -----------------------------------------------
# STEP 3: Start the VM
# -----------------------------------------------
sudo virsh start "$VM_NAME"

# -----------------------------------------------
# STEP 4: Console access
# -----------------------------------------------
# Graphical console
virt-viewer --connect qemu:///system "$VM_NAME"

# Graphical console (Remote-Viewer using SPICE URI)
# URI example: spice://127.0.0.1:5900
# remote-viewer $(sudo virsh domdisplay "$VM_NAME")

# Serial console (text only)
# sudo virsh console "$VM_NAME"
# Exit with Ctrl+]

# -----------------------------------------------
# STEP 5: Shutdown / reboot
# -----------------------------------------------
# sudo virsh shutdown "$VM_NAME"   # graceful shutdown
# sudo virsh destroy "$VM_NAME"    # force stop
# sudo virsh reboot "$VM_NAME"     # reboot VM

# -----------------------------------------------
# STEP 6: Auto-start VM at system boot
# -----------------------------------------------
# sudo virsh autostart "$VM_NAME"

# -----------------------------------------------
# Notes:
# - 'sudo virsh list --all' shows all VMs
# - Use '--connect qemu:///system' for system-wide libvirt
# - The VM is running under system libvirt, so default NAT network works
# -----------------------------------------------
