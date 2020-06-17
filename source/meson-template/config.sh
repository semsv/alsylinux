app="$1"
arch="tar.xz"

if [ -d ../build/$app ]; then
  echo "Delete .... [ ok ]"
  rm -rd ../build
fi

cp Makefile.am Makefile

mkdir -p ../build &&
tar -xf $app.$arch -C ../build &&
cd ../build/$app &&
  meson --prefix=/usr/src/tools/$app \
  .. 
