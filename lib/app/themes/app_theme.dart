import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart' show AppColors;

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    // brightness: Brightness.dark, // Ensures the theme is dark
    primaryColor: AppColors.primaryColor, // Secondary color
    scaffoldBackgroundColor: Colors.black, // Background for Scaffold
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Button's background color
        foregroundColor: Colors.white, // Button's text color
        disabledBackgroundColor: AppColors.grey, // Disabled button background
        disabledForegroundColor: AppColors.white, // Disabled button text color
        textStyle: TextStyle(
          fontSize: 16, // Font size of the button text
          fontWeight:
              FontWeight.bold, // Optional: Set the font weight if needed
        ),
        // padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), // Padding for button
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: false, // No fill color
      hintStyle: TextStyle(color: Colors.white70),
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.white), // Default border color
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide:
            BorderSide(color: AppColors.white), // Primary color when focused
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
            color: Colors.white), // Default border color when not focused
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
  );
}
