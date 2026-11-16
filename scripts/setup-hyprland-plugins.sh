#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo " Hyprland Plugin Installer (HyprExpo + HyprFocus)"
echo "========================================="

# 1. Ensure hyprpm and compilation dependencies are installed
if ! command -v hyprpm &>/dev/null; then
    echo "[*] hyprpm not found. Installing via pacman..."
    sudo pacman -S --needed --noconfirm hyprpm glaze cmake meson
fi

echo "[*] Updating hyprpm repository index..."
hyprpm update || true

echo "[*] Adding hyprland-plugins repository..."
hyprpm add https://github.com/hyprwm/hyprland-plugins || true

echo "[*] Enabling HyprExpo (macOS/GNOME style workspace overview)..."
hyprpm enable hyprexpo

echo "[*] Enabling HyprFocus (flash focus animation)..."
hyprpm enable hyprfocus

echo "[*] Compiling and loading plugins..."
hyprpm reload

# 2. Run plugin configuration script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -x "${SCRIPT_DIR}/hypr-plugins-init.sh" ]; then
    echo "[*] Applying plugin configuration..."
    "${SCRIPT_DIR}/hypr-plugins-init.sh"
fi

echo ""
echo "[✓] Hyprland plugins setup complete!"
echo "    - 4-Finger Swipe Up/Down: HyprExpo Overview"
echo "    - 4-Finger Swipe Left/Right: Workspace switch (1:1)"
echo "    - 3-Finger Swipe: Move active window"
echo "    - 3-Finger Pinch: Toggle fullscreen"
echo "    - SUPER + Tab / SUPER + \`: HyprExpo Overview"
