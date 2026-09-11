local utils = {}

function utils.notify(level, time_ms, color, message, ...)
    local text = (...) and string.format(message, ...) or message
    
    local cmd = string.format("hyprctl notify %d %d '%s' '%s'", level, time_ms, color, text)
    hl.exec_cmd(cmd)
end

return utils