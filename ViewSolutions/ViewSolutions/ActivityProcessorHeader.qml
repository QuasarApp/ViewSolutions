//#
//# Copyright (C) 2020-2026 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ToolBar {

    id: root
    property int titlesAlign: Text.AlignHCenter

    property string title: ""
    property bool titleUppercase: true
    property bool backButton: false
    property bool closeButton: false

    signal backClicked()
    signal closeClicked()

    contentItem: RowLayout {


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
            horizontalAlignment: root.titlesAlign
            Layout.fillWidth: true;

        }

        ToolButton {
            Layout.alignment: Qt.AlignRight
            text: "x"
            onClicked: root.closeClicked()
            visible: root.closeButton

        }

    }
}


