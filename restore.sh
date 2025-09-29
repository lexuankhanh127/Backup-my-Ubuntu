#!/bin/bash

echo "Synchronize APT and FLATPAK packages across multiple machines."

echo ""
echo "------------APT------------"
# Update APT first
# sudo nano /etc/sysctl.conf
# vm.swappiness=10
# sudo sysctl -p
# cat /proc/sys/vm/swappiness
sudo apt update -y
sudo apt-get upgrade -y
sudo apt autoremove -y
sudo apt install -y psensor
sudo apt install -y git
sudo apt install -y ibus-unikey
ibus restart
sudo apt autoremove -y
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo ""
echo "------------FLATPAK------------"
# Install Flatpak apps
if [ -f flatpak-apps.txt ]; then
    while read -r app; do
        flatpak install -y "$app"
    done < flatpak-apps.txt
else
    echo "flatpak-apps.txt not found!"
    exit 1
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
grep -v '^$' flatpak-apps.txt > "$temp_restore"
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
flatpak update -y
# Checking
echo ""
if cmp -s "$temp_current" "$temp_restore"; then
    echo "✅ Success: Current and restore FLATPAK lists match exactly."
else
    echo "❌ Mismatch: Current and restore lists are different."
    echo "Apps in current but not in restore:"
fi
