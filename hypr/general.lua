hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },

    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 0,
        layout = "dwindle",
        allow_tearing = false,
        col = {
            active_border = { colors = { "rgba(d0bcffee)", "rgba(ccc2dcee)" }, angle = 45 },
            inactive_border = "rgba(404040aa)",
        },
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = true,
            xray = false,
        },
        shadow = {
            enabled = true,
            range = 15,
            render_power = 3,
            color = "rgba(0, 0, 0, 0.3)",
        },
    },

    animations = {
        enabled = true,
        bezier = {
            { name = "easeOutQuint",   values = { 0.23, 1, 0.32, 1 } },
            { name = "easeInOutCubic", values = { 0.65, 0.05, 0.36, 1 } },
            { name = "linear",         values = { 0, 0, 1, 1 } },
            { name = "almostLinear",   values = { 0.5, 0.5, 0.75, 1.0 } },
            { name = "quick",          values = { 0.15, 0, 0.1, 1 } },
        },
        animation = {
            { name = "global",           enable = true, speed = 10,   curve = "default" },
            { name = "border",           enable = true, speed = 5.39, curve = "easeOutQuint" },
            { name = "windows",          enable = true, speed = 4.79, curve = "easeOutQuint" },
            { name = "windowsIn",        enable = true, speed = 4.1,  curve = "easeOutQuint", style = "popin 87%" },
            { name = "windowsOut",       enable = true, speed = 1.49, curve = "linear",       style = "popin 87%" },
            { name = "fadeIn",           enable = true, speed = 1.73, curve = "almostLinear" },
            { name = "fadeOut",          enable = true, speed = 1.46, curve = "almostLinear" },
            { name = "fade",             enable = true, speed = 3.03, curve = "quick" },
            { name = "layers",           enable = true, speed = 3.81, curve = "easeOutQuint" },
            { name = "layersIn",         enable = true, speed = 4,    curve = "easeOutQuint", style = "fade" },
            { name = "layersOut",        enable = true, speed = 1.5,  curve = "linear",       style = "fade" },
            { name = "workspaces",       enable = true, speed = 4,    curve = "easeOutQuint", style = "slide" },
            { name = "specialWorkspace", enable = true, speed = 4,    curve = "easeOutQuint", style = "slidefadevert" },
        },
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})
