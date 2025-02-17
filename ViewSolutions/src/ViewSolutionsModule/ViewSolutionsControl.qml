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


Item {
    property alias background: backgroudFrame.contentItem
    property alias bloor: bloorFrame.contentItem
    property alias content: contentFrame.contentItem

    Control {
        id: backgroudFrame
        anchors.fill: parent;
        z: 0
    }

    Control {
        id: bloorFrame
        anchors.fill: parent;
        z: 1
    }

    Control {
        id: contentFrame
        anchors.fill: parent;
        z: 2
    }
}
