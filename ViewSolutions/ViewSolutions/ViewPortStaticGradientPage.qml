//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Universal

ViewPortStaticPage {

    bloor: Item {
        id: privateRoot
        clip: true

        property var theme: Material.theme

        Rectangle {
            rotation: -90

            anchors.centerIn: privateRoot
            radius: background.radius

            height: privateRoot.width
            width: privateRoot.height

            gradient: Gradient {
                GradientStop {
                    position: 0.50;
                    color: "#ff"+ baseColor;
                }

                GradientStop {
                    position: 0.70;
                    color: "#00" + baseColor;
                }
            }
        }

    }
}
