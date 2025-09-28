#!/bin/bash

echo "Synchronize APT and FLATPAK packages across multiple machines."

echo ""
echo "------------APT------------"
# Update APT first
sudo apt update
# Install APT software
if [ -f output/apt-software.txt ]; then
    xargs -a output/apt-software.txt sudo apt install -y
else
    echo "apt-software.txt not found!"
fi
# Uninstall APT software
echo "------------------"
# Current list APT
temp_current_apt=$(mktemp)
apt-mark showmanual > "$temp_current_apt"
echo "Current manually installed APT packages:"
cat "$temp_current_apt"
echo "------------------"
# Restore list APT
temp_restore_apt=$(mktemp)
grep -v '^$' output/apt-software.txt > "$temp_restore_apt"
echo "Restore manually installed APT packages:"
cat "$temp_restore_apt"
echo "------------------"
# Compare lists APT
while read -r pkg; do
    if ! grep -qxF "$pkg" "$temp_restore_apt"; then
        echo "Removing: $pkg"
        sudo apt remove -y "$pkg"
    fi
done < "$temp_current_apt"
sudo apt autoremove
apt-mark showmanual > "$temp_current_apt"
# Checking
echo ""
if cmp -s "$temp_current_apt" "$temp_restore_apt"; then
    echo "✅ Success: Current and restore APT lists match exactly."
else
    echo "❌ Mismatch: Current and restore lists are different."
    echo "Apps in current but not in restore:"
fi

echo ""
echo "------------FLATPAK------------"
# Install Flatpak apps
if [ -f output/flatpak-apps.txt ]; then
    while read -r app; do
        flatpak install -y "$app"
    done < output/flatpak-apps.txt
else
    echo "flatpak-apps.txt not found!"
fi
# Uninstall Flatpak apps
echo "------------------"
# Current list Flatpak
temp_current=$(mktemp)
flatpak list --app --columns=application > "$temp_current"
echo "Current FLATPAK App IDs:"
cat "$temp_current"
echo "------------------"
# Restore list Flatpak
temp_restore=$(mktemp)
grep -v '^$' output/flatpak-apps.txt > "$temp_restore"
echo "Restore FLATPAK App IDs:"
cat "$temp_restore"
echo "------------------"
# Compare lists Flatpak
while read -r app; do
    if ! grep -qxF "$app" "$temp_restore"; then
        echo "Uninstalling: $app"
        flatpak uninstall -y "$app"
    fi
done < "$temp_current"
flatpak list --app --columns=application > "$temp_current"
# Checking
echo ""
if cmp -s "$temp_current" "$temp_restore"; then
    echo "✅ Success: Current and restore FLATPAK lists match exactly."
else
    echo "❌ Mismatch: Current and restore lists are different."
    echo "Apps in current but not in restore:"
fi
