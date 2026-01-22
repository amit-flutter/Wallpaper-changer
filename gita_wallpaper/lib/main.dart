import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gita_wallpaper/services/gita_service.dart';
import 'package:gita_wallpaper/services/wallpaper_service.dart';
import 'package:gita_wallpaper/models/gita_quote.dart';
import 'package:gita_wallpaper/widgets/wallpaper_preview.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gita Wallpaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gita Wallpaper Changer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GitaQuote currentQuote;
  bool autoChangeEnabled = false;
  Timer? _autoChangeTimer;
  final GlobalKey _wallpaperKey = GlobalKey();
  bool isChangingWallpaper = false;
  int changeCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _requestPermissions();
    _loadSettings();
    setState(() {
      currentQuote = GitaService.getRandomQuote();
    });
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.storage.request();
    if (status.isDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      autoChangeEnabled = prefs.getBool('autoChangeEnabled') ?? false;
      changeCount = prefs.getInt('changeCount') ?? 0;
    });

    if (autoChangeEnabled) {
      _startAutoChange();
    }
  }

  void _startAutoChange() {
    _autoChangeTimer?.cancel();
    _autoChangeTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      await _changeWallpaper();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Auto-change enabled (every 5 minutes)')),
    );
  }

  void _stopAutoChange() {
    _autoChangeTimer?.cancel();
    _autoChangeTimer = null;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Auto-change disabled')),
    );
  }

  Future<void> _changeWallpaper() async {
    if (isChangingWallpaper) return;

    setState(() {
      isChangingWallpaper = true;
    });

    try {
      setState(() {
        currentQuote = GitaService.getRandomQuote();
      });

      await Future.delayed(const Duration(milliseconds: 500));

      bool success = await WallpaperService.setWallpaperFromWidget(_wallpaperKey);

      if (success) {
        setState(() {
          changeCount++;
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('changeCount', changeCount);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✓ Wallpaper changed! (Total: $changeCount)'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to change wallpaper')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      setState(() {
        isChangingWallpaper = false;
      });
    }
  }

  Future<void> _toggleAutoChange() async {
    final prefs = await SharedPreferences.getInstance();

    if (autoChangeEnabled) {
      _stopAutoChange();
      setState(() {
        autoChangeEnabled = false;
      });
      await prefs.setBool('autoChangeEnabled', false);
    } else {
      _startAutoChange();
      setState(() {
        autoChangeEnabled = true;
      });
      await prefs.setBool('autoChangeEnabled', true);
    }
  }

  @override
  void dispose() {
    _autoChangeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.indigo.shade50,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Wallpaper Preview',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                // Wallpaper Preview Container
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: WallpaperPreview(
                      quote: currentQuote,
                      wallpaperKey: _wallpaperKey,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Current Quote Details
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Quote',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentQuote.quote,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Bhagavad Gita ${currentQuote.chapter}:${currentQuote.verse}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.deepPurple.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Change Counter
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.deepPurple.shade300,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wallpapers Changed',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade700,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(
                          '$changeCount',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Control Buttons
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed:
                            isChangingWallpaper ? null : _changeWallpaper,
                        icon: const Icon(Icons.wallpaper),
                        label: const Text('Change Now'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.deepPurple.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            currentQuote =
                                GitaService.getRandomQuote();
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Next Quote'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.indigo.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Auto-Change Toggle
                FilledButton.icon(
                  onPressed: _toggleAutoChange,
                  icon: Icon(autoChangeEnabled ? Icons.pause : Icons.play_arrow),
                  label: Text(
                    autoChangeEnabled
                        ? 'Stop Auto-Change'
                        : 'Start Auto-Change (5 min)',
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: autoChangeEnabled
                        ? Colors.red.shade600
                        : Colors.green.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                // Info Card
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'About',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Tap "Change Now" to set wallpaper immediately\n'
                          '• Tap "Next Quote" to preview different quotes\n'
                          '• Enable auto-change to update every 5 minutes\n'
                          '• Original Bhagavad Gita verses with translations',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
