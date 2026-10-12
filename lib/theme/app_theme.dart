import 'package:flutter/material.dart';

/// BazarBondhu অ্যাপের কেন্দ্রীয় থিম।
/// সবুজ + সাদা — বাংলাদেশের সবজি/কাঁচাবাজারের থিম।
class AppTheme {
  AppTheme._();

  // মূল সবুজ রঙ (বাংলাদেশের পতাকার সবুজের কাছাকাছি, কিন্তু কিছুটা গাঢ়)
  static const Color primaryGreen = Color(0xFF1B7F3A);
  static const Color primaryGreenDark = Color(0xFF0F5A28);
  static const Color accentGreen = Color(0xFF4CAF50);

  // ব্যাকগ্রাউন্ড
  static const Color background = Color(0xFFF7FBF8); // খুব হালকা সবুজ-সাদা
  static const Color surface = Colors.white;

  // টেক্সট
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF5A5A5A);

  // সতর্কতা / ডেমো ডেটা লেবেল
  static const Color demoBadgeBg = Color(0xFFFFF3CD);
  static const Color demoBadgeFg = Color(0xFF7A5C00);

  // সফল / যাচাইকৃত
  static const Color verifiedBg = Color(0xFFE3F3E7);
  static const Color verifiedFg = Color(0xFF1B7F3A);

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        surface: surface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: surface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD0DDD4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD0DDD4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
