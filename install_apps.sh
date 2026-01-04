#!/bin/bash

# pacman -Qe
# sudo pacman -Rns $(pacman -Qqet)


echo "--- Arch Setup: Power Tools, Browsers & Virtualization ---"

# 1. Update system and resolve networking conflicts
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm iptables-nft

# 2. Install System Essentials (Pacman)
# git, curl, wget: Downloading and version control
# neovim: Terminal text editor
# fastfetch: System information display
sudo pacman -S --noconfirm git curl wget neovim fastfetch qbittorrent discord bash-completion p7zip unrar vlc vlc-plugins-all mpv


# 3. Install Yay (AUR Helper)
# Needed for Google Chrome and official VS Code
sudo pacman -S --needed base-devel --noconfirm
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm
    cd .. && rm -rf yay
fi

# 4. Install AUR Packages
# google-chrome: The official Chrome browser
# visual-studio-code-bin: The official Microsoft VS Code for Copilot support
yay -S --noconfirm google-chrome visual-studio-code-bin obsidian

# 5. Install & Configure Docker
sudo pacman -S --noconfirm docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# 6. Install QEMU and Virtualization Suite
sudo pacman -S --noconfirm qemu-full virt-manager virt-viewer dnsmasq bridge-utils libvirt ebtables

# 7. Enable Virtualization Services and Networking
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default 2>/dev/null
sudo virsh net-start default 2>/dev/null

# 8. Permissions & Fixes
# Fix QEMU Search permissions for your black_drive
chmod +x /home/$USER
chmod +x /home/$USER/black_drive
sudo usermod -aG libvirt,kvm $USER

echo "------------------------------------------------"
echo "INSTALLATION COMPLETE"
echo "Check your setup with: fastfetch"
echo "IMPORTANT: You MUST REBOOT for group changes to work!"
echo "------------------------------------------------"