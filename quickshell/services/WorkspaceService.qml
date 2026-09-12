pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property var workspacesModel: Hyprland.workspaces
    property int workspaceCount: workspacesModel.values.length
    property int activeWorkspace: Hyprland.focusedWorkspace?.id ?? 1

    function setActiveById(id) {
        Hyprland.dispatch("workspace " + id);
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            Hyprland.refreshWorkspaces();
        }
    }
}