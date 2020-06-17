#!/bin/bash
sapp="cdparanoia-III-10.2"
app="cdparanoia-III-10.2"
arch="src.tgz"

sed 's/@app.alsy.name/'$app'/g' "Makefile.am" > "Makefile"

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
if [ -f cdparanoia-III-10.2-gcc_fixes-1.patch ]; then
  cp cdparanoia-III-10.2-gcc_fixes-1.patch ../build  
fi
if [ $? -eq 0 ]; then
  cd ../build/$app
  if [ $? -eq 0 ]; then    
    pip3 install -U meson &&    
    patch -Np1 -i ../cdparanoia-III-10.2-gcc_fixes-1.patch &&
    ./configure --prefix=/usr/src/tools/$app \
                --mandir=/usr/src/tools/$app/usr/share/man
  fi
fi

