#!/bin/bash
sapp="xproto-xproto-7.0.31"
app="$sapp"
arch="tar.gz"

sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ -d ../build/$app ]; then
 rm -rd ../build
 if [ $? -eq 0 ]; then
   echo "clean .. [ ok ]"
 else
   exit 1
 fi
fi

mkdir -p ../build &&
tar -xf "$app"."$arch" -C ../build
if [ $? -eq 0 ]; then  
  cd ../build
  if [ $? -eq 0 ]; then    
    pushd $app &&
    if [ -f configure.ac ]; then
      libtoolize &&
      autoreconf -fvi
    fi &&
    ./configure --prefix=/usr/src/tools/$app && popd
  fi
fi