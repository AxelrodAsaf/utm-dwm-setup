#!/bin/sh

# Terminal
st &

# Status bar
slstatus &

# Wallpaper
feh --bg-scale ~/src/suckless/st/Seattle.jpg &

# Compositor (transparency)
picom --config ~/.config/picom/picom.conf &

# Browser (FireFox)
firefox &

