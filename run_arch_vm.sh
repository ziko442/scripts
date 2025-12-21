#!/bin/bash
# -----------------------------------------------
# Script: manage_arch_vm.sh
# Purpose: Create, start, and view Arch Linux VM
# Environment: libvirt / QEMU on Arch Linux
# -----------------------------------------------

VM_NAME="arch-linux"
VM_DIR="/home/zaki442/black_drive/vms"
ISO_PATH="$VM_DIR/arch-linux.iso"
DISK_PATH="$VM_DIR/arch-linux.qcow2"

RAM=4096       # MB
VCPUS=4
DISK_SIZE=30   # GB

# -----------------------------------------------
# STEP 1: Check ISO
# -----------------------------------------------
if [ ! -f "$ISO_PATH" ]; then
    echo "❌ ISO not found: $ISO_PATH"
    exit 1
fi

# -----------------------------------------------
# STEP 2: Create disk if missing
# -----------------------------------------------
if [ ! -f "$DISK_PATH" ]; then
    echo "[+] Creating VM disk..."
    qemu-img create -f qcow2 "$DISK_PATH" "${DISK_SIZE}G"
fi

# -----------------------------------------------
# STEP 3: Create VM (first time only)
# -----------------------------------------------
# Uncomment this section only for the first run.
# sudo virt-install \
#   --connect qemu:///system \
#   --name "$VM_NAME" \
#   --memory "$RAM" \
#   --vcpus "$VCPUS" \
#   --cpu host-model \
#   --machine q35 \
#   --disk path="$DISK_PATH",format=qcow2,bus=virtio \
#   --cdrom "$ISO_PATH" \
#   --os-variant archlinux \
#   --boot uefi \
#   --network network=default,model=virtio \
#   --graphics spice \
#   --video virtio \
#   --sound ich9 \
#   --channel spicevmc \
#   --rng /dev/urandom \
#   --noautoconsole

# -----------------------------------------------
# STEP 4: Start the VM
# -----------------------------------------------
# Start by name
sudo virsh start "$VM_NAME"

# Or start by UUID (optional)
# sudo virsh start <UUID>

# -----------------------------------------------
# STEP 5: Stop / Shutdown the VM
# -----------------------------------------------
# Graceful shutdown
# sudo virsh shutdown "$VM_NAME"

# Force stop (like power off)
# sudo virsh destroy "$VM_NAME"

# Reboot VM
# sudo virsh reboot "$VM_NAME"

# -----------------------------------------------
# STEP 6: Console access
# -----------------------------------------------
# Graphical console (Virt-Viewer)
virt-viewer --connect qemu:///system "$VM_NAME"

# Graphical console (Remote-Viewer using SPICE URI)
# URI example: spice://127.0.0.1:5900
# remote-viewer $(sudo virsh domdisplay "$VM_NAME")

# Serial console (text only)
# sudo virsh console "$VM_NAME"
# Exit with Ctrl+]

# -----------------------------------------------
# STEP 7: Auto-start VM at system boot
# -----------------------------------------------
# sudo virsh autostart "$VM_NAME"

# -----------------------------------------------
# Notes:
# - 'sudo virsh list --all' shows all VMs
# - 'sudo virsh net-list --all' shows available networks
# - Use '--connect qemu:///system' for system-wide libvirt
# - The VM is running under system libvirt, so default NAT network works
# -----------------------------------------------
