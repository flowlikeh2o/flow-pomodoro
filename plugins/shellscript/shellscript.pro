include ("../../global.pri")
include ("../plugins.pri")

CONFIG   += plugin
TARGET = shellscript
TEMPLATE = lib

HEADERS += shellscript.h
SOURCES += shellscript.cpp

INCLUDEPATH += ../../src/
DESTDIR = ../

RESOURCES += shellscriptplugin.qrc

QT += quick

OTHER_FILES += Config.qml
