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
import QtQuick.Effects

AbstractButton {
    id: root
    property string source: ""
    property alias imagesource: sourceImg

    property real power: 1.0

    property string toolTip: ""

    property color textColor: Material.foreground
    property alias textVisible: content.visible
    property color backgroundColor: Material.background
    property color selectedColor: Material.accent
    property color hoverColor: Material.accent
    property alias contentData: content.contentItem

    Connections {
        target: sourceImg

        function onStatusChanged(status) {
            if (status === Image.Ready) {
                root.backgroundColor = colorPicker.pick(root.source);
            }
        }
    }

    hoverEnabled: true

    opacity: {
        if (enabled) {
            return 1
        }

        return 0.5
    }

    contentItem: Control {
        id: privateData
        property int rootMinSize: Math.min(root.height, root.width)
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
            color: {

                if (root.enabled) {
                    if (root.hovered) {
                        return root.hoverColor
                    }

                    if (root.checked) {
                        return root.selectedColor
                    }

                }


                return root.backgroundColor
            }
            radius: 16

            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }
        }

        contentItem: ColumnLayout {
            spacing: 0

            MultiEffect {
                id: imgEffect
                Layout.fillWidth: true
                Layout.fillHeight: true

                source: Image {
                    id: sourceImg
                    source: root.source

                    clip: true
                    fillMode: Image.PreserveAspectCrop

                    width: imgEffect.width
                    height: imgEffect.height
                }

                maskEnabled: true
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        radius: 16
                        width: imgEffect.width
                        height: imgEffect.height
                        color: "Black"

                        Rectangle {
                            color: "Black"
                            anchors.bottom: parent.bottom
                            height: 20
                            width: parent.width
                            visible: content.visible
                        }
                    }
                }
            }

            Control {
                id: content
                Layout.fillWidth: true
                padding: 8

                contentItem: Label {
                    text: root.text
                    visible: text.length
                    Layout.fillWidth: true
                    color: root.textColor
                    font: root.font
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                }
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
        visible: root.hovered && text.length
        text: root.toolTip
        delay: 500

    }


    MouseArea {
        acceptedButtons: Qt.NoButton
        hoverEnabled: true;

        onExited: {
            privateData.ry = 0
            privateData.rx = 0

        }

        onPositionChanged: (mouse) => {
                               if (root.enabled) {
                                   let fromCenter = root.width / 2
                                   privateData.ry = -((mouse.x - fromCenter) / (fromCenter * 0.05)) * root.power

                                   fromCenter = root.height / 2
                                   privateData.rx = ((mouse.y - fromCenter) / (fromCenter * 0.05)) * root.power

                               }
                           }

        anchors.fill: parent

    }


}
