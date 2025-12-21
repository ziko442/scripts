#!/bin/bash

# 1. Update the system
sudo pacman -Syu --noconfirm

# 2. Install Hyprland and core essentials
# kitty: terminal (required by default config)
# waybar: the top status bar
# wofi: the app launcher (like a start menu)
# xdg-desktop-portal-hyprland: required for screen sharing/proper booting
sudo pacman -S --noconfirm hyprland kitty waybar wofi xdg-desktop-portal-hyprland qt5-wayland qt6-wayland

# 3. Install Audio and Wallpaper tools
sudo pacman -S --noconfirm pipewire pipewire-pulse swww

# 4. Create the config directory if it doesn't exist
mkdir -p ~/.config/hypr

# 5. Provide a basic "Welcome" message
echo "-------------------------------------------------------"
echo "Installation complete!"
echo "1. Log out of KDE Plasma."
echo "2. Select 'Hyprland' from the session menu in SDDM."
echo "3. Once inside, press SUPER (Windows Key) + Q to open Kitty."
echo "-------------------------------------------------------"
