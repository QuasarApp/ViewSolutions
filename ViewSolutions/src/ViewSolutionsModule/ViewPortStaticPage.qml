//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15
import QtGraphicalEffects 1.15

ViewSolutionsControl {

    id: root

    property string source: ""
    property alias imageSource: image

    property var theme: Material.theme
    property string baseLigtColor: "fafafa"
    property string baseDarkColor: "242424"
    property string baseColor: (theme === Material.Dark)? baseDarkColor: baseLigtColor
    property int margins: 5

    property int textMargins: 10
    property int sourceTextPixelSize: 20
    property int headerTextPixelSize: 32

    property alias title: header.text
    property alias text: sourceText.text
    property alias headerFontColor: header.color
    property alias fontColor: sourceText.color

    Connections {
        target: imageSource

        function onStatusChanged(status) {
            if (status === Image.Ready) {
                background.color = colorPicker.pick(source);
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: colorPicker.pick(root.source);


        Image {
            id: image;
            source: root.source

            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            anchors.margins: margins
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: (parent.width / 2) - margins * 2
        }

    }

    content: Item {
        id: privatePage

        clip: true
        Label {
            id: header
            font.bold: true
            font.pixelSize: headerTextPixelSize

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
                verticalOffset: 2
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
            width: parent.width / 2

            wrapMode: Text.WordWrap
            anchors.bottom: parent.bottom
            anchors.top: header.bottom
            anchors.left: parent.left
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
