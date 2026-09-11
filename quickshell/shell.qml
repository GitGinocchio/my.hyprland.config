import QtQuick
import Quickshell

import "panels"
import "components"

ShellRoot {
    id: root

    Topbar {
        id: topbar
        expandedWidth: 750 // 1900
        collapsedWidth: 150

        right: ShutdownButton {

        }

        center: [
            TopbarPopup {
                topbarComponent: topbar
                trigger: Clock {
                    anchors.verticalCenter: parent.verticalCenter
                    pixelSize: 15
                    fontWeight: 800
                    textColor: "white"
                }

                content: Calendar { 

                }
            }
        ]

        closed: [
            Clock {
                showBackground: false
                anchors.verticalCenter: parent.verticalCenter
                timeFormat: "hh:mm"
                pixelSize: 20
                fontWeight: 800
                textColor: "white"
            }
        ]

        left: [
        ]
    }
}