TEMPLATE = app

QT += qml quick

SOURCES += main.cpp

RESOURCES += qml.qrc \
    image.qrc \
    particle_image.qrc \
    start_image.qrc \
    background_image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=
