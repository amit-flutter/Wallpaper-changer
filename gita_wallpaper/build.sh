#!/bin/bash

# Gita Wallpaper - Build Script
# This script automates the build process

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FLUTTER_PATH="${SCRIPT_DIR}/../flutter/bin/flutter"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}  Gita Wallpaper Build Script${NC}"
echo -e "${GREEN}================================${NC}"
echo ""

# Check if Flutter exists
if [ ! -f "$FLUTTER_PATH" ]; then
    echo -e "${RED}Error: Flutter not found at $FLUTTER_PATH${NC}"
    echo "Please ensure Flutter is in the parent directory"
    exit 1
fi

# Show menu
echo "Select build type:"
echo "1) Debug APK (faster, for testing)"
echo "2) Release APK (optimized, for distribution)"
echo "3) Release AAB (for Google Play Store)"
echo "4) Clean & Get Dependencies"
echo "5) Run Flutter Doctor"
echo "6) Run on Device"
echo ""
read -p "Enter choice (1-6): " choice

case $choice in
    1)
        echo -e "${YELLOW}Building Debug APK...${NC}"
        cd "$SCRIPT_DIR"
        "$FLUTTER_PATH" clean
        "$FLUTTER_PATH" pub get
        "$FLUTTER_PATH" build apk --debug
        echo -e "${GREEN}✓ Debug APK built successfully!${NC}"
        echo "Location: build/app/outputs/flutter-apk/app-debug.apk"
        ;;
    2)
        echo -e "${YELLOW}Building Release APK...${NC}"
        cd "$SCRIPT_DIR"
        "$FLUTTER_PATH" clean
        "$FLUTTER_PATH" pub get
        "$FLUTTER_PATH" build apk --release
        echo -e "${GREEN}✓ Release APK built successfully!${NC}"
        echo "Location: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    3)
        echo -e "${YELLOW}Building Release AAB...${NC}"
        cd "$SCRIPT_DIR"
        "$FLUTTER_PATH" clean
        "$FLUTTER_PATH" pub get
        "$FLUTTER_PATH" build appbundle --release
        echo -e "${GREEN}✓ Release AAB built successfully!${NC}"
        echo "Location: build/app/outputs/bundle/release/app-release.aab"
        ;;
    4)
        echo -e "${YELLOW}Cleaning and getting dependencies...${NC}"
        cd "$SCRIPT_DIR"
        "$FLUTTER_PATH" clean
        "$FLUTTER_PATH" pub get
        echo -e "${GREEN}✓ Dependencies updated!${NC}"
        ;;
    5)
        echo -e "${YELLOW}Running Flutter Doctor...${NC}"
        "$FLUTTER_PATH" doctor -v
        ;;
    6)
        echo -e "${YELLOW}Running app on connected device...${NC}"
        cd "$SCRIPT_DIR"
        "$FLUTTER_PATH" run
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Done!${NC}"
