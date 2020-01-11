#!/bin/bash
#
# Embeds the Qt libraries inside the application bundle, allowing it to be redistributed
# to any Mac without Qt installed.
# 
# -- Julien Ponge <julien@izforge.com>

Frameworks=/usr/local/Frameworks

rm -rf launcher.app/Contents/Frameworks
mkdir launcher.app/Contents/Frameworks
cp -RHL $Frameworks/Qt{Core,Gui,Widgets}.framework launcher.app/Contents/Frameworks

find launcher.app -name '*_debug' | xargs rm
find launcher.app -name 'Headers' | xargs rm -rf

install_name_tool -id @executable_path/../Frameworks/QtCore.framework/Versions/5/QtCore \
launcher.app/Contents/Frameworks/QtCore.framework/Versions/5/QtCore

install_name_tool -id @executable_path/../Frameworks/QtGui.framework/Versions/5/QtGui \
launcher.app/Contents/Frameworks/QtGui.framework/Versions/5/QtGui

install_name_tool -id @executable_path/../Frameworks/QtWidgets.framework/Versions/5/QtWidgets \
launcher.app/Contents/Frameworks/QtWidgets.framework/Versions/5/QtWidgets

# change laucher dependencies
# (launcher depends on core, gui, widgets)

install_name_tool -change $Frameworks/QtCore.framework/Versions/5/QtCore \
@executable_path/../Frameworks/QtCore.framework/Versions/5/QtCore \
launcher.app/Contents/MacOS/launcher

install_name_tool -change $Frameworks/QtGui.framework/Versions/5/QtGui \
@executable_path/../Frameworks/QtGui.framework/Versions/5/QtGui \
launcher.app/Contents/MacOS/launcher

install_name_tool -change $Frameworks/QtWidgets.framework/Versions/5/QtWidgets \
@executable_path/../Frameworks/QtWidgets.framework/Versions/5/QtWidgets \
launcher.app/Contents/MacOS/launcher

# change gui dependencies
# (gui dependens on core)

install_name_tool -change $Frameworks/QtCore.framework/Versions/5/QtCore \
@executable_path/../Frameworks/QtCore.framework/Versions/5/QtCore \
launcher.app/Contents/Frameworks/QtGui.framework/Versions/5/QtGui

# change widgets dependencies
# (widgets depends on core, gui)

install_name_tool -change $Frameworks/QtCore.framework/Versions/5/QtCore \
@executable_path/../Frameworks/QtCore.framework/Versions/5/QtCore \
launcher.app/Contents/Frameworks/QtWidgets.framework/Versions/5/QtWidgets

install_name_tool -change $Frameworks/QtGui.framework/Versions/5/QtGui \
@executable_path/../Frameworks/QtGui.framework/Versions/5/QtGui \
launcher.app/Contents/Frameworks/QtWidgets.framework/Versions/5/QtWidgets


tar cjf ../dist/launcher.app-macosx-universal.tar.bz2 launcher.app/
