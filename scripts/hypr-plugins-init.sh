#!/usr/bin/env bash
# Hyprland Plugin Loader & Dynamic Configuration
# Safe: Gracefully skips if hyprpm or plugins are not yet installed.

if ! command -v hyprpm &>/dev/null; then
    exit 0
fi

# Reload active plugins in non-blocking mode
hyprpm reload -n >/dev/null 2>&1

# Allow plugins a brief moment to initialize before applying keywords
sleep 0.4

# Apply HyprExpo settings if available
hyprctl keyword plugin:hyprexpo:columns 3 2>/dev/null || true
hyprctl keyword plugin:hyprexpo:gap_size 5 2>/dev/null || true
hyprctl keyword plugin:hyprexpo:bg_col "rgb(181825)" 2>/dev/null || true
hyprctl keyword plugin:hyprexpo:workspace_method "center current" 2>/dev/null || true
hyprctl keyword plugin:hyprexpo:enable_gesture false 2>/dev/null || true

# Apply HyprFocus settings if available
hyprctl keyword plugin:hyprfocus:enabled yes 2>/dev/null || true
hyprctl keyword plugin:hyprfocus:keyboard_focus_animation flash 2>/dev/null || true
hyprctl keyword plugin:hyprfocus:mouse_focus_animation flash 2>/dev/null || true
hyprctl keyword plugin:hyprfocus:flash:flash_opacity 0.75 2>/dev/null || true
hyprctl keyword plugin:hyprfocus:flash:in_speed 0.5 2>/dev/null || true
hyprctl keyword plugin:hyprfocus:flash:out_speed 3 2>/dev/null || true
