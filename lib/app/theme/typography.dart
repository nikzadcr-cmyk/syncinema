import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme get darkTextTheme {
    final base = GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme);
    final vazir = GoogleFonts.vazirmatnTextTheme();
    // Merge for bilingual support - Outfit for latin, Vazirmatn for Persian
    return base.copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -0.5, height: 1.1,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.15,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: -0.2,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: -0.1,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 20, fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 18, fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 18, fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.outfit(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.4,
      ),
      bodySmall: GoogleFonts.outfit(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.outfit(
        fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,
      ),
      labelMedium: GoogleFonts.outfit(
        fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      ),
    );
  }

  static TextTheme get lightTextTheme {
    final base = GoogleFonts.outfitTextTheme(ThemeData.light().textTheme);
    return base.copyWith(
      displayLarge: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -0.5, height: 1.1),
      displayMedium: GoogleFonts.outfit(fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -0.3),
      displaySmall: GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.w700),
      headlineLarge: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  // Specific styles
  static TextStyle get roomCodeStyle => GoogleFonts.jetBrainsMono(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: 4,
    color: Colors.white,
  );

  static TextStyle get monoStyle => GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
}
