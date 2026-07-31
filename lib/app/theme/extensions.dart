import 'package:flutter/material.dart';
import 'colors.dart';

extension ContextTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isLight => !isDark;
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isLandscape => screenSize.width > screenSize.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension ColorOpacity on Color {
  Color withValuesAlpha(double alpha) => withOpacity(alpha);
}
