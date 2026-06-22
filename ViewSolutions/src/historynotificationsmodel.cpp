//#
//# Copyright (C) 2020-2026 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "historynotificationsmodel.h"
#include <QDebug>

namespace ViewSolutions {

HistoryNotificationsModel::HistoryNotificationsModel(QObject *parent)
    : QAbstractListModel{parent} {
}

int HistoryNotificationsModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return notificationsList.count();
}

QVariant HistoryNotificationsModel::data(const QModelIndex &index, int role) const {
    if(index.row() < 0 || index.row() >= notificationsList.count())
        return QVariant();

    auto& value = notificationsList.at(index.row());

    switch (role) {
    case Icon:
         return value.img();
    case Title:
        return value.title();
    case Message:
        return value.text();
    case Type:
        return value.type();
    case Time:
        return value.getTime();
    case FilterHuck0:
        return value.filterHuck0();
    case FilterHuck1:
        return value.filterHuck1();
    default:
        break;
    }
    return QVariant();
}

QHash<int, QByteArray> HistoryNotificationsModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[Icon]    = "icon";
    roles[Title]   = "title";
    roles[Message] = "text";
    roles[Type]    = "type";
    roles[Time]    = "msgTime";
    roles[FilterHuck0] = "filterHuck0";
    roles[FilterHuck1] = "filterHuck1";

    return roles;
}


void HistoryNotificationsModel::addHistoryObject(const NotificationData &notificationData) {
    beginInsertRows({}, rowCount({}), rowCount({}));
    notificationsList.append(notificationData);
    endInsertRows();
}

void HistoryNotificationsModel::setHistory(const QList<NotificationData> &historyList) {
    notificationsList = std::move(historyList);
}

void HistoryNotificationsModel::clearAllHistory() {
    beginResetModel();
    notificationsList.clear();
    endResetModel();
}

void HistoryNotificationsModel::removeNotificationItemAtIndex(const int elementIndex) {
    beginRemoveRows({}, elementIndex, elementIndex);
    notificationsList.removeAt(elementIndex);
    endRemoveRows();
}

}
