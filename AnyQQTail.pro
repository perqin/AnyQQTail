TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    settings.cpp

RESOURCES += qml.qrc

TRANSLATIONS += anyqqtail_zh_CN.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    settings.h
