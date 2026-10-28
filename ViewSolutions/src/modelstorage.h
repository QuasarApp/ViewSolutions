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
 * @brief The ModelStorage class is the main model storage object.
 *
 * It provides access to all models in the application. Models that are
 * added to the storage get access to the QML engine and can find any
 * other model that is located in the same storage.
 *
 * Example:
 * ```cpp
 * auto models = QSharedPointer<ViewSolutions::ModelStorage>::create(&engine);
 *
 * auto notify = QSharedPointer<ViewSolutions::NotificationService>::create();
 * models->addModel(notify);
 *
 * // Access a model from C++:
 * auto service = models->get<ViewSolutions::NotificationService>("NotificationService");
 * ```
 *
 * In QML the storage is available as the `modelsStorage` context property
 * (set by ViewSolutions::init):
 * ```qml
 * Item {
 *     property var picker: modelsStorage.getModel("ColorPicker")
 * }
 * ```
 */
class VIEWSOLUTION_EXPORT ModelStorage: public QObject, public QEnableSharedFromThis<ModelStorage>
{
    Q_OBJECT
public:
    ModelStorage(QQmlEngine* engine = nullptr);

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

    /**
     * @brief get returns a typed shared pointer to the model with the given id.
     * @tparam Type is the expected type of the model.
     * @param modeId is the id of the required model.
     * @return shared pointer to the model, nullptr if the model does not exist
     *         or does not match the expected type.
     */
    template <class Type>
    QSharedPointer<Type> get(const QString& modeId) const {
        return _storage.value(modeId).staticCast<Type>();
    }

    /**
     * @brief engine returns context qml engine.
     * @return qml engine.
     */
    QQmlEngine *engine() const;

private:
    QHash<QString, QSharedPointer<iModel>> _storage;
    QQmlEngine * _engine = nullptr;
};

}

#endif // MODELSTORAGE_H
