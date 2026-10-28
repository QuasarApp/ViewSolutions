//#
//# Copyright (C) 2025-2026 QuasarApp.
//# Distributed under the lgplv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

 Control {
     id: root

     /// The content this is content data of the dragging
     property alias draggingContent: data.contentItem
     property var mimeData: null

     /// The dragging area this is the area where the dragging will be dropped
     required property var draggingArea

     signal dragged()
     signal clicked(var mouse)

     contentItem: Control {
         id: delegate

        Drag.active: activeDragArea.drag.active
        Drag.hotSpot.x: activeDragArea.width / 2
        Drag.hotSpot.y: activeDragArea.height / 2
        Drag.source: activeDragArea
        Drag.mimeData: root.mimeData

        states: [
            State {
                when: delegate.Drag.active
                ParentChange {
                    target: delegate
                    parent: draggingArea
                }
            }
        ]

        MouseArea {
            id: activeDragArea
            anchors.fill: parent
            drag.target: parent

            drag.onActiveChanged: {
                if (drag.active) {
                    root.dragged()
                    draggingArea.opacity *= 0.5
                } else {
                    draggingArea.opacity *= 2
                }
                parent.Drag.drop();
            }
            onClicked: root.clicked(mouse)
        }

        implicitHeight: data.implicitHeight
        implicitWidth: data.implicitWidth
        Control {
            id: data
            anchors.fill: parent

        }
    }
}
