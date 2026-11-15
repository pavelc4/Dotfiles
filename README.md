# Hyprland & ThinkPad T14 Gen 3 Dotfiles Suite

Comprehensive system documentation, Git branch architecture, complete keybindings reference, and hardware optimization guide tailored for **ThinkPad T14 Gen 3 (Intel Core i5-1250P, 32GB RAM)** on EndeavourOS / Arch Linux.

## 1. Git Branch Architecture

This repository maintains two distinct branches:

### `main` Branch (Upstream Baseline Preset)
* Pristine, untouched baseline preset dotfiles.
* Serves as the clean upstream baseline prior to any device-specific hardware customizations.
* Free from device-bound rules or platform-specific scripts.

### `personal` Branch (Active Custom Branch)
* Tailored specifically for this **ThinkPad T14 Gen 3** laptop.
* Integrates hardware-level optimizations:
  * Intel QuickSync hardware video acceleration hint (`LIBVA_DRIVER_NAME=iHD` in `hypr/env.lua`).
  * Turnkey hardware feature activator script `scripts/setup-thinkpad-features.sh` (`thermald`, `bolt`, `ModemManager`, and 80% battery threshold).
  * 16:9 widescreen, borderless wallpaper picker (`scripts/bgselector.sh` & `rofi/bgselector/style.rasi`).

## 2. Hardware Specification Profile (ThinkPad T14 Gen 3)

| Component | Specifications & Capabilities |
| :--- | :--- |
| **Model** | Lenovo ThinkPad T14 Gen 3 (Type 21AJS45K00) |
| **CPU** | 12th Gen Intel Core i5-1250P (P-Series 28W TDP, 12 Cores / 16 Threads: 4 P-Cores + 8 E-Cores) |
| **RAM** | 32 GB DDR4 (Substantial headroom, initial startup idle consumes only ~1.7 GB) |
| **Display** | 14" WUXGA (1920x1200) with modern 16:10 aspect ratio |
| **GPU** | Intel Iris Xe Graphics (Hardware decoding for H.264, HEVC, VP9, and AV1 up to 8K) |
| **Thunderbolt** | Dual Thunderbolt 4 / USB4 (40 Gbps, supports dual 4K/8K displays, fast docks, and eGPU) |
| **Wireless** | Intel Wi-Fi 6E AX211 (Tri-Band 2.4 GHz, 5 GHz, 6 GHz, 160MHz) + Bluetooth 5.3 |
| **Cellular (WWAN)** | Quectel EM05-G 4G LTE built-in modem with physical Nano-SIM slot |
| **Battery Guard** | Hardware charge threshold (75% start / 80% stop) to maximize battery longevity |

## 3. Complete Keybindings Reference

