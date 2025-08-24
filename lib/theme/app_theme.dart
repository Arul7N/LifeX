import 'package:flutter/material.dart';

class AppTheme {
  // Atlassian Color Palette
  static const Color primaryBlue = Color(0xFF0052CC);
  static const Color lightBlue = Color(0xFF4C9AFF);
  static const Color darkBlue = Color(0xFF0747A6);
  
  static const Color successGreen = Color(0xFF00875A);
  static const Color warningYellow = Color(0xFFFFAB00);
  static const Color errorRed = Color(0xFFDE350B);
  
  static const Color neutral100 = Color(0xFFF4F5F7);
  static const Color neutral200 = Color(0xFFEBECF0);
  static const Color neutral300 = Color(0xFFDFE1E6);
  static const Color neutral400 = Color(0xFFB3BAC5);
  static const Color neutral500 = Color(0xFF8993A4);
  static const Color neutral800 = Color(0xFF42526E);
  static const Color neutral900 = Color(0xFF253858);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(0xFF0052CC, {
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: primaryBlue,
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF0D47A1),
      }),
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: neutral100,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: neutral900,
        elevation: 1,
        titleTextStyle: TextStyle(
          color: neutral900,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: neutral900,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: neutral900,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: neutral800,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: neutral800,
          fontSize: 14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }
}