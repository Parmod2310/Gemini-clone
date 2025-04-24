import 'package:hive/hive.dart';

part 'message_model.g.dart'; // Needed for Hive code generation

@HiveType(typeId: 1)
class MessageModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final bool isUser;

  @HiveField(3)
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  /// Factory constructor for creating a new `MessageModel` instance from a map.
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      isUser: json['isUser'] ?? false,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  /// Converts the current object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
