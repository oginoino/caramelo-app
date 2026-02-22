import 'dart:developer' as developer;

import '../../../util/import/packages.dart';

class HttpLogger {
  static const String _tag = 'HttpService';

  void logRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
    bool hasBody = false,
  }) {
    if (kDebugMode) {
      developer.log(
        'HTTP REQUEST\n'
        'Method: $method\n'
        'URL: $url\n'
        'Headers: ${headers?.toString() ?? "{}"}\n'
        '${hasBody ? "Body: ${body?.toString() ?? ""}" : ""}',
        name: _tag,
      );
    }
  }

  void logResponse({
    required int statusCode,
    Map<String, String>? headers,
    String? body,
  }) {
    if (kDebugMode) {
      developer.log(
        'HTTP RESPONSE\n'
        'Status Code: $statusCode\n'
        'Headers: ${headers?.toString() ?? "{}"}\n'
        'Body: ${body ?? ""}',
        name: _tag,
      );
    }
  }

  void logError({
    required String method,
    required String url,
    required dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        'HTTP ERROR\n'
        'Method: $method\n'
        'URL: $url\n'
        'Error: $error\n'
        'StackTrace: ${stackTrace?.toString() ?? "N/A"}',
        name: _tag,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
