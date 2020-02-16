   glibpref="/usr/src/tools/glibc-2.31"

   if [ -d glibc-2.31_src ]; then
     sudo rm -rd glibc-2.31_src
   fi
   mkdir -p glibc-2.31_src
   sudo tar -xf glibc-2.31.tar.gz -C glibc-2.31_src/

   if [ -d glibc-2.31_src/build_ ]; then
     rm -rd glibc-2.31_src/build_
   fi

   CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" \
   cd glibc-2.31_src/ &&
   mkdir -p build_ &&
   cd build_ &&
   ../glibc-2.31/configure --prefix=$glibpref                        \
                           --disable-werror                          \
                           --enable-kernel=3.2                       \
                           --enable-multilib                         \
                           --enable-stack-protector=strong           \
                           --with-headers=/usr/include               \
                           --libexecdir=$glibpref/lib64/glibc-2.31   \
                           --libdir=$glibpref/lib64                  \
                           libc_cv_slibdir=$glibpref/lib64

