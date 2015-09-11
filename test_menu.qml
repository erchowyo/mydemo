import QtQuick 2.0

Rectangle {
    id: rec_menu
    width: parent.width * 0.5
    height: parent.height * 0.8
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    color: "#8A2BE2"
    opacity: 0.7

    Rectangle{
        width: 60
        height: 35
        anchors.horizontalCenter: parent.horizontalCenter
        color: parent.color

        Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 18
            font.family: "Verdana"
            text: qsTr("菜单")
            color: "white"
        }
    }

    Rectangle{
        id: rec_menu_1
        width: parent.width / 9
        height: parent.height / 3.5
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 8
        anchors.top: parent.top
        anchors.topMargin: parent.height / 5
        color: parent.color

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                 Qt.createComponent("play.qml").createObject(window1, {"color" : window1.color})
            }
        }

        Image {
            id: pic_menu_1
            source: "/image/icon_4.png"
            width: parent.width
            height: parent.width
        }

        Text {
            id: name_menu_1
            text: qsTr("     test")
            width: parent.width
            height: parent.height - pic_menu_1.height
            anchors.bottom: parent.bottom
            color: "white"
        }
    }

    Rectangle{
        id: rec_menu_2
        width: parent.width / 9
        height: parent.height / 3.5
        anchors.left: rec_menu_1.right
        anchors.leftMargin: parent.width / 10
        anchors.top: parent.top
        anchors.topMargin: parent.height / 5
        color: parent.color

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                 window1.show_quit()
                rec_menu.destroy()
            }
        }

        Image {
            id: pic_menu_2
            source: "/image/icon_4.png"
            width: parent.width
            height: parent.width
        }

        Text {
            id: name_menu_2
            text: qsTr("     test")
            width: parent.width
            height: parent.height - pic_menu_1.height
            anchors.bottom: parent.bottom
            color: "white"
        }
    }

    Rectangle{
        id: rec_menu_3
        width: parent.width / 9
        height: parent.height / 3.5
        anchors.left: rec_menu_2.right
        anchors.leftMargin: parent.width / 10
        anchors.top: parent.top
        anchors.topMargin: parent.height / 5
        color: parent.color

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                 window1.show_quit()
                rec_menu.destroy()
            }
        }

        Image {
            id: pic_menu_3
            source: "/image/icon_4.png"
            width: parent.width
            height: parent.width
        }

        Text {
            id: name_menu_3
            text: qsTr("     test")
            width: parent.width
            height: parent.height - pic_menu_1.height
            anchors.bottom: parent.bottom
            color: "white"
        }
    }

    Rectangle{
        id: rec_menu_4
        width: parent.width / 9
        height: parent.height / 3.5
        anchors.left: rec_menu_3.right
        anchors.leftMargin: parent.width / 10
        anchors.top: parent.top
        anchors.topMargin: parent.height / 5
        color: parent.color

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                 window1.show_quit()
                rec_menu.destroy()
            }
        }

        Image {
            id: pic_menu_4
            source: "/image/icon_4.png"
            width: parent.width
            height: parent.width
        }

        Text {
            id: name_menu_4
            text: qsTr("     test")
            width: parent.width
            height: parent.height - pic_menu_1.height
            anchors.bottom: parent.bottom
            color: "white"
        }
    }

    Rectangle{
        id: rec_menu_5
        width: parent.width / 9
        height: parent.height / 3.5
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 8
        color: parent.color

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                 window1.show_quit()
                rec_menu.destroy()
            }
        }

        Image {
            id: pic_menu_5
            source: "/image/icon_4.png"
            width: parent.width
            height: parent.width
        }

        Text {
            id: name_menu_5
            text: qsTr("     test")
            width: parent.width
            height: parent.height - pic_menu_1.height
            anchors.bottom: parent.bottom
            color: "white"
        }
    }

    Rectangle{
        id: rec_menu_6
        width: parent.width / 9
        height: parent.height / 3.5
        anchors.left: rec_menu_5.right
        anchors.leftMargin: parent.width / 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 8
        color: parent.color

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                 Qt.quit()
            }
        }

        Image {
            id: pic_menu_6
            source: "/image/icon_4.png"
            width: parent.width
            height: parent.width
        }

        Text {
            id: name_menu_6
            text: qsTr("     退出")
            width: parent.width
            height: parent.height - pic_menu_1.height
            anchors.bottom: parent.bottom
            color: "white"
        }
    }
}

