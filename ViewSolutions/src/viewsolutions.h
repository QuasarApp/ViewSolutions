#ifndef VIEWSOLUTIONS_H
#define VIEWSOLUTIONS_H

#include "viewsolutions_global.h"

class QQmlApplicationEngine;

/**
 * @brief the ViewSolutions namespace
 */
namespace ViewSolutions {
/**
     * @brief init this method import all qml resources to your project.
     */
    bool init(QQmlApplicationEngine *engine);
}

#endif // VIEWSOLUTIONS_H
