//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {

    id: root

    property alias extendableWidget: extendetArea.contentItem
    property alias mainWidget: mainButton.contentItem
    // see GridLayout
    property alias layoutDirection: columnLayout.layoutDirection
    property alias flow: columnLayout.flow

    property alias extended: extendetArea.visible
    property int animationDuration: 600

    Behavior on height {

        NumberAnimation {
            easing.type: Easing.OutExpo
            duration: root.animationDuration
        }
    }

    Behavior on width {
        enabled: root.flow === GridLayout.LeftToRight
        NumberAnimation {
            easing.type: Easing.OutExpo
            duration: root.animationDuration
        }
    }

    contentItem: GridLayout {
        id: columnLayout
        columnSpacing: 0
        rowSpacing: 0

        Control {
            id: extendetArea
            clip: true
            padding: 0
            Layout.alignment: Qt.AlignCenter


        }

        Control {
            Layout.alignment: Qt.AlignCenter
            padding: 0
            id: mainButton

        }
    }
}
