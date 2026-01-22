import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class WallpaperService {
  static const String _cacheDir = '/sdcard/Pictures/GitaWallpapers';

  static Future<bool> setWallpaperFromWidget(GlobalKey key) async {
    try {
      RenderRepaintBoundary? boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return false;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return false;

      // Save to cache
      final directory = Directory(_cacheDir);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      String fileName =
          'gita_wallpaper_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('$_cacheDir/$fileName');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Set as wallpaper
      final result = await WallpaperManagerFlutter.setWallpaperImage(
        imagePath: file.path,
      );

      return result ?? false;
    } catch (e) {
      // ignore: avoid_print
      print('Error setting wallpaper: $e');
      return false;
    }
  }

  static Future<bool> setWallpaperFromColor(Color color) async {
    try {
      // Create a simple colored image
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromLTWH(0, 0, 1080, 2340),
      );

      canvas.drawRect(
        Rect.fromLTWH(0, 0, 1080, 2340),
        Paint()..color = color,
      );

      final picture = recorder.endRecording();
      final image = await picture.toImage(1080, 2340);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return false;

      // Save to cache
      final directory = Directory(_cacheDir);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      String fileName =
          'gita_wallpaper_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('$_cacheDir/$fileName');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Set as wallpaper
      final result = await WallpaperManagerFlutter.setWallpaperImage(
        imagePath: file.path,
      );

      return result ?? false;
    } catch (e) {
      // ignore: avoid_print
      print('Error setting wallpaper: $e');
      return false;
    }
  }
}
