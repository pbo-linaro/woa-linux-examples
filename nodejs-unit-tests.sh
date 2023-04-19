#!/usr/bin/env bash

set -euo pipefail
cd $(mktemp -d)

echo "Execute nodejs unit tests using nodejs for windows-arm64"

echo "Download python windows-arm64"
wget -q https://www.nuget.org/api/v2/package/pythonarm64/3.11.3 -O python.zip
unzip -q python.zip
mv tools/ /python
export WINEPATH=/python

echo "Download node windows-arm64"
NODE_VERSION=20.0.0
wget -q https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-win-arm64.zip
unzip -q node-*.zip
mv node-*-win-arm64 /node

echo "Clone node source"
git clone --depth=1 https://github.com/nodejs/node
cd node
mkdir Release
mv /node/node.exe Release

echo "Run node tests containing 'common' in name"
wine-arm64 python.exe tools/test.py -p tap --flaky-tests=skip common || true
