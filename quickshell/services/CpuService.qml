pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real cpuUsage: 0

    property real prevIdle: 0
    property real prevTotal: 0

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: cpuProc.running = true
    }

    Process {
        id: cpuProc
        command: ["head", "-n", "1", "/proc/stat"]

        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split(/\s+/);
                if (parts[0] === "cpu" && parts.length >= 8) {
                    let user = parseInt(parts[1]);
                    let nice = parseInt(parts[2]);
                    let sys = parseInt(parts[3]);
                    let idle = parseInt(parts[4]);
                    let iowait = parseInt(parts[5]);
                    let irq = parseInt(parts[6]);
                    let softirq = parseInt(parts[7]);

                    let currentIdle = idle + iowait;
                    let currentTotal = user + nice + sys + idle + iowait + irq + softirq;

                    let totalDiff = currentTotal - root.prevTotal;
                    let idleDiff = currentIdle - root.prevIdle;

                    if (totalDiff > 0) {
                        let usage = (totalDiff - idleDiff) / totalDiff;
                        root.cpuUsage = Math.max(0, Math.min(100, usage * 100));
                    }

                    root.prevTotal = currentTotal;
                    root.prevIdle = currentIdle;
                }
            }
        }
    }
}