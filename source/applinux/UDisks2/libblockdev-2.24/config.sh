#!/bin/bash
as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

app="libblockdev"
version="2.24"
arch="tar.gz"

if [ ! -f $app-$version.$arch ]; then
  filedwnld="https://github.com/storaged-project/$app/releases/download/2.24-1/$app-$version.$arch"
  wget $filedwnld -O $app-$version.$arch
fi


app="$app-$version"
sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ -d ../build/$app ]; then
 echo "Please enter root password..."
 as_root rm -rd ../build
 if [ $? -eq 0 ]; then
   echo "clean .. [ ok ]"
 else
   exit 1
 fi
fi

# check libtirpc
if [ "$(pkg-config --modversion libtirpc | wc -w)" == "1" ]; then
  echo "check libtirpc.......$(pkg-config --modversion libtirpc)...[ok]"
else
  echo "Error: libtirpc not found!"
  exit 1
fi

mkdir -p ../build &&
tar -xf "$app"."$arch" -C ../build
if [ $? -eq 0 ]; then  
  cd ../build
  if [ $? -eq 0 ]; then    
    pushd $app &&
    if [[ -f configure.ac && ! -x configure ]]; then
      libtoolize &&
      autoreconf -fiv
    fi &&
    if [ -x configure ]; then     
      export TMPDIR=/tmp &&
      export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/include" &&
      sed 's/--tmpdir/-t/g' -i configure &&
      sed 's/XXXXX.c/setup.tmp.1.XXXXXXXX/g' -i configure &&
      ./configure --prefix=/usr/src/tools/$app \
                  --sysconfdir=/etc \
                  --with-python3    \
                  --without-gtk-doc \
                  --without-nvdimm  \
                  --without-dm && popd
    elif [ -f meson.build ]; then
      meson  --prefix=/usr/src/tools/$app           \
             -Dbuildtype=release                    \
             .. && popd
    else         
      CFLAGS="-g -O2 $([ $(uname -m) = x86_64 ] && echo -fPIC)" \
      cmake -DCMAKE_INSTALL_PREFIX=/usr/src/tools/$app \
            -DCMAKE_BUILD_TYPE=Release \
            -DBUILD_SHARED_LIBS=ON && popd
    fi    
  fi
fi