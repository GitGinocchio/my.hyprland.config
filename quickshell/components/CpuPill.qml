import QtQuick
import QtQuick.Layouts
import "../services"
import "../theme"
import "."

Pill {
    id: rootPill

    customWidth: 85

    RowLayout {
        anchors.centerIn: parent
        spacing: 6

        LucideIcon {
            icon: "cpu"
            size: 16
            color: Theme.green
        }

        Text {
            text: CpuService.cpuUsage.toFixed(2) + "%"
            color: Theme.text
            font.pixelSize: 12
        }
    }
}