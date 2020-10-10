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

    property var listView: null

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

    width: (viewPortDelegatW)? viewPortDelegatW: 0
    height: (viewPortDelegatH)? viewPortDelegatH: 0


    Flickable {
        id: flickable
        contentY: -(listView.contentY - delegateItem.y + viewground.y)
        contentX: -(listView.contentX - delegateItem.x + viewground.x)

        onContentXChanged: {
            console.log(contentX)
        }
        contentWidth: 2000//image.width
        contentHeight: image.height
        clip: true
        interactive: false
        Image {
            id: image;
            source: delegateItem.source

            fillMode: Image.PreserveAspectFit
            x:0
            y:0
            width: viewground.width;
            height: viewground.height;

        }

        anchors.fill: parent
        anchors.margins: imageMrgin
    }


}
