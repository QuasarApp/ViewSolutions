#ifndef COLORPICKER_H
#define COLORPICKER_H
#include "viewsolutions_global.h"
#include <QColor>
#include <QObject>

namespace ViewSolutions {

/**
 * @brief The ColorPicker class - this class provide methods of get generals colors from images.
 */
class LOGINVIEW_EXPORT ColorPicker
{
public:
    explicit ColorPicker();

    /**
     * @brief pick - get color from point
     * @arg x
     * @arg y
     * @arg img - source image
     * @return color of point.
    */
    QColor pick(int x, int y, const QImage &img) const;

    /**
     * @brief pick - color from all image. This method get pixels from grid of image
     * @param img - source image
     * @param density - counnt of checked pixels on one plane and planes count. @default 5
     * @return General color of image
     */
    QColor pick(const QImage &img, int density = 5) const;

    /**
     * @brief pick - this is override function for qml
     * @param img - path to image
     * @return General color of image
     */
     QColor pick(const QString &img) const;

};
}

#endif // COLORPICKER_H
