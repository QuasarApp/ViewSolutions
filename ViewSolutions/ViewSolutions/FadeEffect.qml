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
    property point leftRightFadeStart: Qt.vector2d(0.25, 0.75);
    property point leftRightFadeEnd: Qt.vector2d(0.0, 1.0);

    fragmentShader: "qrc:/uieffects/shaders/fade.frag.qsb"
    vertexShader: "qrc:/uieffects/shaders/fade.vert.qsb"
}
