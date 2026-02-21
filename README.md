# UTM dwm Setup

Minimal reproducible dwm-based environment for Ubuntu (UTM VM).

## Overview

This repo bootstraps a minimal X11 + dwm setup including:

- dwm (with autostart patch)
- st
- dmenu
- slstatus (time in bar)
- picom (transparency)
- feh (wallpaper)
- Firefox
- Basic fonts

All custom configuration files are stored in `configs/`.

---

## Installation (Fresh VM)

After installing Ubuntu Server:

```bash
git clone https://github.com/YOUR_USERNAME/utm-dwm-setup.git
cd utm-dwm-setup
chmod +x install.sh
./install.sh

