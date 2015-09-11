import QtQuick 2.0

Item {
    id: root
    property int frameCounter: 0
    property int fps: 0;

    width: 65//160
    height: 32//48

    Image {
        id: spinnerImage
        source: "images/spinner.png"
        width: 32
        height: 32
        NumberAnimation on rotation {
            from:0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }
        onRotationChanged: frameCounter++;
    }

    Text {
        anchors.right:    parent.right
        anchors.verticalCenter: spinnerImage.verticalCenter
        color: "white"// "#ffffff"//fill color
        style: Text.Outline
        styleColor: "#606060"   //round color
        font.pixelSize: 12            //word
        text: root.fps + " fps"
    }

    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {
            fps = frameCounter/2;
            frameCounter = 0;
        }
    }
}
