/*
 * Copyright (C) 2018-2026 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

NotificationForm {
    id: questionDialog

    readonly property string defImg: "qrc:/qt/qml/ViewSolutions/assets/icon/Question.png"

    autoClose: false
    clickClose: false
    modal: true

    footer: DialogButtonBox {
        standardButtons: Dialog.Yes | Dialog.No;
    }
}
