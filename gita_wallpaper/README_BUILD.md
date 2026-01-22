# 🕉️ Gita Wallpaper Changer

A beautiful Flutter app that automatically changes your Android wallpaper every 5 minutes with inspirational quotes from the Bhagavad Gita.

## 🎯 Quick Start

### Build the App (Recommended)

**Using the build script:**
```bash
cd gita_wallpaper
chmod +x build.sh
./build.sh
# Select option 2 for Release APK
```

**Or manually:**
```bash
cd gita_wallpaper
../flutter/bin/flutter pub get
../flutter/bin/flutter build apk --release
```

### Installation

1. Build generates: `build/app/outputs/flutter-apk/app-release.apk`
2. Transfer APK to Android device
3. Install: `adb install app-release.apk`
4. Grant permissions when prompted
5. Open app and tap "Change Now" or enable "Auto-Change"

## ✨ Features

- **🔄 Auto Wallpaper Change** - Every 5 minutes
- **📖 Bhagavad Gita Quotes** - 20+ authentic verses
- **🎨 Beautiful UI** - Material Design with gradients
- **⏱️ Manual Control** - Change anytime you want
- **📊 Change Counter** - Track changes
- **💾 Auto-Save** - Settings persist across restarts

## 📱 App Screens

### Main Screen
- Live wallpaper preview
- Current quote display
- Change counter
- Control buttons

### Buttons
- **Change Now** - Set wallpaper immediately
- **Next Quote** - Preview different quotes
- **Start/Stop Auto-Change** - Toggle 5-minute timer

## 🛠️ Project Structure

```
gita_wallpaper/
├── lib/
│   ├── main.dart                    # Main UI
│   ├── models/gita_quote.dart       # Data model
│   ├── services/
│   │   ├── gita_service.dart        # Quote database
│   │   ├── wallpaper_service.dart   # Wallpaper logic
│   │   └── background_service.dart  # Background tasks
│   └── widgets/wallpaper_preview.dart # Preview UI
├── android/                          # Android config
├── pubspec.yaml                      # Dependencies
├── BUILD_GUIDE.md                    # Full build guide
└── build.sh                          # Build script
```

## 📦 Dependencies

- `wallpaper_manager_flutter` - Set system wallpaper
- `permission_handler` - Request permissions
- `shared_preferences` - Store settings
- `material` - Design & icons

## 🚀 Build Outputs

After building, you'll get:

- **Debug APK**: `build/app/outputs/flutter-apk/app-debug.apk` (~150-200 MB)
- **Release APK**: `build/app/outputs/flutter-apk/app-release.apk` (~35-50 MB)
- **AAB**: `build/app/outputs/bundle/release/app-release.aab` (~30-40 MB)

## 📝 Build Steps Explained

### 1. Get Dependencies
```bash
flutter pub get
```
Downloads all required packages

### 2. Build Debug
```bash
flutter build apk --debug
```
Quick build for testing (includes debug info)

### 3. Build Release
```bash
flutter build apk --release
```
Optimized build for distribution (smaller, faster)

### 4. Build AAB (For Play Store)
```bash
flutter build appbundle --release
```
Format required for Google Play Store

## ⚙️ Configuration

All settings are in these files:

- **Main UI**: `lib/main.dart`
- **Quotes**: `lib/services/gita_service.dart`
- **Wallpaper Style**: `lib/widgets/wallpaper_preview.dart`
- **Permissions**: `android/app/src/main/AndroidManifest.xml`
- **Dependencies**: `pubspec.yaml`

## 🔧 Troubleshooting

### Build Fails
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### Permission Issues
- Grant storage permissions in app
- Check: Settings > Apps > Gita Wallpaper > Permissions

### Wallpaper Won't Change
- Check device storage space
- Restart the app
- Try "Change Now" button manually

## 📚 Full Documentation

See `BUILD_GUIDE.md` for:
- Detailed build instructions
- Android SDK setup
- Development tips
- Advanced troubleshooting
- Performance optimization

## 🎨 Customize

### Change Timer Interval
In `lib/main.dart`, find:
```dart
Timer.periodic(const Duration(minutes: 5), (_) async {
```
Change `5` to desired minutes (1, 3, 10, etc.)

### Add More Quotes
In `lib/services/gita_service.dart`, add to the `quotes` list:
```dart
GitaQuote(
  quote: "Your quote here",
  chapter: "2",
  verse: "47",
),
```

### Change Colors
In `lib/widgets/wallpaper_preview.dart`, modify:
```dart
gradient: LinearGradient(
  colors: [
    Colors.deepPurple.shade900,  // Change these
    Colors.indigo.shade900,
  ],
),
```

## 📋 Pre-Build Checklist

- ✅ Flutter installed: `flutter --version`
- ✅ Android SDK set: `echo $ANDROID_HOME`
- ✅ Java installed: `java -version`
- ✅ Dependencies resolved: `flutter pub get`
- ✅ No errors: `flutter analyze`

## 🚀 Run on Device

```bash
# Connect Android device via USB
flutter run

# For release build on device
flutter run --release
```

## 📊 App Size

| Build Type | Size |
|-----------|------|
| Debug APK | 150-200 MB |
| Release APK | 35-50 MB |
| AAB | 30-40 MB |

## 🔐 Permissions Required

- `READ_EXTERNAL_STORAGE` - Read images
- `WRITE_EXTERNAL_STORAGE` - Save wallpaper
- `SET_WALLPAPER` - Change wallpaper
- `RECEIVE_BOOT_COMPLETED` - Start on boot (optional)

## 📞 Support

For issues:
1. Check `BUILD_GUIDE.md`
2. Run `flutter doctor -v`
3. Check Flutter docs: https://flutter.dev

## 🎯 Next Steps

1. **Build**: Run `./build.sh` or `flutter build apk --release`
2. **Test**: Install on Android device
3. **Customize**: Edit quotes or colors as needed
4. **Deploy**: Share APK or upload AAB to Play Store

## 📄 File Reference

| File | Purpose |
|------|---------|
| `main.dart` | Main app UI & logic |
| `gita_service.dart` | Quote database (20+ verses) |
| `wallpaper_service.dart` | Wallpaper rendering & setting |
| `background_service.dart` | Auto-change timer |
| `wallpaper_preview.dart` | Beautiful wallpaper UI |
| `gita_quote.dart` | Quote data model |
| `pubspec.yaml` | Dependencies & configuration |
| `AndroidManifest.xml` | Permissions & app config |

## 💡 Tips

- **Faster builds**: Use `--split-per-abi` for smaller APKs
- **Testing**: Use `flutter run -v` for verbose output
- **Optimization**: Release builds are ~10x smaller than debug
- **Hot reload**: Perfect for UI tweaks (press `r` in terminal)

---

**Version:** 1.0.0  
**Built with:** Flutter 3.38.7 + Dart 3.10.7  
**Last Updated:** January 2026  
**Status:** ✅ Ready to Build

