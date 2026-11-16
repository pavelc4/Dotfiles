<p align="center">
  <img src="https://img.shields.io/badge/Hyprland-00A86B?style=for-the-badge&logo=hyprland&logoColor=white" alt="Hyprland">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=archlinux&logoColor=white" alt="Arch Linux">
  <img src="https://img.shields.io/badge/Wayland-00599C?style=for-the-badge&logo=wayland&logoColor=white" alt="Wayland">
  <img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Lua">
  <a href="LICENSE"><img src="https://img.shields.io/badge/GPLv3-white?style=for-the-badge&logo=gnu&logoColor=white&label=License&labelColor=222" alt="License"></a>
</p>

## About Dotfiles
A modern, minimalist, and dynamic Wayland desktop environment built on **Hyprland** using native Lua configuration. Engineered for high performance, smooth workflow, and automated **Material You** color synchronization across the entire desktop suite.

> [!NOTE]
> **Compatibility**: Configured specifically for native Lua Hyprland (0.57.2+). Compatible with Arch Linux, EndeavourOS, CachyOS, and other modern rolling distributions.

## Features
- **Native Lua Architecture**: Master entry point and modular configurations written in pure Lua (`hyprland.lua`), ensuring lightning-fast parsing and future-proof stability.
- **Dynamic Display Auto-Configuration**: Wildcard display rules (`output = ""`) that automatically detect and configure external monitors, projectors, and variable refresh rates without manual editing.
- **Material You Dynamic Theming**: Wallpaper-derived color schemes generated automatically via **Matugen** (`scheme-tonal-spot`), synchronizing colors across borders, Waybar, Mako, Ghostty, GTK 3/4, and Vicinae.
- **Widescreen Wallpaper Selector (`SUPER + W`)**: Clean, borderless 16:9 carousel preview with fluid fade transitions and reliable instant theme switching.
- **Precision Touchpad Gestures (end-4 Style)**: Fluid 1:1 multi-finger gestures using native Lua Hyprland 0.57.2+ API (4-finger workspace swipe, 3-finger window move, 3-finger fullscreen pinch).
- **Official Hyprland Plugins**: Integrated **HyprExpo** (macOS/GNOME style workspace overview grid) and **HyprFocus** (flash pulse focus animations).
- **Dual Terminal Integration**: Ultra-fast **Ghostty** terminal as the primary terminal with **Alacritty** as secondary fallback.
- **Application & Clipboard Hub**: **Vicinae** launcher integration featuring instant search, fuzzy emoji lookup, and preview-enabled clipboard history.

## Core Keybindings

### Applications & Launchers
| Shortcut | Action | Command / Target |
| :--- | :--- | :--- |
| `SUPER + Return` | Primary Terminal | Ghostty (fallback to Alacritty) |
| `SUPER + ALT + Return` | Secondary Terminal | Alacritty |
| `SUPER + Space` / `SUPER + A` | Application Launcher | Vicinae App Launcher |
| `SUPER + Tab` / `SUPER + \`` | Workspace Overview | HyprExpo 3x3 Grid Overview |
| `SUPER + B` | Web Browser | Firefox Developer / Zen / Chrome |
| `SUPER + E` | File Manager GUI | Thunar File Manager |
| `SUPER + ALT + E` | Terminal File Manager | Yazi (inside Ghostty / Alacritty) |
| `SUPER + C` | Code Editor | VS Code / VSCodium |
| `SUPER + X` | Terminal Text Editor | Neovim |
| `SUPER + W` | Wallpaper Selector | 16:9 Borderless Carousel Picker |
| `CTRL + SUPER + V` | Audio Control | Pavucontrol |
| `CTRL + SHIFT + Escape` | Task Manager | btop |
| `SUPER + V` | Clipboard History | Vicinae Clipboard Manager |
| `SUPER + ,` / `SUPER + .` | Emoji Picker | Vicinae Emoji Search |
| `SUPER + SHIFT + C` | Color Picker | Hyprpicker (copies HEX code) |

### Screenshots
| Shortcut | Mode | Output Destination |
| :--- | :--- | :--- |
| `SUPER + S` | Area Selection | Slurp -> Grim -> Direct to Clipboard |
| `SUPER + SHIFT + S` | Current Display | Active monitor capture -> Direct to Clipboard |
| `Print` | Current Display | Active monitor capture -> Direct to Clipboard |

### Window Management & Tiling
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `SUPER + Q` | Close Window | Closes currently focused window |
| `SUPER + SHIFT + ALT + Q` | Force Kill Window | Kills unresponsive windows via hyprctl |
| `SUPER + ALT + Space` | Toggle Floating | Switches window between tiling and floating mode |
| `SUPER + F` | True Fullscreen | Fullscreen without borders or bars |
| `SUPER + D` | Maximized Window | Maximized window preserving Waybar |
| `SUPER + P` | Pin Window | Pins floating window across all workspaces |
| `SUPER + Semicolon (;)` | Decrease Split Ratio | Shrinks current window split ratio (-0.1) |
| `SUPER + Apostrophe (')` | Increase Split Ratio | Expands current window split ratio (+0.1) |
| `SUPER + Left Mouse Click` | Drag Window | Drags and moves floating window |
| `SUPER + Right Mouse Click` | Resize Window | Interactively resizes floating window |

