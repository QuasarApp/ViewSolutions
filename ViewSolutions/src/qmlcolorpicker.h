#ifndef QMLCOLORPICKER_H
#define QMLCOLORPICKER_H
#include "colorpicker.h"

#include <QObject>
namespace ViewSolutions {

/**
 * @brief The QMLColorPicker class - qml wraper for ColorPicker clas
 */
class LOGINVIEW_EXPORT QMLColorPicker : public QObject, private ColorPicker
{
    Q_OBJECT
public:
    explicit QMLColorPicker(QObject *parent = nullptr);
    /**
     * @brief instance
     * @return static instance of this ColorPicker
     */
    static QMLColorPicker* instance();

    /**
     * @brief pick - this is override function for qml
     * @param img - path to image
     * @return General color of image
     */
     Q_INVOKABLE QColor pick(const QString &img) const;

};
}
#endif // QMLCOLORPICKER_H
