#!/bin/bash
# ==============================================================================
# Screenshot Script for Hyprland
# - Copies directly to clipboard (does NOT save to disk)
# - Supports Region selection and Active Monitor selection (based on cursor)
# - Integrates with Vicinae for clipboard & screenshot history management
# ==============================================================================

set -euo pipefail

# Find which monitor the cursor is currently on
get_cursor_monitor() {
  local cpos
  cpos=$(hyprctl cursorpos 2>/dev/null || true)
  if [[ -n "$cpos" ]]; then
    local cx cy
    cx=$(echo "$cpos" | cut -d',' -f1 | tr -d ' ')
    cy=$(echo "$cpos" | cut -d',' -f2 | tr -d ' ')
    local mon
    mon=$(hyprctl monitors -j 2>/dev/null | jq -r --argjson cx "$cx" --argjson cy "$cy" \
      '.[] | select($cx >= .x and $cx < (.x + (.width / .scale)) and $cy >= .y and $cy < (.y + (.height / .scale))) | .name' 2>/dev/null | head -n1 || true)
    if [[ -n "$mon" && "$mon" != "null" ]]; then
      echo "$mon"
      return
    fi
  fi

  # Fallback to focused monitor
  local focused_mon
  focused_mon=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.focused) | .name' 2>/dev/null | head -n1 || true)
  if [[ -n "$focused_mon" && "$focused_mon" != "null" ]]; then
    echo "$focused_mon"
    return
  fi

  # Fallback to active workspace monitor
  hyprctl activeworkspace -j 2>/dev/null | jq -r '.monitor // empty' 2>/dev/null || true
}

# Mode: Area / Region screenshot
capture_area() {
  # Prevent multiple slurp instances
  if pidof slurp >/dev/null 2>&1; then
    exit 0
  fi

  local geom
  geom=$(slurp -b 00000088 -c d0bcff -w 2 2>/dev/null || true)

  # If user pressed Escape / cancelled
  if [[ -z "$geom" ]]; then
    exit 0
  fi

  # Capture region and copy directly to clipboard
  grim -g "$geom" - | wl-copy --type image/png

  notify-send -a "Screenshot" "Area Screenshot Copied" \
    "Screenshot saved to clipboard (managed by Vicinae)" \
    -i camera-photo -t 2500
}

# Mode: Fullscreen based on cursor's monitor
capture_cursor_screen() {
  local target_mon
  target_mon=$(get_cursor_monitor)

  if [[ -n "$target_mon" ]]; then
    grim -o "$target_mon" - | wl-copy --type image/png
    notify-send -a "Screenshot" "Screen Screenshot Copied" \
      "Captured monitor $target_mon to clipboard (managed by Vicinae)" \
      -i camera-photo -t 2500
  else
    grim - | wl-copy --type image/png
    notify-send -a "Screenshot" "Screen Screenshot Copied" \
      "Full screen captured to clipboard (managed by Vicinae)" \
      -i camera-photo -t 2500
  fi
}

# Mode: Vicinae Clipboard & Screenshot Manager with Rich Preview
manage_history() {
  if command -v vicinae >/dev/null 2>&1; then
    vicinae deeplink 'vicinae://launch/clipboard/history?toggle=true' 2>/dev/null || \
      vicinae cmd launch clipboard:history 2>/dev/null || \
      vicinae open -q "clipboard"
  elif command -v cliphist >/dev/null 2>&1; then
    local selected
    selected=$(cliphist list 2>/dev/null | rofi -dmenu -p "Clipboard" 2>/dev/null || true)
    if [[ -n "$selected" ]]; then
      echo "$selected" | cliphist decode | wl-copy
      notify-send -a "Clipboard" "Pasted to Clipboard" \
        "Selected item loaded into clipboard" -i edit-paste -t 2000
    fi
  fi
}

case "${1:-area}" in
  --area|-a|area)
    capture_area
    ;;
  --screen|--output|-s|screen)
    capture_cursor_screen
    ;;
  --manage|-m|manage)
    manage_history
    ;;
  *)
    echo "Usage: $0 [--area | --screen | --manage]"
    exit 1
    ;;
esac
