import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gemini_clone/core/exceptions/app_exception.dart';

class GeminiService {
  final String _apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBwmHFRsw3IvHxIxdWj6DQY2a2uSOwEZv8';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": message}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        print('API error: ${response.statusCode} | ${response.body}');
        throw ServerException('Gemini API Error');
      }
    } catch (e) {
      print('Network error: $e');
      throw NetworkException('An unexpected network error occurred');
    }
  }
}
