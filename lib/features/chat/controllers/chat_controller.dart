import 'package:get/get.dart';
import '../models/message_model.dart';
import '../services/gemini_service.dart';
import '../services/storage_service.dart';
import '../../../core/utils/logger_utils.dart';
import '../../../core/exceptions/app_exception.dart';


class ChatController extends GetxController {
  // Observable lists and states for messages, loading, and errors
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isTyping = false.obs;
  final RxString errorMessage = ''.obs;

  final GeminiService _geminiService = Get.find<GeminiService>(); // Gemini service for API calls
  final StorageService _storageService = Get.find<StorageService>(); // Storage service to handle local storage

  @override
  void onInit() {
    super.onInit();
    _loadMessages(); // Load previous messages after initialization
  }

  // Load saved messages from local storage
  Future<void> _loadMessages() async {
    try {
      final savedMessages = await _storageService.getMessages(); // Get stored messages
      messages.addAll(savedMessages); // Add them to the list of messages
    } catch (e, stackTrace) {
      LoggerUtils.logError('Failed to load messages', e, stackTrace);
      errorMessage.value = 'Failed to load conversation history'; // Error handling
    }
  }

  // Send a message to Gemini and handle the response
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return; // Don't send empty messages

    final userMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    messages.add(userMessage); // Add user message to the list
    isLoading.value = true;
    isTyping.value = true;
    errorMessage.value = ''; // Clear previous errors

    try {
      // Send message to Gemini API
      final aiResponse = await _geminiService.sendMessage(text);
      isTyping.value = false;

      // Prepare AI response message
      final aiMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      messages.add(aiMessage); // Add AI message to the list
      await _storageService.saveMessage(userMessage); // Save user message to storage
      await _storageService.saveMessage(aiMessage); // Save AI message to storage
    } on ServerException catch (e, stackTrace) {
      errorMessage.value = 'Server error: ${e.message}';
      LoggerUtils.logError('Server error', e, stackTrace);
    } on NetworkException catch (e, stackTrace) {
      errorMessage.value = 'Network error: ${e.message}';
      LoggerUtils.logError('Network error', e, stackTrace);
    } catch (e, stackTrace) {
      errorMessage.value = 'Unexpected error: $e';
      LoggerUtils.logError('Unexpected error', e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  // Clear the conversation (messages) and clear storage
  void clearConversation() async {
    messages.clear(); // Clear messages list
    await _storageService.clearMessages(); // Clear stored messages
  }
}
