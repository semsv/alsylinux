   app=glibc-2.31
   glibpref="/usr/src/tools/$app"

   if [ -d "$app"_src ]; then
     rm -rd "$app"_src
   fi
   mkdir -p "$app"_src
   tar -xf "$app".tar.gz -C "$app"_src/

   if [ -d "$app"_src/build_ ]; then
     rm -rd "$app"_src/build_
   fi

   CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" \
   cd "$app"_src/ &&
   mkdir -p build_ &&
   cd build_ &&
         ../$app/configure --prefix=$glibpref                        \
                           --disable-werror                          \
                           --enable-kernel=3.2                       \
                           --enable-multilib                         \
                           --enable-stack-protector=strong           \
                           --with-headers=/usr/include               \
                           --libexecdir=$glibpref/lib64/$app         \
                           --libdir=$glibpref/lib64                  \
                           libc_cv_slibdir=$glibpref/lib64

