#ifndef VIEWSOLUTIONS_H
#define VIEWSOLUTIONS_H

#include "viewsolutions_global.h"

class QQmlApplicationEngine;

//// Use This macros for init all library resources.
//#define INIT_VIEW_SOLUTIONS(result, engine) \
//    Q_INIT_RESOURCE(ViewSolutionsResources); \
//    result = ViewSolutions::init(engine)

inline void initResources() { Q_INIT_RESOURCE(ViewSolutionsResources); }
/**
 * @brief the ViewSolutions namespace
 */
namespace ViewSolutions {
/**
     * @brief init this method import all qml resources to your project.
     */
    bool VIEWSOLUTION_EXPORT init(QQmlApplicationEngine *engine);
}

#endif // VIEWSOLUTIONS_H
