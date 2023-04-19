#!/usr/bin/env bash

set -euo pipefail
cd $(mktemp -d)

wine-arm64 cmd.exe /c 'echo Hello World'
