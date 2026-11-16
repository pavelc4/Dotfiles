-- ==============================================================================
-- Hyprland Monitor-Isolated Workspaces (Per-Monitor Independent Workspaces)
-- Laptop Screen (eDP-1): Workspaces 1..10
-- External Screen (HDMI-A-1 / DP-1 / DP-2): Workspaces 11..20 (Mapped to 1..10)
-- ==============================================================================

local function get_active_monitor_index()
    local mon = hl.get_active_monitor()
    if not mon then
        return 0
    end
    if mon.id and type(mon.id) == "number" then
        return mon.id
    end
    if mon.name == "eDP-1" then
        return 0
    elseif mon.name == "HDMI-A-1" then
        return 1
    end
    return 0
end

local function get_monitor_workspace(index)
    local mon_id = get_active_monitor_index()
    return mon_id * 10 + index
end

-- Pin Workspaces to Specific Displays
-- Primary Laptop Display (eDP-1): Workspaces 1..10
for i = 1, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "eDP-1",
        default = (i == 1),
    })
end

-- External Displays (HDMI-A-1, DP-1, DP-2): Workspaces 11..20
for i = 11, 20 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "HDMI-A-1",
        default = (i == 11),
    })
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-1",
    })
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-2",
    })
end

-- Workspaces Navigation & Window Movement (1-10 per monitor)
for i = 1, 10 do
    local key = i % 10
    -- Focus workspace on active monitor
    hl.bind("SUPER + " .. key, function()
        local ws = get_monitor_workspace(i)
        hl.dispatch(hl.dsp.focus({ workspace = ws }))
    end)

    -- Move active window to workspace on active monitor
    hl.bind("SUPER + SHIFT + " .. key, function()
        local ws = get_monitor_workspace(i)
        hl.dispatch(hl.dsp.window.move({ workspace = ws }))
    end)

    -- Move active window and follow focus
    hl.bind("SUPER + ALT + " .. key, function()
        local ws = get_monitor_workspace(i)
        hl.dispatch(hl.dsp.window.move({ workspace = ws }))
        hl.dispatch(hl.dsp.focus({ workspace = ws }))
    end)
end

-- Relative Workspace Navigation (stays on active monitor)
hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "-1" }))

-- Inter-Monitor Focus & Transfer Controls
hl.bind("SUPER + bracketleft", hl.dsp.focus({ monitor = "-1" }))
hl.bind("SUPER + bracketright", hl.dsp.focus({ monitor = "+1" }))
hl.bind("SUPER + SHIFT + bracketleft", hl.dsp.window.move({ monitor = "-1" }))
hl.bind("SUPER + SHIFT + bracketright", hl.dsp.window.move({ monitor = "+1" }))
hl.bind("SUPER + ALT + Left", hl.dsp.window.move({ monitor = "left" }))
hl.bind("SUPER + ALT + Right", hl.dsp.window.move({ monitor = "right" }))
