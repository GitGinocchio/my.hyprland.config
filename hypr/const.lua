local monitors = {
    ["HDMI-A-1"] = {
        mode     = "1920x1080@75",
        position = "0x1080",
        scale    = 1,
    },
    ["HDMI-A-2"] = {
        mode     = "1920x1080@60",
        position = "0x0",
        scale    = 1,
    },
    ["fallback"] = {
        mode     = "preferred",
        position = "preferred",
        scale    = 1,
    },
}

return {
    mainMod = "SUPER",
    terminal = "kitty",
    fileManager = "thunar",
    topbar = "quickshell",
    menu = "wofi",
    monitors = monitors,
}