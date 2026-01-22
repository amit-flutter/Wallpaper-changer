# Build APK - Quick Start

## For Direct Testing (APK Download)

### Option 1: GitHub Actions (Recommended)
1. Push/commit to the `main` or `develop` branch
2. Go to the repository → **Actions** tab
3. Find the latest **"Build APK"** workflow
4. Download the **"apk-release"** artifact
5. Extract and test the APK on your Android device

### Option 2: Local Build
```bash
export ANDROID_HOME=~/android-sdk
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH:$PATH:/tmp/flutter/bin:$ANDROID_HOME/platform-tools"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

cd gita_wallpaper
flutter pub get
flutter build apk --release
```

APK will be at: `gita_wallpaper/build/app/outputs/apk/release/app-release.apk`

## Install on Device

```bash
adb install gita_wallpaper/build/app/outputs/apk/release/app-release.apk
```

## CI/CD Details

See [CI_CD_GUIDE.md](./CI_CD_GUIDE.md) for complete documentation.
