import QtQuick
import Quickshell
import Quickshell.Io

Background {
    id: root

    property string iconSource: "../assets/power.svg"

    horizontalPadding: 4
    verticalPadding: 4

    Process {
        id: poweroffProcess
        command: ["systemctl", "poweroff"]
    }

    onClicked: {
        poweroffProcess.running = true
    }

    // Usiamo Image per caricare un'icona SVG pulita e scalabile
    Image {
        id: iconItem
        anchors.centerIn: parent
        width: 16
        height: width
        source: root.iconSource
        fillMode: Image.PreserveAspectFit
    }
}