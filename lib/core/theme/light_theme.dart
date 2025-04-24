import 'package:flutter/material.dart';
import 'custom_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: CustomColors.primary,
  scaffoldBackgroundColor: CustomColors.backgroundLight,
  appBarTheme: AppBarTheme(
    backgroundColor: CustomColors.primary,
    titleTextStyle: TextStyle(color: CustomColors.textLight, fontSize: 20),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: CustomColors.textLight),
    bodyMedium: TextStyle(color: CustomColors.textLight),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomColors.primary),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CustomColors.primary,
      foregroundColor: CustomColors.textDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);