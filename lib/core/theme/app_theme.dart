import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightMode {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkMode {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );
  }
}
