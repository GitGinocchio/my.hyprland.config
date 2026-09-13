import QtQuick
import Quickshell
import Quickshell.Io
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

    // Salvataggio direttamente dentro la cartella di Quickshell (es. ~/.config/quickshell/cache/icons/)
    property string cachePath: Quickshell.env("HOME") + "/.config/quickshell/.cache/icons/"
    property string iconFileName: root.icon + "_" + root.color.toString().replace("#", "") + ".svg"
    property string localFile: "file://" + cachePath + iconFileName

    Process {
        id: checkProc
        command: ["sh", "-c", "test -f '" + cachePath + iconFileName + "' && echo 'exists' || echo 'missing'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                if (data.trim() === "missing") {
                    downloadProc.command = [
                        "sh", "-c", 
                        "mkdir -p '" + cachePath + "' && curl -s 'https://api.iconify.design/lucide/" + root.icon + ".svg?color=" + colorToHex(root.color) + "' -o '" + cachePath + iconFileName + "'"
                    ];
                    downloadProc.running = true;
                } else {
                    img.source = "";
                    img.source = localFile;
                }
            }
        }
    }

    Process {
        id: downloadProc
        running: false
        onExited: {
            img.source = "";
            img.source = localFile;
        }
    }

    Image {
        id: img
        anchors.fill: parent
        
        source: localFile
        
        sourceSize.width: root.size * 2
        sourceSize.height: root.size * 2
        
        asynchronous: false
        smooth: true

        onStatusChanged: {
            if (status === Image.Error && source !== ("https://api.iconify.design/lucide/" + root.icon + ".svg?color=" + colorToHex(root.color))) {
                source = "https://api.iconify.design/lucide/" + root.icon + ".svg?color=" + colorToHex(root.color);
            }
        }
    }
}