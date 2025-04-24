import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/chat/services/storage_service.dart';
import 'features/chat/services/gemini_service.dart';
import 'features/chat/models/message_model.dart';
import 'features/chat/views/screens/chat_screen.dart';
import 'core/di/dependency_injection.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/logger_utils.dart';
import 'core/constants/api_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageModelAdapter());
    final storageService = StorageService();
    await storageService.initialize(); // ✅ ensure this is done

    // Initialize API Config with API key
    ApiConfig.initialize('AIzaSyBwmHFRsw3IvHxIxdWj6DQY2a2uSOwEZv8'); // Set API key here
    LoggerUtils.logInfo('Hive initialized successfully');
  } catch (e) {
    LoggerUtils.logError('Failed to initialize Hive', e);
  }

  // Setup dependency injection
  setupDependencies();
  // Initialize theme manager
  Get.put(ThemeManager());
  Get.put(StorageService());  // Ensure StorageService is properly initialized
  Get.put(GeminiService());
  // Log startup
  LoggerUtils.logInfo('App started successfully');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return Obx(() => GetMaterialApp(
          title: 'Gemini Clone',
          theme: ThemeManager.to.currentThemeData,
          home: const ChatScreen(),
          debugShowCheckedModeBanner: false,
          onUnknownRoute: (settings) {
            LoggerUtils.logError('Unknown route: ${settings.name}');
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(
                  child: Text('404: Page Not Found'),
                ),
              ),
            );
          },
        ));
      },
    );
  }
}
