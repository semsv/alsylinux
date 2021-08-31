#/bin/sh
app="NetworkManager-1.32.6"
PREFIX="/usr/src/tools/$app"
appPython="$(ls -l /usr/bin/python3 | cut -d'>' -f2 | cut -d' ' -f2)" 
arch="tar.gz"

export PKG_CONFIG_PATH="/lib/pkgconfig:/lib32/pkgconfig:/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/share/pkgconfig:/usr/src/tools/XORG-7/lib/pkgconfig"
LIBRARY_PATH=""
C_INCLUDE_PATH=""
CPLUS_INCLUDE_PATH="$C_INCLUDE_PATH"
LIBRARY_PATH="$XORG_PREFIX/lib:$GTK3_PREFIX/lib"
C_INCLUDE_PATH="$XORG_PREFIX/include:$GTK3_PREFIX/include"
CPLUS_INCLUDE_PATH="$XORG_PREFIX/include:$GTK3_PREFIX/include"
ACLOCAL="aclocal -I $GTK3_PREFIX/share/aclocal"
export ACLOCAL
export LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH
export GTK3_PREFIX
export LD_LIBRARY_PATH="$GTK3_PREFIX/usr/lib:$GTK3_PREFIX/lib:$GTK3_PREFIX/usr/lib64:$GTK3_PREFIX/lib64"

if [ -d ../build ]; then
  rm -rd ../build
fi

if [ "$appPython" != "" ]; then
mkdir -p ../build &&
cp $app.$arch ../build &&
cd    ../build &&
tar -xf $app.$arch &&
cd $app &&
sed '/initrd/d' -i src/meson.build &&
if [ -x /usr/bin/$appPython ]; then
  sudo rm /usr/bin/$appPython
fi &&
sudo ln -s /usr/local/bin/$appPython /usr/bin/$appPython && 
python3 -m pip install -U pip &&
python3 -m pip install -U PyGObject &&
grep -rl '^#!.*python$' | xargs sed -i '1s/python/&3/' &&
  CXXFLAGS+="-O2 -fPIC"            \
  meson --prefix $PREFIX           \
        --sysconfdir /etc          \
        --localstatedir /var       \
        -Djson_validation=false    \
        -Dlibaudit=no              \
        -Dlibpsl=false             \
        -Dnmtui=false              \
        -Dovs=false                \
        -Dppp=false                \
        -Dselinux=false            \
        -Dsession_tracking=elogind \
        -Dudev_dir=/lib/udev       \
        -Dmodem_manager=false      \
        -Dsystemdsystemunitdir=no  \
        -Dsystemd_journal=false    \
        -Dqt=false                 \
  .. 
fi 
