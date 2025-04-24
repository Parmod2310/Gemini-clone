import 'package:get/get.dart';
import '../../features/chat/services/gemini_service.dart';

import '../../features/chat/services/storage_service.dart';

void setupDependencies() {
  Get.lazyPut<GeminiService>(() => GeminiService(), fenix: true);
  Get.lazyPut<StorageService>(() => StorageService(), fenix: true);
}