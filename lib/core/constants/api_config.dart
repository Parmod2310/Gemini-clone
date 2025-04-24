class ApiConfig {
  static const String baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  static const String chatEndpoint = '/models/gemini-pro:generateContent';
  static String? apiKey;

  static String get fullChatUrl => '$baseUrl$chatEndpoint';

  static void initialize(String key) {
    if (key.isEmpty) throw ArgumentError('API key cannot be empty');
    apiKey = key;
  }

  static Map<String, String> get headers {
    if (apiKey == null) throw StateError('API key has not been initialized.');
    return {
      'x-goog-api-key': apiKey!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
