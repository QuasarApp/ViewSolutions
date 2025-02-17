
//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#include "qmlcolorpicker.h"

#include <QQmlApplicationEngine>
#include <QQuickAsyncImageProvider>
namespace ViewSolutions {

QMLColorPicker::QMLColorPicker(QObject *parent) :
    QObject(parent) {

}

QColor QMLColorPicker::pick(const QString &img) const {

    if (img.left(6) == "image:") {
        int urlBegin = img.indexOf('/', 8);
        QString id = img.mid(8, urlBegin - 8);

        if (auto eng = engine()) {
            QQuickImageProvider* provider = dynamic_cast<QQuickImageProvider*>(eng->imageProvider(id));

            if (!provider) {
                return {};
            }

            QString url = img.mid(urlBegin + 1);

            if (provider->imageType() & QQmlImageProviderBase::ImageResponse) {
                auto async = static_cast<QQuickAsyncImageProvider*>(provider);
                auto textureFacrory = async->requestImageResponse(url, {})->textureFactory();

                if (!textureFacrory) {
                    return {};
                }

                QColor responce = ColorPicker::pick(textureFacrory->image());

                delete textureFacrory;

                return responce;
            }

            if (provider->imageType() & QQmlImageProviderBase::Texture) {
                return ColorPicker::pick(provider->requestTexture(url, nullptr, {})->image());
            }

            if (provider->imageType() & QQmlImageProviderBase::Pixmap) {
                return ColorPicker::pick(provider->requestPixmap(url, nullptr, {}).toImage());
            }

            if (provider->imageType() & QQmlImageProviderBase::Image) {
                return ColorPicker::pick(provider->requestImage(url, nullptr, {}));
            }

            return {};
        }

    }

    return ColorPicker::pick(img);
}

QString QMLColorPicker::modelId() const {
    return "ColorPicker";
}

}
