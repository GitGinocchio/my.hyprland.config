-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

local const = require("const")
local utils = require("utils")
local monitors = require("monitors")
require("keybindings")
require("animations")
require("windows")
require("gestures")
require("config")
require("env")

hl.on("hyprland.start", function () 
    hl.exec_cmd(const.topbar)
end)

hl.on("config.reloaded", function ()
    utils.notify(1, 3000, "rgb(33ccff)", "Config reloaded")

    monitors.configure_monitor("HDMI-A-1")
    monitors.configure_monitor("HDMI-A-2")

    hl.exec_cmd("killall " .. const.topbar .. " && " .. const.topbar .. " &")
end)