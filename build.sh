#!/bin/bash
set -e

git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter_sdk
export PATH="$PATH:$(pwd)/flutter_sdk/bin"

flutter config --no-analytics --enable-web
flutter pub get
flutter build web --release
