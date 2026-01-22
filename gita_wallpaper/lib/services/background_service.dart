import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gita_wallpaper/services/gita_service.dart';
import 'dart:async';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      print('Background task executed: $task');

      if (task == 'changeWallpaperTask') {
        final prefs = await SharedPreferences.getInstance();
        final lastQuoteIndex =
            prefs.getInt('lastQuoteIndex') ?? -1;

        final quote = GitaService.getRandomQuote();
        await prefs.setString('lastQuote', quote.quote);
        await prefs.setString('lastChapter', quote.chapter);
        await prefs.setString('lastVerse', quote.verse);

        print('Wallpaper scheduled to change with quote: ${quote.quote}');
      }

      return true;
    } catch (e) {
      print('Error in background task: $e');
      return false;
    }
  });
}

class BackgroundService {
  static void startBackgroundTask() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    Workmanager().registerPeriodicTask(
      'changeWallpaper',
      'changeWallpaperTask',
      frequency: const Duration(minutes: 5),
      constraints: Constraints(
        networksType: NetworkType.any,
      ),
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: const Duration(minutes: 1),
    );

    print('Background task registered to run every 5 minutes');
  }

  static void stopBackgroundTask() {
    Workmanager().cancelByTag('changeWallpaper');
    print('Background task cancelled');
  }
}
