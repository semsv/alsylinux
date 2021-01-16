#!/bin/bash
as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

app="qt-everywhere-src"
version="5.15.2"
arch="tar.xz"
sapp="qt5-5.15.2"

app="$app-$version"
sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"
sed -i 's/@alsy.sapp.name/'$sapp'/g' "Makefile"

if [ ! -d ../build/$app ]; then
  mkdir -p ../build &&
  tar -xf "$app"."$arch" -C ../build
fi

if [ -d /lib64/gcc/x86_64-alesya-linux/9.2.0/include-fixed/openssl/ ]; then
 if [ -f /usr/include/openssl/bn.h ]; then
   sumval1=$(md5sum /usr/include/openssl/bn.h | cut -d " " -f1)
   sumval2=$(md5sum /lib64/gcc/x86_64-alesya-linux/9.2.0/include-fixed/openssl/bn.h | cut -d " " -f1)
   if [ "$sumval1" != "$sumval2" ]; then
     echo "Please enter the root password..."
     su -c "cp -r /usr/include/openssl/bn.h /lib64/gcc/x86_64-alesya-linux/9.2.0/include-fixed/openssl/"
   fi
 fi
fi

test_xcb_renderutl="$(pkg-config --modversion xcb-renderutil | wc -l)"
if [ "$test_xcb_renderutl" != "1" ]; then
  echo "Error: xcb-renderutil not found!"
  exit 1
fi

if [ $? -eq 0 ]; then  
  cd ../build
  if [ $? -eq 0 ]; then    
    pushd $app &&
      QT5PREFIX="/usr/src/tools/$sapp"
     ./configure -prefix $QT5PREFIX                        \
                 -sysconfdir /etc/xdg                      \
                 -confirm-license                          \
                 -opensource                               \
                 -dbus-linked                              \
                 -system-harfbuzz                          \
                 -system-sqlite                            \
                 -nomake examples                          \
                 -nomake tests                             \
                 -gui 					   \
                 -xcb                                      \
                 -openssl-linked                           \
                 -no-rpath && popd
  fi
fi