#!/usr/bin/env bash

# Detect Linux distribution from /etc/os-release
if [ -f /etc/os-release ]; then
    . /etc/os-release
    distro_id="${ID:-linux}"
    distro_like="${ID_LIKE:-}"
    distro_name="${PRETTY_NAME:-Linux}"
else
    distro_id="linux"
    distro_like=""
    distro_name="Linux"
fi

# Map distribution ID to Nerd Font icon
case "${distro_id,,}" in
    endeavouros)
        icon=""
        ;;
    arch)
        icon="󰣇"
        ;;
    cachyos)
        icon="󰣇"
        ;;
    fedora)
        icon=""
        ;;
    ubuntu)
        icon=""
        ;;
    debian)
        icon=""
        ;;
    nixos)
        icon=""
        ;;
    manjaro)
        icon=""
        ;;
    void)
        icon=""
        ;;
    gentoo)
        icon=""
        ;;
    alpine)
        icon=""
        ;;
    opensuse*|suse)
        icon=""
        ;;
    pop)
        icon=""
        ;;
    kali)
        icon=""
        ;;
    *)
        case "${distro_like,,}" in
            *arch*)
                icon="󰣇"
                ;;
            *debian*|*ubuntu*)
                icon=""
                ;;
            *fedora*|*rhel*)
                icon=""
                ;;
            *)
                icon="󰌽"
                ;;
        esac
        ;;
esac

# Output Waybar JSON format
printf '{"text":"%s","tooltip":"%s\\nLeft-click: Terminal\\nRight-click: Vicinae Launcher"}\n' \
    "$icon" "$distro_name"
