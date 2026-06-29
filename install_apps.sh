#!/bin/bash

echo "--- Full Arch System Setup ---"

# 1. Update system
sudo pacman -Syu --noconfirm

# 2. Install Base System & Boot
sudo pacman -S --noconfirm base linux linux-firmware amd-ucode \
  efibootmgr grub grub-btrfs btrfs-progs dosfstools

# 3. Desktop Environment (KDE Plasma)
sudo pacman -S --noconfirm plasma-meta plasma-workspace \
  dolphin konsole ark gwenview

# 4. Networking & Connectivity
sudo pacman -S --noconfirm networkmanager network-manager-applet \
  iwd wireless_tools bluez bluez-utils openvpn aria2

# 5. Development Tools
sudo pacman -S --noconfirm base-devel git neovim \
  nvm uv python-pip python-pipx jq fd parallel \
  inotify-tools tree pacman-contrib electron

# 6. Terminal & Shell Enhancements
sudo pacman -S --noconfirm bash-completion starship tmux \
  htop ncdu less nano fastfetch wl-clipboard xdg-utils

# 7. Audio / Video / Graphics
# PipeWire audio
sudo pacman -S --noconfirm pipewire pipewire-alsa pipewire-jack \
  pipewire-pulse wireplumber gst-plugin-pipewire libpulse

# Media players & tools
sudo pacman -S --noconfirm mpv vlc vlc-plugins-all obs-studio yt-dlp

# GPU drivers (AMD)
sudo pacman -S --noconfirm vulkan-radeon rocm-opencl-runtime \
  xf86-video-amdgpu

# Image editors / viewers
sudo pacman -S --noconfirm gimp gwenview

# 8. Productivity, Browsers & Apps
sudo pacman -S --noconfirm discord qbittorrent obsidian \
  bitwarden bitwarden-cli telegram-desktop thunderbird \
  remmina 7zip gparted smartmontools snapper usbutils

# PostgreSQL and tools
sudo pacman -S --noconfirm postgresql pgcli

# 9. Install Yay (AUR Helper)
sudo pacman -S --needed base-devel --noconfirm
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm
    cd .. && rm -rf yay
fi

# 10. Install AUR Packages
yay -S --noconfirm --needed \
  google-chrome \
  visual-studio-code-bin \
  onlyoffice-bin \
  windsurf \
  anydesk-bin \
  antigravity

# 11. Install & Configure Docker
sudo pacman -S --noconfirm docker docker-buildx
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# 12. Install QEMU & Virtualization Suite
sudo pacman -S --noconfirm qemu-full virt-manager virt-viewer \
  dnsmasq bridge-utils libvirt

# 13. Enable Virtualization Services
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default 2>/dev/null
sudo virsh net-start default 2>/dev/null

# 14. Enable NetworkManager and Bluetooth
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

# 15. Fonts
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

# 16. ZRAM (compressed RAM swap)
sudo pacman -S --noconfirm zram-generator

# 17. AI & Development Tools
sudo pacman -S --noconfirm opencode

# 18. Permissions & Fixes
chmod +x /home/$USER
chmod +x /home/$USER/black_drive
sudo usermod -aG libvirt,kvm $USER

echo "------------------------------------------------"
echo "INSTALLATION COMPLETE"
echo "Check your setup with: fastfetch"
echo "IMPORTANT: You MUST REBOOT for group changes to work!"
echo "------------------------------------------------"
