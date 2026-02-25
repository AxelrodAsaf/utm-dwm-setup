#
#!/bin/sh

# Status bar
slstatus &

# Wallpaper
~/.fehbg &

# Compositor (transparency)
picom --config ~/.config/picom/picom.conf &

# Terminal
st &
