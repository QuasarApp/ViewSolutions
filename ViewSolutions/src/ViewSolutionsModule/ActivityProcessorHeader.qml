//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {

    id: root
    property int titlesAligh: Text.AlignHCenter

    property string title: ""
    property bool titleUppercase: true
    property bool backButton: false
    property bool closeButton: false

    signal backClicked()
    signal closeClicked()

    ToolButton {

        visible: root.backButton
        text: "<<"

        onClicked: {
            root.backClicked()
        }
    }

    Text {
        id: centralTitle
        text: (root.titleUppercase)? root.title.toUpperCase(): root.title
        horizontalAlignment: root.titlesAligh
        Layout.fillWidth: true;

    }

    ToolButton {
        Layout.alignment: Qt.AlignRight
        text: "x"
        onClicked: root.closeClicked()
        visible: root.closeButton

    }

}
