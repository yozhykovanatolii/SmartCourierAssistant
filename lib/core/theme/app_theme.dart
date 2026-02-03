import 'package:flutter/material.dart';

class AppTheme {
  static final _textTheme = TextTheme(
    headlineMedium: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      color: Colors.grey[600],
      fontSize: 15,
    ),
    labelMedium: TextStyle(
      color: Colors.grey[600],
      fontSize: 17,
    ),
  );

  static ThemeData get lightMode {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      textTheme: _textTheme,
    );
  }

  static ThemeData get darkMode {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      textTheme: _textTheme,
    );
  }
}
