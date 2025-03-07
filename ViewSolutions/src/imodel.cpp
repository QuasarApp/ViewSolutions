//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "imodel.h"

#include <modelstorage.h>

namespace ViewSolutions {


const QWeakPointer<ModelStorage> &iModel::storage() const {
    return m_storage;
}

QQmlApplicationEngine *iModel::engine() const {
    if (auto&& storage = m_storage.lock()) {
        return storage->engine();
    }

    return nullptr;
}

void iModel::initStorage(const QWeakPointer<ModelStorage> &newStorage) {
    m_storage = newStorage;
}
}
