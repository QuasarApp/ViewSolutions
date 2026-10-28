//#
//# Copyright (C) 2026-2026 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

pragma ComponentBehavior: Bound
import QtQuick


Item {
    id: root
    property real progress: 0.7
    property real lineWidth: 16
    required property GUITokens guiTokens

    property color color: root.guiTokens.color_accent_primary
    property color backgroundColor: root.guiTokens.color_border_secondary

    implicitWidth: 100
    implicitHeight: 100

    layer.enabled: true
    layer.effect: ShaderEffect {
        fragmentShader: "qrc:/uieffects/shaders/ringProgress.frag.qsb"

        property real progress: root.progress
        property real lineWidth: root.lineWidth

        property color color:  root.color
        property color backgroundColor: root.backgroundColor
    }
}
