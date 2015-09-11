import QtQuick 2.0

Rectangle {
    id:replace
    anchors.fill: parent
    color: "black"
    z:2

    property bool change: true

    Image {
        id: picture_1
        width: (parent.width - 60) / 2
        height: parent.height - 80
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "image/picture_1.jpg"
        visible: change
    }

    Image {
        id: picture_2
        width: (parent.width - 60) / 2
        height: parent.height - 80
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "image/picture_2.jpg"
        visible: !change
    }

    Text {
        id: text1
        color: "white"
        text: qsTr("点击任意键返回桌面")
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.4
        anchors.top: parent.top
       anchors.topMargin: 10
        z: 2
        font.family: "Courier"
        styleColor: "#00000000"
        wrapMode: Text.WordWrap
        font.pixelSize: 20
    }

    Timer{
        id:timer_change
        interval: 500
        onTriggered: change = !change
        running: true
        repeat: true
    }

    MouseArea {
        id: mouseArea1
        anchors.fill: parent

        acceptedButtons: "AllButtons"
        onClicked: {
            window1.show_quit()
            timer_change.stop()
            replace.destroy()
        }
    }
}

