#ifndef QMLCOLORPICKER_H
#define QMLCOLORPICKER_H
#include "colorpicker.h"

#include <QObject>

class QQmlApplicationEngine;
namespace ViewSolutions {

/**
 * @brief The QMLColorPicker class - Qml wrapper for ColorPicker class.
 */
class VIEWSOLUTION_EXPORT QMLColorPicker : public QObject, private ColorPicker
{
    Q_OBJECT
public:
    explicit QMLColorPicker(QObject *parent = nullptr);
    /**
     * @brief instance This method return instance object of the QMLColorPicker setvice.
     * @return Static instance of this ColorPicker.
     */
    static QMLColorPicker* instance();

    /**
     * @brief pick This is override function for qml.
     * @param img This is path to image.
     * @return General color of image.
     */
     Q_INVOKABLE QColor pick(const QString &img) const;

    /**
     * @brief setEngine This method set qml engine for working with image providers.
     * @param engine This is new engine.
     */
    void setEngine(QQmlApplicationEngine *engine);

private:

    QQmlApplicationEngine *_engine = nullptr;
};
}
#endif // QMLCOLORPICKER_H
