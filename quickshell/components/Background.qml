// components/Background.qml
import QtQuick

Rectangle {
    id: root

    default property alias content: contentItem.data

    property real horizontalPadding: 10
    property real verticalPadding: 6

    property color normalColor: "#313244"
    property color hoverColor: "#45475a"
    property color disabledColor: "#252533"
    
    property color borderColorNormal: "#45475a"
    property color borderColorHover: "#585b70"
    property color borderColorDisabled: "#2a2b3d"
    
    property bool enableHover: true
    property bool enabled: true

    signal clicked()

    // Sceglie il colore in base allo stato usando l'HoverHandler
    color: !root.enabled ? disabledColor : (hoverHandler.hovered && enableHover ? hoverColor : normalColor)
    border.color: !root.enabled ? borderColorDisabled : (hoverHandler.hovered && enableHover ? borderColorHover : borderColorNormal)
    border.width: 1
    radius: 8

    opacity: root.enabled ? 1.0 : 0.6

    Behavior on color { ColorAnimation { duration: 150 } }
    Behavior on border.color { ColorAnimation { duration: 150 } }
    Behavior on opacity { NumberAnimation { duration: 150 } }

    width: contentItem.width + (horizontalPadding * 2)
    height: contentItem.height + (verticalPadding * 2)

    // HoverHandler rileva il passaggio del mouse senza bloccare la Topbar
    HoverHandler {
        id: hoverHandler
        enabled: root.enabled && root.enableHover
    }

    // TapHandler gestisce i click in modo nativo e non conflittuale
    TapHandler {
        id: tapHandler
        enabled: root.enabled
        onTapped: root.clicked()
    }

    Item {
        id: contentItem
        width: childrenRect.width
        height: childrenRect.height
        anchors.centerIn: parent
    }
}