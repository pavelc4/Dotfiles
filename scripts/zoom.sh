#!/usr/bin/env bash
# Smooth Screen Zoom Controller for Hyprland
# Keybindings: SUPER + = / + (zoom in), SUPER + - (zoom out), SUPER + 0 (reset)

STEP="0.25"
MIN_ZOOM="1.0"
MAX_ZOOM="5.0"

# Fetch current zoom factor from Hyprland
current=$(hyprctl getoption cursor:zoom_factor 2>/dev/null | awk '/^float.*/ {print $2}')
if [ -z "$current" ] || [ "$current" = "0" ]; then
    current="1.0"
fi

action="${1:-in}"

case "$action" in
    in)
        new_val=$(awk -v c="$current" -v s="$STEP" -v m="$MAX_ZOOM" 'BEGIN {
            val = c + s;
            if (val > m) val = m;
            printf "%.2f", val
        }')
        hyprctl keyword cursor:zoom_factor "$new_val"
        ;;
    out)
        new_val=$(awk -v c="$current" -v s="$STEP" -v min="$MIN_ZOOM" 'BEGIN {
            val = c - s;
            if (val <= min) val = min;
            printf "%.2f", val
        }')
        hyprctl keyword cursor:zoom_factor "$new_val"
        ;;
    reset)
        hyprctl keyword cursor:zoom_factor 1.0
        ;;
    *)
        echo "Usage: $0 [in|out|reset]"
        exit 1
        ;;
esac
