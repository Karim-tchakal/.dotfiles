#!/bin/bash

INTERFACE="wlan0"

echo "Waiting for $INTERFACE to appear by restarting iwd..."

while true; do
    # Check if interface exists
    if iwctl device list | grep -q "$INTERFACE"; then
        echo "$INTERFACE is now available!"
        break
    else
        echo "$INTERFACE not found, restarting iwd..."
        sudo systemctl restart iwd
        sleep 2
    fi
done
