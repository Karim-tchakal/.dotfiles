#!/bin/bash

file1="$HOME/.dotfiles/waybar/waybar/config.jsonc"
file2="$HOME/.dotfiles/waybar/waybar/ACTIVATE_LINUX.jsonc"
tmp="$(mktemp)"

mv "$file1" "$tmp"
mv "$file2" "$file1"
mv "$tmp" "$file2"

pkill waybar && waybar &