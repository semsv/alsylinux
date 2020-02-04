glibpref="/usr/src/tools/glibc-2.29_build"
CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" \
../../glibc-2.29/configure --prefix=$glibpref                        \
                           --disable-werror                          \
                           --enable-kernel=3.2                       \
                           --enable-multilib                         \
                           --enable-stack-protector=strong           \
                           --with-headers=/usr/include               \
                           --libexecdir=$glibpref/lib64/glibc-2.29   \
                           --libdir=$glibpref/lib64                  \
                           libc_cv_slibdir=$glibpref/lib64
