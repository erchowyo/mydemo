import QtQuick 2.0
import QtQuick.Window 2.1

Rectangle {
    id:test
    anchors.fill: parent;
    z: 2

    property string path: "file:///home/null/mywork/mission/start_image/"
    property string suffix: ".bmp"
    property int index: 1
    property string image: path + index.toString() + suffix

    Image {
        anchors.fill: parent
        source: image

        Timer{
            id: timer_test
            interval: 150
            onTriggered: test.gotoplay()
            running: true
            repeat: true
        }
    }

    function gotoplay(){
        index++
        image = path + index.toString() + suffix
        if(index == 22){
            timer_test.stop()
            test.destroy()
        }
   }
}
