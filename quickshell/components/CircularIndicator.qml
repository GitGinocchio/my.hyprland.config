import QtQuick
import QtQuick.Shapes
import "../theme"
import "."

Item {
    id: root
    property string icon: "sun"
    property real progress: 0.6 // Valore da 0.0 a 1.0
    property color activeColor: Theme.teal
    property color inactiveColor: Theme.surface1

    width: 26
    height: 26

    // Anello di sfondo (semicerchio superiore)
    Shape {
        anchors.fill: parent
        // Ruotiamo di -180 gradi per posizionare l'arco nella metà superiore
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
                // 180 gradi totali per fare esattamente mezza circonferenza (il semicerchio)
                sweepAngle: 180 
            }
        }
    }

    // Arco di progresso (semicerchio attivo basato su root.progress)
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
                // Il progresso scala l'ampiezza dell'arco fino a un massimo di 180° (semicerchio pieno)
                sweepAngle: root.progress * 180 
            }
        }
    }

    // Icona centrale leggermente spostata verso il basso per bilanciare il semicerchio superiore
    LucideIcon {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 2
        icon: root.icon
        size: 16
        color: Theme.text
    }
}