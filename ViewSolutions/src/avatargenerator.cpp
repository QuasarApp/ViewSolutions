//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


#include "avatargenerator.h"

#include <QFontMetrics>
#include <QPainter>

namespace ViewSolutions {

AvatarGenerator::AvatarGenerator() {}

bool AvatarGenerator::generateDefaultAvatar(QImage &result,
                                            const QString &nickName,
                                            const QFont &font,
                                            const QColor &color) const {

    const int size = std::max(std::max(result.width(), result.height()), 256);


    QBrush solidBrush = QBrush(color);
    if (!color.isValid()) {
        auto mainColor = QColor(qHash(nickName + "red") % 250,
                           qHash(nickName + "green") % 250,
                           qHash(nickName + "blue") % 250);

        // radnom dark
        auto secondColor = QColor(qHash(nickName + "red dark") % 50,
                           qHash(nickName + "green dark") % 50,
                           qHash(nickName + "blue dark") % 50);

        QLinearGradient g(0.0, 0.0, 0.0, size);
        g.setColorAt(0, mainColor);
        g.setColorAt(1, secondColor);

        solidBrush = QBrush(g);
    }

    QImage image(size, size, QImage::Format_ARGB32);
    image.fill(Qt::transparent);

    QPainter painter(&image);
    painter.setRenderHint(QPainter::Antialiasing);


    painter.setBrush(solidBrush);
    painter.setPen(Qt::NoPen);
    painter.drawEllipse(0, 0, size, size);

    QString firstLetter = nickName.left(1).toUpper();
    QFont currentFont = font;
    currentFont.setPixelSize( size / 2);
    painter.setPen(QColor(Qt::white));
    QFontMetrics metrics(currentFont);
    painter.setFont(currentFont);

    int textWidth = metrics.horizontalAdvance(firstLetter);
    int textHeight = metrics.height();
    int x = (size - textWidth) / 2;
    int y = (size + textHeight / 2) / 1.9;
    painter.drawText(x, y, firstLetter);

    result = image;

    return true;
}

}
