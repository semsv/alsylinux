#!/bin/bash
as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}

app="boost"
version="1_75_0"
ver="1.75.0"
arch="tar.bz2"

app=$app"_"$version
sed 's/@alsy.app.name/'$app'/g' "Makefile.am" > "Makefile"

if [ ! -f $app.$arch ]; then
 wget "https://dl.bintray.com/boostorg/release/$ver/source/$app.$arch" -O $app.$arch
fi

if [ -d ../build/$app ]; then 
 as_root rm -rfd ../build
 if [ $? -eq 0 ]; then
   echo "clean .. [ ok ]"
 else
   exit 1
 fi
fi

#echo -e "\n" &&
#echo "Please enter root password,   " &&
#echo -e " for install Python modules...\n"
#as_root make -f Makefile.pi
            
mkdir -p ../build &&
tar -xf "$app"."$arch" -C ../build
if [ $? -eq 0 ]; then  
  cd ../build
  if [ $? -eq 0 ]; then    
    pushd $app &&    
    ./bootstrap.sh --prefix=$app --with-python=python3 && popd
  fi
fi