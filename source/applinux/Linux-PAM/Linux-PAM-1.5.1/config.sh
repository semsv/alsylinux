#!/bin/bash
as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

app="Linux-PAM"
version="1.5.1"
arch="tar.gz"

if [ ! -f $app-$version.$arch ]; then
  filedwnld="https://github.com/linux-pam/linux-pam/releases/download/v1.5.1/$app-$version.$arch"
  wget $filedwnld -O "$app-$version".tar.gz
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
#    sed -e /service_DATA/d -i modules/pam_namespace/Makefile.am &&
    if [[ -f configure.ac && ! -x configure ]]; then
      libtoolize &&
      autoreconf -fiv
    fi &&
    if [ -x configure ]; then
      sed -e 's/dummy elinks/dummy lynx/'                                    \
          -e 's/-no-numbering -no-references/-force-html -nonumbers -stdin/' \
          -i configure &&
      ./configure --prefix=/usr/src/tools/$app     \
                  --sysconfdir=/etc                \
                  --libdir=/usr/lib                \
                  --enable-securedir=/lib/security && popd
    else
      meson  --prefix=/usr/src/tools/$app           \
             -Dbuildtype=release                    \
             .. && popd
    fi    
  fi
fi