import QtQuick
import QtQuick.Layouts
import "../theme"
import "."

Pill {

    customWidth: 42

    Rectangle {
        id: mainCircle
        width: 26
        height: 26
        radius: width / 2
        color: Theme.lavender
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        LucideIcon {
            anchors.centerIn: parent
            icon: "bell"
            size: 14
            color: root.mainIconColor
        }
    }
}