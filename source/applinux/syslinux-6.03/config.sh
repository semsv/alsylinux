#!/bin/bash

app="syslinux-6.03"
arch="tar.xz"

sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ -d ../build/$app ]; then
 sudo rm -rd ../build
 if [ $? -eq 0 ]; then
   echo "delete..[ ok ]"
 else
   exit 1
 fi
fi

mkdir -p ../build &&
tar -xf "$app"."$arch" -C ../build
cp syslinux.patch -t ../build
if [ $? -eq 0 ]; then
  cd ../build/$app
  patch -Np1 -i ../syslinux.patch &&
  if [ $? -eq 0 ]; then
   echo "configure............ [ OK ]"
  fi
fi 
