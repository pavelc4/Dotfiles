-- ==============================================================================
-- Hyprland Native Lua Configuration
-- Ghostty, Vicinae, Dynamic Monitors, Matugen Colors
-- ==============================================================================

local HOME = os.getenv("HOME") or ""
local hyprDir = HOME .. "/.config/hypr"
package.path = hyprDir .. "/?.lua;" .. hyprDir .. "/?/init.lua;" .. package.path

local function file_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end
    return false
end

-- Core configuration modules
require("monitors")
require("env")
require("execs")
require("general")
require("rules")
require("keybinds")

-- Dynamic Matugen colors
if file_exists(hyprDir .. "/colors.lua") then
    dofile(hyprDir .. "/colors.lua")
end

-- Custom user overrides
if file_exists(hyprDir .. "/custom/execs.lua") then
    dofile(hyprDir .. "/custom/execs.lua")
end
if file_exists(hyprDir .. "/custom/keybinds.lua") then
    dofile(hyprDir .. "/custom/keybinds.lua")
end
if file_exists(hyprDir .. "/custom/rules.lua") then
    dofile(hyprDir .. "/custom/rules.lua")
end
