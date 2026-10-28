//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef LISTVIEWMODEL_H
#define LISTVIEWMODEL_H
#include <QAbstractItemModel>
#include "viewsolutions_global.h"

namespace ViewSolutions {

/**
 * @brief The ListViewModelRoles enum defines the data roles
 * of the ListViewModel.
 */
enum class ListViewModelRoles {
    /// The Qt::UserRole role. Returns the QObject data of the list item.
    ModelData = Qt::UserRole
};

/**
 * @brief The ListViewModel class provides a QML list model with QObject data.
 *
 * The model can be filled with an internal list of QObject pointers or with
 * an external list. In the external case the model does not own the data,
 * the data must stay valid while the model is in use.
 *
 * The model exposes one role: `modelData` (see ListViewModelRoles::ModelData).
 *
 * Example:
 * ```cpp
 * ViewSolutions::ListViewModel model;
 *
 * // Internal data list (owned by the model):
 * model.addSource(myObject);
 * model.setSource({object1, object2});
 *
 * // External data list (not owned by the model):
 * QList<QObject*> externalList = {object1, object2};
 * model.setExternalSource(&externalList);
 * ```
 *
 * QML usage:
 * ```qml
 * ListView {
 *     model: listViewModel
 *     delegate: Item {
 *         property var data: modelData
 *     }
 * }
 * ```
 */
class VIEWSOLUTION_EXPORT ListViewModel: public QAbstractListModel
{
    Q_OBJECT
public:
    ListViewModel(QObject *ptr = nullptr);
    ~ListViewModel();

    int rowCount(const QModelIndex &parent =  QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    /**
     * @brief setExternalSource sets a new external data list.
     * The model does not take ownership of the list content.
     * @param newData is pointer to the new external data list.
     */
    void setExternalSource(const QList<QObject*>* newData);

    /**
     * @brief setSource sets a new internal data list.
     * The model takes ownership of the list content.
     * @param newData is the new internal data list.
     */
    void setSource(const QList<QObject*>& newData);

    /**
     * @brief addSource adds one new QObject to the data list.
     * @param data is the new data object.
     */
    void addSource(QObject *data);

    /**
     * @brief clear removes all data from the model and deletes the
     * objects of the internal data list.
     * @param fast if true the objects are deleted with deleteLater,
     *             otherwise they are deleted directly.
     */
    void clear(bool fast = false);

    /**
     * @brief external returns true if the model uses an external
     * data list.
     * @return true if the model uses an external data list.
     */
    bool external() const;

private:
    void setExternal(bool external);

    bool _external = false;
    QList<QObject*> _data;
    const QList<QObject*> *_externalData = nullptr;

};

}
#endif // LISTVIEWMODEL_H
