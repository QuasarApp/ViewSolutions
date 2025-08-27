//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "colorpicker.h"

#include <QColor>
#include <QImage>
#include <QUrl>
namespace ViewSolutions {

ColorPicker::ColorPicker() {

}

QColor ColorPicker::pick(int x, int y, const QImage &img) const {
    return img.pixelColor(x, y);
}

QColor ColorPicker::pick(const QImage &img, int density) const {
    int stepX = img.width() / density;
    int stepY = img.height() / density;

    if (!(stepX && stepY)) {
        return QColor::fromRgb(0);
    }

    int A = 0,
        R = 0,
        G = 0,
        B = 0;

    for (int x = stepX - 1; x < img.width(); x += stepX) {
        for (int y = stepY - 1; y < img.height(); y += stepY) {
            int pixel = img.pixel(x, y);
            A += (pixel & 0xFF000000) >> 24;
            R += (pixel & 0x00FF0000) >> 16;
            G += (pixel & 0x0000FF00) >> 8;
            B +=  pixel & 0x000000FF;
        }
    }

    int count = density * density;
    return QColor::fromRgba(((A / count) << 24) |
                            ((R / count) << 16) |
                            ((G / count) << 8) |
                              B / count);
}

QColor ColorPicker::pick(const QString &img) const {
    if (img.left(3).compare("qrc") == 0) {
        return pick(QImage(img.right(img.size() - 3)));
    }

    if (img.left(5).compare("file:") == 0) {
        return pick(QImage(img.right(img.size() - 5)));
    }

    return pick(QImage(img));
}

}
