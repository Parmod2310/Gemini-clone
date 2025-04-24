// File: lib/core/exceptions/app_exception.dart

abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() {
    return "$runtimeType: $message ${code != null ? '(Code: $code)' : ''}";
  }
}

class ServerException extends AppException {
  ServerException(String message, [String? code]) : super(message, code);
}

class NetworkException extends AppException {
  NetworkException(String message, [String? code]) : super(message, code);
}

class FetchException extends AppException {
  FetchException(String message, [String? code]) : super(message, code);
}
