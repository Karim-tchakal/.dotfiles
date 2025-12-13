#!/bin/bash

THEME_DIR="$HOME/.dotfiles/hollowtheme/hollowtheme"
LIGHT_DIR="$THEME_DIR/lighttheme"
DARK_DIR="$THEME_DIR/darktheme"
CURRENT=$(readlink -f "$THEME_DIR/current_colors.css")

if [[ "$CURRENT" == "$DARK_DIR/dark.css" ]]; then
    ln -sf "$LIGHT_DIR/light.css" "$THEME_DIR/current_colors.css"
    ln -sf "$LIGHT_DIR/ghostty_light.conf" "$THEME_DIR/ghostty.conf"
    ln -sf "$LIGHT_DIR/vscode_light.json" "$THEME_DIR/vscode.json"
    ln -sf "$LIGHT_DIR/ascii_light.txt" "$HOME/.dotfiles/fastfetch/fastfetch/ascii.txt"
    ln -sf "$LIGHT_DIR/hyprland_light.conf" "$THEME_DIR/hyprland.conf"
    touch "$THEME_DIR/light.mode"
else

    ln -sf "$DARK_DIR/dark.css" "$THEME_DIR/current_colors.css"
    ln -sf "$DARK_DIR/ghostty_dark.conf" "$THEME_DIR/ghostty.conf"
    ln -sf "$DARK_DIR/vscode_dark.json" "$THEME_DIR/vscode.json"
    ln -sf "$DARK_DIR/ascii_dark.txt" "$HOME/.dotfiles/fastfetch/fastfetch/ascii.txt"
    ln -sf "$DARK_DIR/hyprland_dark.conf" "$THEME_DIR/hyprland.conf"
    if [ -f "$THEME_DIR/light.mode" ]; then
        rm "$THEME_DIR/light.mode"
    fi
fi

# Reload Waybar to pick up new colors
# pkill waybar && waybar &
pkill -SIGUSR2 -x ghostty
sed -i '' /home/karim/.dotfiles/waybar/waybar/style.css
theme_name=$(jq -r '.name' ~/.config/omarchy/current/theme/vscode.json)
sed -i -E "s/(\"workbench.colorTheme\"[[:space:]]*:[[:space:]]*\")[^\"]*(\")/\1$theme_name\2/" ~/.config/Code/User/settings.json
omarchy-theme-set-gnome
