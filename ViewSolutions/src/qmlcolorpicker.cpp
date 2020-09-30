#include "qmlcolorpicker.h"

#include <QQmlApplicationEngine>
#include <QQuickAsyncImageProvider>
namespace ViewSolutions {

QMLColorPicker::QMLColorPicker(QObject *parent) :
    QObject(parent) {

}

QMLColorPicker *ViewSolutions::QMLColorPicker::instance() {
    static auto ints = new QMLColorPicker();
    return ints;
}

QColor QMLColorPicker::pick(const QString &img) const {

    if (img.left(6) == "image:") {
        int urlBegin = img.indexOf('/', 8);
        QString id = img.mid(8, urlBegin - 8);

        if (!_engine)
            return {};

        QQuickImageProvider* provider = dynamic_cast<QQuickImageProvider*>(_engine->imageProvider(id));

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

    return ColorPicker::pick(img);
}

void QMLColorPicker::setEngine(QQmlApplicationEngine *engine) {
    _engine = engine;
}
}
