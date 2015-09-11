import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id: root
    width: 100
    height: 100

    property string name: model.name
    property bool isSelected: pathView.currentIndex === model.index
    property real fogAmount: PathView.iconFog

    z: PathView.iconZ
    scale: PathView.iconScale

    Image {
        id: shadowSource
        source: model.shadowIcon
        width: nmapItem.width
        height: nmapItem.height
        anchors.centerIn: nmapItem
        anchors.horizontalCenterOffset: ((root.x + root.width/2) - (lightSourceItem.width/2)) * 0.05
        anchors.verticalCenterOffset: ((root.y + root.height/2) - (lightSourceItem.height/2)) * 0.05 + (settings.spotAnimationPosition - 25) * (0.8 - fogAmount)
        opacity: 0.1 + (fogAmount*0.5)
        scale: 1.1 - (fogAmount*0.4)
    }

    NMapEffect {
        id: nmapItem
        sourceImage: model.sourceIcon
        normalsImage: model.normalsIcon
        lightSource: lightSourceItem
        switchX: true
        switchY: true
        elementPositionX: root.x
        elementPositionY: root.y
        colorizeAmount: fogAmount
        diffuseBoost: 0.8//0.5
    }

    ParticleSystem {                        // 这里将ParticleSystem作为ImageParticle、Emitter的父对象，它们就不再需要指定系统
        id: particles
        anchors.fill: parent
        opacity: 0.5
        ImageParticle {                     // 基本图像粒子
            source:  "/particle_image/particle.jpg"
            alpha: 0
            colorVariation: 0.6             // 0.6保证了丰富的色彩
        }

        Emitter {                           // 与上面的例子不同，这个粒子系统包含两个发射器
            id: clickEmitter
            x: parent.width/2               // 最主要的是，这里的Emitter没有了属性绑定，因此需要在定时器中手动调用burst和pulse
            y: parent.height/2
            emitRate: 800
            lifeSpan: 250
            enabled: false
            velocity: AngleDirection{magnitude: 200; angleVariation: 360}  // 这里使用了AngleDirection以使用角度定义粒子行为，magnitude指明了在该角度的每秒运动距离（像素），angleVariation使粒子方向随机从0到其大小之间产生。这里也就是一个圆
            size: 18
            sizeVariation: 12
        }
    }

    property bool is_click: false

    Timer{
        id: timer_click
        interval: 250
        onTriggered: timer_click.do_click()
        running: is_click
        repeat: false
        function do_click(){
            timer_click.stop()
            is_click = false
            switch(model.index){
            case 0: {//"Contacts"
                Qt.createComponent("../menu.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 1: {//"Friends"
                Qt.createComponent("test.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 2: {//"Files"
                Qt.createComponent("test.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 3: {//"Calendar"
                Qt.createComponent("Calendar.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 4: {//"Notes"
                Qt.createComponent("test.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 5: {//"Chat"
                Qt.createComponent("test.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 6: {//"Email"
                Qt.createComponent("test.qml").createObject(window1, {"color" : window1.color})
                break
            }
            case 7: {//"Seach"
                Qt.createComponent("test.qml").createObject(window1, {"color" : window1.color})
                break
            }
            default: break
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            window1.closeMenu()
            if (isSelected) {
                clickEmitter.burst(1000)
                is_click = true
            }
            else {
                clickEmitter.burst(1000)
                pathView.currentIndex = model.index;
            }
        }
    }

    function closeCurrentExample() {
            currentExample.destroy();
        }
}
