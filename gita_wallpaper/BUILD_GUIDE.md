# Gita Wallpaper Changer - Flutter App

A beautiful Flutter app that changes your Android wallpaper every 5 minutes with random quotes from the Bhagavad Gita.

## Features

✨ **Auto Wallpaper Change** - Automatically changes wallpaper every 5 minutes  
📖 **Bhagavad Gita Quotes** - 20+ authentic Bhagavad Gita verses with translations  
🎨 **Beautiful UI** - Material Design 3 with gradient backgrounds and smooth animations  
🔄 **Manual Control** - Change wallpaper or quotes manually anytime  
📊 **Change Counter** - Track how many times wallpaper has been changed  
💾 **Persistent State** - Settings are saved and restored automatically  

## Build Instructions

### Prerequisites

1. **Flutter SDK** (v3.10.7 or higher)
   ```bash
   git clone https://github.com/flutter/flutter.git
   export PATH="$PATH:$(pwd)/flutter/bin"
   ```

2. **Android SDK** (for Android builds)
   - Download from: https://developer.android.com/studio
   - Set `ANDROID_HOME` environment variable
   - Install Android Build Tools 35.0.0+

3. **Java Development Kit** (JDK 11+)
   ```bash
   sudo apt-get install openjdk-11-jdk
   ```

### Setup Steps

1. **Clone the Repository**
   ```bash
   cd /workspaces/Wallpaper-changer/gita_wallpaper
   ```

2. **Get Dependencies**
   ```bash
   flutter pub get
   ```

3. **Check Setup**
   ```bash
   flutter doctor
   ```

### Build APK (Android)

**Debug APK:**
```bash
flutter build apk --debug
```

**Release APK (Optimized):**
```bash
flutter build apk --release
```

The APK will be generated at:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Build App Bundle (AAB)

For Google Play Store submission:
```bash
flutter build appbundle --release
```

The AAB will be generated at:
```
build/app/outputs/bundle/release/app-release.aab
```

### Run on Device/Emulator

1. **Start Android Emulator or connect device**
   ```bash
   flutter emulators --launch emulator-name
   ```

2. **Run App**
   ```bash
   flutter run
   ```

3. **Hot Reload** (after code changes)
   ```bash
   flutter run -v
   # Press 'r' for hot reload
   # Press 'R' for full restart
   ```

## Required Permissions (AndroidManifest.xml)

The app requests these permissions:

- `android.permission.READ_EXTERNAL_STORAGE` - Read images
- `android.permission.WRITE_EXTERNAL_STORAGE` - Save wallpaper images
- `android.permission.SET_WALLPAPER` - Set wallpaper
- `android.permission.RECEIVE_BOOT_COMPLETED` - Run on device startup

## Project Structure

```
lib/
├── main.dart                    # Main app entry & UI
├── models/
│   └── gita_quote.dart         # Quote data model
├── services/
│   ├── gita_service.dart       # Quote database
│   ├── wallpaper_service.dart  # Wallpaper setting logic
│   └── background_service.dart # Background tasks
└── widgets/
    └── wallpaper_preview.dart  # Wallpaper preview widget
```

## Dependencies

- `flutter` - UI framework
- `wallpaper_manager_flutter` - Set wallpaper functionality
- `permission_handler` - Request Android permissions
- `shared_preferences` - Store user settings
- `material` - Material Design icons

## Key Features Explained

### Auto-Change (Every 5 Minutes)

Uses Dart's `Timer.periodic()` to:
1. Fetch a random Bhagavad Gita quote
2. Generate a beautiful wallpaper with the quote
3. Set it as the device wallpaper
4. Update change counter

### Quote Management

- 20 authentic Bhagavad Gita verses
- Each quote includes chapter and verse reference
- Random selection algorithm
- Stored locally in `GitaService`

### Wallpaper Generation

- Creates dynamic wallpaper using Canvas rendering
- Beautiful purple/indigo gradient background
- Centered quote text with shadow effects
- Chapter:Verse reference in elegant container
- Timestamp of creation

### Data Persistence

Using `SharedPreferences`:
- Auto-change toggle state
- Change counter
- Last displayed quote
- Settings restored on app restart

## Troubleshooting

### Build Errors

**"No Android SDK found"**
```bash
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

**"Build fails with permission errors"**
```bash
flutter clean
flutter pub get
```

### Runtime Errors

**"Permission denied when setting wallpaper"**
- Grant storage permissions when prompted
- Check Settings > Apps > Permissions > Storage

**"App crashes on wallpaper change"**
- Restart app
- Check device storage space
- Clear app cache: `Settings > Apps > Gita Wallpaper > Storage > Clear Cache`

## Development Tips

### Debug Mode
```bash
flutter run --debug -v
```

### Enable Verbose Output
```bash
flutter run -v
```

### Profile Build
```bash
flutter build apk --profile
```

### View Release Build Info
```bash
flutter build apk --release -- verbose
```

## File Sizes (Typical)

- Debug APK: ~150-200 MB
- Release APK: ~35-50 MB
- App Bundle: ~30-40 MB

## Testing

### Manual Testing Checklist

- [ ] App launches without crashes
- [ ] "Change Now" button works
- [ ] "Next Quote" button changes quote
- [ ] Wallpaper changes successfully
- [ ] Auto-change timer starts/stops correctly
- [ ] Counter increments on wallpaper change
- [ ] Settings persist after app restart
- [ ] Permissions are requested properly

## Performance

- Memory: ~50-100 MB (typical usage)
- CPU: Low during idle, slight spike on wallpaper change
- Battery: Minimal impact from 5-minute timer

## Future Enhancements

- [ ] Custom quote intervals (1, 3, 5, 10, 30 minutes)
- [ ] Multiple language support (Sanskrit, Hindi)
- [ ] Quote search functionality
- [ ] Favorites/bookmarks
- [ ] Widget for home screen
- [ ] Night mode for UI
- [ ] Statistics/analytics
- [ ] Multiple wallpaper themes
- [ ] Share quotes on social media

## License

This project is provided as-is for personal use.

## Support

For issues or questions:
1. Check Flutter documentation: https://flutter.dev
2. Visit Flutter community: https://flutter.dev/community

## Credits

- Bhagavad Gita verses and translations
- Flutter team and community
- Material Design principles

---

**Last Updated:** January 2026  
**Version:** 1.0.0  
**Flutter:** 3.38.7  
**Dart:** 3.10.7
