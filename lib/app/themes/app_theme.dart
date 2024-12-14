import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart' show AppColors;

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary, // Primary color
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
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Button's background color
        foregroundColor: Colors.white, // Button's text color
        disabledBackgroundColor: AppColors.grey, // Disabled button background
        disabledForegroundColor: AppColors.white, // Disabled button text color
        textStyle: TextStyle(
          fontSize: 16, // Font size of the button text
          fontWeight: FontWeight.bold, // Font weight of button text
        ),
      ),
    ),

    // Common input decoration for TextField and Dropdown
    inputDecorationTheme: InputDecorationTheme(
      filled: false, // No fill color
      hintStyle: TextStyle(
          color: AppColors
              .hintText), // Using AppColors.hintText for hint text color
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

    // For dropdown styling in general
    dropdownMenuTheme: DropdownMenuThemeData(
      // Customizes the dropdown menu (when opened)
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
            AppColors.backgroundDark), // Background color for dropdown
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )),
      ),
    ),

    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
  );
}
