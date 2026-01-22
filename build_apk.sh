#!/bin/bash

set -e

# Setup environment
export ANDROID_HOME=~/android-sdk
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH:/tmp/flutter/bin:$ANDROID_HOME/platform-tools"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export FLUTTER_HOME=/tmp/flutter

echo "====== Flutter Build Setup ======"
echo "ANDROID_HOME: $ANDROID_HOME"
echo "JAVA_HOME: $JAVA_HOME"
echo "FLUTTER_HOME: $FLUTTER_HOME"
echo ""

cd /workspaces/Wallpaper-changer/gita_wallpaper

# Clean previous builds
echo "Cleaning previous builds..."
$FLUTTER_HOME/bin/flutter clean
rm -rf build/

# Get dependencies
echo "Getting dependencies..."
$FLUTTER_HOME/bin/flutter pub get

# Try to build APK
echo ""
echo "====== Building APK ======"
$FLUTTER_HOME/bin/flutter build apk --release 2>&1 | tail -100

# Check if APK was created
if [ -f "build/app/outputs/apk/release/app-release.apk" ]; then
    echo ""
    echo "✓ APK built successfully!"
    ls -lh build/app/outputs/apk/release/app-release.apk
    cp build/app/outputs/apk/release/app-release.apk /workspaces/Wallpaper-changer/gita_wallpaper-release.apk
    echo "✓ APK copied to: /workspaces/Wallpaper-changer/gita_wallpaper-release.apk"
else
    echo "✗ APK build failed"
    exit 1
fi
