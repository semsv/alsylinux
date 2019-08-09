case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir build                                          &&
cd    build                                          &&

../configure                                         \
    --prefix=/usr/src/tools/gcc-7.3.0                \
    --disable-multilib                               \
    --with-system-zlib                               \
    --target=x86_64-alsy-linux                       \
    --build=x86_64-alsy-linux                        \
    --host=x86_64-alsy-linux                         \
    --enable-languages=c,c++,fortran,go,objc,obj-c++
