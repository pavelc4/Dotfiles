#!/bin/bash

set -uo pipefail

sleep 0.8 # let awww set the wallpaper

# Source common utilities if available
if [[ -f "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh" ]]; then
  source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"
else
  # Fallback logging functions if common.sh is not available
  log_info() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;34m[$timestamp] INFO: $*\\033[0m" >&2
  }

  log_error() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;31m[$timestamp] ERROR: $*\\033[0m" >&2
  }

  log_success() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;32m[$timestamp] SUCCESS: $*\\033[0m" >&2
  }

  log_warn() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;33m[$timestamp] WARN: $*\\033[0m" >&2
  }

  log_debug() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;36m[$timestamp] DEBUG: $*\\033[0m" >&2
  }

  die() {
    log_error "$*"
    exit 1
  }

  validate_dependencies() {
    local -ra required_deps=("$@")
    local missing_deps=()

    for dep in "${required_deps[@]}"; do
      command -v "$dep" > /dev/null 2>&1 || missing_deps+=("$dep")
    done

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
      die "Missing required dependencies: ${missing_deps[*]}"
    fi
  }
fi

# --- Configuration ---
readonly SCRIPT_NAME="${0##*/}"
readonly WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
readonly DEFAULT_GTK_THEME="Colloid-Dark"
readonly DEFAULT_ICON_THEME="Colloid-Dark"
readonly THEME_STATE_FILE="$HOME/.cache/theme-sync-state"

# Get theme based on directory and variation
map_to_gtk_theme() {
  local theme_name="$1"
  local variation="$2"

  case "${theme_name}" in
    "catppuccin")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Catppuccin"
      else
        echo "Colloid-Dark-Catppuccin"
      fi
      ;;
    "dracula")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Dracula"
      else
        echo "Colloid-Dark-Dracula"
      fi
      ;;
    "everforest")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Everforest"
      else
        echo "Colloid-Dark-Everforest"
      fi
      ;;
    "gruvbox")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Gruvbox"
      else
        echo "Colloid-Dark-Gruvbox"
      fi
      ;;
    "material")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Grey-Dark"
      fi
      ;;
    "nord")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Nord"
      else
        echo "Colloid-Dark-Nord"
      fi
      ;;
    "solarized")
      if [[ "$variation" == "light" ]]; then
        echo "Osaka-Light-Solarized"
      else
        echo "Osaka-Dark-Solarized"
      fi
      ;;
    "rose-pine")
      if [[ "$variation" == "light" ]]; then
        echo "Rosepine-Light"
      else
        echo "Rosepine-Dark"
      fi
      ;;
    "tokyo-night")
      if [[ "$variation" == "light" ]]; then
        echo "Tokyonight-Light"
      else
        echo "Tokyonight-Dark"
      fi
      ;;
    *)
      log_warn "Unknown theme: $theme_name, using default theme"
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Dark"
      fi
      ;;
  esac
}

map_to_icon_theme() {
  local theme_name="$1"
  local variation="$2"

  case "${theme_name}" in
    "catppuccin")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Catppuccin-Light"
      else
        echo "Colloid-Catppuccin-Dark"
      fi
      ;;
    "dracula")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Dracula-Light"
      else
        echo "Colloid-Dracula-Dark"
      fi
      ;;
    "everforest")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Everforest-Light"
      else
        echo "Colloid-Everforest-Dark"
      fi
      ;;
    "gruvbox")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Gruvbox-Light"
      else
        echo "Colloid-Gruvbox-Dark"
      fi
      ;;
    "material")
      # Base colloid-dark for material as requested
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Dark"
      fi
      ;;
    "nord")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Nord-Light"
      else
        echo "Colloid-Nord-Dark"
      fi
      ;;
    "solarized")
      # everforest for osaka (solarized) as requested
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Everforest-Light"
      else
        echo "Colloid-Everforest-Dark"
      fi
      ;;
    "rose-pine" | "tokyo-night")
      # catppuccin for rose-pine and tokyo-night as requested
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Catppuccin-Light"
      else
        echo "Colloid-Catppuccin-Dark"
      fi
      ;;
    *)
      log_warn "Unknown theme: $theme_name, using default icon theme"
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Dark"
      fi
      ;;
  esac
}

