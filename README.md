# Backup-my-Ubuntu

A simple tool to **export and restore manually installed APT packages and Flatpak apps** on Ubuntu (or Debian-based systems). This helps you migrate your custom software setup to a new system without reinstalling default system packages.

## Features

- Export manually installed APT packages (excluding system/default packages and drivers/firmware)
- Export installed Flatpak apps
- Restore all exported software on a fresh system

## Requirements

- Ubuntu or Debian-based system
- `bash`
- `apt` and `flatpak` installed
- Internet connection for restoring packages

## Usage

### 1. Export your current software

```bash
git clone <your-repo-url>
cd Backup-my-Ubuntu
bash export.sh

