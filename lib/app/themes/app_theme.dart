import 'package:flutter/material.dart';
import 'package:live_admin/app/global_imports.dart' show AppColors, kRadius;

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
      bodySmall: TextStyle(color: AppColors.white),
      titleSmall: TextStyle(color: AppColors.white),
      titleMedium: TextStyle(color: AppColors.white),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    primaryIconTheme: IconThemeData(color: AppColors.white),

    iconButtonTheme: IconButtonThemeData(
        style:
            ButtonStyle(iconColor: WidgetStateProperty.all(AppColors.white))),
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
    inputDecorationTheme: inputDecorationTheme,

    // For dropdown styling in general
    dropdownMenuTheme: DropdownMenuThemeData(
      // Customizes the dropdown menu (when opened)
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
            AppColors.backgroundDark), // Background color for dropdown
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        )),
      ),
    ),

    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondaryColor),
  );
}

final inputDecorationTheme = InputDecorationTheme(
  filled: false, // No fill color
  hintStyle: TextStyle(
    color: AppColors.hintText, // Hint text color
  ),
  labelStyle: const TextStyle(
    color: Colors.white, // Label color
  ),

  // Default border
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: BorderSide(
      color: AppColors.white, // Default border color
    ),
  ),

  // Focused border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: BorderSide(
      color: AppColors.primary, // Border color when focused
      width: 2.0, // Slightly thicker border on focus
    ),
  ),

  // Enabled border
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: BorderSide(
      color: AppColors.white, // Border color when enabled
    ),
  ),

  // Error border
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: BorderSide(
      color: AppColors.red, // Border color when there's an error
      width: 2.0,
    ),
  ),

  // Focused error border
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: BorderSide(
      color: AppColors.red, // Border color when focused with an error
      width: 2.5, // Slightly thicker for emphasis
    ),
  ),

  // Disabled border
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: BorderSide(
      color:
          AppColors.hintText.withOpacity(0.5), // Lighter border when disabled
    ),
  ),

  // Content padding for better alignment inside the input field
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16.0,
  ),
);
