#!/bin/bash

echo "Exporting manually installed APT software and Flatpak apps"
mkdir -p output
cd output

# --- Export manually installed packages ---
apt-mark showmanual > apt-software.txt

# --- Export Flatpak apps ---
flatpak list --app --columns=application > flatpak-apps.txt

echo "Export complete!"
echo "Manual APT software list saved to: ~/output/apt-software.txt"
echo "Flatpak app list saved to: ~/output/flatpak-apps.txt"
