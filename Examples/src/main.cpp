/****************************************************************************
**
#
# Copyright (C) 2018-2020 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

****************************************************************************/
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <viewsolutions.h>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("ViewSolutionsExample");
    QGuiApplication::setOrganizationName("QuasarApp");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    if (!ViewSolutions::init(&engine)) {
        return -1;
    }

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
