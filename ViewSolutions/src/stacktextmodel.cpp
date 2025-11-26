//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "stacktextmodel.h"

StackTextModel::StackTextModel() {}

QString StackTextModel::fullText() const {
    return _fullText;
}

void StackTextModel::setFullText(const QString &newFullText) {
    if (_fullText == newFullText)
        return;
    _fullText = newFullText;
    updateText();
    emit fullTextChanged();
}

QString StackTextModel::delimiter() const {
    return _delimiter;
}

void StackTextModel::setDelimiter(const QString &newDelimiter) {
    if (_delimiter == newDelimiter)
        return;
    _delimiter = newDelimiter;
    updateText();
    emit delimiterChanged();
}

void StackTextModel::updateText() {
    QStringList lines = _fullText.split(_delimiter, Qt::SkipEmptyParts);
    setStringList(lines);
}



QHash<int, QByteArray> StackTextModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "display";
    return roles;
}