map_to_wallust_theme() {
  local theme_name="$1"
  local variation="$2"

  case "${theme_name}" in
    "catppuccin")
      if [[ "$variation" == "light" ]]; then
        echo "Catppuccin-Latte"
      else
        echo "Catppuccin-Mocha"
      fi
      ;;
    "dracula")
      if [[ "$variation" == "light" ]]; then
        echo "base16-default-light"
      else
        echo "base16-dracula"
      fi
      ;;
    "everforest")
      if [[ "$variation" == "light" ]]; then
        echo "Everforest-Light-Medium"
      else
        echo "Everforest-Dark-Medium"
      fi
      ;;
    "gruvbox")
      if [[ "$variation" == "light" ]]; then
        echo "Gruvbox"
      else
        echo "Gruvbox-Dark"
      fi
      ;;
    "material")
      if [[ "$variation" == "light" ]]; then
        echo "base16-default-light"
      else
        echo "base16-black-metal-funeral"
      fi
      ;;
    "nord")
      if [[ "$variation" == "light" ]]; then
        echo "Nord-Light"
      else
        echo "Nord"
      fi
      ;;
    "solarized")
      if [[ "$variation" == "light" ]]; then
        echo "Solarized-Light"
      else
        echo "Solarized-Dark"
      fi
      ;;
    "rose-pine")
      if [[ "$variation" == "light" ]]; then
        echo "Rosé-Pine-Dawn"
      else
        echo "Rosé-Pine"
      fi
      ;;
    "tokyo-night")
      if [[ "$variation" == "light" ]]; then
        echo "Tokyo-Night-Light"
      else
        echo "Tokyo-Night"
      fi
      ;;
    *)
      log_warn "Unknown theme: $theme_name, using random theme"
      echo "random"
      ;;
  esac
}

# --- Functions ---

detect_theme_from_wallpaper() {
  local target_path="${1:-}"

  if [[ -n "$target_path" && -f "$target_path" ]]; then
    WALLPAPER_PATH="$target_path"
  else
    local wallpaper_query
    wallpaper_query=$(awww query 2> /dev/null | grep -oP '(?<=image: ).*' | head -n1 | tr -d '\n\r')

    if [[ -n "$wallpaper_query" && -f "$wallpaper_query" ]]; then
      WALLPAPER_PATH="$wallpaper_query"
    else
      local fallback_wall
      fallback_wall=$(find "$WALLPAPERS_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | head -n1 || true)
      if [[ -n "$fallback_wall" && -f "$fallback_wall" ]]; then
        WALLPAPER_PATH="$fallback_wall"
        if command -v awww >/dev/null 2>&1 && pidof awww-daemon >/dev/null 2>&1; then
          awww img "$fallback_wall" >/dev/null 2>&1 &
        fi
      else
        die "No wallpaper found via awww query or in $WALLPAPERS_DIR"
      fi
    fi
  fi

  log_debug "Found wallpaper: $WALLPAPER_PATH"

  local lower_path
  lower_path=$(echo "$WALLPAPER_PATH" | tr '[:upper:]' '[:lower:]')
  if [[ "$lower_path" =~ light ]]; then
    WALLPAPER_VARIATION="light"
  else
    WALLPAPER_VARIATION="dark"
  fi

  local theme_dir
  theme_dir=$(dirname "$WALLPAPER_PATH")
  local parent_dir
  parent_dir=$(dirname "$theme_dir")
  local candidate_theme
  candidate_theme=$(basename "$parent_dir" | tr '[:upper:]' '[:lower:]')

  case "$candidate_theme" in
    catppuccin|dracula|everforest|gruvbox|material|nord|solarized|rose-pine|tokyo-night)
      DETECTED_THEME="$candidate_theme"
      ;;
    osaka)
      DETECTED_THEME="solarized"
      ;;
    *)
      DETECTED_THEME="material"
      ;;
  esac

  log_debug "Detected theme: $DETECTED_THEME, variation: $WALLPAPER_VARIATION"

  export WALLPAPER_PATH WALLPAPER_VARIATION DETECTED_THEME
}

check_theme_changed() {
  local -r path="$1"
  local -r force_flag="${2:-0}"

  if [[ "$force_flag" -eq 1 ]]; then
    log_info "Forced theme update requested"
    return 0
  fi

  mkdir -p "$(dirname "$THEME_STATE_FILE")"

  if [[ ! -f "$THEME_STATE_FILE" ]]; then
    log_info "No previous theme state found, running first initialization"
    return 0
  fi

  local current_state
  current_state="${path}:$(stat -c %Y "$path" 2>/dev/null || echo 0)"

  local previous_state
  read -r previous_state < "$THEME_STATE_FILE"

  if [[ "$current_state" == "$previous_state" ]]; then
    log_info "Wallpaper unchanged: $path"
    return 1
  else
    log_info "Wallpaper changed from $previous_state to $current_state"
    return 0
  fi
}

