//#
//# Copyright (C) 2020-2026 QuasarApp.
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

Control {
    id: root
    property string source: ""
    property string text: ""

    property alias imagesource: sourceImg
    property alias imagEffect: imgEffect
    property int  radius: 16

    property string toolTip: ""

    property color textColor: Material.foreground
    property alias textVisible: content.visible
    property color backgroundColor: Material.background
    property color selectedColor: Material.accent
    property color hoverColor: Material.accent
    property alias contentData: content.contentItem
    property alias contentPadding: content.padding


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
            radius: root.radius

            border.width: {
                if (root.focus) {
                    return 2;
                }

                return 0;
            }
            border.color: root.hoverColor

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
                    mipmap: false
                    sourceSize: Qt.size(imgEffect.width, imgEffect.height)

                    clip: true
                    fillMode: Image.PreserveAspectCrop

                    width: imgEffect.width
                    height: imgEffect.height
                }

                maskEnabled: true
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        radius: root.radius
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
                    Layout.fillWidth: true
                    color: root.textColor
                    font: root.font
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                }
            }

        }
    }

    ToolTip {
        parent: root
        visible: root.hovered && text.length
        text: root.toolTip
        delay: 500

    }


}
