import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Universal 2.14

Item {

    id: root

    property string background: ""
    property var viewground: null

    onXChanged: updatePos;
    onYChanged: updatePos;

    Flickable {
        id: flickable
        contentWidth: (viewground)? viewground.width: image.width
        contentHeight: (viewground)? viewground.height: image.height
        contentX: 0
        contentY: 0
        clip: true
        interactive: false
        function updatePos() {
            if (!viewground) {
                return {x: 0, y : 0};
            }

            const viewGlobal = root.mapToGlobal(viewground.x, viewground.y);
            const img = image.mapFromGlobal(viewGlobal.x, viewGlobal.y);
            flickable.contentX = img.x;
            flickable.contentY = img.y;
        }


        Image {
            id: image;
            source: background
            height: root.contentH
            fillMode: Image.PreserveAspectFit
            width: root.contentW

        }

        anchors.fill: parent

    }


}
