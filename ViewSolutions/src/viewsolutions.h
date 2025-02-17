//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef VIEWSOLUTIONS_H
#define VIEWSOLUTIONS_H

#include "modelstorage.h"
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
 * @param engine is QQmlApplicationEngine object.
 * @return gui model storage object.
 */
QSharedPointer<ModelStorage> init(QQmlApplicationEngine *engine);
}

#endif // VIEWSOLUTIONS_H
