#!/usr/bin/env bash
set -euo pipefail

echo "Compile and run windows-arm64 'hello world' using MSVC"

echo "Dependencies"
apt update && apt install -y wine64 python3 msitools python3-simplejson python3-six ca-certificates winbind
ln -s /usr/bin/wine /usr/bin/wine64
echo "Download MSVC using https://github.com/mstorsjo/msvc-wine"
git clone https://github.com/mstorsjo/msvc-wine
msvc-wine/vsdownload.py --accept-license --dest /msvc
msvc-wine/install.sh /msvc
export PATH=/msvc/bin/arm64:$PATH

echo "Compile Hello World"
which cl
cl hello_world.cpp
file hello_world.exe

echo "Execute Hello World"
wine-arm64 hello_world.exe
