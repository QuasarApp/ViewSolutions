# ViewSolutions

View solutions of qml for quasarapp projects

## QML classes:

#### ImageView

This is animate image viewer 

##### Example:
```qml
import ViewSolutionsModule 1.0

ImageView {

    anchors.fill: parent
    soucre:  "qrc:/img/images/example.png"
    text: "exampele"
    anchors.margins: 100
    borderColor: "red"
}
```

#### ViewPortPage

This is animate Delegate viewer for ListView 

##### Example:

```qml
import ViewSolutionsModule 1.0

ListView {
    id: viewPort
    property real globalPos: 0
    anchors.fill: parent
    delegate: Component {
        ViewPortPage {
            viewPortDelegatH: 500 // base size of content item
            scrollPos: viewPort.globalPos // due to qml limitations, this field will have to be tied to updating the location of the scroll
            source:  modelData
            viewground: root // this is plane to display the main background
            title: "Test ViewPortPage"
            text: "Test ViewPortPage. General text and <i>html code</i>"
        }
    }

    ScrollBar.vertical: ScrollBar {
        onPositionChanged: {
            viewPort.globalPos = position
        }
    }


    model: [
        "qrc:/img/res/LOGO.png",
        "qrc:/img/res/LOGO-GREAN.png",
    ]
}
```
