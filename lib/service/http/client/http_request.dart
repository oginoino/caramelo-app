import '../../../util/import/http.dart';

class HttpRequest {
  final HttpMethod method;
  final String path;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;
  final Duration? timeout;

  HttpRequest({
    required this.method,
    required this.path,
    this.queryParameters,
    this.body,
    this.headers,
    this.timeout,
  });

  HttpRequest copyWith({
    HttpMethod? method,
    String? path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
  }) {
    return HttpRequest(
      method: method ?? this.method,
      path: path ?? this.path,
      queryParameters: queryParameters ?? this.queryParameters,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      timeout: timeout ?? this.timeout,
    );
  }
}
