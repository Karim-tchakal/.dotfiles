#!/bin/bash

CURRENT_FILE=$(readlink -f ~/.dotfiles/hollowtheme/hollowtheme/current_colors.css)

if [[ "$CURRENT_FILE" == *"dark.css" ]]; then
    echo ""
else
    echo ""
fi
sed -i '' /home/karim/.dotfiles/waybar/waybar/style.css