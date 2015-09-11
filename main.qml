import QtQuick 2.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

Window {
    id: window1
    visible: true
    color: "black"
    opacity: out
    maximumHeight: 336
    maximumWidth: 1024
    minimumHeight: 336
    minimumWidth: 1024
    flags:Qt.FramelessWindowHint
    x: (Screen.desktopAvailableWidth - 1024) / 2; y: (Screen.desktopAvailableHeight - 336) / 2

    property double value_opacity: 0.7
    property bool first_view: false
    property bool second_view_2: false
    property bool second_view_3: false
    property bool second_view_4: false
    property bool second_view_5: false
    property bool press_menu_view: false
    property int openness: 0
    property bool is_second: false
    property int flag: 0
    property int current_view: 0
    property double out: 1
    property bool go_out: false
    property bool is_mode2: false
    property double opa_mode2: 1
    property var lock_mode2: null

    Timer{
        interval: 0
        onTriggered: Qt.createComponent("start.qml").createObject(window1, {"color" : window1.color})
        running: true
        repeat: false
    }

    Timer{
        id: timer_out
        interval: 10
        onTriggered:timer_out.changeout()
        running: go_out
        repeat: true
        function changeout(){
            out += 0.01
            if((1 - out)  < 0.01)
            {
                timer_out.destroy()
            }
        }
    }

    Text {
        id: time
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pointSize: 12
        color: "white"
        z: parent.z + 1

        Timer {
            interval: 500; running: true; repeat: true
            onTriggered: time.text = Qt.formatDateTime(new Date(), "yyyy年MM月dd日    dddd    hh:mm:ss")
        }
    }

    //    Text {
    //        id: clue;
    //        text: "华安鑫创内部测试程序"
    //        style: Text.Normal
    //        font.italic: true
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        anchors.top: parent.top
    //        anchors.topMargin: 50
    //        font.pointSize: 18
    //        font.family: "Verdana"
    //        color: "white"
    //        opacity: opa_mode2
    //    }

    property string back_pic: "/image/background.jpg"
    Image {
        id: background
        source: back_pic
        anchors.fill: parent
        width: parent.width
        height: parent.height
        opacity: opa_mode2
        z:-3

        MouseArea{
            // enabled: is_mode2
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            hoverEnabled: true
            onEntered: {
                if(!is_second){
                    press_menu.currentIndex = -1
                    examples2_2.currentIndex = -1
                    examples2_3.currentIndex = -1
                    examples2_4.currentIndex = -1
                    examples2_5.currentIndex = -1
                }
            }

            onClicked: {
                window1.closeMenu()
            }
            onPressAndHold: {
                press_menu_view = true
            }
        }
    }

    Component {
        id: exampleDelegate;
        Rectangle {
            id: wrapper;
            width: parent.width;
            height: 40;
            color: "transparent";
            border.color: "grey"

            Text {
                anchors.fill: parent;
                text: name;
                color: wrapper.ListView.isCurrentItem ? "white" : "black"                          //"blue" : "steelblue";
                font.pointSize: 12;
                verticalAlignment: Text.AlignVCenter;
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true
                onEntered: {
                    if(is_second) {
                        if(flag == 2) {
                            second_view_2 = true;
                            second_view_3 = false;
                            second_view_4 = false;
                            second_view_5 = false;
                            examples2_2.currentIndex = -1
                        }
                        else if(flag == 3){
                            second_view_2 = false;
                            second_view_3 = true;
                            second_view_4 = false;
                            second_view_5 = false;
                            examples2_3.currentIndex = -1
                        }
                        else if(flag == 4){
                            second_view_2 = false;
                            second_view_3 = false;
                            second_view_4 = true;
                            second_view_5 = false;
                            examples2_4.currentIndex = -1
                        }
                        else if(flag == 5){
                            second_view_2 = false;
                            second_view_3 = false;
                            second_view_4 = false;
                            second_view_5 = true;
                            examples2_5.currentIndex = -1
                        }
                    }
                    else if(flag == 1) {
                        second_view_2 = false;
                        second_view_3 = false;
                        second_view_4 = false;
                        second_view_5 = false;
                    }
                    wrapper.ListView.view.currentIndex = index;
                }
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if(!is_second){
                        first_view = false;
                        second_view_2 = false;
                        second_view_3 = false;
                        second_view_4 = false;
                        second_view_5 = false;
                        press_menu_view = false
                        visible_quit = false;

                        var data

                        if(current_view == 1){
                            if(flag == 6){
                                Qt.quit();
                            }
                            else{
                                data = examples.model.get(examples.currentIndex);
                                console.log("example: " , data.example);
                                Qt.createComponent(data.example).createObject(window1, {"color" : window1.color});
                            }
                        }
                        else if(current_view == 2){
                            if(is_mode2){
                                lock_mode2.destroy()
                                window1.close_mode2()
                                window1.show_quit()
                            }
                            else
                            {
                                data = examples2_2.model.get(examples2_2.currentIndex);
                                console.log("example: " , data.example);
                                lock_mode2 = Qt.createComponent(data.example).createObject(window1, {"color" : window1.color});
                            }
                        }
                        else if(current_view == 3){
                            data = examples2_3.model.get(examples2_3.currentIndex);
                            console.log("example: " , data.example);
                            Qt.createComponent(data.example).createObject(window1, {"color" : window1.color});
                        }
                        else if(current_view == 4){
                            data = examples2_4.model.get(examples2_4.currentIndex);
                            console.log("example: " , data.example);
                            Qt.createComponent(data.example).createObject(window1, {"color" : window1.color});
                        }
                        else if(current_view == 5){
                            data = examples2_5.model.get(examples2_5.currentIndex);
                            console.log("example: " , data.example);
                            Qt.createComponent(data.example).createObject(window1, {"color" : window1.color});
                        }
                        else if(current_view == 6){
                            data = press_menu.model.get(press_menu.currentIndex);
                            console.log("example: " , data.example);
                            Qt.createComponent(data.example).createObject(window1, {"color" : window1.color});
                        }
                    }
                }
            }
        }
    }

    ListView{
        id: press_menu
        width: 100
        height: 110
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: press_menu_view
        delegate: exampleDelegate
        highlight: Rectangle {
            anchors.fill: parent
            color: "#FFF0F5"
            opacity: 0.35
        }
        model: ListModel {
            ListElement {
                name: "更改背景图片"
                example: "Change_Background.qml"
                current_view: 6
            }
            ListElement {
                name: "更改背景图片"
                example: "Change_Background.qml"
                current_view: 6
            }
            ListElement {
                name: "       菜单"
                example: "menu.qml"
                current_view: 6
            }
        }
    }

    ListView {
        id: examples;
        width: 120
        height: 200
        visible: first_view
        z: 1
        anchors.bottomMargin: 32
        anchors.bottom: parent.bottom
        anchors.margins: 8;
        clip: true;
        delegate: exampleDelegate;
        highlight: Rectangle {
            anchors.fill: parent
            color: "#FFF0F5";
            opacity: 0.35
        }
        model: ListModel {
            ListElement {
                name: "开机动画演示";
                example: "play.qml";
                flag:1;
                current_view: 1;
            }
            ListElement {
                name: "第一级菜单-2 ->";
                flag:2;
                is_second: true;
                current_view: 1;
            }
            ListElement {
                name: "第一级菜单-3  ->";
                flag:3;
                is_second: true;
                current_view: 1;
            }
            ListElement {
                name: "第一级菜单-4  ->";
                flag:4;
                is_second: true;
                current_view: 1;
            }
            ListElement {
                name: "第一级菜单-5  ->";
                flag:5;
                is_second: true;
                current_view: 1;
            }
            ListElement {
                name: "退出";
                flag:6;
                current_view: 1;
            }
        }
    }

    ListView {
        id: examples2_2;
        width: 120
        height: 170
        visible: second_view_2
        anchors.left: parent.left
        anchors.leftMargin: 120
        z: 1
        anchors.bottomMargin: 22
        anchors.bottom: parent.bottom
        anchors.margins: 8;
        clip: true;
        delegate: exampleDelegate;
        highlight: Rectangle {
            anchors.fill: parent
            color: "#FFF0F5";
            opacity: 0.35
        }
        model: ListModel {
            id: check_mode
            ListElement {
                name: "    交替显示演示";
                example: "replace.qml";
                is_second: false;
                current_view: 2;
            }
            ListElement {
                name: "    打开图形菜单";
                example: "Qt5_NMap_CarouselDemo.qml";
                is_second: false;
                current_view: 2;
            }
            ListElement {
                name: "    更改背景图片";
                example: "Change_Background.qml";
                is_second: false;
                current_view: 2;
            }
            ListElement {
                name: "    第二级菜单-4";
                example: "GradientExample.qml";
                is_second: false;
                current_view: 2;
            }
        }
    }

    ListView {
        id: examples2_3;
        x: 120
        y: 166
        width: 120
        height: 135
        visible: second_view_3
        anchors.left: parent.left
        anchors.leftMargin: 120
        z: 1
        anchors.bottomMargin: 17
        anchors.bottom: parent.bottom
        anchors.margins: 8;
        clip: true;
        delegate: exampleDelegate;
        highlight: Rectangle {
            anchors.fill: parent
            color: "#FFF0F5";
            opacity: 0.35
        }
        model: ListModel {
            ListElement {
                name: "    第二级菜单-1";
                example: "play.qml";
                is_second: false;
                current_view: 3;
            }
            ListElement {
                name: "    第二级菜单-2";
                example: "ColorExample.qml";
                is_second: false;
                current_view: 3;
            }
            ListElement {
                name: "    第二级菜单-3";
                example: "GradientExample.qml";
                is_second: false;
                current_view: 3;
            }
            ListElement {
                name: "    第二级菜单-4";
                example: "DistortionExample.qml";
                is_second: false;
                current_view: 3;
            }
        }
    }

    ListView {
        id: examples2_4;
        x: 120
        y: 166
        width: 120
        height: 170
        visible: second_view_4
        anchors.left: parent.left
        anchors.leftMargin: 120
        z: 1
        anchors.bottomMargin: 62
        anchors.bottom: parent.bottom
        anchors.margins: 8;
        clip: true;
        delegate: exampleDelegate;
        highlight: Rectangle {
            anchors.fill: parent
            color: "#FFF0F5";
            opacity: 0.35
        }
        model: ListModel {
            ListElement {
                name: "    第二级菜单-1";
                example: "play.qml";
                is_second: false;
                current_view: 4;
            }
            ListElement {
                name: "    第二级菜单-2";
                example: "ColorExample.qml";
                is_second: false;
                current_view: 4;
            }
            ListElement {
                name: "    第二级菜单-3";
                example: "GradientExample.qml";
                is_second: false;
                current_view: 4;
            }
            ListElement {
                name: "    第二级菜单-4";
                example: "DistortionExample.qml";
                is_second: false;
                current_view: 4;
            }
        }
    }

    ListView {
        id: examples2_5;
        x: 120
        y: 166
        width: 120
        height: 170
        visible: second_view_5
        anchors.left: parent.left
        anchors.leftMargin: 120
        z: 1
        anchors.bottomMargin: 22
        anchors.bottom: parent.bottom
        anchors.margins: 8;
        clip: true;
        delegate: exampleDelegate;
        highlight: Rectangle {
            anchors.fill: parent
            color: "#FFF0F5";
            opacity: 0.35
        }
        model: ListModel {
            ListElement {
                name: "    第二级菜单-1";
                example: "play.qml";
                is_second: false;
                current_view: 5;
            }
            ListElement {
                name: "    第二级菜单-2";
                example: "ColorExample.qml";
                is_second: false;
                current_view: 5;
            }
            ListElement {
                name: "    第二级菜单-3";
                example: "GradientExample.qml";
                is_second: false;
                current_view: 5;
            }
            ListElement {
                name: "    第二级菜单-4";
                example: "DistortionExample.qml";
                is_second: false;
                current_view: 5;
            }
        }
    }

    function closeMenu(){
        first_view = false;
        second_view_2 = false;
        second_view_3 = false;
        second_view_4 = false;
        second_view_5 = false;
        press_menu_view = false;
    }

    function start_goout(){
        out = 0
        go_out = true
    }

    function in_mode2(){
        is_mode2 = true
        opa_mode2 = 0.7
        check_mode.set(1, {"name" : "    关闭图形菜单"})
    }

    function close_mode2(){
        is_mode2 = false
        opa_mode2 = 1
        check_mode.set(1, {"name" : "    打开图形菜单"})
    }

    function show_quit(){
        if(!is_mode2){
            visible_quit = true
        }
    }

    function set_background(pic){
        back_pic = pic
    }

    Image {
        width: 32
        height: 32
        fillMode: Image.TileHorizontally
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        source: "/image/icon_5.png"
        z: 2

        opacity: value_opacity

        MouseArea {
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            transformOrigin: Item.BottomLeft
            hoverEnabled: true
            onEntered: {
                value_opacity=1
            }
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onExited: {
                value_opacity=0.7
            }
            onClicked: {
                first_view = !first_view
                is_second = false
                second_view_2  = false
                second_view_3 = false
                second_view_4 = false
                second_view_5 = false
            }
        }
    }

    property double show: 0.5
    property bool visible_quit: true

    Image {
        id: quit
        source: "image/quit.png"
        width: 45
        height: 36
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom

        opacity: show
        visible: visible_quit

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                show = 1
            }
            onExited: {
                show = 0.7
            }
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                Qt.quit()
            }
        }
    }
}
