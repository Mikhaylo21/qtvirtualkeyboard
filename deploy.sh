#!/bin/bash
ip=192.168.2.67
builddir=/home/user/cpp/qtvirtualkeyboard/arm_build
installdir=$builddir/install
sourcedir=/home/user/cpp/qtvirtualkeyboard

#clean install dir
rm -r -f $installdir

mkdir -p $installdir

mkdir -p $installdir/plugins/platforminputcontexts/ 2> /dev/null
install -m 755 -p $builddir/plugins/platforminputcontexts/libqtvirtualkeyboardplugin.so $installdir/plugins/platforminputcontexts/libqtvirtualkeyboardplugin.so

mkdir -p $installdir/lib/cmake/Qt5Gui/ 2> /dev/null
install -m 644 -p $builddir/lib/cmake/Qt5Gui/Qt5Gui_QVirtualKeyboardPlugin.cmake $installdir/lib/cmake/Qt5Gui/Qt5Gui_QVirtualKeyboardPlugin.cmake

mkdir -p $installdir/import/ 2> /dev/null
install -m 644 -p $sourcedir/src/virtualkeyboard/import/qmldir $installdir/import/qmldir
install -m 644 -p $sourcedir/src/virtualkeyboard/import/plugins.qmltypes $installdir/import/plugins.qmltypes

mkdir -p $installdir/qml/QtQuick/VirtualKeyboard/Styles/ 2> /dev/null
install -m 755 -p $builddir/qml/QtQuick/VirtualKeyboard/Styles/libqtvirtualkeyboardstylesplugin.so $installdir/qml/QtQuick/VirtualKeyboard/Styles/libqtvirtualkeyboardstylesplugin.so

mkdir -p $installdir/styles/ 2> /dev/null
install -m 644 -p $sourcedir/src/virtualkeyboard/styles/qmldir $installdir/styles/qmldir
install -m 644 -p $sourcedir/src/virtualkeyboard/styles/plugins.qmltypes $installdir/styles/plugins.qmltypes

rm install.tar 2> /dev/null
cd $builddir
tar -cf install.tar install
scp install.tar root@$ip:/home/root/install.tar
ssh root@$ip "tar -xf install.tar"

ssh root@$ip "install -m 755 -p /home/root/install/plugins/platforminputcontexts/libqtvirtualkeyboardplugin.so /usr/lib/qt5/plugins/platforminputcontexts/libqtvirtualkeyboardplugin.so"
ssh root@$ip "install -m 644 -p /home/root/install/lib/cmake/Qt5Gui/Qt5Gui_QVirtualKeyboardPlugin.cmake /usr/lib/cmake/Qt5Gui/"
ssh root@$ip "mkdir /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/"
ssh root@$ip "install -m 644 -p /home/root/install/import/qmldir /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/"
ssh root@$ip "install -m 644 -p /home/root/install/import/plugins.qmltypes /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/"
ssh root@$ip "mkdir /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/Styles/"
ssh root@$ip "install -m 755 -p /home/root/install/qml/QtQuick/VirtualKeyboard/Styles/libqtvirtualkeyboardstylesplugin.so /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/Styles/libqtvirtualkeyboardstylesplugin.so"
ssh root@$ip "install -m 644 -p /home/root/install/styles/qmldir /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/Styles/"
ssh root@$ip "install -m 644 -p /home/root/install/styles/plugins.qmltypes /usr/lib/qt5/qml/QtQuick/VirtualKeyboard/Styles/"

cd $sourcedir
