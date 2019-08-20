ALSYBUILDPATH="/usr/src/alsy-source/NetworkManager-1.18.2/build"
echo $ALSYBUILDPATH > "ALSYBUILDPATH"

if [ -d build ]; then
  rm -rd build
fi

mkdir build &&
cd    build &&

CXXFLAGS+="-O2 -fPIC"            \
meson --prefix /usr              \
      --sysconfdir /etc          \
      --localstatedir /var       \
      -Djson_validation=false    \
      -Dlibaudit=no              \
      -Dlibpsl=false             \
      -Dnmtui=true               \
      -Dovs=false                \
      -Dppp=false                \
      -Dselinux=false            \
      -Dudev_dir=/lib/udev       \
      -Dsession_tracking=elogind \
      -Dmodem_manager=false      \
      -Dsystemdsystemunitdir=no  \
      -Dsystemd_journal=false    \
      -Dqt=false                 \
      ..
