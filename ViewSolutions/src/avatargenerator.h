//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#



#ifndef AVATARGENERATOR_H
#define AVATARGENERATOR_H

#include <QImage>
#include "viewsolutions_global.h"

namespace ViewSolutions {

/**
 * @brief The AvatarGenerator class contains function for create default users avatars.
 *
 * The generated avatar is an ellipse image with the 2 first letters of the
 * user name. The size of the image depends on the result image size, but if
 * it is smaller than 256 px, 256 px will be used.
 *
 * Example:
 * ```cpp
 * ViewSolutions::AvatarGenerator generator;
 * QImage avatar;
 * if (!generator.generateDefaultAvatar(avatar, "John Doe", QFont()))
 *     qWarning() << "Could not create the default avatar";
 *
 * avatar.save("avatar.png");
 * ```
 */
class VIEWSOLUTION_EXPORT AvatarGenerator
{
public:
    AvatarGenerator();

    /**
     * @brief generateDefaultAvatar generates default avatar.
     * This function generate Ellipse with 2 first letters of user name.
     * Size of image depends of result image size, but if it smaller the 256 px will use 256 px.
     * @param result - result image
     * @param nickName - user name
     * @param font - font for text
     * @param color - color of text - if not sets by default will be used random color
     * @return true if the avatar was generated successfully, otherwise false.
     */
    bool generateDefaultAvatar(QImage &result, const QString &nickName,
                               const QFont& font, const QColor& color = {}) const;


};

}
#endif // AVATARGENERATOR_H
