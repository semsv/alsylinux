app="mesa-18.3.6"
GALLIUM_DRV="i915,nouveau,r600,radeonsi,svga,swrast,virgl"
DRI_DRIVERS="i965,nouveau"
XORG_PREFIX="/usr/src/tools/$app"

# Install Mesa by running the following commands:
#CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}"
#export LLVM_CONFIG=/usr/bin/llvm-config32
#patch -Np1 -i ../mesa-19.3.3-fix_svga_vmwgfx_segfaults-1.patch &&

if [ -d ../build ]; then
  rm -rd ../build
fi

mkdir -p ../build &&
cp $app.tar.xz ../build &&
cd    ../build &&
tar -xf $app.tar.xz &&
cd $app &&
  meson --prefix=$XORG_PREFIX           \
        -D gles1=true                   \
        -D gles2=true                   \
        -D buildtype=release            \
        -D dri-drivers=$DRI_DRIVERS     \
        -D gallium-drivers=$GALLIUM_DRV \
        -D gallium-nine=false           \
        -D glx=dri                      \
        -D osmesa=gallium               \
        -D valgrind=false               \
  ..                             &&
  unset GALLIUM_DRV DRI_DRIVERS
