//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "modelstorage.h"

#include <QQmlEngine>

namespace ViewSolutions {

ModelStorage::ModelStorage(QQmlApplicationEngine *engine) {
    QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);
    _engine = engine;
}

bool ModelStorage::addModel(const QSharedPointer<iModel> &model) {
    if (_storage.contains(model->modelId())) {
        return false;
    }

    if (QObject* qobject = dynamic_cast<QObject*>(model.get())) {
        QQmlEngine::setObjectOwnership(qobject, QQmlEngine::CppOwnership);
    }

    _storage[model->modelId()] = model;
    model->initStorage(sharedFromThis().toWeakRef());

    return true;
}

QObject* ModelStorage::getModel(const QString &modeId) const {
    return dynamic_cast<QObject*>(_storage.value(modeId).get());
}

QQmlApplicationEngine *ModelStorage::engine() const {
    return _engine;
}
}
