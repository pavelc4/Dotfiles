local HOME = os.getenv("HOME") or ""
local scriptsDir = HOME .. "/.config/scripts"

-- Terminal & Core Applications
hl.bind("SUPER + Return", hl.dsp.exec_cmd("ghostty || alacritty"))
hl.bind("SUPER + ALT + Return", hl.dsp.exec_cmd("alacritty"))

-- Launcher (Vicinae) & Overview (HyprExpo)
hl.bind("SUPER + Space", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + Tab", hl.dsp.exec_cmd("hyprctl dispatch hyprexpo:expo toggle"))
hl.bind("SUPER + grave", hl.dsp.exec_cmd("hyprctl dispatch hyprexpo:expo toggle"))

-- Browser, File Manager, Editors
hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox-developer-edition || firefox || google-chrome-stable"))
hl.bind("SUPER + W", hl.dsp.exec_cmd(scriptsDir .. "/bgselector.sh"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + ALT + E", hl.dsp.exec_cmd("ghostty -e yazi || alacritty -e yazi"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("code || codium"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("ghostty -e nvim || alacritty -e nvim"))
hl.bind("CTRL + SUPER + V", hl.dsp.exec_cmd("pavucontrol"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("ghostty -e btop || alacritty -e btop"))
hl.bind("SUPER + S", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh --area"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh --screen"))
hl.bind("Print", hl.dsp.exec_cmd(scriptsDir .. "/screenshot.sh --screen"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("vicinae deeplink 'vicinae://launch/clipboard/history?toggle=true' || vicinae cmd launch clipboard:history"))
hl.bind("SUPER + comma", hl.dsp.exec_cmd("vicinae deeplink 'vicinae://launch/core/search-emojis?toggle=true' || vicinae cmd launch core:search-emojis"))
hl.bind("SUPER + period", hl.dsp.exec_cmd("vicinae deeplink 'vicinae://launch/core/search-emojis?toggle=true' || vicinae cmd launch core:search-emojis"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Window Controls
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("SUPER + ALT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + D", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pin())

-- Split ratio
hl.bind("SUPER + Semicolon", hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind("SUPER + Apostrophe", hl.dsp.layout("splitratio +0.1"), { repeating = true })

-- Focus Movement (Arrows and HJKL)
hl.bind("SUPER + Left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- Window Movement (Arrows and HJKL)
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + Up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + Down", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Mouse drag and resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces (1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Relative workspace navigation
hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "-1" }))

-- Session controls
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("gtklock || hyprlock || loginctl lock-session"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("gtklock || hyprlock || loginctl lock-session"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("gtklock || hyprlock || loginctl lock-session"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend || loginctl suspend"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("wlogout -p layer-shell || loginctl terminate-user $USER"))

-- Multimedia keys (Volume & Brightness)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })

-- Media Player keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("playerctl next"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("playerctl previous"))
