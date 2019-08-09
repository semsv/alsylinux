#/bin/sh
ALSYBUILDPATH="/src-linux/gcc-7.3.0/build"
echo $ALSYBUILDPATH > "ALSYBUILDPATH"
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac
if [ -d build ]; then
 rm -rd build
fi
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
