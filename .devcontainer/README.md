# GitHub Codespace Setup

This project uses **`.devcontainer.json`** to automatically configure Flutter in GitHub Codespaces.

## How It Works

1. **When you open a Codespace**, VS Code automatically:
   - Reads `.devcontainer/devcontainer.json`
   - Runs `.devcontainer/setup.sh` 
   - Installs Flutter 3.38.5
   - Installs necessary tools (Java 17, Git, etc.)

2. **Flutter is installed to**: `/opt/flutter` with PATH automatically set

3. **VS Code extensions installed**: Flutter, Dart, GitLens

## Local Development (GitHub Codespace)

```bash
cd gita_wallpaper
flutter pub get
flutter analyze
flutter build apk --release
```

## GitHub Actions (CI/CD)

The workflow (`.github/workflows/build-apk.yml`) automatically:
- Checks out code
- Installs Flutter 3.38.5 via `subosito/flutter-action@v2`
- Builds APK and uploads artifacts

## Project Structure

```
.devcontainer/
├── devcontainer.json          # Codespace configuration
└── setup.sh                   # Automatic setup script

.github/workflows/
└── build-apk.yml             # CI/CD pipeline

gita_wallpaper/               # Your Flutter app
```

## First Time in Codespace?

1. Open `.devcontainer/devcontainer.json` 
2. Click "Reopen in Container" when prompted
3. Wait for setup.sh to complete (~5-10 minutes first time)
4. Run: `cd gita_wallpaper && flutter pub get`

Done! ✅
