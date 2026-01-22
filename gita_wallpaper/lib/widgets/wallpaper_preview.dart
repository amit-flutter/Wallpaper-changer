import 'package:flutter/material.dart';
import 'package:gita_wallpaper/models/gita_quote.dart';

class WallpaperPreview extends StatelessWidget {
  final GitaQuote quote;
  final GlobalKey wallpaperKey;

  const WallpaperPreview({
    Key? key,
    required this.quote,
    required this.wallpaperKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: wallpaperKey,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade700,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo.withValues(alpha: 0.1),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sacred symbol
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amber.shade300,
                        width: 3,
                      ),
                      color: Colors.amber.shade100.withValues(alpha: 0.2),
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      size: 50,
                      color: Colors.amber.shade300,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Quote text
                  Text(
                    quote.quote,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          height: 1.4,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                  ),
                  const SizedBox(height: 60),
                  // Chapter and verse
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber.shade300.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Bhagavad Gita ${quote.chapter}:${quote.verse}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.amber.shade200,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Timestamp
                  Text(
                    'Updated: ${DateTime.now().toString().split('.')[0]}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
