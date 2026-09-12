import Quickshell
import QtQuick
import QtQuick.Layouts

import "components" 
import "panels"

ShellRoot {
    TopBar {
        left: [
            WorkspacePill {},
            CpuPill {},
            RamPill {},
        ]

        center: [
        ]

        right: [
            ControlsPill {}
        ]
    }
}