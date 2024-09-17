import 'package:flutter/material.dart';

final konsiTheme = ThemeData(
  fontFamily: 'roboto',
  scaffoldBackgroundColor: const Color(0xFFF6F6F6),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF6F6F6),
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    centerTitle: true,
    elevation: 0.0,
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFF2E8896),
    onPrimaryContainer: Color(0xFFFCA33B),
    secondary: Color(0xFFE8E8E8),
    surface: Color(0xFFFFFFFF),
    error: Color(0xFFEB5757),
    onPrimary: Color(0xFFEBF5F7),
    onSecondary: Color(0xFF7C7C7C),
    onSurface: Color(0xFFFBFBFB),
    onError: Color(0xFFFFFFFF),
    onSecondaryFixed: Color(0xFF5E6772),
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
