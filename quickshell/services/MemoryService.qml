pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real usedRam: 0
    property real totalRam: 0

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: memProc.running = true
    }

    Process {
        id: memProc
        command: ["awk", "/MemTotal|MemAvailable/ {print $2}", "/proc/meminfo"]

        property var lines: []

        stdout: SplitParser {
            onRead: data => {
                memProc.lines.push(data.trim());
                if (memProc.lines.length >= 2) {
                    let totalKb = parseInt(memProc.lines[0]);
                    let availKb = parseInt(memProc.lines[1]);
                    if (!isNaN(totalKb) && !isNaN(availKb)) {
                        let usedKb = totalKb - availKb;
                        root.totalRam = totalKb / (1024 * 1024); // GB
                        root.usedRam = usedKb / (1024 * 1024);   // GB
                    }
                    memProc.lines = [];
                }
            }
        }
    }
}