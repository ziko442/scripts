#!/bin/bash

set -e

echo "=============================="
echo " Kali THM Post-Install Script"
echo "=============================="

if [[ $EUID -ne 0 ]]; then
  echo "[!] Run as root: sudo ./kali-thm-postinstall.sh"
  exit 1
fi

echo "[*] Updating system..."
apt update && apt upgrade -y
apt autoremove -y

echo "[*] Installing TryHackMe required tools..."
apt install -y \
  nmap \
  gobuster \
  ffuf \
  hydra \
  john \
  hashcat \
  nikto \
  smbclient \
  enum4linux \
  netcat-traditional \
  wireshark \
  ftp \
  curl \
  wget

echo "[*] Unzipping rockyou.txt..."
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
  gunzip -f /usr/share/wordlists/rockyou.txt.gz
  echo "[+] rockyou.txt unzipped"
else
  echo "[!] rockyou.txt already unzipped or missing"
fi

echo "[*] Fixing wordlist permissions..."
chmod 644 /usr/share/wordlists/rockyou.txt 2>/dev/null || true

echo "=============================="
echo " ✅ Done!"
echo "=============================="
