CFLAGS="-g -O2 $([ $(uname -m) = x86_64 ] && echo -fPIC)" \
cmake -DCMAKE_INSTALL_PREFIX=/usr/src/tools/taglib-1.11.1 \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON