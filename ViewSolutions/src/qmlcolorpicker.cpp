#include "qmlcolorpicker.h"
namespace ViewSolutions {

QMLColorPicker::QMLColorPicker(QObject *parent) :
    QObject(parent) {

}

QMLColorPicker *ViewSolutions::QMLColorPicker::instance() {
    static auto ints = new QMLColorPicker();
    return ints;
}

QColor QMLColorPicker::pick(const QString &img) const {
    return ColorPicker::pick(img);
}
}
