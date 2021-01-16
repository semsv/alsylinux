#!/bin/sh
#$1=PREFIX QT5;          FOR SAMPLE: /usr/src/tools/qt5-5.15.2
#$2=QT5 SOURCE CODE DIR; FOR SAMPLE: qt-everywhere-src-5.15.2 

QT5PREFIX=$1
QT5BINDIR=$QT5PREFIX/bin
app=$2

pushd ../build/$app

install -v -dm755 $QT5PREFIX/share/pixmaps/                  &&
install -v -Dm644 qttools/src/assistant/assistant/images/assistant-128.png \
                  $QT5PREFIX/share/pixmaps/assistant-qt5.png &&
install -v -Dm644 qttools/src/designer/src/designer/images/designer.png \
                  $QT5PREFIX/share/pixmaps/designer-qt5.png  &&
install -v -Dm644 qttools/src/linguist/linguist/images/icons/linguist-128-32.png \
                  $QT5PREFIX/share/pixmaps/linguist-qt5.png  &&
install -v -Dm644 qttools/src/qdbus/qdbusviewer/images/qdbusviewer-128.png \
                  $QT5PREFIX/share/pixmaps/qdbusviewer-qt5.png &&
install -dm755 $QT5PREFIX/share/applications

popd

if [ -d /usr/src/tools/qt5 ]; then
  rm -rd /usr/src/tools/qt5 
fi
mkdir -pv $QT5PREFIX/usr/src/tools/
ln -s $QT5PREFIX $QT5PREFIX/usr/src/tools/qt5
mkdir -pv $QT5PREFIX/share/applications/
mkdir -pv $QT5PREFIX/etc/profile.d/

cat > $QT5PREFIX/share/applications/assistant-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Assistant
Comment=Shows Qt5 documentation and examples
Exec=$QT5BINDIR/assistant
Icon=assistant-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Documentation;
EOF

cat > $QT5PREFIX/share/applications/designer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Designer
GenericName=Interface Designer
Comment=Design GUIs for Qt5 applications
Exec=$QT5BINDIR/designer
Icon=designer-qt5.png
MimeType=application/x-designer;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF

cat > $QT5PREFIX/share/applications/linguist-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Linguist
Comment=Add translations to Qt5 applications
Exec=$QT5BINDIR/linguist
Icon=linguist-qt5.png
MimeType=text/vnd.trolltech.linguist;application/x-linguist;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF

cat > $QT5PREFIX/share/applications/qdbusviewer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 QDbusViewer
GenericName=D-Bus Debugger
Comment=Debug D-Bus applications
Exec=$QT5BINDIR/qdbusviewer
Icon=qdbusviewer-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Debugger;
EOF

cat > $QT5PREFIX/etc/profile.d/qt5.sh << "EOF"
# Begin /etc/profile.d/qt5.sh
#!/bin/sh
QT5PREFIX=/usr/src/tools/qt5
QT5DIR=$QT5PREFIX
PKG_CONFIG_PATH="$QT5DIR/bin:$PKG_CONFIG_PATH"
PATH="$QT5DIR/bin:$PATH"
export QT5PREFIX;
export QT5DIR;
export PKG_CONFIG_PATH;
export PATH;
# End /etc/profile.d/qt5.sh
EOF

chmod a+rwx $QT5PREFIX/etc/profile.d/qt5.sh