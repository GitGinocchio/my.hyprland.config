// components/PopupWrapper.qml
import QtQuick
import Quickshell
import Quickshell.Wayland

Item {
    id: root

    property bool isOpen: false
    property var topbarComponent: null

    property alias trigger: triggerContainer.data
    property alias content: bg.content

    width: triggerContainer.children.length > 0 ? (triggerContainer.children[0].width > 0 ? triggerContainer.children[0].width : triggerContainer.children[0].implicitWidth) : 0
    height: triggerContainer.children.length > 0 ? (triggerContainer.children[0].height > 0 ? triggerContainer.children[0].height : triggerContainer.children[0].implicitWidth) : 0
    anchors.verticalCenter: parent.verticalCenter

    onIsOpenChanged: {
        let win = root.topbarComponent;
        if (win && win.hasOwnProperty("hasOpenPopup")) {
            if (isOpen) {
                win.hasOpenPopup = true;
                win.isHovered = true;
            } else {
                win.hasOpenPopup = false;
            }
        }
    }

    Item {
        id: triggerContainer
        anchors.fill: parent

        TapHandler {
            onTapped: {
                let win = root.topbarComponent;
                if (root.isOpen) {
                    root.isOpen = false;
                    if (win) {
                        win.hasOpenPopup = false;
                        win.isHovered = false;
                    }
                } else {
                    if (win) {
                        win.isHovered = true;
                    }
                    root.isOpen = true;
                }
            }
        }
    }

    PopupWindow {
        id: popupWindow
        
        anchor.window: root.topbarComponent
        anchor.rect.x: (root.topbarComponent.width - width) / 2
        anchor.rect.y: root.topbarComponent ? root.topbarComponent.height + 8 : 45

        visible: root.isOpen
        
        width: Math.max(260, bg.width)
        height: Math.max(300, bg.height)
        
        color: "transparent"
        grabFocus: true

        onVisibleChanged: {
            if (!visible) {
                root.isOpen = false;
                let win = root.topbarComponent;
                if (win) {
                    win.hasOpenPopup = false;
                    // Chiediamo alla topbar di rivalutare subito se il mouse è ancora sopra di essa
                    win.checkMouseState(); 
                }
            }
        }

        Background {
            id: bg
            horizontalPadding: 6
            verticalPadding: 6
            enableHover: false

            y: root.isOpen ? 0 : -10
            opacity: root.isOpen ? 1 : 0
            scale: root.isOpen ? 1 : 0.95

            Behavior on opacity {
                NumberAnimation { duration: 180; easing.type: Easing.InOutCubic }
            }
            Behavior on scale {
                NumberAnimation { duration: 180; easing.type: Easing.InOutCubic }
            }
        }
    }
}