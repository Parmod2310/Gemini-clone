import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'light_theme.dart';
import 'dark_theme.dart';
import '../constants/app_config.dart';

class ThemeManager extends GetxController {
  final RxString _currentTheme = AppConfig.defaultTheme.obs;
  static ThemeManager get to => Get.find();

  String get currentTheme => _currentTheme.value;

  bool get isDarkMode => _currentTheme.value == 'dark'; // Added getter

  ThemeData get currentThemeData {
    return _currentTheme.value == 'dark' ? darkTheme : lightTheme;
  }

  void toggleTheme(String theme) {
    if (AppConfig.supportedThemes.contains(theme)) {
      _currentTheme.value = theme;
      Get.changeTheme(currentThemeData);
      // Optionally save to local storage (e.g., Hive) here
    }
  }
}