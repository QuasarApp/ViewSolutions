import QtQuick 2.14
import QtQuick.Layouts 1.14

Item {
    id: root
    property string soucre: ""
    property string text: ""
    property bool hover: false
    property bool presed: false

    property color background: "#00000000"
    property color borderColor: "#00000000"

    signal clicked(var mouse);

    Item {
        id: privateData
        property int rootMinSize: Math.min(root.height, root.width)
        anchors.margins: (root.hover && !presed)? rootMinSize * 0.01: rootMinSize * 0.1

        Behavior on anchors.margins {
            NumberAnimation {
                easing.type: Easing.OutExpo
                duration: 550
            }
        }

        anchors.fill: parent
        Rectangle {
            id: background
            color: root.background
            border.color: (root.hover)? root.borderColor: "#00000000"
            border.width: 4
            anchors.fill: parent
            radius: border.width * 2

            Behavior on border.color {
                ColorAnimation {
                    duration: 250
                }
            }

        }

        ColumnLayout {
            Image {
                id: source
                source: root.soucre

                clip: true
                property real rx : 0
                property real ry : 0
                property real rz : 0
                fillMode: Image.PreserveAspectFit
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: 10
                transform: [
                    Rotation {
                        axis { x: 0; y: 0; z: 1 }
                        origin { x: root.width / 2; y: root.height / 2; z: 0 }
                        angle: source.rz
                    },
                    Rotation {
                        axis { x: 0; y: 1; z: 0 }
                        origin { x: root.width / 2; y: root.height / 2; z: 0 }
                        angle: source.ry
                    },
                    Rotation {
                        axis { x: 1; y: 0; z: 0 }
                        origin { x: root.width / 2; y: root.height / 2; z: 0 }
                        angle: source.rx
                    }
                ]
            }

            Text {
                text: root.text
                Layout.preferredHeight: root.height * 0.1
                Layout.fillWidth: true
                font.pixelSize: root.height * 0.05
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }
            anchors.fill: parent
        }

        MouseArea {

            hoverEnabled: true;

            onEntered: {
                hover = true
            }

            onExited: {
                hover = false;
                source.ry = 0
                source.rx = 0

            }

            onMouseXChanged: {
                const fromCenter = root.width / 2
                source.ry = -((mouse.x - fromCenter) / (fromCenter * 0.05))

            }
            onMouseYChanged: {
                const fromCenter = root.height / 2

                source.rx = ((mouse.y - fromCenter) / (fromCenter * 0.05))
            }

            onPressed: {
                presed = true;
            }

            onReleased: {
                presed = false;

                root.clicked(mouse)
            }

            anchors.fill: parent

        }
    }

}
