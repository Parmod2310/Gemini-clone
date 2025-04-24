class AppConfig {
  static const int networkTimeout = 30; // Seconds
  static const String appName = 'Gemini Clone';
  static const bool isDebugMode = true;

  // Theme modes
  static const List<String> supportedThemes = ['light', 'dark'];
  static const String defaultTheme = 'light';

  // Animation durations
  static const Duration animationDuration = Duration(milliseconds: 300);
}