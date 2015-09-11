import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
//import org.qtproject.examples.calendar 1.0

Rectangle {
    id: mycalendar
    visible: true
    width: parent.width * 0.4
    height: parent.height * 0.8
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    color: "white"//"#f4f4f4"

    SystemPalette {
        id: systemPalette
    }

//    SqlEventModel {
//        id: eventModel
//    }

    Flow {
        id: row
        anchors.fill: parent
        layoutDirection: Qt.RightToLeft

        Calendar {
            id: calendar
            width: parent.width//(parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
            height: parent.height * 0.85//(parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
            frameVisible: true
            weekNumbersVisible: true
            focus: true

            style: CalendarStyle {
                dayDelegate: Item {
                    readonly property color sameMonthDateTextColor: "#444"
                    readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : systemPalette.highlight
                    readonly property color selectedDateTextColor: "white"
                    readonly property color differentMonthDateTextColor: "#bbb"
                    readonly property color invalidDatecolor: "#dddddd"

                    Rectangle {
                        anchors.fill: parent
                        border.color: "transparent"
                        color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                        anchors.margins: styleData.selected ? -1 : 0
                    }

//                    Image {
//                        visible: eventModel.eventsForDate(styleData.date).length > 0
//                        anchors.top: parent.top
//                        anchors.left: parent.left
//                        anchors.margins: -1
//                        width: 12
//                        height: width
//                        source: "qrc:/images/eventindicator.png"
//                    }

                    Label {
                        id: dayDelegateText
                        text: styleData.date.getDate()
                        anchors.centerIn: parent
                        color: {
                            var color = invalidDatecolor;
                            if (styleData.valid) {
                                // Date is within the valid range.
                                color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                                if (styleData.selected) {
                                    color = selectedDateTextColor;
                                }
                            }
                            color;
                        }
                    }
                }
            }

        }
        Rectangle{
            width: parent.width
            height: parent.height * 0.15

            Button{
                anchors.fill: parent
                text: "返回"
                onClicked: mycalendar.destroy()
            }
        }

        Component {
            id: eventListHeader

            Row {
                id: eventDateRow
                width: parent.width
                height: eventDayLabel.height
                spacing: 10

                Label {
                    id: eventDayLabel
                    text: calendar.selectedDate.getDate()
                    font.pointSize: 35
                }

                Column {
                    height: eventDayLabel.height

                    Label {
                        readonly property var options: { weekday: "long" }
                        text: Qt.locale().standaloneDayName(calendar.selectedDate.getDay(), Locale.LongFormat)
                        font.pointSize: 18
                    }
                    Label {
                        text: Qt.locale().standaloneMonthName(calendar.selectedDate.getMonth())
                              + calendar.selectedDate.toLocaleDateString(Qt.locale(), " yyyy")
                        font.pointSize: 12
                    }
                }
            }
        }

//        Rectangle {
//            width: (parent.width > parent.height ? parent.width * 0.4 - parent.spacing : parent.width)
//            height: (parent.height > parent.width ? parent.height * 0.4 - parent.spacing : parent.height)
//            border.color: Qt.darker(color, 1.2)

//            ListView {
//                id: eventsListView
//                spacing: 4
//                clip: true
//                header: eventListHeader
//                anchors.fill: parent
//                anchors.margins: 10
//                model: eventModel.eventsForDate(calendar.selectedDate)

//                delegate: Rectangle {
//                    width: eventsListView.width
//                    height: eventItemColumn.height
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    Image {
//                        anchors.top: parent.top
//                        anchors.topMargin: 4
//                        width: 12
//                        height: width
//                        source: "qrc:/images/eventindicator.png"
//                    }

//                    Rectangle {
//                        width: parent.width
//                        height: 1
//                        color: "#eee"
//                    }

//                    Column {
//                        id: eventItemColumn
//                        anchors.left: parent.left
//                        anchors.leftMargin: 20
//                        anchors.right: parent.right
//                        height: timeLabel.height + nameLabel.height + 8

//                        Label {
//                            id: nameLabel
//                            width: parent.width
//                            wrapMode: Text.Wrap
//                            text: modelData.name
//                        }
//                        Label {
//                            id: timeLabel
//                            width: parent.width
//                            wrapMode: Text.Wrap
//                            text: modelData.startDate.toLocaleTimeString(calendar.locale, Locale.ShortFormat)
//                            color: "#aaa"
//                        }
//                    }
//                }
//            }
 //       }
    }
}