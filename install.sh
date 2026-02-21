#!/bin/bash

set -e

echo "Updating system..."
sudo apt update
sudo apt install -y \
  build-essential git curl \
  libx11-dev libxft-dev libxinerama-dev \
  xorg xinit \
  feh picom \
  neovim firefox thunar \
  fonts-dejavu fonts-firacode

echo "Creating source directory..."
mkdir -p ~/src/suckless
cd ~/src/suckless

echo "Cloning suckless repos..."
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/slstatus

echo "Applying configs..."

# dwm
cp ~/repos/utm-dwm-setup/configs/dwm_config.h ~/src/suckless/dwm/config.h
cd ~/src/suckless/dwm
sudo make clean install

# slstatus
cp ~/repos/utm-dwm-setup/configs/slstatus_config.h ~/src/suckless/slstatus/config.h
cd ~/src/suckless/slstatus
sudo make clean install

# Autostart
mkdir -p ~/.dwm
cp ~/repos/utm-dwm-setup/configs/autostart.sh ~/.dwm/autostart.sh
chmod +x ~/.dwm/autostart.sh

# Picom config
mkdir -p ~/.config/picom
cp ~/repos/utm-dwm-setup/configs/picom.conf ~/.config/picom/picom.conf

echo "Setup complete."
echo "Run: startx"
