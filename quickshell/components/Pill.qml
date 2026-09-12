import QtQuick
import QtQuick.Layouts
import "../theme"

Rectangle {
    id: pillRoot

    default property alias pillContent: innerLayout.data

    property int customWidth: -1
    property bool customFillWidth: false
    property int pillRadius: 24
    property color pillColor: Theme.crust

    // Se customWidth è impostato usa quello, altrimenti usa la dimensione implicita del layout interno
    width: customWidth !== -1 ? customWidth : (innerLayout.width + innerLayout.margins.left + innerLayout.margins.right)
    
    Layout.preferredWidth: width
    Layout.fillWidth: customFillWidth
    Layout.fillHeight: true

    color: pillColor
    radius: pillRadius

    RowLayout {
        id: innerLayout
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        anchors.topMargin: 4
        anchors.bottomMargin: 4
        spacing: 6
    }
}