#!/bin/bash

app="vlc-3.0.10"
arch="tar.xz"

sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ -d $app ]; then
 rm -rd $app
 if [ $? -eq 0 ]; then
   echo "delete..[ ok ]"
 else
   exit 1
 fi
fi

tar -xf "$app"."$arch"
sleep 3
if [ $? -eq 0 ]; then
  cd $app
  if [ $? -eq 0 ]; then
    BUILDCC="/usr/bin/gcc -std=gnu99" configure --prefix=/usr/src/tools/$app --disable-lua
  fi
fi