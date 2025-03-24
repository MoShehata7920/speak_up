import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speak_up/resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryTextColor),
      bodyMedium: TextStyle(color: AppColors.primaryTextColor),
      titleLarge: TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.accentColor,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Customize additional components (e.g., button themes) as needed.
  );
}
