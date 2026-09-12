import QtQuick
import QtQuick.Layouts
import "../theme"
import "."

Pill {
    id: root
    
    property real brightProgress: 0.6
    property real headphonesProgress: 0.8
    property real micProgress: 0.3

    customWidth: 225

    Item {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        // 1. Riga degli indicatori circolari all'inizio (a sinistra)
        Row {
            id: indicatorsRow
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            CircularIndicator {
                icon: "sun"
                progress: root.brightProgress
            }

            CircularIndicator {
                icon: "headphones"
                progress: root.headphonesProgress
            }

            CircularIndicator {
                icon: "mic"
                progress: root.micProgress
            }
        }

        // 2. Primo cerchio a destra degli indicatori (WiFi)
        Rectangle {
            id: mainCircle
            width: 26
            height: 26
            radius: width / 2
            color: Theme.teal
            anchors.left: indicatorsRow.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            LucideIcon {
                anchors.centerIn: parent
                icon: "wifi"
                size: 14
                color: Theme.base
            }
        }

        // 3. Secondo cerchio alla fine (Notifications)
        Rectangle {
            id: notifications
            width: 26
            height: 26
            radius: width / 2
            color: Theme.lavender
            anchors.left: mainCircle.right
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter

            LucideIcon {
                anchors.centerIn: parent
                icon: "bell"
                size: 14
                color: Theme.base
            }
        }

        // 3. Secondo cerchio alla fine (Notifications)
        Rectangle {
            id: settings
            width: 26
            height: 26
            radius: width / 2
            color: Theme.surface2
            anchors.left: mainCircle.right
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter

            LucideIcon {
                anchors.centerIn: parent
                icon: "settings"
                size: 14
                color: Theme.base
            }
        }
    }
}