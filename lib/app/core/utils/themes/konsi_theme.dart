import 'package:flutter/material.dart';

final konsiTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    centerTitle: true,
    elevation: 0.0,
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFF2E8896),
    secondary: Color(0xFFE8E8E8),
    surface: Color(0xFFFFFFFF),
    error: Color(0xFFEB5757),
    onPrimary: Color(0xFFEBF5F7),
    onSecondary: Color(0xFF7C7C7C),
    onSurface: Color(0xFFFFFFFF),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    titleMedium: const TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.grey[900]),
    bodyLarge: const TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.grey[900]),
    labelSmall: const TextStyle(
      color: Color(0xFF9E9E9E),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
    ),
  ),
);
