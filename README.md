# utm-dwm-setup

Reproducible Ubuntu 24.04 ARM64 `dwm` environment for UTM on Apple Silicon.

## Architecture

- Host: macOS on Apple Silicon (M1)
- Guest: Ubuntu 24.04 ARM64 in UTM
- WM stack: `dwm` + `st` + `slstatus` + `picom`
- Config model: repo-managed configs are installed into `$HOME` (some are symlinked)

## File Structure

```text
utm-dwm-setup/
├── .gitignore
├── README.md
├── install.sh
└── configs/
    ├── autostart.sh
    ├── dmenu-killproc
    ├── dmenu-runapps
    ├── dwm_config.h
    ├── lpassmenu
    ├── notes
    ├── nvim_init.vim
    ├── picom.conf
    ├── qutebrowser/config.py
    ├── qutebrowser/css/dark-all-sites.css
    ├── slstatus_config.h
    ├── st_config.h
    ├── youtube-search-dmenu
    ├── youtube-subs-dmenu
    ├── youtube-subs-scan
    └── youtube-subs.txt
```

## What Each File Does

- `install.sh`: bootstrap script. Updates apt packages, removes Snap/services, installs dependencies, clones suckless repos, applies config files, sets up symlinks, and builds/install `dwm`, `st`, and `slstatus`.
- `configs/dwm_config.h`: `dwm` behavior (MOD key, layouts, tags, rules, keybindings, launcher hooks).
- `configs/st_config.h`: `st` build-time config injected into upstream `st/config.h`.
- `configs/slstatus_config.h`: status bar modules and format (CPU, RAM, and datetime).
- `configs/picom.conf`: compositor config (xrender backend, vsync, terminal transparency rule).
- `configs/autostart.sh`: session startup (`slstatus`, wallpaper via `~/.fehbg`, `picom`, terminal).
- `configs/dmenu-runapps`: app launcher menu used by `MOD + p`.
- `configs/dmenu-killproc`: dmenu process picker/killer helper.
- `configs/notes`: notes utility entrypoint exposed in `~/.local/bin/notes`.
- `configs/nvim_init.vim`: Neovim config symlinked to `~/.config/nvim/init.vim`.
- `configs/lpassmenu`: LastPass CLI dmenu helper.
- `configs/youtube-search-dmenu`: YouTube search flow.
- `configs/youtube-subs-dmenu`: YouTube subscriptions flow.
- `configs/youtube-subs-scan`: discovery/cache refresh script for subscriptions list.
- `configs/youtube-subs.txt`: static seed list for subscriptions.
- `configs/qutebrowser/config.py`: qutebrowser settings.
- `configs/qutebrowser/css/dark-all-sites.css`: qutebrowser stylesheet.
- `.gitignore`: excludes machine-local files and artifacts.
- `README.md`: project documentation.

## Setup Theory (Why It Is Structured This Way)

- Keep upstream suckless repos in `~/src/suckless/*`, and keep custom behavior in this repo.
- Inject headers (`*_config.h`) at build-time so runtime stays deterministic.
- Symlink user-level scripts/configs to repo files to prevent config drift.
- Keep VM lean by removing unused desktop services.

## Useful Keybindings (`configs/dwm_config.h`)

`MOD` is `Super` (`Mod4Mask`).

| Action                              | Keys                                    |
|-------------------------------------|-----------------------------------------|
| Launcher menu (`dmenu-runapps`)     | `Super + p`                             |
| Process killer (`dmenu-killproc`)   | `Super + Shift + p`                     |
| Notes launcher                      | `Super + Shift + n`                     |
| Help command                        | `Super + Shift + ?`                     |
| Toggle bar                          | `Super + b`                             |
| Focus next / previous window        | `Super + j` / `Super + k`               |
| Increase / decrease master clients  | `Super + i` / `Super + d`               |
| Increase / decrease master area     | `Super + l` / `Super + h`               |
| Promote focused window to master    | `Super + Enter`                         |
| Tile / Float / Monocle              | `Super + t` / `Super + f` / `Super + m` |
| Toggle floating                     | `Super + Shift + Space`                 |
| Close focused window                | `Super + Shift + c`                     |
| View tag `1..9`                     | `Super + 1..9`                          |
| Move window to tag `1..9`           | `Super + Shift + 1..9`                  |
| Quit `dwm`                          | `Super + x`                             |

## Install

```bash
sudo apt update
sudo apt install -y git
git clone https://github.com/AxelrodAsaf/utm-dwm-setup.git
cd utm-dwm-setup
chmod +x install.sh
./install.sh
startx
```

## Usage Tips

- Before pushing, use `git status` and ensure only intended files changed.
- Rebuild after header changes:
  - `cd ~/src/suckless/dwm && sudo make clean install`
  - `cd ~/src/suckless/st && sudo make clean install`
  - `cd ~/src/suckless/slstatus && sudo make clean install`
- If launcher behavior changes, verify `~/.local/bin/*` symlinks still point into this repo.
