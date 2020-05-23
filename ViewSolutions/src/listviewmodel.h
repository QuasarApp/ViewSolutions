#ifndef LISTVIEWMODEL_H
#define LISTVIEWMODEL_H
#include <QAbstractItemModel>
#include "viewsolutions_global.h"

namespace ViewSolutions {

enum class ListViewModelRoles {
    ModelData = Qt::UserRole
};

class LOGINVIEW_EXPORT ListViewModel: public QAbstractListModel
{
    Q_OBJECT
public:
    ListViewModel(QObject *ptr = nullptr);
    ~ListViewModel();

    int rowCount(const QModelIndex &parent =  QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    void setExternalSource(const QList<QObject*>* newData);
    void setSource(const QList<QObject*>& newData);
    void addSource(QObject *data);

    void clear(bool fast = false);

    bool external() const;

private:
    void setExternal(bool external);

    bool _external = false;
    QList<QObject*> _data;
    const QList<QObject*> *_externalData = nullptr;

};

}
#endif // LISTVIEWMODEL_H
