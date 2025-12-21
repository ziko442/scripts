#!/bin/bash

set -e

echo "=============================="
echo " GitHub SSH Setup (Arch Linux)"
echo "=============================="

# 1. Install git if missing
if ! command -v git &>/dev/null; then
  echo "[*] Installing git..."
  sudo pacman -S --noconfirm git
else
  echo "[+] Git already installed"
fi

# 2. Set git identity (ask user)
read -p "Enter your GitHub name: " GIT_NAME
read -p "Enter your GitHub email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo "[+] Git identity set"

# 3. Generate SSH key if not exists
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "[*] Generating SSH key..."
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
else
  echo "[+] SSH key already exists"
fi

# 4. Start ssh-agent
echo "[*] Starting ssh-agent..."
eval "$(ssh-agent -s)"

# 5. Add SSH key
ssh-add "$HOME/.ssh/id_ed25519"

# 6. Ensure GitHub SSH is known
ssh-keyscan github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null

# 7. Show public key
echo
echo "=============================="
echo " COPY THIS KEY TO GITHUB"
echo "=============================="
cat "$HOME/.ssh/id_ed25519.pub"
echo "=============================="
echo
echo "GitHub → Settings → SSH and GPG keys → New SSH key"
echo
echo "After adding, test with:"
echo "  ssh -T git@github.com"
