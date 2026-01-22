#!/bin/bash
set -e

echo "🚀 Setting up Flutter development environment..."

# Update system
apt-get update && apt-get install -y \
  git \
  curl \
  zip \
  unzip \
  xz-utils \
  openjdk-17-jdk-headless

# Install Flutter SDK
echo "📦 Installing Flutter SDK..."
FLUTTER_VERSION="3.38.5"
FLUTTER_HOME="/opt/flutter"

mkdir -p $FLUTTER_HOME
cd $FLUTTER_HOME
git clone --depth 1 --branch $FLUTTER_VERSION https://github.com/flutter/flutter.git .

# Add Flutter to PATH
echo 'export PATH="/opt/flutter/bin:$PATH"' >> /etc/profile.d/flutter.sh
export PATH="/opt/flutter/bin:$PATH"

# Run flutter doctor to download Dart SDK
flutter doctor

echo "✅ Flutter setup complete!"
echo "Flutter version:"
flutter --version
