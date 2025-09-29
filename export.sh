#!/bin/bash
# --- Export Flatpak apps ---
flatpak list --app --columns=application > flatpak-apps.txt
echo "Export complete!"
