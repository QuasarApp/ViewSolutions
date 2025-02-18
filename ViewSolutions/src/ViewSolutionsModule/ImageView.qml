//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Universal

Control {
    id: root
    property string source: ""
    property alias imagesource: sourceImg

    property string text: ""
    property bool hover: false
    property bool presed: false
    property bool selected: false

    property real power: 1.0

    property string toolTip: ""

    property color textColor: Material.color(Material.Grey)

    property color backgroundColor: colorPicker.pick(source)
    property color selectedColor: "#5de2ff"
    property color borderColor: "#00000000"
    property color hoverColor: "#00000000"

    signal clicked(var mouse);

    Connections {
        target: sourceImg

        function onStatusChanged(status) {
            if (status === Image.Ready) {
                root.backgroundColor = colorPicker.pick(source);
            }
        }
    }

    contentItem: Control {
        id: privateData
        property int rootMinSize: Math.min(root.height, root.width)
        anchors.margins: (root.hover && !presed)? rootMinSize * 0.01: rootMinSize * 0.1

        property real rx : 0
        property real ry : 0
        property real rz : 0

        Behavior on anchors.margins {
            NumberAnimation {
                easing.type: Easing.OutExpo
                duration: 550
            }
        }

        Behavior on rx {
            NumberAnimation {
                easing.type: Easing.OutExpo
                duration: 550
            }
        }

        Behavior on ry {
            NumberAnimation {
                easing.type: Easing.OutExpo
                duration: 550
            }
        }

        Behavior on rz {
            NumberAnimation {
                easing.type: Easing.OutExpo
                duration: 550
            }
        }

        background: Rectangle {
            color: root.backgroundColor
            border.color: (root.hover)? root.hoverColor: root.selected? root.selectedColor: "#00000000"
            border.width: 4
            radius: border.width * 2

            Behavior on border.color {
                ColorAnimation {
                    duration: 250
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }

        contentItem: ColumnLayout {
            Image {
                id: sourceImg
                source: root.source

                clip: true
                fillMode: Image.PreserveAspectCrop
                mipmap: true
                smooth: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: 4



            }

            Label {
                text: root.text
                visible: text.length
                Layout.fillWidth: true
                color: root.textColor
                font: root.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }
        }

        transform: [
            Rotation {
                axis { x: 0; y: 0; z: 1 }
                origin { x: root.width / 2; y: root.height / 2; z: 0 }
                angle: privateData.rz
            },
            Rotation {
                axis { x: 0; y: 1; z: 0 }
                origin { x: root.width / 2; y: root.height / 2; z: 0 }
                angle: privateData.ry
            },
            Rotation {
                axis { x: 1; y: 0; z: 0 }
                origin { x: root.width / 2; y: root.height / 2; z: 0 }
                angle: privateData.rx
            }
        ]
    }

    ToolTip {
        parent: root
        visible: root.hover && text.length
        text: root.toolTip
        delay: 500

    }


    MouseArea {

        hoverEnabled: true;

        onEntered: {
            root.hover = true
        }

        onExited: {
            root.hover = false;
            privateData.ry = 0
            privateData.rx = 0

        }

        onPositionChanged: (mouse) => {
            let fromCenter = root.width / 2
            privateData.ry = -((mouse.x - fromCenter) / (fromCenter * 0.05)) * root.power

            fromCenter = root.height / 2
            privateData.rx = ((mouse.y - fromCenter) / (fromCenter * 0.05)) * root.power

        }

        onPressed: {
            root.presed = true;
        }

        onReleased: (mouse) => {
            root.presed = false;

            root.clicked(mouse)
        }

        anchors.fill: parent

    }


}
