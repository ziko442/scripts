#!/bin/bash
set -e

echo "[*] Starting BlackArch repository installation..."

# 0. Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "[!] Please run as root: sudo ./install_blackarch_repo.sh"
  exit 1
fi

# 1. Remove any existing broken BlackArch repo entry
echo "[*] Cleaning old BlackArch entries (if any)..."
sed -i '/^\[blackarch\]/,/^$/d' /etc/pacman.conf

# 2. Update Arch first (important)
echo "[*] Updating Arch Linux..."
pacman -Syu --noconfirm

# 3. Install required dependencies
echo "[*] Installing required packages..."
pacman -S --needed curl gnupg --noconfirm

# 4. Download and run official BlackArch strap script
echo "[*] Downloading BlackArch strap.sh..."
curl -fsSLO https://blackarch.org/strap.sh

echo "[*] Setting permissions..."
chmod +x strap.sh

echo "[*] Running strap.sh..."
./strap.sh

# 5. Force refresh pacman databases
echo "[*] Forcing pacman database refresh..."
pacman -Syy --noconfirm

# 6. Verify repository
echo "[*] Verifying BlackArch repository..."
if pacman -Sl blackarch >/dev/null 2>&1; then
  echo "[+] BlackArch repository installed successfully!"
else
  echo "[!] BlackArch repo verification failed."
  exit 1
fi

echo
echo "[✔] DONE!"
echo "You can now install tools like:"
echo "    sudo pacman -S nmap sqlmap metasploit burpsuite"
echo
echo "Do NOT install the full blackarch meta-package unless you want everything."
