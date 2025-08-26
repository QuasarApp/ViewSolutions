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
import QtGraphicalEffects 1.15

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
