#include "viewsolutions.h"
#include <QQmlContext>
#include <qmlcolorpicker.h>
#include <QQmlApplicationEngine>

namespace ViewSolutions {
bool init(QQmlApplicationEngine *engine) {
    if (!engine)
        return false;

    auto root = engine->rootContext();
    if (!root)
        return false;
    engine->addImportPath(":/");

    root->setContextProperty("colorPicker", QMLColorPicker::instance());

    return true;
}
}
