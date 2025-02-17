//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef MODELSTORAGE_H
#define MODELSTORAGE_H

#include "imodel.h"

#include <QHash>
#include <QObject>
#include <QSharedPointer>

namespace ViewSolutions {

/**
 * @brief The ModelStorage class main model storage object. Provide access to all models in the application.
 */
class VIEWSOLUTION_EXPORT ModelStorage: public QObject, public QEnableSharedFromThis<ModelStorage>
{
    Q_OBJECT
public:
    ModelStorage(QQmlApplicationEngine* engine = nullptr);

    /**
     * @brief addModel adds new model into storage.
     * @param model is model object.
     * @return true if model added succesfful, if model alredy exists or model is invalid return false.
     * @note All valid models should be inherited from QObject, and inited using a QSharedPointer::create() method.
     */
    bool addModel(const QSharedPointer<iModel>& model);

    /**
     * @brief getModel This method isible on The QML and using for gettings required GUI models.
     * @param modeId This is id of required model.
     * @return model raw pointer.
     */
    Q_INVOKABLE QObject* getModel(const QString& modeId) const;

    template <class Type>
    QSharedPointer<Type> get(const QString& modeId) const {
        return _storage.value(modeId).staticCast<Type>();
    }

    /**
     * @brief engine returns context qml engine.
     * @return qml engine.
     */
    QQmlApplicationEngine *engine() const;

private:
    QHash<QString, QSharedPointer<iModel>> _storage;
    QQmlApplicationEngine * _engine = nullptr;
};

}

#endif // MODELSTORAGE_H
