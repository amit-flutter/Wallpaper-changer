# CI/CD Configuration for Gita Wallpaper

This document provides instructions for building and testing the Gita Wallpaper APK.

## GitHub Actions CI/CD Setup

A GitHub Actions workflow has been created at `.github/workflows/build-apk.yml`. This workflow:

1. **Triggers** on:
   - Push to `main` and `develop` branches
   - Pull requests to `main`
   - Manual trigger (workflow_dispatch)

2. **Performs**:
   - Checks out the code
   - Sets up Java and Flutter
   - Gets dependencies
   - Runs code analysis
   - Builds the APK (split by ABI)
   - Uploads artifacts to GitHub

3. **Artifacts** are retained for 30 days and can be downloaded from the GitHub Actions page

## Local Build Instructions

### Prerequisites
- Flutter SDK (stable channel)
- Android SDK with build-tools and platform-tools
- Java JDK 11 or higher

### Quick Build

```bash
cd gita_wallpaper
flutter pub get
flutter build apk --release
```

The APK will be located at: `build/app/outputs/apk/release/app-release.apk`

### Debug APK

For testing:
```bash
flutter build apk --debug
```

### Split APKs by Architecture

```bash
flutter build apk --split-per-abi --release
```

This produces separate APKs for:
- arm64-v8a
- armeabi-v7a
- x86_64

## Download APK for Testing

### From GitHub Actions
1. Go to the repository's Actions tab
2. Select the latest successful build
3. Download the "apk-release" artifact
4. Extract and install the APK on your Android device

### From Local Build
After running the local build commands above, transfer the APK to your device:

```bash
adb install build/app/outputs/apk/release/app-release.apk
```

## Testing the APK

1. Install the APK on an Android device (API level 21 or higher)
2. Open the Gita Wallpaper app
3. Test wallpaper selection and application functionality
4. Verify permissions are requested and handled correctly

## Troubleshooting

### Build Fails with "No Android SDK found"
- Ensure `ANDROID_HOME` environment variable is set to your Android SDK location
- Run `flutter doctor` to check your setup

### Build Fails with version conflicts
- Run `flutter clean` before building
- Ensure all dependencies are up to date: `flutter pub get`

### APK installation fails
- Ensure the device has sufficient storage
- Check that the APK is signed correctly (release builds use debug signing for testing)
- Try clearing app cache: `adb shell pm clear com.example.gita_wallpaper`

## CI/CD Status

Check the latest build status in the GitHub Actions tab of the repository.
