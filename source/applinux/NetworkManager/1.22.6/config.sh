
app="NetworkManager-1.22.6"
PREFIX="/usr/src/tools/$app"

if [ -d ../build ]; then
  rm -rd ../build
fi

mkdir -p ../build &&
cp $app.tar.xz ../build &&
cd    ../build &&
tar -xf $app.tar.xz &&
cd $app &&
sed '/initrd/d' -i src/meson.build &&
rm -r /usr/bin/python3.6 &&
ln -s /usr/local/bin/python3.6 /usr/bin/python3.6 &&
python3.6 -m pip install -U pip &&
python3.6 -m pip install -U PyGObject &&
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