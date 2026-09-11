// panels/PillBar.qml
import QtQuick
import Quickshell
import Quickshell.Wayland

import "../components"

PanelWindow {
    id: window

    property int collapsedWidth: 150
    property int expandedWidth: 500
    property int barHeight: 35
    property real topMargin: 8

    property alias closed: closedContainer.data
    property alias left: leftRow.data
    property alias center: centerRow.data
    property alias right: rightRow.data

    property bool isHovered: false
    property bool hasOpenPopup: false

    anchors {
        top: true
        left: true
        right: true
    }

    height: barHeight + topMargin
    exclusionMode: ExclusionMode.None
    color: "transparent"

    // Funzione chiamata dal PopupWrapper alla chiusura per sincronizzare lo stato
    function checkMouseState() {
        if (!pillHover.hovered && !window.hasOpenPopup) {
            closeTimer.restart();
        }
    }

    Rectangle {
        id: pill
        width: (window.isHovered || window.hasOpenPopup) ? window.expandedWidth : window.collapsedWidth
        height: window.barHeight
        anchors.top: parent.top
        anchors.topMargin: window.topMargin
        anchors.horizontalCenter: parent.horizontalCenter

        color: "#1e1e2e"
        border.color: "#313244"
        border.width: 1
        radius: height / 2
        clip: true

        Behavior on width {
            NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
        }
        Behavior on radius {
            NumberAnimation { duration: 200 }
        }

        HoverHandler {
            id: pillHover
            onHoveredChanged: {
                if (hovered) {
                    closeTimer.stop();
                    window.isHovered = true;
                } else {
                    if (!window.hasOpenPopup) {
                        closeTimer.restart();
                    }
                }
            }
        }

        Timer {
            id: closeTimer
            interval: 400
            repeat: false
            onTriggered: {
                if (!pillHover.hovered && !window.hasOpenPopup) {
                    window.isHovered = false;
                }
            }
        }

        // 1. STATO CHIUSO
        Item {
            anchors.fill: parent
            opacity: (window.isHovered || window.hasOpenPopup) ? 0 : 1
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }

            Row {
                id: closedContainer
                anchors.centerIn: parent
                spacing: 12
            }
        }

        // 2. STATO APERTO
        Item {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            
            opacity: (window.isHovered || window.hasOpenPopup) ? 1 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }

            Row {
                id: leftRow
                spacing: 12
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Row {
                id: centerRow
                spacing: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Row {
                id: rightRow
                spacing: 12
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}