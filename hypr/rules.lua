-- Vicinae Launcher
hl.window_rule({
    name = "vicinae-floating",
    match = { class = "vicinae" },
    float = true,
    center = true,
    stay_focused = true,
})

-- Common dialogs & mixers
hl.window_rule({
    name = "pavucontrol-floating",
    match = { class = "pavucontrol" },
    float = true,
})
hl.window_rule({
    name = "pavucontrol-qt-floating",
    match = { class = "pavucontrol-qt" },
    float = true,
})
hl.window_rule({
    name = "nm-connection-editor-floating",
    match = { class = "nm-connection-editor" },
    float = true,
})
hl.window_rule({
    name = "pip-floating",
    match = { title = "Picture-in-Picture" },
    float = true,
    pin = true,
})
hl.window_rule({
    name = "dialog-open-file",
    match = { title = "Open File" },
    float = true,
})
hl.window_rule({
    name = "dialog-save-file",
    match = { title = "Save File" },
    float = true,
})
hl.window_rule({
    name = "dialog-choose-files",
    match = { title = "Choose Files" },
    float = true,
})

-- Rofi Wallpaper Switcher & Layer Rules (Blur, Ignore Zero, Slide Bottom)
hl.layer_rule({
    name = "rofi-layer-rules",
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = true,
    animation = "slide bottom",
})