All keybindings are natively configured in Lua within [hypr/keybinds.lua](file:///home/pavelc4/prjtk/dotfiles/main/hypr/keybinds.lua), ensuring full compatibility with Hyprland 0.57.2+.

### Core Applications & Launchers
| Shortcut | Action | Target / Command |
| :--- | :--- | :--- |
| `SUPER + Return` | Primary Terminal | Ghostty (fallback to Alacritty) |
| `SUPER + ALT + Return` | Secondary Terminal | Alacritty |
| `SUPER + Space` / `SUPER + A` | Application Launcher | Vicinae App Launcher |
| `SUPER + B` | Web Browser | Firefox Dev / Zen / Chrome |
| `SUPER + E` | GUI File Manager | Thunar |
| `SUPER + ALT + E` | Terminal File Manager | Yazi (inside Ghostty/Alacritty) |
| `SUPER + C` | Code Editor | VS Code / VSCodium |
| `SUPER + X` | Terminal Text Editor | Neovim (inside Ghostty/Alacritty) |
| `SUPER + W` | Wallpaper Selector | 16:9 Borderless Carousel Picker |
| `CTRL + SUPER + V` | Audio Mixer | Pavucontrol |
| `CTRL + SHIFT + Escape` | System Task Manager | btop (inside Ghostty/Alacritty) |
| `SUPER + V` | Clipboard History | Vicinae Clipboard Manager |
| `SUPER + ,` / `SUPER + .` | Emoji Selector | Vicinae Emoji Search |
| `SUPER + SHIFT + C` | Screen Color Picker | Hyprpicker (copies HEX code) |

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
| `SUPER + ALT + Space` | Toggle Floating | Switches between tiling and floating mode |
| `SUPER + F` | True Fullscreen | Fullscreen without borders or bars |
| `SUPER + D` | Maximized Window | Maximized window while preserving Waybar |
| `SUPER + P` | Pin Window | Pins floating window across all workspaces |
| `SUPER + Semicolon (;)` | Decrease Split Ratio | Shrinks current window split ratio (-0.1) |
| `SUPER + Apostrophe (')` | Increase Split Ratio | Expands current window split ratio (+0.1) |
| `SUPER + Left Mouse Click` | Drag Window | Drags and moves floating window |
| `SUPER + Right Mouse Click` | Resize Window | Interactively resizes floating window |

### Focus Navigation & Window Movement (Arrows & Vim HJKL)
| Direction | Change Window Focus | Move Window Position |
| :--- | :--- | :--- |
| **Left** | `SUPER + Left` or `SUPER + H` | `SUPER + SHIFT + Left` or `SUPER + SHIFT + H` |
| **Right** | `SUPER + Right` or `SUPER + L` | `SUPER + SHIFT + Right` or `SUPER + SHIFT + L` |
| **Up** | `SUPER + Up` or `SUPER + K` | `SUPER + SHIFT + Up` or `SUPER + SHIFT + K` |
| **Down** | `SUPER + Down` or `SUPER + J` | `SUPER + SHIFT + Down` or `SUPER + SHIFT + J` |

### Workspace Management
| Shortcut | Action |
| :--- | :--- |
| `SUPER + 1..10` | Switch to Workspace 1 through 10 |
| `SUPER + SHIFT + 1..10` | Move focused window to Workspace 1 through 10 |
| `CTRL + SUPER + Left / Right` | Relative workspace navigation (previous / next) |
| `SUPER + Page_Up / Page_Down` | Relative workspace navigation (previous / next) |
| `SUPER + Mouse Scroll Up / Down` | Quick workspace cycling via mouse wheel |

### Session & Power Management
| Shortcut | Action |
| :--- | :--- |
| `SUPER + Escape` | Lock Screen (gtklock / hyprlock) |
| `SUPER + SHIFT + Q` | Lock Screen (Alternative) |
| `SUPER + SHIFT + L` | Suspend System (Sleep mode) |
| `CTRL + ALT + Delete` | Power & Session Menu (Wlogout: Lock, Suspend, Logout, Reboot, Shutdown) |

### Multimedia & ThinkPad Function Keys
| Key / Shortcut | Function |
| :--- | :--- |
| `Fn + F1` / `AudioMute` | Mute / Unmute Speaker Audio |
| `Fn + F2` / `LowerVolume` | Lower Audio Volume (-2%) |
| `Fn + F3` / `RaiseVolume` | Raise Audio Volume (+2%, max 150%) |
| `Fn + F4` / `MicMute` | Mute / Unmute Microphone (Toggles orange hardware LED on F4 key) |
| `Fn + F5` / `BrightnessDown` | Decrease Display Brightness (-5%) |
| `Fn + F6` / `BrightnessUp` | Increase Display Brightness (+5%) |
| `MediaPlay / SUPER + SHIFT + P` | Play / Pause Media |
| `MediaNext / SUPER + SHIFT + N` | Next Track |
| `MediaPrev / SUPER + SHIFT + B` | Previous Track |

## 4. Wallpaper & Dynamic Theming (Matugen Engine)

1. **Wallpaper Selector (`SUPER + W`)**:
   * Displays thumbnails in true widescreen 16:9 (`640x360`), completely uncropped.
   * Borderless card styling (`border: 0px`) with subtle rounded glow highlight on active items.
   * Navigate with Left/Right Arrow keys (`h`/`l`) or mouse clicks.
   * Press `Enter` to apply.
2. **Dynamic Material You Theme Sync**:
   * Invokes [scripts/theme-sync.sh](file:///home/pavelc4/prjtk/dotfiles/main/scripts/theme-sync.sh) powered by **Matugen** (`scheme-tonal-spot`).
   * Instantly synchronizes color palettes across:
     * Dynamic Hyprland window borders ([hypr/colors.lua](file:///home/pavelc4/prjtk/dotfiles/main/hypr/colors.lua))
     * Waybar status bar ([waybar/colors.css](file:///home/pavelc4/prjtk/dotfiles/main/waybar/colors.css))
     * Mako notification daemon ([mako/config](file:///home/pavelc4/prjtk/dotfiles/main/mako/config))
     * Ghostty terminal ([ghostty/themes/matugen](file:///home/pavelc4/prjtk/dotfiles/main/ghostty/themes/matugen))
     * GTK 3 & GTK 4 themes
     * Vicinae launcher & btop monitor

## 5. ThinkPad Hardware Feature Activation

The automated setup script in [scripts/setup-thinkpad-features.sh](file:///home/pavelc4/prjtk/dotfiles/main/scripts/setup-thinkpad-features.sh) enables all specialized hardware capabilities. Execute in your terminal:

```bash
~/prjtk/dotfiles/main/scripts/setup-thinkpad-features.sh
```

Activated features:
1. **`thermald`**: Intel Thermal Framework daemon for the i5-1250P CPU (maintains 28W boost TDP and prevents premature thermal throttling).
2. **`bolt`**: Security daemon for Dual Thunderbolt 4 / USB4 40Gbps ports.
3. **`ModemManager`**: Enables cellular mobile broadband for the Quectel EM05-G 4G LTE modem using a physical SIM card.
4. **80% Battery Charge Threshold**: Deploys an automated udev rule `/etc/udev/rules.d/99-thinkpad-battery.rules` to protect battery chemistry and longevity.
