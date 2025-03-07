//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef COLORPICKER_H
#define COLORPICKER_H
#include "viewsolutions_global.h"
#include <QColor>
#include <QObject>

namespace ViewSolutions {

/**
 * @brief The ColorPicker class - This class provide methods of get generals colors from images.
 */
class VIEWSOLUTION_EXPORT ColorPicker
{
public:
    explicit ColorPicker();

    /**
     * @brief pick Get color from point.
     * @arg x This is x coordinate.
     * @arg y This is y coordinate.
     * @arg img Source image.
     * @return Color of point.
    */
    QColor pick(int x, int y, const QImage &img) const;

    /**
     * @brief pick Color from all image. This method get pixels from grid of image.
     * @param img Source image.
     * @param density Count of checked pixels on one plane and planes count, default 5.
     * @return General color of image.
     */
    QColor pick(const QImage &img, int density = 5) const;

    /**
     * @brief pick This is override function for qml.
     * @param img Path to image.
     * @return General color of image.
     */
     QColor pick(const QString &img) const;

};
}

#endif // COLORPICKER_H
