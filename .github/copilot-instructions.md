# Gita Wallpaper Changer - AI Coding Agent Instructions

## Project Overview
A Flutter Android application that automatically changes device wallpaper every 5 minutes with Bhagavad Gita quotes. Material Design 3 UI with persistent settings, permission handling, and native Android integration.

## Architecture & Key Components

### Service Layer (Separation of Concerns)
- **GitaService** ([lib/services/gita_service.dart](../../gita_wallpaper/lib/services/gita_service.dart)): Static quote database with 20+ authentic verses. Use `GitaService.getRandomQuote()` and `GitaService.getAllQuotes()`.
- **WallpaperService** ([lib/services/wallpaper_service.dart](../../gita_wallpaper/lib/services/wallpaper_service.dart)): Flutter widget-to-wallpaper rendering via `RepaintBoundary`. Saves PNG to `/sdcard/Pictures/GitaWallpapers/` before setting via `WallpaperManagerFlutter.setWallpapeImage()`.
- **BackgroundService** ([lib/services/background_service.dart](../../gita_wallpaper/lib/services/background_service.dart)): WorkManager handles 5-minute periodic tasks independent of app lifecycle.

### State Management Pattern
- **SharedPreferences** for persistent state: `autoChangeEnabled`, `changeCount`, `lastQuote`, `lastChapter`, `lastVerse`
- **StatefulWidget** (_MyHomePageState) manages timer lifecycle, quote state, and permission requests
- Load settings in `_initializeApp()` during `initState()`

### Data Model
- **GitaQuote** ([lib/models/gita_quote.dart](../../gita_wallpaper/lib/models/gita_quote.dart)): Simple immutable class (quote text, chapter, verse) with JSON serialization

### UI Layer
- **WallpaperPreview** widget uses `RepaintBoundary` + `GlobalKey` for rendering wallpaper. High pixel ratio (3.0) ensures quality.
- Material Design 3 theme seeded with `Colors.deepPurple`
- Gradient backgrounds (purple→indigo) with decorative circles for visual depth

## Critical Workflows

### Build Process
```bash
cd /workspaces/Wallpaper-changer/gita_wallpaper
flutter clean
flutter pub get
flutter build apk --release
```
- Build script: [build_apk.sh](../../build_apk.sh) sets `ANDROID_HOME`, `JAVA_HOME`, `FLUTTER_HOME`
- Output: `build/app/outputs/apk/release/app-release.apk` → copied to root as `gita_wallpaper-release.apk`

### Wallpaper Change Flow
1. User taps "Change Wallpaper" or auto-timer fires
2. Get random quote from `GitaService`
3. Update UI state and render `WallpaperPreview` widget
4. `WallpaperService.setWallpaperFromWidget()` captures `RepaintBoundary` as PNG image
5. Save to `/sdcard/Pictures/GitaWallpapers/` with timestamp filename
6. Call native Android via `WallpaperManagerFlutter.setWallpapeImage()` with `WALLPAPER_SYSTEM` location
7. Increment `changeCount` in SharedPreferences

### Permissions & Lifecycle
- **Required Permissions** (AndroidManifest.xml): `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE`, `SET_WALLPAPER`, `RECEIVE_BOOT_COMPLETED`
- Request at startup via `Permission.storage.request()` with snackbar feedback
- Timer cleanup in `dispose()` to prevent leaks

## Key Dependencies
- `wallpaper_manager_flutter: ^1.0.1` - Native Android wallpaper API
- `permission_handler: ^11.0.0` - Permission requests
- `shared_preferences: ^2.2.2` - Persistent app settings
- `workmanager: ^0.x` - Background task scheduling (optional BackgroundService)

## Project-Specific Conventions

### Quote Data Structure
Quotes stored as `List<GitaQuote>` static field. Each includes:
- `quote`: English translation (single string, may contain multiple sentences)
- `chapter`: String representation (e.g., "2", "10")
- `verse`: String representation (e.g., "47", "34")

### File Paths
- Wallpaper cache: `/sdcard/Pictures/GitaWallpapers/` with format `gita_wallpaper_<timestamp>.png`
- Generated images are cleaned up by Android system or manually

### Widget Rendering for Wallpaper
Always use `RepaintBoundary` with `GlobalKey` + `toImage(pixelRatio: 3.0)` to capture widgets as PNG. Standard device size: 1080×2340 pixels.

### Error Handling
- Silent failures logged to console with `print('Error: ...')`
- Permission denial shows snackbar to user
- Wallpaper operations return `bool` success indicator

## Integration Points

### Android Native Interaction
- `WallpaperManagerFlutter` plugin wraps Android `WallpaperManager`
- Must set `wallpaperLocation: WallpaperManagerFlutter.WALLPAPER_SYSTEM` (not lock screen)

### WorkManager Background Tasks
- Independent of app state; persists across reboots via `RECEIVE_BOOT_COMPLETED` permission
- Task execution logged; includes exponential backoff on failure

## Related Documentation
- [PROJECT_SUMMARY.md](../../gita_wallpaper/PROJECT_SUMMARY.md): Complete feature inventory
- [BUILD_GUIDE.md](../../gita_wallpaper/BUILD_GUIDE.md): SDK setup, prerequisites, troubleshooting
- [pubspec.yaml](../../gita_wallpaper/pubspec.yaml): Dependency versions and Flutter SDK version (3.10.7)
