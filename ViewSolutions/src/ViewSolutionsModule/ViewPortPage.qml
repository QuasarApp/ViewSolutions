import QtQuick 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15
import QtGraphicalEffects 1.14


ViewPortDelegatBase {
    id: root
    property string title: ""
    property string text: ""
    property int textMargins: 10
    property int sourceTextPixelSize: 20
    property int headerTextPixelSize: 32
    property color fontColor: ( Material.theme === Material.Light)? "#626465" : "#d2d5d8"

    property int additionalHeight: getBrCount(text) * sourceText.fontInfo.pixelSize + textMargins * 2

    function getBrCount(text) {
        return (text.match(/<br>/g) || []).length;
    }

    viewPortDelegatH: header.height + sourceText.paintedHeight + additionalHeight

    background: Rectangle {
        color: colorPicker.pick(source)
        border.color: "#" + baseColor
        border.width: 4
        radius: height * 0.05
    }

    bloor: Rectangle {
        color: "#77"+ baseColor
        border.color: "#" + baseColor
        border.width: 0
        radius: height * 0.05

    }

    content: Item {
        id: privatePage

        Component.onDestruction: {
            header.destroy()
            sourceText.destroy()
        }

        clip: true
        Label {
            id: header
            font.bold: true
            font.pixelSize: headerTextPixelSize
            color: fontColor
            text: title;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            clip: true
            height: paintedHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: textMargins

            layer.effect: DropShadow {
                verticalOffset: 0
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }

        Label {
            id: sourceText
            font.bold: false
            font.pixelSize: sourceTextPixelSize
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: root.text
            color: fontColor

            wrapMode: Text.WordWrap
            anchors.bottom: parent.bottom
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
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
