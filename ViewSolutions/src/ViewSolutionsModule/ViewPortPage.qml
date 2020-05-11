import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Universal 2.14

ViewPortDelegatBase {
    id: root
    property string title: ""
    property string text: ""


    background: Rectangle {
        color: "#00ffffff"
        border.color: "#a7777777"
        border.width: 4
        radius: height * 0.01
    }

    bloor: Rectangle {
        color: "#55ffffff"
        border.color: "#a7777777"
        border.width: 4
        radius: height * 0.01
    }

    content: Item {
        Label {
            id: header
            font.bold: true
            font.pixelSize: height * 0.5
            text: title;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap

            height: parent.height * 0.2

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Label {
            id: sourceText
            font.bold: false
            font.pixelSize: header.font.pixelSize * 0.5
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: root.text
            wrapMode: Text.WordWrap
            anchors.bottom: parent.bottom
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.horizontalCenter: parent.Center
        }
    }
}
