#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Updating system ==="
sudo apt update
sudo apt upgrade -y

echo "=== Removing snap and unnecessary services ==="
sudo snap remove firefox 2>/dev/null || true
sudo snap remove gnome-42-2204 2>/dev/null || true
sudo snap remove gtk-common-themes 2>/dev/null || true
sudo snap remove core22 2>/dev/null || true
sudo snap remove bare 2>/dev/null || true
sudo snap remove snapd 2>/dev/null || true
sudo apt purge -y snapd
sudo rm -rf ~/snap /snap /var/snap /var/lib/snapd

sudo apt purge -y \
cups* \
bluez* \
avahi-daemon avahi-utils \
speech-dispatcher* \
espeak* \
brltty \
modemmanager \
whoopsie \
apport* \
xdg-desktop-portal-gtk \
policykit-1-gnome || true

sudo apt autoremove --purge -y
sudo apt clean

echo "=== Installing required packages ==="
sudo apt install -y \
xorg \
build-essential \
libx11-dev \
libxft-dev \
libxinerama-dev \
libfontconfig1-dev \
picom \
neovim \
fzf \
git \
curl \
mpv \
python3-venv \
python3-pip \
nodejs \
npm \
gh

echo "=== Installing Firefox (APT version) ==="
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt update
sudo apt install -y firefox

echo "=== Cloning suckless tools ==="
mkdir -p ~/src/suckless
cd ~/src/suckless

[ -d dwm/.git ] || git clone https://git.suckless.org/dwm
[ -d st/.git ] || git clone https://git.suckless.org/st
[ -d slstatus/.git ] || git clone https://git.suckless.org/slstatus

echo "=== Applying configs ==="
cp "$REPO_DIR/configs/dwm_config.h" ~/src/suckless/dwm/config.h
cp "$REPO_DIR/configs/slstatus_config.h" ~/src/suckless/slstatus/config.h

mkdir -p ~/.config/picom
cp "$REPO_DIR/configs/picom.conf" ~/.config/picom/picom.conf

mkdir -p ~/.dwm
ln -sf "$REPO_DIR/configs/autostart.sh" ~/.dwm/autostart.sh

# Notes script
mkdir -p ~/.local/bin
ln -sf "$REPO_DIR/configs/notes" ~/.local/bin/notes
chmod +x "$REPO_DIR/configs/notes"

# Neovim config
mkdir -p ~/.config/nvim
ln -sf "$REPO_DIR/configs/nvim_init.vim" ~/.config/nvim/init.vim

cd "$HOME/src/suckless/dwm"
if ! grep -q "runautostart" dwm.c; then
  patch -p1 < "$REPO_DIR/patches/dwm/autostart.patch"
fi

# Apply dwm patches (repo-canonical)
DWM_DIR="$HOME/src/suckless/dwm"
if [ -f "$REPO_DIR/patches/dwm/autostart.patch" ]; then
  ( cd "$DWM_DIR" && patch -p1 --forward < "$REPO_DIR/patches/dwm/autostart.patch" ) || true
fi

echo "=== Building dwm ==="
cd ~/src/suckless/dwm
sudo make clean install

echo "=== Building st ==="
# --- st ---
ST_DIR="$HOME/src/suckless/st"

if [ -d "$ST_DIR" ]; then
  echo "[*] Injecting st config"
  cp -f "$REPO_DIR/configs/st_config.h" "$ST_DIR/config.h"
fi

echo "[*] Building st"
cd "$ST_DIR"
sudo make clean install

echo "=== Building slstatus ==="
cd ~/src/suckless/slstatus
sudo make clean install

echo "=== Installing yt-dlp properly (venv) ==="
python3 -m venv ~/.venvs/yt
~/.venvs/yt/bin/pip install -U pip yt-dlp

echo "=== Setup complete ==="
echo "Log into TTY and run: startx"
