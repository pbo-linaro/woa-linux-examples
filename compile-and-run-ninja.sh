#!/usr/bin/env bash

set -euo pipefail
cd $(mktemp -d)

echo "Compile and run windows-arm64 ninja using llvm-mingw windows-arm64"

echo "Download llvm-mingw windows-arm64"
wget -q https://github.com/mstorsjo/llvm-mingw/releases/download/20230320/llvm-mingw-20230320-ucrt-aarch64.zip
unzip -q *.zip && rm *.zip
mv llvm-mingw-* /llvm-mingw
rm /llvm-mingw/bin/ld # confuse cmake
export WINEPATH=/llvm-mingw/bin

echo "Download cmake windows-arm64"
wget -q https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3-windows-arm64.zip
unzip -q *.zip && rm *.zip
mv cmake-* /cmake/
export WINEPATH="/cmake/bin;$WINEPATH"

echo "Download ninja windows-arm64"
wget -q https://woastorage.blob.core.windows.net/packages/ninja/ninja_v1.11.1.zip
unzip *.zip && rm *.zip
mv ninja.exe /cmake/bin/

echo "Clone ninja"
git clone https://github.com/ninja-build/ninja && cd ninja
mkdir build && cd build
wine-arm64 cmake ../ -GNinja -DCMAKE_CXX_COMPILER=aarch64-w64-mingw32-clang++.exe
wine-arm64 ninja
file ninja.exe
wine-arm64 ./ninja.exe --version
