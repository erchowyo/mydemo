import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id:change_background
    anchors.fill: parent
    color: "black"
    z:2

    property string path: "/background_image/Heise"
    property string suffix: ".jpg"
    property int index: 1
    property string image: path + index.toString() + suffix

    Image {
        id: preview
        width: parent.width
        height: parent.height * 0.85
        anchors.right: parent.right
        source: image
        visible: true
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                if(mouse.button === Qt.LeftButton)
                    change_background.next_pic()
                else
                    change_background.prev_pic()
            }
        }
    }

    MessageDialog {
        id: confirm_change
        title: "确认"
        icon: StandardIcon.Question
        text: "是否保存修改？"
        standardButtons: StandardButton.Yes | StandardButton.No
        modality: Qt.ApplicationModal
        onYes: {
            window1.set_background(image)
            window1.show_quit()
            change_background.destroy()
        }
        onNo: {
            window1.show_quit()
            change_background.destroy()
        }
    }

    Button{
        width: parent.width / 3
        height: parent.height - preview.height
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        text: "上一张"
        onClicked: {
            change_background.prev_pic()
        }
    }

    Button{
        width: parent.width / 3
        height: parent.height - preview.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: "返回"
        onClicked: {
           confirm_change.open()
        }
    }

    Button{
        width: parent.width / 3
        height: parent.height - preview.height
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "下一张"
        onClicked: {
            change_background.next_pic()
        }
    }

    function next_pic(){
        if(index == 20) index = 1
        else index++
    }
    function prev_pic(){
        if(index == 1) index = 20
        else index--
    }
}



