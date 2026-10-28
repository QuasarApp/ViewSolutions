//#
//# Copyright (C) 2024-2026 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "iguitokensmodel.h"

namespace ViewSolutions {

iGUITokensModel::iGUITokensModel() {}

QString iGUITokensModel::modelId() const {
    return "GUITokens";
}

QColor iGUITokensModel::addTransparent(QColor input, float alpha) const {
    return addTransparentImpl(input, alpha);
}

QColor &iGUITokensModel::addTransparentImpl(QColor &input, float alpha) const {
    input.setAlphaF(alpha);
    return input;
}

}
