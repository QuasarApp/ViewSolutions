//#
//# Copyright (C) 2025-2026 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick

// this effect make fade effect for left and right side of the item
//
ShaderEffect {
    property real leftFadePx: 25;
    property real rightFadePx: 25;
    property real leftFadePaddingPx: 2;
    property real rightFadePaddingPx: 2;

    property real topFadePx: 0;
    property real bottomFadePx: 0;
    property real topFadePaddingPx: 0;
    property real bottomFadePaddingPx: 0;

    required property real widthSource;
    required property real heightSource;

    fragmentShader: "qrc:/uieffects/shaders/fade.frag.qsb"
    vertexShader: "qrc:/uieffects/shaders/fade.vert.qsb"
}
