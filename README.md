# Ubuntu Backup Tool

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
bash export.sh
```

### 2. Restore on a new system

```bash
bash restore.sh

