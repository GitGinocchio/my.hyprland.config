pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property real value: 0.0

    function setBrightness(newValue) {
        let clamped = Math.max(0.01, Math.min(1.0, newValue));
        root.value = clamped; // Aggiornamento ottimistico immediato

        let percent = Math.round(clamped * 100);
        // Specifichiamo il bus i2c-1 per evitare conflitti con la TV TCL secondaria
        setProc.command = ["ddcutil", "setvcp", "10", percent, "--bus=1"];
        setProc.running = true;
    }

    Process {
        id: brightnessProc
        command: ["sh", "-c", "ddcutil getvcp 10 --bus=1 | grep -oP 'current value = \\K\\d+'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                let val = parseInt(data.trim());
                if (!isNaN(val)) {
                    root.value = val / 100.0;
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
        interval: 1000
        running: true
        repeat: true
        onTriggered: brightnessProc.running = true
    }
}