save_theme_state() {
  local -r path="$1"

  mkdir -p "$(dirname "$THEME_STATE_FILE")"
  local current_state="${path}:$(stat -c %Y "$path" 2>/dev/null || echo 0)"
  echo "$current_state" > "$THEME_STATE_FILE"
  log_info "Saved wallpaper theme state: $current_state"
}

# Function to set values in INI files
set_ini_value() {
  local -r file="$1"
  local -r section="$2"
  local -r key="$3"
  local -r value="$4"

  [[ -f "$file" ]] || touch "$file"

  if grep -q "^\\[$section\\]" "$file"; then
    if grep -q "^$key=" "$file"; then
      sed -i "/^\\[$section\\]/,/^\\[/ s/^$key=.*/$key=$value/" "$file"
    else
      sed -i "/^\\[$section\\]/a $key=$value" "$file"
    fi
  else
    printf '\\n[%s]\\n%s=%s\\n' "$section" "$key" "$value" >> "$file"
  fi
}

manage_gtk_config() {
  local -r version="$1"
  local -r theme="$2"
  local -r variation="${3:-dark}"
  local -r config_file="$HOME/.config/gtk-$version/settings.ini"

  # Create directory if it doesn't exist
  mkdir -p "$(dirname "$config_file")"

  set_ini_value "$config_file" "Settings" "gtk-theme-name" "$theme"

  # Set prefer-dark-theme based on variation
  if [[ "$variation" == "light" ]]; then
    set_ini_value "$config_file" "Settings" "gtk-application-prefer-dark-theme" "0"
  else
    set_ini_value "$config_file" "Settings" "gtk-application-prefer-dark-theme" "1"
  fi
}

update_xsettingsd() {
  local -r theme="$1"
  local -r icon_theme="$2"
  local -r config_file="$HOME/.config/xsettingsd/xsettingsd.conf"

  # Create directory if it doesn't exist
  mkdir -p "$(dirname "$config_file")"

  # Check if file exists, create it with proper format if it doesn't
  if [[ ! -f "$config_file" ]]; then
    printf 'Net/ThemeName "%s"
Net/IconThemeName "%s"
' "$theme" "$icon_theme" > "$config_file"
  else
    sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"$theme\"/; s/Net\/IconThemeName \".*\"/Net\/IconThemeName \"$icon_theme\"/" "$config_file" 2> /dev/null ||
      log_warn "Failed to update xsettingsd config for theme name"
  fi
}

update_gtk_settings() {
  local -r gtk_theme="$1"
  local -r variation="$2"

  # Set the GTK theme using gsettings
  gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme" 2> /dev/null || {
    log_warn "Failed to set GTK theme via gsettings, may not be available"
  }

  # Set color scheme based on variation
  if [[ "$variation" == "light" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light" 2> /dev/null || {
      log_warn "Failed to set light color scheme via gsettings"
    }
  else
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" 2> /dev/null || {
      log_warn "Failed to set dark color scheme via gsettings"
    }
  fi

  # Force reload of GTK settings for running applications
  if command -v dbus-send > /dev/null 2>&1; then
    dbus-send --session --dest=org.gtk.Settings --type=method_call \
      /org/gtk/Settings org.gtk.Settings.NotifyThemeChange 2> /dev/null || true
  fi

  # Reload xsettingsd if running
  if command -v pgrep > /dev/null 2>&1 && command -v pkill > /dev/null 2>&1; then
    if pgrep -x xsettingsd > /dev/null; then
      pkill -HUP xsettingsd
    fi
  else
    log_warn "pgrep/pkill not available, skipping xsettingsd reload"
  fi
}

manage_symlinks() {
  local -r theme="$1"
  local target_dir=""

  # Find theme directory
  local -ra theme_paths=(
    "$HOME/.themes/$theme"
    "$HOME/.local/share/themes/$theme"
    "/usr/share/themes/$theme"
  )

  for path in "${theme_paths[@]}"; do
    if [[ -d "$path" ]]; then
      target_dir="$path"
      break
    fi
  done

  [[ -n "$target_dir" ]] || {
    log_warn "Theme assets not found: $theme, skipping symlinks"
    return 1
  }

  # Create symlinks for GTK 4.0
  local -r gtk4_dir="$HOME/.config/gtk-4.0"
  mkdir -p "$gtk4_dir"

  declare -A links=(
    ["$gtk4_dir/gtk.css"]="gtk-4.0/gtk.css"
    ["$gtk4_dir/gtk-dark.css"]="gtk-4.0/gtk-dark.css"
    ["$gtk4_dir/assets"]="gtk-4.0/assets"
  )

  # Create symlinks
  for link in "${!links[@]}"; do
    local target="$target_dir/${links[$link]}"
    [[ -e "$target" ]] || continue

    mkdir -p "$(dirname "$link")"
    ln -sf "$target" "$link" && log_info "Created symlink: ${link##*/}"
  done
}

