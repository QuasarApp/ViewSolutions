//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the lgplv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

 Control {
     id: root

     /// The content this is content data of the draging
     property alias dragingContent: data.contentItem
     property var mimeData: null

     /// The draging area this is the area where the draging will be dropped
     required property var dragingArea

     signal draged()
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
                    parent: dragingArea
                }
            }
        ]

        MouseArea {
            id: activeDragArea
            anchors.fill: parent
            drag.target: parent

            drag.onActiveChanged: {
                if (drag.active) {
                    root.draged()
                    dragingArea.opacity *= 0.5
                } else {
                    dragingArea.opacity *= 2
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
