pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property real volume: 0.0
    property real micVolume: 0.0

    function setVolume(newValue) {
        let clamped = Math.max(0.0, Math.min(1.0, newValue));
        root.volume = clamped;
        let percent = Math.round(clamped * 100) + "%";
        setVolProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", percent];
        setVolProc.running = true;
    }

    function setMicVolume(newValue) {
        let clamped = Math.max(0.0, Math.min(1.0, newValue));
        root.micVolume = clamped;
        let percent = Math.round(clamped * 100) + "%";
        setMicProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", percent];
        setMicProc.running = true;
    }

    Process {
        id: audioProc
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data.trim());
                if (!isNaN(val)) {
                    root.volume = Math.max(0.0, Math.min(1.0, val));
                }
            }
        }
    }

    Process {
        id: micProc
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}'"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data.trim());
                if (!isNaN(val)) {
                    root.micVolume = Math.max(0.0, Math.min(1.0, val));
                }
            }
        }
    }

    Process {
        id: setVolProc
        running: false
        onExited: audioProc.running = true
    }

    Process {
        id: setMicProc
        running: false
        onExited: micProc.running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            audioProc.running = true;
            micProc.running = true;
        }
    }
}