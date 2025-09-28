#!/bin/bash

echo "Restoring manually installed APT software and Flatpak apps"

# --- Update APT first ---
sudo apt update

# --- Install APT software ---
if [ -f output/apt-software.txt ]; then
    xargs -a output/apt-software.txt sudo apt install -y
else
    echo "apt-software.txt not found!"
fi

# --- Install Flatpak apps ---
if [ -f output/flatpak-apps.txt ]; then
    while read -r app; do
        flatpak install -y "$app"
    done < output/flatpak-apps.txt
else
    echo "flatpak-apps.txt not found!"
fi

echo "Restore complete!"
