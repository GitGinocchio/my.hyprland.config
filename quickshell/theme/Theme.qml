pragma Singleton
import QtQuick

Item {
    // --- Tavolozza di Base (Catppuccin Mocha) ---
    readonly property color base: "#1e1e2e"
    readonly property color mantle: "#181825"
    readonly property color crust: "#11111b"
    readonly property color surface0: "#313244"
    readonly property color surface1: "#45475a"
    readonly property color surface2: "#585b70"

    readonly property color text: "#cdd6f4"
    readonly property color subtext1: "#bac2de"
    readonly property color subtext0: "#a6adc8"

    // --- Colori Principali ---
    readonly property color lavender: "#b4befe"
    readonly property color rosewater: "#f5e0dc"
    readonly property color blue: "#89b4fa"
    readonly property color green: "#a6e3a1"
    readonly property color yellow: "#f9e2af"
    readonly property color peach: "#fab387"
    readonly property color mauve: "#cba6f7"
    readonly property color teal: "#94e2d5"
    readonly property color red: "#f38ba8"
    readonly property color maroon: "#eba0ac"
    readonly property color pink: "#f5c2e7"
    readonly property color flamingo: "#f2cdcd"
    readonly property color sky: "#89dceb"
    readonly property color sapphire: "#74c7ec"
    readonly property color lime: "#b8bb26"
    readonly property color amber: "#fab243"
    readonly property color violet: "#d3869b"
    readonly property color slate: "#83a598"

    // --- Sotto-oggetti per variante chiara e scura ---
    readonly property Item light: Item {
        readonly property color lavender: "#b4befe"
        readonly property color rosewater: "#f5e0dc"
        readonly property color blue: "#89b4fa"
        readonly property color green: "#a6e3a1"
        readonly property color yellow: "#f9e2af"
        readonly property color peach: "#fab387"
        readonly property color mauve: "#cba6f7"
        readonly property color teal: "#94e2d5"
        readonly property color red: "#f38ba8"
        readonly property color maroon: "#eba0ac"
        readonly property color pink: "#f5c2e7"
        readonly property color flamingo: "#f2cdcd"
        readonly property color sky: "#89dceb"
        readonly property color sapphire: "#74c7ec"
        readonly property color lime: "#b8bb26"
        readonly property color amber: "#fab243"
        readonly property color violet: "#d3869b"
        readonly property color slate: "#83a598"
    }

    // Versioni dark rese più spente, desaturate e opache (stile Catppuccin Macchiato/Frappé smorzato)
    readonly property Item dark: Item {
        readonly property color lavender: "#7f849c"
        readonly property color rosewater: "#b58782"
        readonly property color blue: "#6c85b5"
        readonly property color green: "#739272"
        readonly property color yellow: "#b59f73"
        readonly property color peach: "#b57f64"
        readonly property color mauve: "#947ba6"
        readonly property color teal: "#688c89"
        readonly property color red: "#b56976"
        readonly property color maroon: "#a8757d"
        readonly property color pink: "#b584a3"
        readonly property color flamingo: "#b08a8a"
        readonly property color sky: "#6b96a3"
        readonly property color sapphire: "#638996"
        readonly property color lime: "#878a4e"
        readonly property color amber: "#a3824c"
        readonly property color violet: "#966f7f"
        readonly property color slate: "#617d78"
    }
}