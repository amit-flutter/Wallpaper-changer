import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gita_wallpaper/services/gita_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == 'changeWallpaperTask') {
        final prefs = await SharedPreferences.getInstance();

        final quote = GitaService.getRandomQuote();
        await prefs.setString('lastQuote', quote.quote);
        await prefs.setString('lastChapter', quote.chapter);
        await prefs.setString('lastVerse', quote.verse);
      }

      return true;
    } catch (e) {
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
        networkType: NetworkType.connected,
      ),
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: const Duration(minutes: 1),
    );
  }

  static void stopBackgroundTask() {
    Workmanager().cancelByTag('changeWallpaper');
  }
}
