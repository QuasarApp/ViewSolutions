import QtQuick 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15
import QtGraphicalEffects 1.14


ViewPortPage {
    id: root

    Connections {
        target: imageSource

        function onStatusChanged(status) {
            if (status === Image.Ready) {
                background.color = colorPicker.pick(source);
            }
        }
    }

    background: Rectangle {
        color: colorPicker.pick(source)
        radius: 16
    }

    bloor: Rectangle {
        id: privateRoot
        color: "#00000000"
        border.color: "#" + baseColor
        border.width: 0
        radius: 16
        clip: true

        property var theme: Material.theme

        Rectangle {
            rotation: -90

            anchors.centerIn: parent
            radius: 16
            border.width: 4
            border.color: "#" + baseColor

            height: parent.width - privateRoot.border.width / 2
            width: parent.height - privateRoot.border.width / 2

            gradient: Gradient {
                GradientStop {
                    position: 0.50;
                    color: "#ff"+ baseColor;
                }

                GradientStop {
                    position: 0.70;
                    color: "#00" + baseColor;
                }
            }
        }

    }
    viewPortDelegatH: header.paintedHeight + header.anchors.bottomMargin + header.anchors.topMargin + sourceText.paintedHeight + sourceText.anchors.bottomMargin + sourceText.anchors.topMargin

    content: Item {
        id: privatePage

        clip: true
        TextEdit {
            id: header
            font.bold: true
            font.pixelSize: headerTextPixelSize
            text: title;
            color: fontColor

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            clip: true
            height: paintedHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: textMargins

            selectByMouse: true
            readOnly: true

            layer.effect: DropShadow {
                verticalOffset: 0
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }

        TextEdit {
            id: sourceText
            font.bold: false
            font.pixelSize: sourceTextPixelSize
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            width: parent.width / 2
            text: root.text
            color: fontColor
            readOnly: true
            selectByMouse: true
            textFormat: TextEdit.MarkdownText

            wrapMode: Text.WordWrap
            anchors.bottom: parent.bottom
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.horizontalCenter: parent.Center
            anchors.margins: textMargins

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 0
                color: "#80000000"
                radius: 1
                samples: 3
            }


        }
    }
}
