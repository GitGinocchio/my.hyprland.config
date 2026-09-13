import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../services"
import "../theme"

Pill {
    id: root

    customWidth: 225

    Process {
        id: notifProc
        running: false
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        // 1. Riga degli indicatori circolari all'inizio (a sinistra)
        Row {
            id: indicatorsRow
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            // Luminosità
            CircularIndicator {
                icon: "sun"
                activeColor: Theme.yellow
                progress: BrightnessService.value

                onValueChanged: newVal => {
                    BrightnessService.setBrightness(newVal);
                    let percent = Math.round(newVal * 100);
                    NotificationService.send("Luminosità", percent + "%", "brightness");
                }
            }

            // Cuffie / Volume Output
            CircularIndicator {
                icon: "headphones"
                activeColor: Theme.red
                progress: AudioService.volume

                onValueChanged: newVal => {
                    AudioService.setVolume(newVal);
                    let percent = Math.round(newVal * 100);
                    NotificationService.send("Volume", percent + "%", "volume");
                }
            }

            // Microfono / Volume Input
            CircularIndicator {
                icon: "mic"
                activeColor: Theme.green
                progress: AudioService.micVolume

                onValueChanged: newVal => {
                    AudioService.setMicVolume(newVal);
                    let percent = Math.round(newVal * 100);
                    NotificationService.send("Microfono", percent + "%", "microphone");
                }
            }
        }

        // 2. Primo cerchio a destra degli indicatori (WiFi)
        Rectangle {
            id: mainCircle
            width: 26
            height: 26
            radius: width / 2
            color: Theme.teal
            anchors.left: indicatorsRow.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            LucideIcon {
                anchors.centerIn: parent
                icon: "wifi"
                size: 14
                color: Theme.base
            }
        }

        // 3. Secondo cerchio alla fine (Notifications)
        Rectangle {
            id: notifications
            width: 26
            height: 26
            radius: width / 2
            color: Theme.lavender
            anchors.left: mainCircle.right
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter

            LucideIcon {
                anchors.centerIn: parent
                icon: "bell"
                size: 14
                color: Theme.base
            }
        }

        // 4. Terzo cerchio alla fine (Settings)
        Rectangle {
            id: settings
            width: 26
            height: 26
            radius: width / 2
            color: Theme.surface2
            anchors.left: mainCircle.right
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter

            LucideIcon {
                anchors.centerIn: parent
                icon: "settings"
                size: 14
                color: Theme.base
            }
        }
    }
}