pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    function send(title, message, tag = "general") {
        notifProc.command = [
            "notify-send", 
            "-h", "string:x-canonical-private-synchronous:" + tag, 
            "-u", "low",
            "-t", "1000",
            title, 
            message
        ];
        notifProc.running = true;
    }

    Process {
        id: notifProc
        running: false
    }
}