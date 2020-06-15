#!/bin/bash
sapp="orc-0.4.31"
app="orc-0.4.31"
arch="tar.xz"

sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ -d ../build/$app ]; then
 rm -rd ../build
 if [ $? -eq 0 ]; then
   echo "delete..[ ok ]"
 else
   exit 1
 fi
fi

mkdir -p ../build &&
tar -xf "$app"."$arch" -C ../build
if [ $? -eq 0 ]; then
  cd ../build/$app
  if [ $? -eq 0 ]; then    
    meson  --prefix=/usr/src/tools/$sapp \
           -Dbuildtype=release \
           -Dgtk_doc=disabled  \
           ..
  fi
fi
