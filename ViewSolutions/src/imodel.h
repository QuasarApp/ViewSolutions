//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef IMODEL_H
#define IMODEL_H

#include <QQmlApplicationEngine>
#include <QString>
#include <QWeakPointer>
#include "viewsolutions_global.h"


namespace ViewSolutions {

class ModelStorage;

/**
 * @brief The iModel class is base model for GUI models. Works with @a ModelStorage.
 *  All models after adding can get access to any othe models that located on same storage object.
 */
class VIEWSOLUTION_EXPORT iModel
{
public:
    iModel() = default;
    virtual ~iModel() = default;

    /**
     * @brief modelId returns text model id. override this method to provide access to model in qml or other models.
     * @return model id.
     */
    virtual QString modelId() const = 0;

    /**
     * @brief storage returns storage object. this method return context of the model's storage.
     * @return storage object.
     */
    const QWeakPointer<ModelStorage>& storage() const;

    /**
     * @brief engine returns qml engine.
     * @return qml engine.
     * @note can be return nullptr if the models system initialized without qml engine.
     * @note this method convert weak pointer to shared pointer,
     * so you can use it without any restrictions,
     * but it may be slowly then dirrect access.
     */
    QQmlApplicationEngine * engine() const;

protected:

    /**
     * @brief initStorage This method is called by storage object after adding model to storage.
     * @param newStorage is storage object.
     */
    virtual void initStorage(const QWeakPointer<ModelStorage>& newStorage);

private:

    QWeakPointer<ModelStorage> m_storage;

    friend class ModelStorage;
};

}
#endif // IMODEL_H
