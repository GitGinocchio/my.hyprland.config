import QtQuick

Background {
    id: clockRoot

    property string timeFormat: "dd/MM/yyyy hh:mm:ss"
    property color textColor: "#cdd6f4"
    property int pixelSize: 12
    property int fontWeight: 400
    
    // Proprietà per decidere se mostrare lo sfondo e l'hover
    property bool showBackground: true

    horizontalPadding: 10
    verticalPadding: 2

    // Se showBackground è false, azzeriamo i colori e disabilitiamo l'hover
    normalColor: showBackground ? "#1e1e2e" : "transparent"
    hoverColor: showBackground ? "#313244" : "transparent"
    borderColorNormal: "transparent"
    borderColorHover: showBackground ? "#585b70" : "transparent"
    enableHover: showBackground

    Text {
        id: timeText
        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), clockRoot.timeFormat)
        color: clockRoot.textColor
        font.pixelSize: clockRoot.pixelSize
        font.weight: clockRoot.fontWeight
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeText.text = Qt.formatDateTime(new Date(), clockRoot.timeFormat)
    }
}