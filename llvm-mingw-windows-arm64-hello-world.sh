#!/usr/bin/env bash
set -euo pipefail

echo "Compile and run windows-arm64 'hello world' using llvm-mingw windows-arm64"

echo "Download llvm-mingw windows-arm64"
wget -q https://github.com/mstorsjo/llvm-mingw/releases/download/20230320/llvm-mingw-20230320-ucrt-aarch64.zip
unzip -q *.zip && rm *.zip
mv llvm-mingw-* /llvm-mingw
export WINEPATH=/llvm-mingw/bin

echo "Compile Hello World"
wine-arm64 aarch64-w64-mingw32-clang++ hello_world.cpp -o hello.exe
file hello.exe

echo "Execute Hello World"
wine-arm64 hello.exe
