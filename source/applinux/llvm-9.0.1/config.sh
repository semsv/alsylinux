app_prefix="/usr/src/tools/llvm-9.0.1"

if [ -d build ]; then
  rm -rd build
fi
if [ -d tools/clang ]; then
  rm -rd tools/clang
fi
if [ -d projects/compiler-rt ]; then
  rm -rd projects/compiler-rt
fi

tar -xf ../clang-9.0.1.src.tar.xz -C tools          &&
tar -xf ../compiler-rt-9.0.1.src.tar.xz -C projects &&

mv tools/clang-9.0.1.src tools/clang &&
mv projects/compiler-rt-9.0.1.src projects/compiler-rt &&

#Fix a problem introduced by Glibc-2.31:
if [ "$(ldd --version | grep '2.31')" != "" ]; then
sed -e '/ipc_perm, mode/s|^|//|' \
    -i projects/compiler-rt/lib/sanitizer_common/anitizer_platform_limits_posix.cc
fi

mkdir -p build &&
cd       build &&

CC=gcc CXX=g++                                  \
cmake -DCMAKE_INSTALL_PREFIX=$app_prefix        \
      -DCMAKE_BUILD_TYPE=Release                \
      -DLLVM_BUILD_LLVM_DYLIB=ON                \
      -DLLVM_LINK_LLVM_DYLIB=ON                 \
      -DLLVM_ENABLE_RTTI=ON                     \
      -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;BPF" \
      -DLLVM_BUILD_TESTS=ON                     \
      -Wno-dev -G Ninja ..                      &&
ninja
