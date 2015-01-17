#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include "settings.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QTranslator qtTranslator;
    qtTranslator.load("anyqqtail_zh_CN.qm");
    app.installTranslator(&qtTranslator);

    Settings *settings = new Settings;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("MySettings", settings);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