set_gtk_theme() {
  local -r gtk_theme="$1"
  local -r variation="${2:-dark}"
  local -r icon_theme="${3:-$DEFAULT_ICON_THEME}"

  log_info "Setting GTK theme to: $gtk_theme"

  # Check if theme directory exists
  local theme_found=0
  local -ra theme_paths=(
    "$HOME/.themes/$gtk_theme"
    "$HOME/.local/share/themes/$gtk_theme"
    "/usr/share/themes/$gtk_theme"
  )

  for path in "${theme_paths[@]}"; do
    if [[ -d "$path" ]]; then
      theme_found=1
      break
    fi
  done

  if [[ $theme_found -eq 0 ]]; then
    log_warn "GTK theme not found: $gtk_theme, skipping theme change"
    return
  fi

  # Apply theme through multiple methods to ensure coverage
  update_gtk_settings "$gtk_theme" "$variation"
  manage_gtk_config "3.0" "$gtk_theme" "$variation"
  manage_gtk_config "4.0" "$gtk_theme" "$variation"
  manage_symlinks "$gtk_theme"
  update_xsettingsd "$gtk_theme" "$icon_theme"

  log_success "GTK theme set to: $gtk_theme with comprehensive configuration"
}

set_icon_theme() {
  local -r icon_theme="$1"

  log_info "Setting icon theme to: $icon_theme"

  # Check if icon theme directory exists
  local theme_found=0
  local -ra icon_theme_paths=(
    "$HOME/.icons/$icon_theme"
    "$HOME/.local/share/icons/$icon_theme"
    "/usr/share/icons/$icon_theme"
  )

  for path in "${icon_theme_paths[@]}"; do
    if [[ -d "$path" ]]; then
      theme_found=1
      break
    fi
  done

  if [[ $theme_found -eq 0 ]]; then
    log_warn "Icon theme not found: $icon_theme, skipping icon theme change"
    return
  fi

  # Set the icon theme
  gsettings set org.gnome.desktop.interface icon-theme "$icon_theme" || {
    log_warn "Failed to set icon theme, gsettings may not be available"
  }

  log_success "Icon theme set to: $icon_theme"
}

run_matugen_theme() {
  local -r wallpaper_path="$1"
  local -r variation="$2"

  log_info "Running matugen for wallpaper: $wallpaper_path (mode: $variation, scheme: tonal-spot)"

  local mode_arg="dark"
  if [[ "$variation" == "light" ]]; then
    mode_arg="light"
  fi

  if command -v matugen > /dev/null 2>&1; then
    # Try scheme-tonal-spot, then fallback to tonal-spot, then default (always non-interactive with --source-color-index 0)
    if ! matugen image "$wallpaper_path" --mode "$mode_arg" --type scheme-tonal-spot --source-color-index 0 2> /dev/null; then
      if ! matugen image "$wallpaper_path" --mode "$mode_arg" --type tonal-spot --source-color-index 0 2> /dev/null; then
        log_warn "Matugen tonal-spot generation failed, retrying standard mode..."
        matugen image "$wallpaper_path" --mode "$mode_arg" --source-color-index 0 2> /dev/null || log_warn "Matugen generation failed completely"
      else
        log_success "Matugen theme generation completed ($mode_arg mode, tonal-spot)"
      fi
    else
      log_success "Matugen theme generation completed ($mode_arg mode, scheme-tonal-spot)"
    fi
  else
    log_warn "matugen not found in PATH"
  fi
}

reload_desktop_components() {
  if command -v hyprctl > /dev/null 2>&1 && pidof Hyprland > /dev/null 2>&1; then
    hyprctl reload 2> /dev/null || log_warn "Failed to reload Hyprland"
  fi

  if pidof waybar > /dev/null 2>&1; then
    killall -SIGUSR2 waybar 2> /dev/null || log_warn "Failed to reload Waybar"
  fi
}

