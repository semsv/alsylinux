   ./configure --prefix=/usr/src/tools/a52dec-0.7.4 \
               --mandir=/usr/share/man \
               --enable-shared \
               --disable-static \
               CFLAGS="-g -O2 $([ $(uname -m) = x86_64 ] && echo -fPIC)" && make