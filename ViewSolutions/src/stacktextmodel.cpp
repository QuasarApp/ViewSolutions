//#
//# Copyright (C) 2025-2026 QuasarApp.
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
    return _delimiter.pattern();
}

void StackTextModel::setDelimiter(const QString &newDelimiter) {
    if (_delimiter.pattern() == newDelimiter)
        return;
    _delimiter.setPattern(newDelimiter);
    updateText();
    emit delimiterChanged();
}

void StackTextModel::updateText() {
    QStringList lines;
    QString line;

    int delimeterIdx = _fullText.indexOf(_delimiter);
    int lastIdx = -1;
    while (delimeterIdx >= 0) {
        line = _fullText.mid(lastIdx + 1, delimeterIdx - lastIdx);
        lastIdx = delimeterIdx;
        delimeterIdx = _fullText.indexOf(_delimiter, lastIdx + 1);

        if (line.size()) {
            lines += line;
        }

    }

    // take last string.
    line = _fullText.mid(lastIdx + 1, delimeterIdx);
    if (line.size()) {
        lines += line;
    }

    setStringList(lines);
}

QHash<int, QByteArray> StackTextModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "display";
    return roles;
}
