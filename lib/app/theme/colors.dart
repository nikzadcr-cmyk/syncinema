import 'package:flutter/material.dart';

class AppColors {
  // Primary - Electric Violet inspired premium palette
  static const Color primary = Color(0xFF7C4DFF);
  static const Color primaryLight = Color(0xFFB47CFF);
  static const Color primaryDark = Color(0xFF3F1DCB);
  static const Color secondary = Color(0xFF00E5FF);
  static const Color secondaryLight = Color(0xFF6EFFFF);
  static const Color secondaryDark = Color(0xFF00B2CC);
  
  // Accents
  static const Color accentPink = Color(0xFFFF2E93);
  static const Color accentOrange = Color(0xFFFF8A00);
  static const Color accentGreen = Color(0xFF00E676);
  
  // Dark Theme Base
  static const Color backgroundDark = Color(0xFF0A0A12);
  static const Color surfaceDark = Color(0xFF15151F);
  static const Color surfaceDark2 = Color(0xFF1E1E2D);
  static const Color surfaceDark3 = Color(0xFF2A2A3D);
  
  static const Color cardDark = Color(0xFF1C1C28);
  static const Color cardDarkHover = Color(0xFF252538);
  
  // Light
  static const Color backgroundLight = Color(0xFFFAFAFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLight2 = Color(0xFFF2F2F7);
  
  // Text
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA0A0B8);
  static const Color textTertiaryDark = Color(0xFF6C6C7D);
  
  static const Color textPrimaryLight = Color(0xFF0A0A12);
  static const Color textSecondaryLight = Color(0xFF5A5A6D);
  
  // Glass
  static Color glassDark = const Color(0xFF1E1E2D).withOpacity(0.6);
  static Color glassLight = Colors.white.withOpacity(0.7);
  static Color glassBorderDark = Colors.white.withOpacity(0.08);
  static Color glassBorderLight = Colors.black.withOpacity(0.05);
  
  // Status
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF1744);
  static const Color info = Color(0xFF00B0FF);
  
  // Gradients - Premium
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C4DFF), Color(0xFF00E5FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF2E93), Color(0xFFFF8A00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF0A0A12), Color(0xFF1E1E2D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1C1C28), Color(0xFF252538)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const RadialGradient glowGradient = RadialGradient(
    colors: [Color(0x337C4DFF), Colors.transparent],
    center: Alignment.center,
    radius: 1.2,
  );
  
  // Shimmer
  static const Color shimmerBase = Color(0xFF252538);
  static const Color shimmerHighlight = Color(0xFF2A2A3D);
}
