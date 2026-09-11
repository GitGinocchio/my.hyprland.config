local const = require("const")
local utils = require("utils")

local monitors = {}

function monitors.configure_monitor(name)
    local cfg = const.monitors[name] or const.monitors["fallback"]
    
    hl.monitor({
        output   = name,
        mode     = cfg.mode,
        position = cfg.position,
        scale    = cfg.scale,
    })
end

monitors.configure_monitor("HDMI-A-1")
monitors.configure_monitor("HDMI-A-2")

hl.on("monitor.added", function(monitor)
    utils.notify(1, 3000, "rgb(33ccff)", "Monitor rilevato: %s", monitor.name)
    monitors.configure_monitor(monitor.name)
end)

return monitors