import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF4CAF50),
  primaryColorLight: const Color(0xFF81C784),
  primaryColorDark: const Color(0xFF388E3C),
  secondaryHeaderColor: const Color(0xFF81C784),
  backgroundColor: const Color(0xFFF8F9FA),
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  cardColor: const Color(0xFFFFFFFF),
  dividerColor: const Color(0xFFE0E0E0),
  focusColor: const Color(0xFF4CAF50),
  hoverColor: const Color(0xFFE8F5E9),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
    displayMedium: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Color(0xFF333333),
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      color: Color(0xFF333333),
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      color: Color(0xFF666666),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4CAF50),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF4CAF50),
      side: const BorderSide(
        color: Color(0xFF4CAF50),
        width: 2.0,
      ),
      textStyle: const TextStyle(
        fontSize: 18.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Color(0xFFE0E0E0),
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Color(0xFF4CAF50),
        width: 2.0,
      ),
    ),
    hintStyle: const TextStyle(
      fontSize: 16.0,
      color: Color(0xFF999999),
    ),
    labelStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF333333),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 16.0,
    ),
  ),
);
