# utm-dwm-setup

Minimal reproducible Ubuntu 24.04 (ARM64) environment running dwm inside UTM.

This repository contains configuration files and install script to recreate a clean tiling window manager setup.

---

## System Overview

Base:
- Ubuntu 24.04.4 LTS (ARM64)
- Running inside UTM VM

Window Manager:
- dwm 6.8 (with autostart patch)

Status Bar:
- slstatus (custom config)

Terminal:
- st (transparent via picom)

Compositor:
- picom (transparency enabled)

Browser:
- Firefox (APT version, snap removed)

Media:
- mpv
- yt-dlp

Developer Tools:
- neovim
- fzf
- git
- gh CLI
- node

---

## System State (Minimal Base v1.0)

This VM has been aggressively trimmed.

Removed:
- Snap + snapd
- Printing (CUPS)
- Bluetooth (bluez)
- Avahi (network discovery)
- Speech stack
- Crash reporting (apport, whoopsie)
- GNOME terminal
- XFCE panel libraries
- GTK desktop portal backend

Current disk usage after cleanup:
6.9G / 11G (68%)

---

## Directory Structure

configs/
    dwm_config.h
    slstatus_config.h
    picom.conf
    autostart.sh

install.sh

---

## Install Instructions

Clone repository:

    git clone https://github.com/AxelrodAsaf/utm-dwm-setup.git
    cd utm-dwm-setup

Run installer:

    chmod +x install.sh
    ./install.sh

Then login via TTY and run:

    startx

---

## Notes

This system is designed to be:

- Snap-free
- Minimal background services
- Lightweight
- Reproducible
- Development-ready

Future planned phases:
- CLI YouTube feed integration
- Plex CLI integration
