//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef HISTORYNOTIFICATIONMODEL_H
#define HISTORYNOTIFICATIONMODEL_H

#include <QAbstractListModel>
#include "notificationdata.h"
namespace ViewSolutions {

class VIEWSOLUTION_EXPORT HistoryNotificationsModel : public QAbstractListModel
{
    Q_OBJECT

    enum Roles {
        Icon = Qt::UserRole + 1,
        Title,
        Message,
        Type
    };

public:
    explicit HistoryNotificationsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    void addHistoryObject(const ViewSolutions::NotificationData &notificationData);
    void setHistory(const QList<ViewSolutions::NotificationData> &historyList);
    Q_INVOKABLE void clearAllHistory();
    Q_INVOKABLE void removeNotificationItemAtIndex(const int index);

private:
    QList<ViewSolutions::NotificationData> notificationsList;
};
}
#endif // HISTORYNOTIFICATIONMODEL_H