update_niri_config() {
  local -r niri_config_file="$HOME/.config/niri/config.kdl"
  local -r matugen_colors_file="$HOME/.cache/matugen/colors.json"

  if [[ ! -f "$matugen_colors_file" ]]; then
    log_warn "Matugen color cache not found, skipping niri config update"
    return
  fi

  local background_color
  background_color=$(jq -r '.background' "$matugen_colors_file")

  if [[ -z "$background_color" || "$background_color" == "null" ]]; then
    log_warn "Could not extract background color from matugen cache"
    return
  fi

  log_info "Updating niri config with background color: $background_color"

  # Only change active-color within the focus-ring block
  sed -i "/focus-ring {/,/}/ s/active-color \".*\"/active-color \"$background_color\"/" "$niri_config_file"
  # Only change color within the insert-hint block
  sed -i "/insert-hint {/,/}/ s/color \".*\"/color \"$background_color\"/" "$niri_config_file"

  log_success "Niri config updated successfully"
}

update_vscode_theme() {
  local -r vscode_settings_file="$HOME/.config/Code/User/settings.json"
  local theme

  if [[ ! -f "$vscode_settings_file" ]]; then
    log_warn "VSCode settings file not found, skipping theme update"
    return
  fi

  if [[ "$WALLPAPER_VARIATION" == "light" ]]; then
    theme="Wallust-Bordered-Light"
  else
    theme="Wallust-Bordered-Dark"
  fi

  log_info "Updating VSCode theme to: $theme"

  if ! sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$theme\"/" "$vscode_settings_file"; then
    log_error "Failed to update VSCode theme with sed"
    return 1
  fi

  log_success "VSCode theme updated successfully"
}

main() {
  log_info "Starting dynamic theme synchronization"

  local force=0
  local custom_path=""

  for arg in "$@"; do
    case "$arg" in
      --init)
        if command -v awww >/dev/null 2>&1; then
          # Ensure awww-daemon is up
          if ! pidof awww-daemon >/dev/null 2>&1; then
            awww-daemon &
            sleep 0.5
          fi
          awww restore >/dev/null 2>&1 || true
          sleep 0.5
        fi
        force=1
        ;;
      --force|-f)
        force=1
        ;;
      *)
        if [[ -f "$arg" ]]; then
          custom_path="$arg"
        fi
        ;;
    esac
  done

  # Validate dependencies
  validate_dependencies "jq" "sed" "grep" "head" "tr"

  # Detect theme from current wallpaper
  detect_theme_from_wallpaper "$custom_path"

  local detected_theme="${DETECTED_THEME:-material}"
  local wallpaper_path="${WALLPAPER_PATH:-}"
  local wallpaper_variation="${WALLPAPER_VARIATION:-dark}"

  if [[ -z "$wallpaper_path" || ! -f "$wallpaper_path" ]]; then
    die "Wallpaper file does not exist: ${wallpaper_path:-unknown}"
  fi

  log_info "Detected theme: $detected_theme, variation: $wallpaper_variation, wallpaper: $wallpaper_path"

  # Check if wallpaper/theme changed or force requested
  local theme_changed=0
  if check_theme_changed "$wallpaper_path" "$force"; then
    theme_changed=1
  fi

  # Map to appropriate themes
  local gtk_theme
  gtk_theme=$(map_to_gtk_theme "$detected_theme" "$wallpaper_variation")

  local icon_theme
  icon_theme=$(map_to_icon_theme "$detected_theme" "$wallpaper_variation")

  # Apply themes
  if [[ $theme_changed -eq 1 ]]; then
    set_gtk_theme "$gtk_theme" "$wallpaper_variation" "$icon_theme"
    set_icon_theme "$icon_theme"
    run_matugen_theme "$wallpaper_path" "$wallpaper_variation"
    update_niri_config
    update_vscode_theme
    reload_desktop_components

    if command -v vicinae > /dev/null 2>&1; then
      vicinae theme set matugen 2>/dev/null || vicinae deeplink 'vicinae://theme/set/matugen' 2>/dev/null || log_warn "Failed to set vicinae theme"
    fi

    if command -v makoctl > /dev/null 2>&1; then
      makoctl reload 2> /dev/null || true
    fi

    save_theme_state "$wallpaper_path"

    log_success "Dynamic theme synchronization completed successfully"
    send_notification "Theme Manager" "Theme Synchronization Complete" "" "normal" "preferences-desktop-theme" 4000
  else
    log_info "Theme unchanged, skipping all theming operations"
    log_success "Wallpaper applied, no theme changes needed"
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi

