#!/bin/bash

echo "Exporting manually installed APT software and Flatpak apps"
mkdir -p output
cd output

# --- Export manually installed packages ---
apt-mark showmanual > apt-manual.txt

# --- Filter to include only software (exclude drivers/firmware) ---
grep -vE 'linux-|firmware-|xserver-xorg-video-|nvidia-|broadcom-' apt-manual.txt > apt-software.txt
rm apt-manual.txt

# --- Export Flatpak apps ---
flatpak list --app --columns=ref > flatpak-apps.txt

echo "Export complete!"
echo "Manual APT software list saved to: ~/output/apt-software.txt"
echo "Flatpak app list saved to: ~/output/flatpak-apps.txt"

