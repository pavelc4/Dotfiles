#!/usr/bin/env bash
# ThinkPad T14 Gen 3 Hardware Optimization & Feature Unlock Script
# Unlocks: thermald (CPU), bolt (Thunderbolt 4), ModemManager (4G LTE), and 80% Battery Threshold

set -euo pipefail

echo "=========================================================="
echo "  ThinkPad T14 Gen 3 - Hardware Feature Setup & Activation"
echo "=========================================================="

# Check root/sudo
if [ "$EUID" -ne 0 ]; then
    echo ">> Elevating privileges with sudo..."
    exec sudo bash "$0" "$@"
fi

# 1. Install missing hardware daemons
echo "[1/4] Installing thermald (Intel Thermal Daemon) & bolt (Thunderbolt 4)..."
pacman -S --needed --noconfirm thermald bolt

# 2. Enable and start core hardware services
echo "[2/4] Enabling & starting hardware services..."
systemctl enable --now thermald.service
systemctl enable --now bolt.service
systemctl enable --now ModemManager.service

# 3. Configure ThinkPad Battery Health Guard (80% charge threshold)
echo "[3/4] Configuring ThinkPad Battery Health Protection (80% threshold)..."
cat << 'EOF' > /etc/udev/rules.d/99-thinkpad-battery.rules
# ThinkPad T14 Gen 3 Battery Charge Thresholds
# Preserves battery longevity by stopping charge at 80% and starting at 75%
SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{charge_control_start_threshold}="75", ATTR{charge_control_end_threshold}="80"
EOF

# Reload and trigger udev rules
udevadm control --reload
udevadm trigger --subsystem-match=power_supply

# Also apply directly to sysfs if available right now
if [ -f /sys/class/power_supply/BAT0/charge_control_end_threshold ]; then
    echo 75 > /sys/class/power_supply/BAT0/charge_control_start_threshold 2>/dev/null || true
    echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold 2>/dev/null || true
fi

# 4. Status Check
echo "[4/4] Verifying status..."
echo "  - thermald:       $(systemctl is-active thermald.service)"
echo "  - bolt:           $(systemctl is-active bolt.service)"
echo "  - ModemManager:   $(systemctl is-active ModemManager.service)"
if [ -f /sys/class/power_supply/BAT0/charge_control_end_threshold ]; then
    echo "  - Battery Threshold: Start $(cat /sys/class/power_supply/BAT0/charge_control_start_threshold)% / Stop $(cat /sys/class/power_supply/BAT0/charge_control_end_threshold)%"
fi

echo "=========================================================="
echo "  All ThinkPad hardware features successfully enabled!"
echo "=========================================================="
