import QtQuick 2.0
import QtQuick.Window 2.1

Rectangle  {
    id:start;
    visible: true
    anchors.fill: parent
    z: parent.z + 2

    property string path: "/start_image/"
    property string suffix: ".bmp"
    property int index: 1
    property string image: path + index.toString() + suffix

    Image {
        anchors.fill: parent
        source: image

        Timer{
            id: timer_start
            interval: 150
            onTriggered: start.do_start()
            running: true
            repeat: true
        }
    }

    function do_start(){
        index++
        image = path + index.toString() + suffix
        if(index == 22){
            window1.start_goout()
            timer_start.stop()
            start.destroy()
        }
    }
}

