Introduction to LLVM
The LLVM package contains a collection of modular and reusable compiler and toolchain technologies. The Low Level Virtual Machine (LLVM) Core libraries provide a modern source and target-independent optimizer, along with code generation support for many popular CPUs (as well as some less common ones!). These libraries are built around a well specified code representation known as the LLVM intermediate representation ("LLVM IR").

The optional Clang and Compiler RT packages provide new C, C++, Objective C and Objective C++ front-ends and runtime libraries for the LLVM and are required by some packages which use Rust, for example firefox.

This package is known to build and work properly using an LFS-9.1 platform.

Package Information
Download (HTTP): https://github.com/llvm/llvm-project/releases/download/llvmorg-9.0.1/llvm-9.0.1.src.tar.xz

Download MD5 sum: 31eb9ce73dd2a0f8dcab8319fb03f8fc

Download size: 30 MB

Estimated disk space required: 2.1 GB (with Clang, 655 MB installed, add 19 GB for tests)

Estimated build time: 30 SBU (with Clang and parallelism=4, add 5.5 SBU for tests)

Optional Downloads
Clang
Download: https://github.com/llvm/llvm-project/releases/download/llvmorg-9.0.1/clang-9.0.1.src.tar.xz

Download MD5 sum: 13468e4a44940efef1b75e8641752f90

Download size: 13 MB

Compiler RT
Download: https://github.com/llvm/llvm-project/releases/download/llvmorg-9.0.1/compiler-rt-9.0.1.src.tar.xz

Download MD5 sum: 1b39b9b90007a2170ebe77d6214ec581

Download size: 1.9 MB

LLVM Dependencies
Required
CMake-3.16.4

Optional
Doxygen-1.8.17, Graphviz-2.42.3, libxml2-2.9.10, Python-2.7.17, texlive-20190410 (or install-tl-unx), Valgrind-3.15.0, PyYAML-5.3, Zip-3.0, OCaml, recommonmark, Sphinx, and Z3

User Notes: http://wiki.linuxfromscratch.org/blfs/wiki/llvm
