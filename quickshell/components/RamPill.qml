import QtQuick
import QtQuick.Layouts
import "../services"
import "../theme"

Pill {
    id: rootPill

    customWidth: 85

    RowLayout {
        anchors.centerIn: parent
        spacing: 6

        LucideIcon {
            icon: "memory-stick"
            size: 16
            color: Theme.blue
        }

        Text {
            text: MemoryService.usedRam.toFixed(1) + " GB"
            color: Theme.text
            font.pixelSize: 12
        }
    }
}