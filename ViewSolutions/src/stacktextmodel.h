//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


#ifndef STACKTEXTMODEL_H
#define STACKTEXTMODEL_H

#include <QStringListModel>
#include "viewsolutions_global.h"

/**
 * @brief The StackTextModel class is model that contains stack text lines.
 * This model split full text into lines by delimiter.
 */
class VIEWSOLUTION_EXPORT StackTextModel: public QStringListModel
{
    Q_OBJECT

    Q_PROPERTY(QString fullText READ fullText WRITE setFullText NOTIFY fullTextChanged FINAL)
    Q_PROPERTY(QString delimiter READ delimiter WRITE setDelimiter NOTIFY delimiterChanged FINAL)

public:
    StackTextModel();

    // QAbstractItemModel interface

    /**
     * @brief fullText returns full text from all lines.
     * @return  full text from all lines.
     */
    QString fullText() const;
    void setFullText(const QString &newFullText);

    /**
     * @brief delimiter returns delimiter that used to split fullText into lines.
     * @return delimiter that used to split fullText into lines.
     * @default is "\n"
     */
    QString delimiter() const;

    /**
     * @brief setDelimiter sets new delimiter for split fullText into lines.
     * @param newDelimiter new delimiter for split fullText into lines.
     */
    void setDelimiter(const QString &newDelimiter);
    QHash<int, QByteArray> roleNames() const override;

protected:

    /**
     * @brief updateText updates internal model data from fullText and delimiter.
     */
    virtual void updateText();

signals:
    void fullTextChanged();
    void delimiterChanged();

private:

    QString _fullText;
    QString _delimiter = "\n";

    // QAbstractItemModel interface
public:
};

#endif // STACKTEXTMODEL_H
