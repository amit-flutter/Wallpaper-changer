# Gita Wallpaper - Complete CI/CD & Build Setup

## ✓ What Has Been Set Up

### 1. GitHub Actions CI/CD Workflow
**File**: `.github/workflows/build-apk.yml`

This automated workflow:
- **Automatically triggers** on:
  - Push to `main` or `develop` branches  
  - Pull requests to `main`
  - Manual trigger via GitHub Actions UI

- **Performs these steps**:
  1. Checks out code
  2. Sets up Java JDK
  3. Downloads and configures Flutter
  4. Gets all Dart/Flutter dependencies
  5. Runs code analysis (`flutter analyze`)
  6. Builds APK (with ABI splitting)
  7. Uploads artifacts (30-day retention)
  8. Creates GitHub releases for tags

### 2. Local Build Configuration
- **Build scripts**: `/build_apk.sh` - Automated local build script
- **Updated gradle.properties**: Optimized build settings
- **Environment**: All necessary Android SDK, build-tools, and platforms

### 3. Documentation
- **CI_CD_GUIDE.md**: Detailed setup and troubleshooting guide
- **BUILD_APK_QUICK.md**: Quick reference for developers
- **README.md**: Project overview

---

## 🚀 How to Get the APK for Testing

### **Method 1: GitHub Actions (Recommended for Testing)**

1. **Make a commit and push** to trigger the workflow:
   ```bash
   git add .
   git commit -m "trigger build"
   git push origin main
   ```

2. **Go to GitHub → Actions** tab in your repository

3. **Find the latest "Build APK" workflow** run

4. **Download the "apk-release" artifact**:
   - It contains the release APK and can be extracted directly

5. **Install on device**:
   ```bash
   adb install app-release.apk
   ```

### **Method 2: Local Build (Direct Testing)**

#### Prerequisites:
```bash
# Already installed in this environment:
- Flutter SDK (stable)
- Android SDK
- Java JDK 11+
- gradle
```

#### Quick Build:
```bash
cd /workspaces/Wallpaper-changer/gita_wallpaper

# Get dependencies
flutter pub get

# Build Release APK
flutter build apk --release
```

**APK Location**: `build/app/outputs/apk/release/app-release.apk`

#### Alternative - Debug APK (Faster):
```bash
flutter build apk --debug
```

#### Split APKs by Architecture (Smaller files):
```bash
flutter build apk --split-per-abi --release
```

This creates:
- `app-armeabi-v7a-release.apk` (ARM 32-bit)
- `app-arm64-v8a-release.apk` (ARM 64-bit)  
- `app-x86_64-release.apk` (Intel 64-bit)

### **Method 3: Transfer to Device**

```bash
# From local build
adb install /workspaces/Wallpaper-changer/gita_wallpaper/build/app/outputs/apk/release/app-release.apk

# Or from GitHub artifact
adb install app-release.apk
```

---

## 📋 What Each File Does

### CI/CD Files
| File | Purpose |
|------|---------|
| `.github/workflows/build-apk.yml` | GitHub Actions workflow definition |
| `build_apk.sh` | Local build automation script |
| `CI_CD_GUIDE.md` | Comprehensive CI/CD documentation |
| `BUILD_APK_QUICK.md` | Quick build reference |

### Android Config
| File | Purpose |
|------|---------|
| `android/gradle.properties` | Gradle optimization settings |
| `android/build.gradle.kts` | Root gradle configuration |
| `android/app/build.gradle.kts` | App-level gradle configuration |

---

## 🔧 Environment Setup Reference

The following are pre-configured in this environment:

```bash
# Flutter
export FLUTTER_HOME=/tmp/flutter
export PATH="$FLUTTER_HOME/bin:$PATH"

# Android SDK
export ANDROID_HOME=~/android-sdk
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
```

Installed Components:
- ✓ Flutter 3.38.7 (stable)
- ✓ Android SDK Platform-Tools
- ✓ Android SDK Build-Tools (34.0.0, 35.0.0)
- ✓ Android Platforms (android-34, android-35, android-36)
- ✓ Java JDK 21
- ✓ Gradle 9.2.1

---

## 📱 Testing the APK

### Device Requirements
- Android 5.0+ (API 21+) - as per `pubspec.yaml`
- Minimum 50MB free space
- USB debugging enabled (for ADB)

### Testing Steps
1. **Install**: `adb install app-release.apk`
2. **Launch**: Open "Gita Wallpaper" from app drawer
3. **Test functionality**:
   - Browse wallpapers
   - Set wallpaper
   - Check permissions (storage, system)
   - Verify app settings

---

## ❓ Troubleshooting

### Build Fails: "No Android SDK found"
```bash
export ANDROID_HOME=~/android-sdk
```

### Build Fails: "SDK Platform 36 not found"
```bash
export ANDROID_HOME=~/android-sdk && \
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH" && \
yes | sdkmanager --sdk_root=$ANDROID_HOME "platforms;android-36"
```

### APK Installation Fails
```bash
# Clear app cache
adb shell pm clear com.example.gita_wallpaper

# Then retry
adb install -r app-release.apk
```

### Build Takes Too Long
- First build is slower (downloads Gradle, dependencies)
- Use `flutter build apk --debug` for faster development builds
- Use split APKs for faster builds: `--split-per-abi`

---

## 📊 CI/CD Status

**Latest Builds**: Check GitHub Actions → "Build APK" workflow

**Automatic Triggers**:
- ✓ On push to `main` and `develop`
- ✓ On pull requests  
- ✓ Manual via "Run workflow" button

**Artifacts**: Available for 30 days after build

---

## 🔐 Security Notes

- Release APKs use **debug signing** for testing
- For production release, configure proper signing in `build.gradle.kts`
- Keep sensitive keys in environment variables or secure storage

---

## 📝 Next Steps

1. **Push code** to trigger automated build
2. **Download APK** from GitHub Actions artifacts
3. **Test on device** using `adb install`
4. **Report issues** via GitHub Issues

---

**Setup Completed**: ✓ CI/CD configured | ✓ Build scripts ready | ✓ Documentation complete
