#!/usr/bin/env bash
# Smooth Screen Zoom Controller for Hyprland (Native Lua REPL IPC)
# Keybindings: SUPER + = / + (zoom in), SUPER + - (zoom out), SUPER + Backspace / ALT+0 (reset)

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
        hyprctl repl "hl.config({ cursor = { zoom_factor = $new_val } })" >/dev/null 2>&1
        ;;
    out)
        new_val=$(awk -v c="$current" -v s="$STEP" -v min="$MIN_ZOOM" 'BEGIN {
            val = c - s;
            if (val <= min) val = min;
            printf "%.2f", val
        }')
        hyprctl repl "hl.config({ cursor = { zoom_factor = $new_val } })" >/dev/null 2>&1
        ;;
    reset)
        hyprctl repl "hl.config({ cursor = { zoom_factor = 1.0 } })" >/dev/null 2>&1
        ;;
    *)
        echo "Usage: $0 [in|out|reset]"
        exit 1
        ;;
esac
