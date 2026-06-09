//#
//# Copyright (C) 2025-2026 QuasarApp.
//# Distributed under the lgplv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Image {

    id: root
    property alias color: effect.colorizationColor
    property alias colorization: effect.colorization

    sourceSize.width: root.width
    sourceSize.height: root.height

    layer.enabled: true
    layer.effect : MultiEffect {
        id: effect
        colorization: 1

    }
}
