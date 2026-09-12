import QtQuick
import "../theme"

Item {
    id: root

    property string icon: ""
    property color color: Theme.teal
    property int size: 16

    width: size
    height: size

    function colorToHex(c) {
        let hex = c.toString();
        return hex.replace("#", "%23");
    }

    Image {
        id: img
        anchors.fill: parent
        
        source: root.icon ? "https://api.iconify.design/lucide/" + root.icon + ".svg?color=" + colorToHex(root.color) : ""
        
        sourceSize.width: root.size * 2
        sourceSize.height: root.size * 2
        
        asynchronous: true
        smooth: true
    }
}