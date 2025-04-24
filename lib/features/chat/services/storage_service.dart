import 'package:get_storage/get_storage.dart';
import '../models/message_model.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // Initialize the storage
  Future<void> initialize() async {
    await GetStorage.init();  // Initialize GetStorage
  }

  // Save a message to local storage
  Future<void> saveMessage(MessageModel message) async {
    final messages = _box.read<List>('messages') ?? [];
    messages.add(message.toJson());
    await _box.write('messages', messages);
  }

  // Get saved messages from local storage
  Future<List<MessageModel>> getMessages() async {
    final messages = _box.read<List>('messages') ?? [];
    return messages.map((json) => MessageModel.fromJson(json)).toList();
  }

  // Clear saved messages from local storage
  Future<void> clearMessages() async {
    await _box.remove('messages');
  }
}
