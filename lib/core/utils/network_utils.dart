import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../exceptions/app_exception.dart';
import '../constants/app_config.dart';

class NetworkUtils {
  static Future<http.Response> fetchWithTimeout(String url, {Map<String, String>? headers}) async {
    try {
      final client = http.Client();
      final response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: AppConfig.networkTimeout));
      _checkStatusCode(response);
      return response;
    } on TimeoutException {
      throw FetchException('Request timed out after ${AppConfig.networkTimeout} seconds');
    } on SocketException {
      throw NetworkException('No internet connection');
    } finally {
      // Clean up client
    }
  }

  static void _checkStatusCode(http.Response response) {
    if (response.statusCode != 200) {
      throw FetchException('Error ${response.statusCode}: ${response.body}');
    }
  }
}

class FetchException implements Exception {
  final String message;
  FetchException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}