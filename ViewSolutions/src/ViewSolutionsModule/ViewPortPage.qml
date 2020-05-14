import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Universal 2.14
import QtGraphicalEffects 1.14


ViewPortDelegatBase {
    id: root
    property string title: ""
    property string text: ""
    property int textMargins: 10
    property int sourceTextPointSize: 20
    property int headerTextPointSize: 32

    property int additionalHeight: getBrCount(text) * sourceText.fontInfo.pixelSize + textMargins

    function getBrCount(text) {
        return (text.match(/<br>/g) || []).length;
    }

    viewPortDelegatH: header.height + sourceText.paintedHeight + additionalHeight

    background: Rectangle {
        color: "#00ffffff"
        border.color: "#a7777777"
        border.width: 4
        radius: height * 0.05
    }

    bloor: Rectangle {
        color: (Material.theme == Material.Dark)? "#55000000": "#55cdcdcd"
        border.color: "#a7777777"
        border.width: 0
        radius: height * 0.05
    }

    content: Item {
        id: privatePage

        clip: true
        Label {
            id: header
            font.bold: true
            font.pointSize: headerTextPointSize
            text: title;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            clip: true
            height: paintedHeight

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }

        Label {
            id: sourceText
            font.bold: false
            font.pointSize: sourceTextPointSize
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: root.text
            wrapMode: Text.WordWrap
            anchors.bottom: parent.bottom
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.horizontalCenter: parent.Center
            anchors.margins: textMargins

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }
    }


}
