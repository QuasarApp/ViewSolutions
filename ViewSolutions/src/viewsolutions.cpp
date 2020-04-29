#include "viewsolutions.h"

#include <QQmlApplicationEngine>

namespace ViewSolutions {
bool init(QQmlApplicationEngine *engine) {
    if (!engine)
        return false;

    engine->addImportPath(":/");

    return true;
}
}
