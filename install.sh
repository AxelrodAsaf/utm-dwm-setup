#!/usr/bin/env bash
set -e

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

git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/slstatus

echo "=== Applying configs ==="
cp ~/repos/utm-dwm-setup/configs/dwm_config.h ~/src/suckless/dwm/config.h
cp ~/repos/utm-dwm-setup/configs/slstatus_config.h ~/src/suckless/slstatus/config.h
cp ~/repos/utm-dwm-setup/configs/picom.conf ~/.config/picom.conf 2>/dev/null || mkdir -p ~/.config && cp ~/repos/utm-dwm-setup/configs/picom.conf ~/.config/picom.conf
cp ~/repos/utm-dwm-setup/configs/autostart.sh ~/.dwm-autostart.sh

echo "=== Building dwm ==="
cd ~/src/suckless/dwm
sudo make clean install

echo "=== Building st ==="
cd ~/src/suckless/st
sudo make clean install

echo "=== Building slstatus ==="
cd ~/src/suckless/slstatus
sudo make clean install

echo "=== Installing yt-dlp properly (pipx-style) ==="
python3 -m venv ~/.venvs/yt
~/.venvs/yt/bin/pip install yt-dlp

echo "=== Setup complete ==="
echo "Log into TTY and run: startx"
