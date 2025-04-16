//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "variantlistmodel.h"
#include "viewsolutions.h"
#include <QQmlContext>
#include <qmlcolorpicker.h>
#include <QQmlApplicationEngine>
#include <QFile>
#include <QDir>
#include <modelstorage.h>

namespace ViewSolutions {
QSharedPointer<ModelStorage> init(QQmlApplicationEngine *engine) {

    if (!engine)
        return nullptr;

    auto root = engine->rootContext();
    if (!root)
        return nullptr;

    initResources();

    engine->addImportPath(":/");



    auto&& storage = QSharedPointer<ModelStorage>::create(engine);
    QQmlEngine::setObjectOwnership(storage.get(), QQmlEngine::CppOwnership);

    root->setContextProperty("modelsStorage", storage.get());

    auto&& picker = QSharedPointer<QMLColorPicker>::create();
    storage->addModel(picker);

    // to-do - remove
    root->setContextProperty("colorPicker", picker.get());

    qRegisterMetaType<VariantListModel>("VariantListModel");

    return storage;
}
}
