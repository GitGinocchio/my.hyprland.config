import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    
    default property alias left: leftLayout.data
    property alias center: centerLayout.data
    property alias right: rightLayout.data

    property int barHeight: 50
    property int barSpacing: 12

    anchors {
        top: true
        left: true
        right: true
    }
    
    exclusiveZone: barHeight
    height: barHeight
    color: "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.topMargin: 8
        anchors.bottomMargin: 8
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 0

        RowLayout {
            id: leftLayout
            spacing: root.barSpacing
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        Item { Layout.fillWidth: true }

        RowLayout {
            id: centerLayout
            spacing: root.barSpacing
            Layout.alignment: Qt.AlignCenter
        }

        Item { Layout.fillWidth: true }

        RowLayout {
            id: rightLayout
            spacing: root.barSpacing
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
    }
}