//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the lgplv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Control {
    id: root
    property alias source: image.source
    property alias color: effect.colorizationColor
    property alias colorization: effect.colorization

    contentItem: Image {
        id: image

        MultiEffect {
            id: effect
            anchors.fill: image
            colorization: 1

        }
    }
}
