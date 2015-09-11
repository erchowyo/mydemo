import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0
import "content"

Item {
    id: mainView
    anchors.fill: parent

    property double out: 0
    property double opa_back: 0.5

    opacity: out

    Timer{
        id: timer_out
        interval: 10
        onTriggered:timer_out.changeout()
        running: true
        repeat: true
        function changeout(){
            do{
                window1.in_mode2()
            }while(0)

            out += 0.01
            if((1 - out)  < 0.01)
            {
                timer_out.destroy()
            }
        }
    }

    Image {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z: parent.z + 2
        width: 64
        height: 64
        source: "image/back.png"
        opacity: opa_back
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: opa_back = 1
            onExited: opa_back = 0.5
            acceptedButtons: Qt.LeftButton |  Qt.RightButton
            onClicked: {
                window1.close_mode2()
                window1.show_quit()
                mainView.destroy()
            }
        }
    }

    QtObject {
        id: settings
        property real spotAnimationPosition: 0.0//shanshuoxiaoguo
        SequentialAnimation on spotAnimationPosition {
            loops: Animation.Infinite
            NumberAnimation { to: 30; duration: 2000; easing.type: Easing.InOutQuad }//30  2000
            NumberAnimation { to: 0; duration: 2000; easing.type: Easing.InOutQuad }
        }
    }

    ContentModel {
        id: listModel
    }

    NMapLightSource {
        id: lightSourceItem
        z: 10
        lightPosX: mainView.width * 0.8
        lightPosY: mainView.height * 0.8 - settings.spotAnimationPosition * 8
        lightIntensity: 0.8//0.3
    }

    PathView {
        id: pathView
        anchors.fill: parent
        model: listModel
        delegate: ListItem {
            onIsSelectedChanged: {
                if (isSelected) {
                    nameTextItem.text = model.name
                }
            }
        }
        /*X Y select the menu  position */
        path: Path {
            startX: mainView.width*0.5
            startY: mainView.height*0.68
            PathAttribute { name: "iconScale"; value: 1.4 }
            PathAttribute { name: "iconZ"; value: 100.0 }
            PathAttribute { name: "iconFog"; value: 0.0 }
            PathQuad {
                x: mainView.width*0.5
                y: mainView.height*0.2
                controlX: mainView.width*0.85
                controlY: mainView.height*0.2
            }
            PathAttribute { name: "iconScale"; value: 0.8 }
            PathAttribute { name: "iconZ"; value: 1.0 }
            PathAttribute { name: "iconFog"; value: 0.5 }
            PathQuad {
                x: mainView.width*0.5
                y: mainView.height*0.68
                controlX: mainView.width*0.15
                controlY: mainView.height*0.2
            }
        }
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_Left) {
                pathView.decrementCurrentIndex();
                event.accepted = true;
            }
            if (event.key === Qt.Key_Right) {
                pathView.incrementCurrentIndex();
                event.accepted = true;
            }
        }
    }

    Text {
        id: nameTextItem
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.08
        font.pixelSize: 18
        color: "#d0d0d0"
        style: Text.Outline
        styleColor: "#404040"
        visible: true//false
    }

    DropShadow {
        anchors.fill: nameTextItem
        horizontalOffset: 0
        verticalOffset: settings.spotAnimationPosition * 0.5 - 18
        radius: 14.0
        samples: 16
        color: "#000000"
        source: nameTextItem
        opacity: 0.6
    }

    Image {
        id: right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 32                                 //parent.height * 0.01
        anchors.right: parent.right
        anchors.rightMargin: 150                                   //Math.max(8, parent.width * 0.15 - 100)
        source: "content/images/arrow-right.png"
        opacity: 0.5
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: right.opacity = 1
            onExited: right.opacity = 0.5
            onClicked :{
                window1.closeMenu()
                pathView.incrementCurrentIndex()  //mouse case
//                KeyNavigation.right: pathView.decrementCurrentIndex()               //do not need using
            }
        }
    }

    Image {
        id: left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 32                           //parent.height * 0.01
        anchors.left: parent.left
        anchors.leftMargin: 150                                 //Math.max(8, parent.width * 0.15 - 100)
        mirror: true
        source: "content/images/arrow-right.png"
        opacity: 0.5
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: left.opacity = 1
            onExited: left.opacity = 0.5
            onClicked :{
                window1.closeMenu()
                pathView.decrementCurrentIndex()  //mouse case
//                KeyNavigation.left:pathView.decrementCurrentIndex()               //do not need using
            }
        }
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 250
        source: "content/images/spot.png"
        transformOrigin: Item.BottomRight
        width: 128
        height: 64
        rotation: settings.spotAnimationPosition * 0.4
        opacity: 0.2
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -250
        source: "content/images/spot.png"
        mirror: true
        transformOrigin: Item.BottomLeft
        width: 128
        height: 64
        rotation: -settings.spotAnimationPosition * 0.4
        opacity: 0.2
    }

    FpsItem {
        id: fpsItem
    }
}
