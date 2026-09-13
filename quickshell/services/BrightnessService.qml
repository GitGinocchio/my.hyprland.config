pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property real value: 0.0

    function setBrightness(newValue) {
        let clamped = Math.max(0.01, Math.min(1.0, newValue));
        root.value = clamped;

        let percent = Math.round(clamped * 100);
        setProc.command = ["ddcutil", "setvcp", "10", percent, "--bus=1"];
        setProc.running = true;
    }

    Process {
        id: brightnessProc
        command: ["sh", "-c", "ddcutil getvcp 10 --bus=1 --brief | awk '{print $4 / 100}'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data.trim());
                if (!isNaN(val)) {
                    root.value = val;
                }
            }
        }
    }

    Process {
        id: setProc
        running: false
        onExited: brightnessProc.running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: brightnessProc.running = true
    }
}