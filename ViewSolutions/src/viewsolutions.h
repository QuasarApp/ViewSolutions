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

/**
 * @brief initResources loads the QML resources of the ViewSolutions module.
 *
 * This method is called automatically by @a init. A manual call is only
 * required if the host application loads the resources on its own.
 *
 * Example:
 * ```cpp
 * ViewSolutions::initResources();
 * ```
 */
inline void initResources() { /*Q_INIT_RESOURCE(ViewSolutionsResources);*/ }

/**
 * @brief The ViewSolutions namespace
 *
 * This namespace groups all C++ classes of the ViewSolutions module:
 * the model system (@a ModelStorage, @a iModel, @a BaseListModel,
 * @a BaseHashModel), the notification system (@a NotificationService,
 * @a NotificationData, @a HistoryNotificationsModel) and helper classes
 * such as @a ColorPicker, @a QMLColorPicker and @a AvatarGenerator.
 *
 * Example:
 * ```cpp
 * #include <viewsolutions.h>
 *
 * int main(int argc, char *argv[])
 * {
 *     QGuiApplication app(argc, argv);
 *     QQmlApplicationEngine engine;
 *
 *     // Imports all QML resources and creates the central model storage.
 *     auto models = ViewSolutions::init(&engine);
 *     if (!models)
 *         return -1;
 *
 *     engine.load(QUrl("qrc:/main.qml"));
 *     return app.exec();
 * }
 * ```
 *
 * After calling @a init the model storage is available in QML through the
 * `modelsStorage` context property:
 * ```qml
 * import ViewSolutions
 *
 * Item {
 *     property var picker: modelsStorage.getModel("ColorPicker")
 * }
 * ```
 */
namespace ViewSolutions {

/**
 * @brief init this method import all qml resources to your project
 * and creates the central model storage of the application.
 *
 * The returned @a ModelStorage object is exposed to QML as the
 * `modelsStorage` context property.
 * @param engine is QQmlApplicationEngine object.
 * @return gui model storage object. `nullptr` is returned if the
 *         engine or its root context is invalid.
 *
 * Example:
 * ```cpp
 * QSharedPointer<ViewSolutions::ModelStorage> models = ViewSolutions::init(&engine);
 *
 * // Access a model from C++ (the color picker is registered by init):
 * auto picker = models->get<ViewSolutions::QMLColorPicker>("ColorPicker");
 * ```
 */
[[nodiscard("The ViewSolutions create model storage space for all QML. This is central model for fast acces to models of your App.") ]]
QSharedPointer<ModelStorage> VIEWSOLUTION_EXPORT init(QQmlEngine *engine);
}

#endif // VIEWSOLUTIONS_H
