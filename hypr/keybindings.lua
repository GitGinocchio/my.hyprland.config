
local const = require("const")

-- Open terminal
hl.bind(const.mainMod .. " + T", hl.dsp.exec_cmd(const.terminal))

-- Close current window
hl.bind(const.mainMod .. " + Q", hl.dsp.window.close())

-- Quit Hyprland
hl.bind(const.mainMod .. " + ALT + Q", hl.dsp.exec_cmd("systemctl poweroff"))

-- Back to login
hl.bind(const.mainMod .. " + L", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Open menu
hl.bind(const.mainMod .. " + TAB", hl.dsp.exec_cmd("pkill " .. const.menu .. " || " .. const.menu .. " --show drun"))

-- Open file manager
hl.bind(const.mainMod .. " + F", hl.dsp.exec_cmd(const.fileManager))

-- Capture Screenshot
hl.bind(const.mainMod .. " + C", hl.dsp.exec_cmd('pkill -x slurp || grim -g "$(slurp)" - | wl-copy'))

-- Floating window
hl.bind(const.mainMod .. " + Z", hl.dsp.window.float({ action = "toggle" }))
hl.bind(const.mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(const.mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(const.mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(const.mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(const.mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(const.mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(const.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(const.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(const.mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(const.mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(const.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(const.mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(const.mainMod .. " + mouse:272", hl.dsp.window.drag(),    { mouse = true })
hl.bind(const.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
