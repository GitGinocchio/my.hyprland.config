import QtQuick
import QtQuick.Layouts
import "../services"
import "../theme"

Pill {
    id: rootPill

    customWidth: (WorkspaceService.workspaceCount * 30)

    Repeater {
        model: WorkspaceService.workspacesModel

        Rectangle {
            property int wsId: modelData.id
            property bool isActive: wsId === WorkspaceService.activeWorkspace

            Layout.preferredWidth: isActive ? 28 : 12
            Layout.preferredHeight: 12
            radius: 6
            color: isActive ? Theme.sapphire : Theme.surface0

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 200 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    WorkspaceService.setActiveById(wsId);
                }
            }
        }
    }
}