//#
//# Copyright (C) 2024-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef IGUITOKENSMODEL_H
#define IGUITOKENSMODEL_H

#include "imodel.h"
#include <QColor>
#include <QFont>
#include <QObject>

namespace ViewSolutions {

/**
 * @brief The Tokens class is general global instanke of all QML constans used in the App.
 */
class VIEWSOLUTION_EXPORT iGUITokensModel: public QObject, public iModel
{
    Q_OBJECT

    // colors contants
    Q_PROPERTY(QColor color_accent_primary READ color_surface_accent_primary CONSTANT FINAL)

    Q_PROPERTY(QColor color_accent_secondary READ color_surface_accent_secondary CONSTANT FINAL)
    Q_PROPERTY(QColor color_accent_error READ color_surface_accent_error CONSTANT FINAL)
    Q_PROPERTY(QColor color_accent_success READ color_surface_accent_success CONSTANT FINAL)

    Q_PROPERTY(QColor color_text_primary READ color_text_primary CONSTANT FINAL)
    Q_PROPERTY(QColor color_text_secondary READ color_text_secondary CONSTANT FINAL)
    Q_PROPERTY(QColor color_text_tertiary READ color_text_tertiary CONSTANT FINAL)

    Q_PROPERTY(QColor color_text_disabled READ color_text_disabled CONSTANT FINAL)
    Q_PROPERTY(QColor color_border_primary READ color_border_primary CONSTANT FINAL)
    Q_PROPERTY(QColor color_border_secondary READ color_border_secondary CONSTANT FINAL)
    Q_PROPERTY(QColor color_border_disabled READ color_border_disabled CONSTANT FINAL)
    Q_PROPERTY(QColor color_devider_dark READ color_devider_dark CONSTANT FINAL)
    Q_PROPERTY(QColor color_devider_white READ color_devider_white CONSTANT FINAL)

    //states_colors_constants:
    Q_PROPERTY(QColor pressed_focused READ pressed_focused CONSTANT FINAL)
    Q_PROPERTY(QColor hover READ hover CONSTANT FINAL)

    // fonts
    Q_PROPERTY(QFont font_caption_1 READ font_caption_1 CONSTANT FINAL)
    Q_PROPERTY(QFont font_caption_2 READ font_caption_2 CONSTANT FINAL)
    Q_PROPERTY(QFont font_caption_3 READ font_caption_3 CONSTANT FINAL)

    Q_PROPERTY(QFont font_body_1 READ font_body_1 CONSTANT FINAL)
    Q_PROPERTY(QFont font_body_2 READ font_body_2 CONSTANT FINAL)
    Q_PROPERTY(QFont font_body_large READ font_body_large CONSTANT FINAL)
    Q_PROPERTY(QFont font_subtitle_1 READ font_subtitle_1 CONSTANT FINAL)
    Q_PROPERTY(QFont font_subtitle_2 READ font_subtitle_2 CONSTANT FINAL)
    Q_PROPERTY(QFont font_subtitle_large READ font_subtitle_large CONSTANT FINAL)
    Q_PROPERTY(QFont font_subtitle_x_large READ font_subtitle_x_large CONSTANT FINAL)
    Q_PROPERTY(QFont font_subtitle_uppercase READ font_subtitle_uppercase CONSTANT FINAL)

    Q_PROPERTY(QFont font_title_1 READ font_title_1 CONSTANT FINAL)
    Q_PROPERTY(QFont font_title_1_secondary READ font_title_1_secondary CONSTANT FINAL)

    Q_PROPERTY(QFont font_title_2 READ font_title_2 CONSTANT FINAL)
    Q_PROPERTY(QFont font_title_3 READ font_title_3 CONSTANT FINAL)
    Q_PROPERTY(QFont font_title_3_secondary READ font_title_3_secondary CONSTANT FINAL)

    Q_PROPERTY(QFont font_title_strong READ font_title_strong CONSTANT FINAL)
    Q_PROPERTY(QFont font_title_large READ font_title_large CONSTANT FINAL)
    Q_PROPERTY(QFont font_title_x_large READ font_title_x_large CONSTANT FINAL)
    Q_PROPERTY(QFont font_title_uppercase READ font_title_uppercase CONSTANT FINAL)
    Q_PROPERTY(QFont font_botton_1 READ font_botton_1 CONSTANT FINAL)
    Q_PROPERTY(QFont font_botton_2 READ font_botton_2 CONSTANT FINAL)
    Q_PROPERTY(QFont font_bubble READ font_bubble CONSTANT FINAL)


public:
    explicit iGUITokensModel();
    virtual QColor color_surface_accent_primary() const = 0;
    virtual QColor color_surface_accent_secondary() const = 0;
    virtual QColor color_surface_accent_error() const = 0;
    virtual QColor color_surface_accent_success() const = 0;

    virtual QColor color_text_primary() const = 0;
    virtual QColor color_text_secondary() const = 0;
    virtual QColor color_text_tertiary() const = 0;

    virtual QColor color_text_disabled() const = 0;
    virtual QColor color_border_primary() const = 0;
    virtual QColor color_border_secondary() const = 0;
    virtual QColor color_border_disabled() const = 0;
    virtual QColor color_devider_dark() const = 0;
    virtual QColor color_devider_white() const = 0;

    virtual QColor pressed_focused() const = 0;
    virtual QColor hover() const = 0;

    virtual QFont font_caption_1() const = 0;
    virtual QFont font_caption_2() const = 0;
    virtual QFont font_caption_3() const = 0;

    virtual QFont font_body_1() const = 0;
    virtual QFont font_body_2() const = 0;
    virtual QFont font_body_large() const = 0;
    virtual QFont font_subtitle_1() const = 0;
    virtual QFont font_subtitle_2() const = 0;
    virtual QFont font_subtitle_large() const = 0;
    virtual QFont font_subtitle_x_large() const = 0;
    virtual QFont font_subtitle_uppercase() const = 0;
    virtual QFont font_title_1() const = 0;
    virtual QFont font_title_1_secondary() const = 0;

    virtual QFont font_title_2() const = 0;

    virtual QFont font_title_3() const = 0;
    virtual QFont font_title_3_secondary() const = 0;

    virtual QFont font_title_strong() const = 0;
    virtual QFont font_title_large() const = 0;
    virtual QFont font_title_x_large() const = 0;
    virtual QFont font_title_uppercase() const = 0;
    virtual QFont font_botton_1() const = 0;
    virtual QFont font_botton_2() const = 0;
    virtual QFont font_bubble() const = 0;

    // iModel interface
public:
    QString modelId() const;

protected:
    /**
     * @brief addTransporent This method add alpha chennel to the color.
     * @param input input link to color
     * @param alpha alphachennol factor from 0 to 1.
     * @return color with new alpha chennel.
     */
    QColor& addTransporent(QColor& input, float alpha) const;
};
}
#endif // IGUITOKENSMODEL_H
