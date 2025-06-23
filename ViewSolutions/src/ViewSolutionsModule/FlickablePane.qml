//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls

Flickable {
    property alias flicableContent: content.contentItem
    property alias padding: content.padding
    property alias leftPadding: content.leftPadding
    property alias rightPadding: content.rightPadding
    property alias bottomPadding: content.bottomPadding
    property alias topPadding: content.topPadding

    property int fade: 0
    id: settingsContentData

    boundsBehavior: Flickable.StopAtBounds
    Control {
        id: content
        topPadding: settingsContentData.fade
        bottomPadding: settingsContentData.fade
        width: settingsContentData.width
    }

    contentWidth: flicableContent.width
    contentHeight: flicableContent.height + fade * 2
    clip: true
}
