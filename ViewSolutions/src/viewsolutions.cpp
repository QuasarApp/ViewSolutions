#include "viewsolutions.h"
#include <QQmlContext>
#include <qmlcolorpicker.h>
#include <QQmlApplicationEngine>
#include <QFile>
#include <QDir>

namespace ViewSolutions {
bool init(QQmlApplicationEngine *engine) {

    if (!engine)
        return false;

    auto root = engine->rootContext();
    if (!root)
        return false;

    engine->addImportPath(":/");

    auto picker = QMLColorPicker::instance();
    picker->setEngine(engine);

    root->setContextProperty("colorPicker", picker);

    return true;
}
}
