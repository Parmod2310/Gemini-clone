import 'dart:developer' as dev;
import '../constants/app_config.dart'; // Adjust based on your structure

class LoggerUtils {
  static void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    if (AppConfig.isDebugMode) {
      dev.log(message, name: 'ERROR', error: error, stackTrace: stackTrace);
    }
  }

  static void logDebug(String message) {
    if (AppConfig.isDebugMode) {
      dev.log(message, name: 'DEBUG');
    }
  }

  static void logInfo(String message) {
    dev.log('[INFO] $message');
  }
}
