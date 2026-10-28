//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef BASELISTMODEL_H
#define BASELISTMODEL_H

#include <QAbstractItemModel>
#include <QQmlEngine>

namespace ViewSolutions {

/**
 * @brief The __PrvateBaseListModel class is the private QObject base class
 * of the @a BaseListModel template.
 *
 * This class is not intended to be used directly. It exists only to make
 * the Q_OBJECT macro (and its signals) available to the BaseListModel
 * template class, which cannot use Q_OBJECT itself.
 */
class __PrvateBaseListModel : public QAbstractListModel{
    Q_OBJECT
protected:
    __PrvateBaseListModel(QObject* parent = nullptr): QAbstractListModel(parent){}
signals:
    void listDateChanged();
};


#define BASE_LIST_MODEL_DATA_PROPERTY(Type) \
Q_PROPERTY(QList<Type> listDate READ dateList WRITE setDataList NOTIFY listDateChanged FINAL)


/**
 * @brief The BaseListModel class is the base class of all GUI list models.
 *
 * A BaseListModel stores its items in a simple list and exposes them to QML
 * as a list model. The list of all items is also available in QML through
 * the `listDate` property (see the BASE_LIST_MODEL_DATA_PROPERTY macro).
 *
 * @tparam TYPE - is main stored delegate model of all list items.
 *
 * Concepts and usage rules:
 *  - All models should provide delegate models based on QObject
 *  - If the model requires a fast solution, just implement a BaseListModel<int> model
 *
 * @note To access the delegate model use the Qt::EditRole role:
 *       it is available in QML by the `delegateModel` keyword.
 *
 * Example of a model based on the BaseListModel:
 * ```cpp
 * class VariantListModel: public ViewSolutions::BaseListModel<QVariant>
 * {
 *     Q_OBJECT
 *     BASE_LIST_MODEL_DATA_PROPERTY(QVariant)
 *
 * public:
 *     VariantListModel(QObject* ptr = nullptr):
 *         ViewSolutions::BaseListModel<QVariant>(ptr) {}
 * };
 * ```
 *
 * C++ usage:
 * ```cpp
 * VariantListModel model;
 *
 * QList<QVariant> items;
 * items << "one" << "two" << "three";
 * model.setDataList(items);
 *
 * const QList<QVariant>& values = model.dateList();
 * ```
 *
 * QML usage (after the model was registered as context property):
 * ```qml
 * ListView {
 *     model: variantListModel
 *     delegate: Text { text: delegateModel }
 * }
 * ```
 */
template<class TYPE>
class BaseListModel: public __PrvateBaseListModel
{

public:
    BaseListModel(QObject* parent = nullptr): __PrvateBaseListModel(parent) {

    }

    int rowCount(const QModelIndex &) const override {
        return m_data.size();
    }

    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[Qt::EditRole] = "delegateModel";
        return roles;
    }

    QVariant data(const QModelIndex &index, int role) const override {
        if (index.isValid() &&
            index.row() < m_data.size() &&
            m_data.size() &&
            role == Qt::EditRole) {

            if constexpr  (std::is_same_v<TYPE, QVariant>) {
                return m_data[index.row()];
            } else if constexpr(std::is_base_of_v<QObject, TYPE>) {
                QQmlEngine::setObjectOwnership(m_data[index.row()], QQmlEngine::CppOwnership);

                return QVariant::fromValue(m_data[index.row()]);

            } else if constexpr (std::is_same_v<TYPE, QSharedPointer<QObject>> ||
                                 std::is_base_of_v<QObject, typename TYPE::element_type>) {
                QObject* ptr = m_data[index.row()].get();

                QQmlEngine::setObjectOwnership(ptr, QQmlEngine::CppOwnership);
                return QVariant::fromValue(ptr);
            } else {
                return QVariant::fromValue(m_data[index.row()]);

            }
        }

        return {};
    }

    /**
     * @brief setDataList sets new date of model, and reset all model;
     * @param newData
     */
    Q_INVOKABLE void setDataList(const QList<TYPE> &newData) {

        const int diff = newData.size() - m_data.size();

        if (diff > 0) {
            beginInsertRows(QModelIndex{}, m_data.size(), m_data.size() + diff - 1);
            m_data = newData;
            endInsertRows();

            emit dataChanged(index(0, 0),
                             index(m_data.size() - diff - 1, 0));
        } else if (diff == 0) {
            m_data = newData;

            emit dataChanged(index(0, 0),
                             index(m_data.size() - diff - 1, 0));
        } else {
            beginRemoveRows(QModelIndex{}, m_data.size() + diff, m_data.size() - 1);
            m_data = newData;

            endRemoveRows();

            emit dataChanged(index(0, 0),
                             index(m_data.size() - 1, 0));
        }

        emit listDateChanged();

    }

    Q_INVOKABLE const QList<TYPE>& dateList() const {
        return m_data;
    }

private:
    QList<TYPE> m_data;

};



}
#endif // BASELISTMODEL_H
