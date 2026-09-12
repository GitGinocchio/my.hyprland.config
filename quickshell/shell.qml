import Quickshell
import QtQuick
import QtQuick.Layouts

import "components" 
import "panels"

ShellRoot {
    TopBar {
        left: [
            CpuPill {},
            RamPill {},
        ]

        center: [
            WorkspacePill {},
        ]

        right: [
            ControlsPill {}
        ]
    }
}