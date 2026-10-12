import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'main_shell.dart';

/// Splash — সবুজ background, লোগো স্কেল + ফেড অ্যানিমেশন।
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainShell(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // লোগো
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                '🛒',
                style: TextStyle(fontSize: 60),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.3, 0.3),
                  end: const Offset(1, 1),
                  duration: 700.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 500.ms),
            const SizedBox(height: 24),
            Text(
              'বাজারবন্ধু',
              style: AppTheme.heading1.copyWith(
                color: Colors.white,
                fontSize: 30,
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(
                  begin: 0.3,
                  end: 0,
                  delay: 400.ms,
                  duration: 600.ms,
                ),
            const SizedBox(height: 6),
            Text(
              'বাংলাদেশের বাজারদর ও ডেলিভারি',
              style: AppTheme.bodySmall.copyWith(
                color: Colors.white70,
                fontSize: 13,
              ),
            ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
