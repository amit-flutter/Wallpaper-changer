#!/bin/bash

# Gita Wallpaper - Quick Start Checklist
# This script helps verify everything is ready to build

echo "╔═══════════════════════════════════════════╗"
echo "║   Gita Wallpaper - Pre-Build Checklist    ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# Function to check command
check_command() {
    if command -v $1 &> /dev/null; then
        echo "✅ $1: Found"
        return 0
    else
        echo "❌ $1: NOT FOUND"
        return 1
    fi
}

# Function to check file
check_file() {
    if [ -f "$1" ]; then
        echo "✅ $1: Exists"
        return 0
    else
        echo "❌ $1: NOT FOUND"
        return 1
    fi
}

# Function to check directory
check_dir() {
    if [ -d "$1" ]; then
        echo "✅ $1: Exists"
        return 0
    else
        echo "❌ $1: NOT FOUND"
        return 1
    fi
}

echo "1️⃣  Checking System Tools..."
echo "─────────────────────────────"
check_command flutter
check_command java
check_command git
echo ""

echo "2️⃣  Checking Flutter Setup..."
echo "─────────────────────────────"
FLUTTER_PATH="../flutter/bin/flutter"
if [ -f "$FLUTTER_PATH" ]; then
    echo "✅ Flutter SDK: Found"
    FLUTTER_VERSION=$($FLUTTER_PATH --version 2>/dev/null | head -1)
    echo "   Version: $FLUTTER_VERSION"
else
    echo "❌ Flutter SDK: NOT FOUND at $FLUTTER_PATH"
fi
echo ""

echo "3️⃣  Checking Project Files..."
echo "─────────────────────────────"
check_file "pubspec.yaml"
check_file "android/app/build.gradle.kts"
check_file "android/app/src/main/AndroidManifest.xml"
check_dir "lib"
echo ""

echo "4️⃣  Checking Source Code..."
echo "─────────────────────────────"
check_file "lib/main.dart"
check_file "lib/models/gita_quote.dart"
check_file "lib/services/gita_service.dart"
check_file "lib/services/wallpaper_service.dart"
check_file "lib/widgets/wallpaper_preview.dart"
echo ""

echo "5️⃣  Checking Documentation..."
echo "─────────────────────────────"
check_file "BUILD_GUIDE.md"
check_file "README_BUILD.md"
check_file "PROJECT_SUMMARY.md"
check_file "build.sh"
echo ""

echo "6️⃣  Checking Dependencies..."
echo "─────────────────────────────"
if [ -f "pubspec.yaml" ]; then
    echo "✅ pubspec.yaml configured"
    grep -q "wallpaper_manager_flutter" pubspec.yaml && echo "✅ wallpaper_manager_flutter: Found"
    grep -q "permission_handler" pubspec.yaml && echo "✅ permission_handler: Found"
    grep -q "shared_preferences" pubspec.yaml && echo "✅ shared_preferences: Found"
fi
echo ""

echo "7️⃣  Getting Flutter Dependencies..."
echo "─────────────────────────────"
if [ -d "pubspec.lock" ] || [ -f "pubspec.lock" ]; then
    echo "✅ pubspec.lock: Exists (dependencies resolved)"
else
    echo "⚠️  pubspec.lock: Not found yet"
    echo "   Run: flutter pub get"
fi
echo ""

echo "╔═══════════════════════════════════════════╗"
echo "║          Ready to Build? ✅              ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "📋 Next Steps:"
echo "───────────────"
echo ""
echo "1. Verify all items above are ✅"
echo ""
echo "2. Run: flutter pub get"
echo ""
echo "3. Build options:"
echo "   - Debug:   flutter build apk --debug"
echo "   - Release: flutter build apk --release"
echo "   - Or use:  ./build.sh"
echo ""
echo "4. Install on device:"
echo "   adb install build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "5. Open app and test features!"
echo ""
echo "📖 For detailed info, read: BUILD_GUIDE.md"
echo "⚡ For quick ref, read: README_BUILD.md"
echo ""
