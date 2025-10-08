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



# SimpleQmlNotify
Simple Qml notification service for qml applications.

## Include

### For cmake projects
#### The cmake build do not required Qt libraries. 
 
 * cd yourRepo
 * git submodule add https://github.com/QuasarApp/SimpleQmlNotify.git # add the repository of QSimpleQmlNotify into your repo like submodule
 * git submodule update --init --recursive
 * Include in your CMakeLists.txt file the main CMakeLists.txt file of QSimpleQmlNotify library
  ```cmake
    include(QmlNotyfyService)
  ```
 * Rebuild yuor project



### For other build system
 
 * cd yourRepo
 * git submodule add https://github.com/QuasarApp/SimpleQmlNotify.git # add the repository of QSimpleQmlNotify into your repo like submodule
 * git submodule update --init --recursive
 * Add the rule for build QmlNotyfyService
 * Add INCLUDEPATH and LIBS for your build system 
 * Rebuild yuor project


## Using

### Notification

#### CPP
```cpp
 #include <qmlnotifyservice.h>

 int main() {
     QmlNotificationService::init();
     auto service = QmlNotificationService::NotificationService::getService();
     service->setNotify("title", "text", "UrlOfImage", NotificationData::Normal);
 }


```

#### QML

```qml
 import NotifyModule 1.0

 NotificationServiceView {
     anchors.fill: parent;
 }

```

### Questions


#### CPP
```cpp
 #include <qmlnotifyservice.h>

 int main() {
     QmlNotificationService::init();
     auto service = QmlNotificationService::NotificationService::getService();

     QmlNotificationService::Listner listner = [] (bool accepted) {
                            // your action here.
     };

     service->setQuestion(listner, "title", "some text");

     
 }


```

#### QML

```qml
 import NotifyModule 1.0
 
 NotificationServiceView {
     anchors.fill: parent;
 }
 
 Item {
 
     notificationService.setQuestion(this, "onQuestionCompleted", qsTr("Remove %0 user").arg(userModel.userId),
                                qsTr("All saved data and records will be delete, Do you want continuee?"));
                                
     function onQuestionCompleted(accepted) {
        // your action here.   
     }
 }

```
### Include translations

For include translations into your projects you need to use the QuasarAppUtils::Locales class. See oficiald [documentation](https://quasarapp.ddns.net:3031/docs/QuasarApp/QuasarAppLib/latest/classQuasarAppUtils_1_1Locales.html)

```cpp
if(!QuasarAppUtils::Locales::init(locale, {":/qmlNotify_languages/"})) {
    QuasarAppUtils::Params::log("Error load language : " , QuasarAppUtils::Error);
}
```

Or you can manually load needed qm file.
All qm files located in qmlNotify_languages folder.
