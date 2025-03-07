//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef QMLCOLORPICKER_H
#define QMLCOLORPICKER_H
#include "colorpicker.h"

#include <QObject>
#include <imodel.h>

namespace ViewSolutions {

/**
 * @brief The QMLColorPicker class - Qml wrapper for ColorPicker class.
 */
class VIEWSOLUTION_EXPORT QMLColorPicker : public QObject, public iModel, private ColorPicker
{
    Q_OBJECT
public:
    explicit QMLColorPicker(QObject *parent = nullptr);


    /**
     * @brief pick This is override function for qml.
     * @param img This is path to image.
     * @return General color of image.
     */
    Q_INVOKABLE QColor pick(const QString &img) const;

    /**
     * @brief instance This is singleton instance of QMLColorPicker.
     * @return
     */
    QString modelId() const override;

};

}
#endif // QMLCOLORPICKER_H
