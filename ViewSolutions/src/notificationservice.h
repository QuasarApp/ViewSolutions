/*
 * Copyright (C) 2018-2026 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

#ifndef NOTIFICATIONSERVICE_H
#define NOTIFICATIONSERVICE_H

#include "imodel.h"
#include "notificationdata.h"
#include "historynotificationsmodel.h"

#include <QHash>
#include <QObject>
#include <QQmlEngine>

namespace ViewSolutions {

/**
 * @brief Listener This is listener lambda function of user answer. This function has next signature: void(bool accept)
 */
using Listener = std::function<void(bool accept)>;

/**
 * @brief The NotificationService class. This class used for working with notify.
 */
class VIEWSOLUTION_EXPORT NotificationService: public QObject, public iModel
{
    Q_OBJECT

    Q_PROPERTY(NotificationData notify READ notify NOTIFY notifyChanged)
    Q_PROPERTY(NotificationData question READ question NOTIFY questionChanged)
    Q_PROPERTY(bool uiIsDisplay READ uiIsDisplay WRITE setUiIsDisplay NOTIFY uiIsDisplayChanged FINAL)

    Q_PROPERTY(QObject* history READ history NOTIFY notifyChanged)

    Q_PROPERTY(int notificationsCount READ notificationsCount NOTIFY countNotificationsChanged)

public:
    explicit NotificationService(QObject *ptr = nullptr);
    ~NotificationService();

    /**
     * @brief Notify This method return data of the last notify message.
     * @return return data of the last notify message.
     */
    NotificationData notify() const;

    /**
     * @brief question This method return data of the last question.
     * @return question data.
     */
    NotificationData question() const;

    /**
     * @brief setNotify This method add new notification message of application.
     * @param notify are message data.
     */
    void setNotify(const NotificationData &notify);

    /**
     * @brief setQuestion This method sets information of the users question.
     * @param listener This is listener lambda function.
     * @param question are data of the question.
     * @return return question code. You must be save this code for check answer of your question.
     */
    int setQuestion(const Listener &listener, const NotificationData& question);

    /**
     * @brief questionComplete This method is main response method of the users questions.
     * @param accepted are boolean option. Set this option to true if user click on accept button.
     * @param code are automatically generated code for the question.
     */
    Q_INVOKABLE void questionComplete(bool accepted, int code = 0);

    /**
     * @brief setNotify This method set new notify message for user. When notify changed on main application windows shows notify message.
     * @param title are title of a notify window.
     * @param text are text value of a notify window.
     * @param img are url to image of a notify window.
     * @param type are code of a notification type. For more information about notification type see the NotificationData enum.
     */
    Q_INVOKABLE void setNotify(const QString& title = "",
                               const QString& text = "",
                               const QString& img = "",
                               int type = NotificationData::Normal);

    /**
     * @brief setQuestion This method set new question for user. When question changed on main application windows shows question.
     * @param listenerObject This is qml object with listener function.
     * @param listenerMethod This is listener method name. Method signature : void(bool)
     * @param title are title of a question window.
     * @param text are text value of a question window.
     * @param img are url to image of a question window.
     * @param code are code of question. This code must be sent to the questionComplete method after buttons click.
     */
    Q_INVOKABLE int setQuestion(QObject *listenerObject,
                                const QString &listenerMethod,
                                const QString& title = "",
                                const QString& text = "",
                                const QString& img = "",
                                int code = 0);

    /**
     * @brief setQuestion This method set new question for user. When question changed on main application windows shows question.
     * @param listener This is listener lambda function.
     * @param title are title of a question window.
     * @param text are text value of a question window.
     * @param img are url to image of a question window.
     * @param code are code of question. This code must be sent to the questionComplete method after buttons click.
     */
    int setQuestion(const Listener &listener,
                    const QString& title = "",
                    const QString& text = "",
                    const QString& img = "",
                    int code = 0);

    /**
     * @brief getService This method return instance to notify service.
     * @return pointer to the notification service.
     */
    static NotificationService* getService();

    /**
     * @brief history - This method used for return notify history model.
     * @return history model of all notify.
     */
    QObject* history() const;

    /**
     * @brief showHistory - This method used for emit signal by which show notification menu.
     */

    Q_INVOKABLE void showHistory();

    /**
     * @brief notificationHidden this method should invoked every time when the current notification is hidden, automatically or by user.
     */
    Q_INVOKABLE void notificationHidden();

    /**
     * @brief notificationsCount - This method used for return count of history notifications.
     * @return count of history notifications.
     */
    Q_INVOKABLE int notificationsCount() const;


    // iModel interface
public:
    QString modelId() const override;

    /**
     * @brief uiIsDisplay this method return true if notify service is display now.
     * @return true if notify service is display now.
     */
    bool uiIsDisplay() const;

    /**
     * @brief setUiIsDisplay this method used for set notify service display state.
     * @param newUiIsDisplay - new display state.
     */
    void setUiIsDisplay(bool newUiIsDisplay);

    /**
     * @brief setHistory this method used for set history list.
     * @param historyList - list of history notifications.
     */
    void setHistory(const QList<ViewSolutions::NotificationData> &historyList);


    /**
     * @brief uiTimeOut this is maximum time that notify service can be locked for display.
     * @return
     */
    int uiTimeOut() const;
    void setUiTimeOut(int newUiTimeOut);

signals:
    /**
     * @brief notifyChanged This signal emitted when the notificator (This object) received a new notification message.
     */
    void notifyChanged();

    /**
     * @brief questionChanged This signal emitted when the notificator (This object) received a new question message.
     */
    void questionChanged();

    /**
     * @brief questionCompleted This signal emitted when user clicks any buttons on question popup.
     * @param accepted are bool option with "true" value if the yesr click to accept button.
     * @param questionCode are automatically generated code of the question.
     *  For more information about code option see the setQuestion method.
     */
    void questionCompleted(bool accepted, int questionCode);

    void historyListChanged();

    void sigShowHistory();

    void countNotificationsChanged();

    void uiIsDisplayChanged();

private:



    QHash<int, Listener> _listeners;
    NotificationData _question;
    NotificationData _notify;
    bool _uiIsDisplay = false;
    int _uiTimeOut = 60;
    int _lastDisplayTime = 0;

    HistoryNotificationsModel* _history = nullptr;


};
}

#endif // NOTIFICATIONSERVICE_H
