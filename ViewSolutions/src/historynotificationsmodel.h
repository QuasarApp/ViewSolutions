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

/**
 * @brief The HistoryNotificationsModel class stores the history of all
 * sent notification messages.
 *
 * This model is used by the NotificationHistoryView to display the list of
 * all notifications that were shown by the @a NotificationService.
 *
 * Each row of the model exposes the following roles:
 *  - `icon`  - url of the notification image
 *  - `title` - notification title
 *  - `text`  - notification message
 *  - `type`  - notification type code (see NotificationData::Type)
 *
 * Example:
 * ```cpp
 * ViewSolutions::HistoryNotificationsModel history;
 * history.addHistoryObject(
 *     ViewSolutions::NotificationData("Title", "Message"));
 *
 * history.removeNotificationItemAtIndex(0);
 * history.clearAllHistory();
 * ```
 */
class VIEWSOLUTION_EXPORT HistoryNotificationsModel : public QAbstractListModel
{
    Q_OBJECT

    /**
     * @brief The Roles enum defines the data roles of the model.
     */
    enum Roles {
        /// Url of the notification image
        Icon = Qt::UserRole + 1,
        /// Title of the notification
        Title,
        /// Message of the notification
        Message,
        /// Type code of the notification (see NotificationData::Type)
        Type
    };

public:
    explicit HistoryNotificationsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    /**
     * @brief addHistoryObject adds a new notification to the history list.
     * @param notificationData is data of the notification.
     */
    void addHistoryObject(const ViewSolutions::NotificationData &notificationData);

    /**
     * @brief setHistory replaces the complete history list with a new one.
     * @param historyList is the new history list.
     */
    void setHistory(const QList<ViewSolutions::NotificationData> &historyList);

    /**
     * @brief clearAllHistory removes all notifications from the history.
     */
    Q_INVOKABLE void clearAllHistory();

    /**
     * @brief removeNotificationItemAtIndex removes one notification
     * from the history list.
     * @param index is the index of the notification that should be removed.
     */
    Q_INVOKABLE void removeNotificationItemAtIndex(const int index);

private:
    QList<ViewSolutions::NotificationData> notificationsList;
};
}
#endif // HISTORYNOTIFICATIONMODEL_H
