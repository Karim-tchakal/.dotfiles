#!/bin/bash

THEME_DIR="$HOME/.dotfiles/hollowtheme/hollowtheme"
CURRENT=$(readlink -f "$THEME_DIR/current_colors.css")

if [[ "$CURRENT" == "$THEME_DIR/dark.css" ]]; then
    ln -sf "$THEME_DIR/light.css" "$THEME_DIR/current_colors.css"
    ln -sf "$THEME_DIR/ghostty_light.conf" "$THEME_DIR/ghostty.conf"
else
    ln -sf "$THEME_DIR/dark.css" "$THEME_DIR/current_colors.css"
    ln -sf "$THEME_DIR/ghostty_dark.conf" "$THEME_DIR/ghostty.conf"
fi

# Reload Waybar to pick up new colors
# pkill waybar && waybar &
pkill -SIGUSR2 -x ghostty
sed -i '' /home/karim/.dotfiles/waybar/waybar/style.css

