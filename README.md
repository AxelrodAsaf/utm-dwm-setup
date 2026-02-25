# utm-dwm-setup

Reproducible Ubuntu 24.04 (ARM64) tiling environment running **dwm 6.8** inside UTM on Apple Silicon.

This repository is the **canonical configuration layer** for the VM.  
All user-level configuration lives here and is symlinked into place to prevent drift.

---

## Architecture Overview

Host:
- macOS
- UTM virtualization
- 8GB RAM total (VM tuned for stability)

Guest:
- Ubuntu 24.04 LTS (ARM64)
- Snap removed
- Background services aggressively minimized

Window Manager:
- dwm 6.8
- Custom keybindings (MOD = Super/Command)
- Notes integration
- Custom dmenu scripts

Terminal:
- st

Status Bar:
- slstatus (custom config)

Compositor:
- picom (transparent st)

Editor:
- Neovim (markdown-focused setup)

---

## Canonical Config Model

This repository is the single source of truth.

All editable configs live in:


configs/
dwm_config.h
slstatus_config.h
picom.conf
autostart.sh
notes
nvim_init.vim
ZZ

User-facing files are **symlinked** to these:


~/.dwm/autostart.sh
~/.local/bin/notes
~/.config/nvim/init.vim


This prevents configuration drift.

---

## Repository Structure

```text
utm-dwm-setup/
├── configs/
│   ├── autostart.sh
│   ├── dwm_config.h
│   ├── slstatus_config.h
│   ├── picom.conf
│   ├── notes
│   └── nvim_init.vim
├── install.sh
└── README.md
```


### configs/

This directory contains all canonical configuration files.

- `dwm_config.h`  
  Injected into `~/src/suckless/dwm/config.h` before build.

- `slstatus_config.h`  
  Injected into `~/src/suckless/slstatus/config.h` before build.

- `picom.conf`  
  Installed to `~/.config/picom/picom.conf`.

- `autostart.sh`  
  Symlinked to `~/.dwm/autostart.sh`.

- `notes`  
  Notes launcher script (dmenu-based).  
  Symlinked to `~/.local/bin/notes`.

- `nvim_init.vim`  
  Neovim configuration.  
  Symlinked to `~/.config/nvim/init.vim`.

### install.sh

Bootstrap script that:

- Removes snap and unnecessary services
- Installs required packages
- Clones suckless repositories
- Injects config headers
- Builds dwm, st, slstatus
- Creates symlinks for user-level configs

---

## Upstream Policy

Upstream suckless repositories live in:


~/src/suckless/
dwm/
st/
slstatus/


They are treated as upstream source trees.

`install.sh` injects the canonical config headers before building:

- dwm_config.h → dwm/config.h
- slstatus_config.h → slstatus/config.h

Upstream is never committed to this repository.

---

## Keybindings (Custom)

- MOD = Super (Command)
- MOD + x → Quit dwm
- MOD + Shift + n → Notes launcher
- MOD + p → Custom dmenu launcher
- MOD + Shift + p → Process killer

---

## Install

From a fresh Ubuntu 24.04 installation:

```bash
sudo apt update
sudo apt install -y git

Clone repository (HTTPS works without SSH setup):

git clone https://github.com/AxelrodAsaf/utm-dwm-setup.git
cd utm-dwm-setup

Run installer:

chmod +x install.sh
./install.sh

Then start X:

startx
```


---

## Design Goals

- Minimal
- Deterministic
- Snap-free
- Low background services
- No config drift
- Git-tracked environment

---

## Phase Status

Phase 1:
- Minimal base system
- Snap removal
- dwm environment stable

Phase 2:
- Canonical config layer
- Drift-free symlink model
- Notes system integration
- Neovim markdown workflow

Next:
- True pristine upstream build model
- Patch documentation layer
- Performance tuning iteratio
-
