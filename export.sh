#!/bin/bash

mkdir -p output
cd output
# --- Export Flatpak apps ---
flatpak list --app --columns=application > flatpak-apps.txt
echo "Export complete!"
echo "Flatpak app list saved to: ~/output/flatpak-apps.txt"
