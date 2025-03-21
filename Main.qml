import QtQuick
import QtQuick.VirtualKeyboard

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        id:id_bg
        width: parent.width
        height: parent.height
        property color gradient_color: "#ff00ff"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00ff00" }
            GradientStop { position: 1.0; color: id_bg.gradient_color }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("Clicked")
        }
        Row {
            spacing: 2
            Repeater {
                model: 7
                Rectangle {
                    required property int index
                    property var colors: ["red","green","blue","#00ffff","#ffff00","#00ff00","#ff00ff"]
                    color:colors[index]; width: 50; height: 50; radius:25
                    border.color: "gray"
                    border.width: 1
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            id_bg.gradient_color=parent.colors[parent.index]
                        }
                    }
                }
            }
        }

        Text {
            id:id_cur_date_time
            anchors.right: parent.right
            font.pixelSize: 50
            color: "#FFFFFF"
            text: ""
            Timer{
                interval: 1000; running: true; repeat: true
                onTriggered: {
                    parent.text = qsTr(new Date().toLocaleString(Qt.locale("zh_CN")))
                }
            }
        }

        Text {
            id:id_blog_text
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            font.pixelSize: 30
            color: "#FFFFFF"
            text: qsTr("博客:https://blog.csdn.net/fittec?type=blog")
        }

        Text {
            id:id_tech_text
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pixelSize: 30
            color: "#FFFFFF"
            text: qsTr("基于WebAssembly Qt6.8.2 实现")

        }


        Timer {
            interval: 100; running: true; repeat: true
            property int r: 36
            onTriggered: {
                id_logo.rotation = (360-r)%360
                r=r+10
            }
        }
        Image {
            id: id_logo
            source: "qrc:/images/rpi.png"
            visible: true
            fillMode: Image.Stretch
            scale: 0.5
            anchors.centerIn: parent

        }
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
