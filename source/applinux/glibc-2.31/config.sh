app=glibc-2.29
arch="x86-64"
   
   if [ ! -f $app.tar.gz ]; then
     filedwnld="https://ftp.gnu.org/gnu/glibc/$app.tar.gz"
     wget $filedwnld -O "$app".tar.gz
   fi
   
   if [ "$arch" != "x86-64" ]; then
     sapp="$app-$arch"
   else
     sapp="$app"
   fi
   sed 's/$alsy-app-prefix/'$sapp'/g' "Makefile.am" > "Makefile"
   glibpref="/usr/src/tools/$sapp"
   
   if [ -d "$app"_src ]; then
     rm -rd "$app"_src
   fi
   mkdir -p "$sapp"_src
   tar -xf "$app".tar.gz -C "$sapp"_src/

   if [ -d "$sapp"_src/build_ ]; then
     rm -rd "$sapp"_src/build_
   fi

   cd "$sapp"_src/ &&
   mkdir -p build_ &&
   cd build_ &&

if [ "$arch" == "x86-64" ]; then
# for x86-64 architecture
../$app/configure --prefix=$glibpref                       \
                  CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" \
                  --disable-werror                         \
                  --enable-kernel=3.2                      \
                  --enable-multilib                        \
                  --enable-stack-protector=strong          \
                  --with-headers=/usr/include              \
                  --libexecdir=$glibpref/lib64/$app        \
                  --libdir=$glibpref/lib64                 \
                  libc_cv_slibdir=$glibpref/lib64
else                           
# for x86-32 architecture
../$app/configure --prefix=$glibpref                 \
                  CC="gcc -m32" CXX="g++ -m32"       \
                  CFLAGS="-O2 -march=i686"           \
                  CXXFLAGS="-O2 -march=i686"         \     
                  --disable-werror                   \
                  --enable-kernel=3.2                \
                  --enable-multilib                  \
                  --enable-stack-protector=strong    \
                  --with-headers=/usr/include        \
                  --libexecdir=$glibpref/lib32/$app  \
                  --libdir=$glibpref/lib32           \
                  libc_cv_slibdir=$glibpref/lib32
fi 
