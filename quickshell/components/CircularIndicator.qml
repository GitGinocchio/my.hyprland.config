import QtQuick
import QtQuick.Shapes
import Quickshell.Io
import "../theme"

Item {
    id: root
    property string icon: "sun"
    property real progress: 0.6 // Valore da 0.0 a 1.0
    property color activeColor: Theme.teal
    property color inactiveColor: Theme.surface1

    signal valueChanged(real newValue)

    width: 26
    height: 26

    // Anello di sfondo
    Shape {
        anchors.fill: parent
        rotation: -180

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.inactiveColor
            strokeWidth: 3
            strokeStyle: ShapePath.SolidLine
            capStyle: ShapePath.RoundCap

            startX: 13; startY: 13
            PathAngleArc {
                centerX: 13; centerY: 13
                radiusX: 10; radiusY: 10
                startAngle: 0
                sweepAngle: 180 
            }
        }
    }

    // Arco di progresso
    Shape {
        anchors.fill: parent
        rotation: -180

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.activeColor
            strokeWidth: 3
            strokeStyle: ShapePath.SolidLine
            capStyle: ShapePath.RoundCap

            startX: 13; startY: 13
            PathAngleArc {
                centerX: 13; centerY: 13
                radiusX: 10; radiusY: 10
                startAngle: 0
                sweepAngle: root.progress * 180 
            }
        }
    }

    // Icona centrale
    LucideIcon {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 2
        icon: root.icon
        size: 16
        color: Theme.text
    }

    // Processo per inviare la notifica di sistema su Hyprland
    Process {
        id: notifProc
        running: false
    }

    // MouseArea per catturare la rotellina
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onWheel: wheel => {
            let deltaY = wheel.angleDelta.y !== 0 ? wheel.angleDelta.y : wheel.pixelDelta.y;
            
            if (deltaY !== 0) {
                // Calcoliamo la percentuale attuale intera (da 0 a 100)
                let currentPercent = Math.round(root.progress * 100);
                
                // Determiniamo la direzione dello scroll (+1 o -1 scatto)
                let step = deltaY > 0 ? 5 : -5;
                
                // Calcoliamo la nuova percentuale clampata tra 5 e 100 (o 1 e 100)
                let newPercent = Math.max(5, Math.min(100, currentPercent + step));
                
                // Convertiamo in decimale per il service (da 0.05 a 1.0)
                let newProg = newPercent / 100.0;
                
                root.valueChanged(newProg);
                wheel.accepted = true;
                notifProc.running = true;
            }
        }
    }
}