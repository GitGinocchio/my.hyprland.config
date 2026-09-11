import QtQuick

Item {
    id: calendarRoot
    width: 260
    height: 220

    property var currentDateTime: new Date()
    property int viewYear: currentDateTime.getFullYear()
    property int viewMonth: currentDateTime.getMonth() // 0-11

    // Array dei mesi e dei giorni della settimana abbreviati
    readonly property var monthNames: ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"]
    readonly property var weekDays: ["Lu", "Ma", "Me", "Gi", "Ve", "Sa", "Do"]

    // Calcola i giorni da mostrare nella griglia (inclusi i padding del mese precedente/successivo)
    function getDaysInMonth(year, month) {
        let days = [];
        
        // Primo giorno del mese
        let firstDay = new Date(year, month, 1);
        let lastDay = new Date(year, month + 1, 0);
        
        // Giorno della settimana del primo giorno (0 = Domenica, 1 = Lunedì, ecc.)
        // Vogliamo che la settimana inizi di Lunedì (0 = Lunedì, ..., 6 = Domenica)
        let startDayIndex = firstDay.getDay() === 0 ? 6 : firstDay.getDay() - 1;
        
        // Giorni del mese precedente per riempire la prima riga
        let prevMonthLastDay = new Date(year, month, 0).getDate();
        for (let i = startDayIndex - 1; i >= 0; i--) {
            days.push({
                day: prevMonthLastDay - i,
                isCurrentMonth: false,
                date: new Date(year, month - 1, prevMonthLastDay - i)
            });
        }
        
        // Giorni del mese corrente
        for (let i = 1; i <= lastDay.getDate(); i++) {
            days.push({
                day: i,
                isCurrentMonth: true,
                date: new Date(year, month, i)
            });
        }
        
        // Giorni del mese successivo per completare la griglia (fino a 42 celle / 6 righe)
        let totalCells = Math.ceil(days.length / 7) * 7;
        let nextMonthDay = 1;
        while (days.length < totalCells) {
            days.push({
                day: nextMonthDay,
                isCurrentMonth: false,
                date: new Date(year, month + 1, nextMonthDay)
            });
            nextMonthDay++;
        }
        
        return days;
    }

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        border.color: "#313244"
        border.width: 1
        radius: 12
        clip: true

        Column {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 10

            // Header: Mese, Anno e pulsanti cambio mese
            Row {
                width: parent.width
                height: 24

                Text {
                    text: monthNames[calendarRoot.viewMonth] + " " + calendarRoot.viewYear
                    color: "#cdd6f4"
                    font.pixelSize: 14
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: parent.width - x - 50; height: 1 } // Spaziatore

                // Pulsante Mese Precedente
                Text {
                    text: "‹"
                    color: "#a6adc8"
                    font.pixelSize: 16
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -4
                        onClicked: {
                            if (calendarRoot.viewMonth === 0) {
                                calendarRoot.viewMonth = 11;
                                calendarRoot.viewYear -= 1;
                            } else {
                                calendarRoot.viewMonth -= 1;
                            }
                        }
                    }
                }

                Item { width: 15; height: 1 }

                // Pulsante Mese Successivo
                Text {
                    text: "›"
                    color: "#a6adc8"
                    font.pixelSize: 16
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -4
                        onClicked: {
                            if (calendarRoot.viewMonth === 11) {
                                calendarRoot.viewMonth = 0;
                                calendarRoot.viewYear += 1;
                            } else {
                                calendarRoot.viewMonth += 1;
                            }
                        }
                    }
                }
            }

            // Intestazione giorni della settimana (Lu, Ma, Me...)
            Grid {
                columns: 7
                spacing: 4
                width: parent.width

                Repeater {
                    model: calendarRoot.weekDays
                    delegate: Item {
                        width: 31
                        height: 20
                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: "#6c7086"
                            font.pixelSize: 11
                            font.bold: true
                        }
                    }
                }
            }

            // Griglia dei giorni del mese
            Grid {
                columns: 7
                spacing: 4
                width: parent.width

                Repeater {
                    model: calendarRoot.getDaysInMonth(calendarRoot.viewYear, calendarRoot.viewMonth)

                    delegate: Rectangle {
                        width: 31
                        height: 26
                        radius: 6

                        // Evidenzia il giorno odierno
                        readonly property bool isToday: {
                            let today = new Date();
                            return modelData.date.getDate() === today.getDate() &&
                                   modelData.date.getMonth() === today.getMonth() &&
                                   modelData.date.getFullYear() === today.getFullYear();
                        }

                        color: isToday ? "#89b4fa" : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: modelData.day
                            color: {
                                if (parent.isToday) return "#1e1e2e";
                                if (!modelData.isCurrentMonth) return "#45475a";
                                return "#cdd6f4";
                            }
                            font.pixelSize: 12
                            font.bold: parent.isToday || modelData.isCurrentMonth
                        }
                    }
                }
            }
        }
    }
}