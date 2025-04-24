import 'package:flutter/material.dart';
import 'custom_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: CustomColors.primaryDark,
  scaffoldBackgroundColor: CustomColors.backgroundDark,
  appBarTheme: AppBarTheme(
    backgroundColor: CustomColors.primaryDark,
    titleTextStyle: TextStyle(color: CustomColors.textDark, fontSize: 20),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: CustomColors.textDark),
    bodyMedium: TextStyle(color: CustomColors.textDark),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomColors.borderDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomColors.primaryDark),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CustomColors.primaryDark,
      foregroundColor: CustomColors.textLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);