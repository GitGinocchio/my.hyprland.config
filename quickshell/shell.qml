import Quickshell
import QtQuick
import QtQuick.Layouts

import "components" 
import "panels"

ShellRoot {
    // Itera automaticamente su tutti i monitor collegati
    Variants {
        model: Quickshell.screens

        delegate: TopBar {
            required property var modelData
            screen: modelData

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
}