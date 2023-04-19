#!/usr/bin/env bash
set -euo pipefail

echo "Compile and run windows-arm64 'hello world' using llvm-mingw linux-x64"

echo "Download llvm-mingw linux-x64"
wget -q https://github.com/mstorsjo/llvm-mingw/releases/download/20230320/llvm-mingw-20230320-ucrt-ubuntu-18.04-x86_64.tar.xz
tar xf *.tar.xz && rm *.tar.xz
mv llvm-mingw-* /llvm-mingw
export PATH=/llvm-mingw/bin:$PATH

echo "Compile Hello World"
aarch64-w64-mingw32-clang++ hello_world.cpp -o hello.exe
file hello.exe

echo "Need to add {libc++,libunwind}.dll to WINEPATH"
export WINEPATH=/llvm-mingw/aarch64-w64-mingw32/bin/

echo "Execute Hello World"
wine-arm64 hello.exe
