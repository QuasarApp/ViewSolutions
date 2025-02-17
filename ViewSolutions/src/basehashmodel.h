//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef BASEHASHMODEL_H
#define BASEHASHMODEL_H
#include <QAbstractItemModel>
#include <QQmlEngine>

namespace ViewSolutions {

/**
 * @tparam KEY - is type of hash table key,
 * @tparam DATA - is main stored delegate model of all list items.

 * @brief The BaseHashModel class is base class of all GUI list models
 *
 * Conceptions and using rooles
 * * All models should provides delegate models base of qobject
 * * If model require fast solution just implement BaseListModel<int> model
 *
 *
 * @note to access to delegate model use Qt::EditRole role: available in qml by delegateModel keyword
 * @example :
 * ```
 * class VariantListModel: public BaseHashModel<QVariant>
{
    Q_OBJECT

public:
    VariantListModel(QObject* ptr = nullptr): BaseListModel<QString, QVariant>(ptr){};
};
}
 * ```
 *
 * @note The BaseHashModel is not support Qml space, to short access in qml use the @a BaseListModel
 */
template<class KEY, class DATA>
class BaseHashModel: public QAbstractListModel
{

public:
    BaseHashModel(QObject* parent = nullptr): QAbstractListModel(parent) {

    }

    int rowCount(const QModelIndex &parent) const override {
        return m_data.size();
    }

    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[Qt::EditRole] = "delegateModel";
        return roles;
    }

    QVariant data(const QModelIndex &index, int role) const override {
        if (index.isValid() && role == Qt::EditRole) {

            auto iter = std::next(m_data.begin(), index.row());
            if (iter == m_data.end()) {
                return {};
            }

            if constexpr  (std::is_same_v<DATA, QVariant>) {
                return *iter;
            } else if constexpr(std::is_base_of_v<QObject, DATA>) {
                QQmlEngine::setObjectOwnership(*iter, QQmlEngine::CppOwnership);

                return QVariant::fromValue(*iter);

            } else if constexpr (std::is_same_v<DATA, QSharedPointer<QObject>> ||
                                 std::is_base_of_v<QObject, typename DATA::element_type>) {
                QObject* ptr = iter->get();

                QQmlEngine::setObjectOwnership(ptr, QQmlEngine::CppOwnership);
                return QVariant::fromValue(ptr);
            } else {
                return QVariant::fromValue(*iter);

            }
        }

        return {};
    }

    /**
     * @brief getByKey returns value by key
     * @param key
     * @return
     */
    virtual QVariant getByKey(const KEY& key) {
        auto&& val = m_data.value(key);
        if constexpr  (std::is_same_v<DATA, QVariant>) {
            return val;
        } else if constexpr(std::is_base_of_v<QObject, DATA>) {
            QQmlEngine::setObjectOwnership(val, QQmlEngine::CppOwnership);

            return QVariant::fromValue(val);

        } else if constexpr (std::is_base_of_v<QSharedPointer<QObject>, DATA>) {
            QObject* ptr = val.get();

            QQmlEngine::setObjectOwnership(ptr, QQmlEngine::CppOwnership);
            return QVariant::fromValue(ptr);
        } else {
            return QVariant::fromValue(val);

        }

        return {};
    }

    const QHash<KEY, DATA>& dateList() const {
        return m_data;
    }

    /**
     * @brief setByKey update delegate by key
     * @param key
     * @param data
     */
    virtual void setByKey(const KEY& key, const DATA& data) {
        auto&& iter = m_data.find(key);
        if (iter != m_data.end() ||  *iter != data) {

            int insertIdx = std::distance(m_data.begin(), m_data.insert(key, data));
            emit dataChanged(index(insertIdx, 0),
                             index(insertIdx, 0));
        }
    }

    virtual void removeByKey(const KEY& key) {
        auto&& iter = m_data.find(key);
        if (iter != m_data.end()) {

            int removeIdx = std::distance(m_data.begin(), iter);
            beginRemoveRows(QModelIndex{}, removeIdx, removeIdx);
            m_data.erase(iter);
            endRemoveRows();
        }
    }

    /**
     * @brief setDataList sets new date of model, and reset all model;
     * @param newData
     */
    void setDataList(const QHash<KEY, DATA> &newData) {

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
    }

private:
    QHash<KEY, DATA> m_data;

};



}


#endif // BASEHASHMODEL_H
