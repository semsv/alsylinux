#!/bin/bash

app="x265_v3.3"
mch="x265_3.3"
seax="$mch/source"
sapp="libx265"
arch="tar.gz"

sed 's/alsyappname/'$mch'/g' "Makefile.am" > "Makefile"

if [ -d ../build ]; then
  rm -rd ../build
fi

mkdir -p ../build &&
cp $app.$arch ../build &&
cd    ../build &&
tar -xf $app.$arch &&
cd $seax &&
CFLAGS="-g -O2 $([ $(uname -m) = x86_64 ] && echo -fPIC)" \
cmake -DCMAKE_INSTALL_PREFIX=/usr/src/tools/$sapp \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON
       