### Focus Navigation & Window Movement
| Direction | Change Window Focus | Move Window Position |
| :--- | :--- | :--- |
| **Left** | `SUPER + Left` or `SUPER + H` | `SUPER + SHIFT + Left` or `SUPER + SHIFT + H` |
| **Right** | `SUPER + Right` or `SUPER + L` | `SUPER + SHIFT + Right` or `SUPER + SHIFT + L` |
| **Up** | `SUPER + Up` or `SUPER + K` | `SUPER + SHIFT + Up` or `SUPER + SHIFT + K` |
| **Down** | `SUPER + Down` or `SUPER + J` | `SUPER + SHIFT + Down` or `SUPER + SHIFT + J` |
| **Move Across Monitors** | `SUPER + [ / ]` (Focus Monitor) | `SUPER + SHIFT + [ / ]` or `SUPER + ALT + Left / Right` |

### Independent Monitor Workspaces (Isolated per Display)
Workspaces are strictly isolated per monitor: Laptop (`eDP-1`) owns workspaces `1..10`, and External displays (`HDMI-A-1`) own their own independent `1..10` (mapped to `11..20`).
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `SUPER + 1..10` | Switch Workspace | Switches to workspace 1..10 on the currently active monitor |
| `SUPER + SHIFT + 1..10` | Move Window to Workspace | Moves active window to workspace 1..10 on active monitor |
| `SUPER + ALT + 1..10` | Move Window & Follow | Moves active window and follows focus on active monitor |
| `CTRL + SUPER + Left / Right` | Relative Navigation | Cycles relative workspace on current active monitor (`r-1` / `r+1`) |
| `SUPER + Page_Up / Page_Down` | Relative Navigation | Cycles relative workspace on current active monitor (`r-1` / `r+1`) |
| `SUPER + Mouse Scroll Up / Down` | Quick Wheel Cycling | Relative workspace cycling via mouse wheel |

### Screen Magnification / Zoom
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `SUPER + =` / `SUPER + +` | Zoom In | Smoothly magnifies display around cursor (+0.25x step) |
| `SUPER + -` | Zoom Out | Decreases magnification (-0.25x step down to 1.0x) |
| `SUPER + Backspace` / `SUPER + ALT + 0` | Reset Zoom | Instantly resets zoom level to 1.0x |

### Session & Media Controls
| Shortcut | Action |
| :--- | :--- |
| `SUPER + Escape` / `SUPER + SHIFT + Q` | Lock Screen (gtklock / hyprlock) |
| `SUPER + SHIFT + L` | Suspend System (Sleep mode) |
| `CTRL + ALT + Delete` | Power & Session Menu (Wlogout) |
| `Fn + F1` / `AudioMute` | Mute / Unmute Speaker Audio |
| `Fn + F2` / `LowerVolume` | Lower Audio Volume (-2%) |
| `Fn + F3` / `RaiseVolume` | Raise Audio Volume (+2%, max 150%) |
| `Fn + F4` / `MicMute` | Mute / Unmute Microphone |
| `Fn + F5` / `BrightnessDown` | Decrease Display Brightness (-5%) |
| `Fn + F6` / `BrightnessUp` | Increase Display Brightness (+5%) |
| `MediaPlay / SUPER + SHIFT + P` | Play / Pause Media |
| `MediaNext / SUPER + SHIFT + N` | Next Track |
| `MediaPrev / SUPER + SHIFT + B` | Previous Track |

### Touchpad Gestures (end-4 Style)
| Gesture | Action | Description |
| :--- | :--- | :--- |
| **4-Finger Horizontal Swipe** | Workspace Switch | Fluid 1:1 sliding transition across workspaces |
| **4-Finger Swipe Up / Down** | Overview Toggle | Toggles HyprExpo workspace overview grid |
| **3-Finger Swipe** | Move Active Window | Interactively drags and rearranges active window |
| **3-Finger Pinch** | Fullscreen Toggle | Pinches to enter or exit true fullscreen |

## Plugins & Extensions
Hyprland official plugins enhance desktop usability with hardware-accelerated animations:
- **HyprExpo**: Exposé-style multi-workspace overview grid (`SUPER + Tab` or 4-finger swipe up).
- **HyprFocus**: Responsive flash focus animation when switching between active windows.

To install and compile the plugins automatically:
```bash
./scripts/setup-hyprland-plugins.sh
```

## Theming Engine
1. **Wallpaper Carousel (`SUPER + W`)**:
   * Previews landscape wallpapers in native 16:9 (`640x360`) without cropping.
   * Borderless styling with active rounded highlight.
2. **Matugen Synchronizer**:
   * Analyzes dominant tones from wallpaper to generate Material You tonal spot palettes.
   * Hot-reloads Waybar, Mako, Ghostty, GTK, Vicinae, and btop in milliseconds.

## Installation
Clone the repository and run the setup installer:
```bash
git clone https://github.com/pavelc4/Dotfiles.git ~/prjtk/dotfiles/main
cd ~/prjtk/dotfiles/main
./install.sh
```

## Support
If you find these dotfiles useful, consider starring the repository on GitHub.

## License
Open-sourced software licensed under the [GNU General Public License v3.0](LICENSE).
