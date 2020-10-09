import QtQuick 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15

ViewSolutionsControl {
    id: delegateItem

    property string source: ""
    property alias imageSource: image

    property var viewground: null
    property real scrollPos: 0
    property int imageMrgin: 5

    property var theme: Material.theme
    property string baseLigtColor: "fafafa"
    property string baseDarkColor: "242424"
    property string baseColor: (theme === Material.Dark)? baseDarkColor: baseLigtColor


    property int viewPortDelegatW: 0
    property int viewPortDelegatH: 0

    background: Rectangle {
        border.color: "black"
        anchors.fill: parent
        color: "#00000000"
    }

    width: (viewPortDelegatW)? viewPortDelegatW: (viewground)? viewground.width : 0
    height:  (viewPortDelegatH)? viewPortDelegatH: (viewground)?viewground.height * 0.1 : 0

    onScrollPosChanged: {
        updatePos();
    }

    function updatePos() {
        if (!viewground) {
            return ;
        }

        const viewGlobal = viewground.mapToGlobal(0, 0);
        const img = flickable.mapFromGlobal(viewGlobal.x, viewGlobal.y);

        flickable.contentX = -img.x;
        flickable.contentY = -img.y;
    }

    Flickable {
        id: flickable

        contentWidth: viewground.width
        contentHeight: viewground.height
        clip: true
        interactive: false

        Image {
            id: image;
            source: delegateItem.source

            fillMode: Image.PreserveAspectFit
            anchors.fill: parent

        }

        anchors.fill: parent
        anchors.margins: imageMrgin
    }


}
