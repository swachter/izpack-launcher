TEMPLATE = app
CONFIG += warn_on release qt
macx {
#    QMAKE_MAC_SDK=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
    CONFIG += x86 ppc
    DEFINES += Q_WS_MAC
}
QT = core gui widgets
FORMS = resolve-dialog.ui
HEADERS = launcher.h resolve-dialog.h
SOURCES = main.cpp launcher.cpp resolve-dialog.cpp
RESOURCES = resources.qrc
TRANSLATIONS = launcher_fr.ts launcher_de.ts
TARGET=launcher
win32 {
    RC_FILE = win32.rc
}
macx {
    RC_FILE = img/mac.icns
}
