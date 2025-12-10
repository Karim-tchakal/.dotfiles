#!/usr/bin/env bash
PALETTE_FILE="$HOME/.dotfiles/hollowtheme/hollowtheme/current_colors.css"

get_less_color() {
  grep "@define-color $1" "$PALETTE_FILE" | awk '{print $3}' | tr -d ' \t\n;,' | xargs
}

# colors
VERYWEAK=$(get_less_color "wifi-veryweak")
WEAK=$(get_less_color "wifi-weak")
MEDIUM=$(get_less_color "wifi-medium")
GOOD=$(get_less_color "wifi-good")
FULL=$(get_less_color "full")

# choose icon by signal (example, use nmcli to read signal)
sig=$(nmcli -f IN-USE,SIGNAL dev wifi | awk '/\*/{print $2}')
# fallback if no wifi
if [ -z "$sig" ]; then
  ICON="<span color='$VERYWEAK'>󰤮</span>"
  TOOLTIP="Disconnected"
else
  if [ "$sig" -ge 80 ]; then ICON="<span color='$FULL'>󰤨</span>"; fi
  if [ "$sig" -ge 60 ] && [ "$sig" -lt 80 ]; then ICON="<span color='$GOOD'>󰤥</span>"; fi
  if [ "$sig" -ge 40 ] && [ "$sig" -lt 60 ]; then ICON="<span color='$MEDIUM'>󰤢</span>"; fi
  if [ "$sig" -ge 20 ] && [ "$sig" -lt 40 ]; then ICON="<span color='$WEAK'>󰤟</span>"; fi
  if [ "$sig" -lt 20 ]; then ICON="<span color='$VERYWEAK'>󰤯</span>"; fi

  SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '/\*/{print $2}')
  TOOLTIP="${SSID:-Unknown} (${sig}%)"
fi

# Output single-line JSON for Waybar (no newlines)
printf '%s\n' "{\"text\": \"$ICON\", \"tooltip\": \"$TOOLTIP\"}"
