#!/usr/bin/env bash
set -euo pipefail

if [ "$EUID" -ne 0 ]; then
    exec sudo bash "$0" "$@"
fi

pacman -S --needed --noconfirm thermald bolt

systemctl enable --now thermald.service
systemctl enable --now bolt.service
systemctl enable --now ModemManager.service

cat << 'EOF' > /etc/udev/rules.d/99-thinkpad-battery.rules
SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{charge_control_start_threshold}="75", ATTR{charge_control_end_threshold}="80"
EOF

udevadm control --reload
udevadm trigger --subsystem-match=power_supply

if [ -f /sys/class/power_supply/BAT0/charge_control_end_threshold ]; then
    echo 75 > /sys/class/power_supply/BAT0/charge_control_start_threshold 2>/dev/null || true
    echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold 2>/dev/null || true
fi
