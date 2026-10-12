import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// BazarBondhu এর কেন্দ্রীয় থিম।
/// Elite Grocery স্টাইল — সাদা-সবুজ-লাল।
class AppTheme {
  AppTheme._();

  // ─── রঙ ───
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color primaryGreenDark = Color(0xFF1B5E20);
  static const Color accentGreen = Color(0xFF4CAF50);

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color divider = Color(0xFFEEEEEE);

  static const Color badgeRed = Color(0xFFD32F2F);
  static const Color badgeYellow = Color(0xFFFFC107);
  static const Color badgeGreen = Color(0xFF4CAF50);

  static const Color priceGreen = Color(0xFF2E7D32);
  static const Color oldPriceGrey = Color(0xFF9E9E9E);

  // ─── Spacing ───
  static const double padX = 16.0;
  static const double padY = 12.0;
  static const double radiusCard = 12.0;
  static const double radiusButton = 10.0;

  // ─── ফন্ট ───
  static TextStyle get heading1 => GoogleFonts.hindSiliguri(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        height: 1.3,
      );

  static TextStyle get heading2 => GoogleFonts.hindSiliguri(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1.3,
      );

  static TextStyle get heading3 => GoogleFonts.hindSiliguri(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  static TextStyle get body => GoogleFonts.hindSiliguri(
        fontSize: 14,
        color: textPrimary,
        height: 1.4,
      );

  static TextStyle get bodySmall => GoogleFonts.hindSiliguri(
        fontSize: 12,
        color: textSecondary,
      );

  static TextStyle get price => GoogleFonts.hindSiliguri(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: priceGreen,
      );

  static TextStyle get priceBig => GoogleFonts.hindSiliguri(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: priceGreen,
      );

  static TextStyle get oldPrice => GoogleFonts.hindSiliguri(
        fontSize: 13,
        color: oldPriceGrey,
        decoration: TextDecoration.lineThrough,
      );

  // ─── ThemeData ───
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentGreen,
        surface: surface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,

      textTheme: GoogleFonts.hindSiliguriTextTheme(base.textTheme),

      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: GoogleFonts.hindSiliguri(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),

      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: divider, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: GoogleFonts.hindSiliguri(
          color: textSecondary,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusButton),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusButton),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusButton),
          borderSide: const BorderSide(color: primaryGreen, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusButton),
          ),
          elevation: 0,
          textStyle: GoogleFonts.hindSiliguri(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.hindSiliguri(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.hindSiliguri(fontSize: 11),
      ),

      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
