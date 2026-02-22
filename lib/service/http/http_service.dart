import 'package:http/http.dart' as http;
import 'dart:io';

import '../../util/import/http.dart';
import '../../util/import/packages.dart';
import '../../util/import/packages.dart';

class HttpService implements HttpServiceInterface {
  String _baseUrl;
  Map<String, String> _defaultHeaders;
  Duration _timeout;
  final http.Client _client;
  final HttpLogger _logger;
  final List<HttpInterceptor> _interceptors;

  HttpService({
    required String baseUrl,
    Map<String, String>? defaultHeaders,
    Duration? timeout,
    http.Client? client,
    HttpLogger? logger,
  }) : _baseUrl = baseUrl,
       _defaultHeaders = defaultHeaders ?? {},
       _timeout = timeout ?? const Duration(seconds: 30),
       _client = client ?? http.Client(),
       _logger = logger ?? HttpLogger(),
       _interceptors = [];

  @override
  Future<HttpResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  }) async {
    final request = HttpRequest(
      method: HttpMethod.get,
      path: path,
      queryParameters: queryParameters,
      headers: headers,
    );
    return this.request<T>(
      request: request,
      fromJson: fromJson,
      fromJsonList: fromJsonList,
    );
  }

  @override
  Future<HttpResponse<T>> post<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final request = HttpRequest(
      method: HttpMethod.post,
      path: path,
      body: body,
      headers: headers,
    );
    return this.request<T>(request: request, fromJson: fromJson);
  }

  @override
  Future<HttpResponse<T>> put<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final request = HttpRequest(
      method: HttpMethod.put,
      path: path,
      body: body,
      headers: headers,
    );
    return this.request<T>(request: request, fromJson: fromJson);
  }

  @override
  Future<HttpResponse<T>> patch<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final request = HttpRequest(
      method: HttpMethod.patch,
      path: path,
      body: body,
      headers: headers,
    );
    return this.request<T>(request: request, fromJson: fromJson);
  }

  @override
  Future<HttpResponse<T>> delete<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final request = HttpRequest(
      method: HttpMethod.delete,
      path: path,
      body: body,
      headers: headers,
    );
    return this.request<T>(request: request, fromJson: fromJson);
  }

  @override
  Future<HttpResponse<T>> upload<T>({
    required String path,
    required Uint8List fileBytes,
    required String fileName,
    String? fieldName,
    Map<String, String>? additionalFields,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = _buildUri(path, null);
    final request = http.MultipartRequest('POST', uri);

    request.headers.addAll(_mergeHeaders(headers));
    request.files.add(
      http.MultipartFile.fromBytes(
        fieldName ?? 'file',
        fileBytes,
        filename: fileName,
      ),
    );

    if (additionalFields != null) {
      request.fields.addAll(additionalFields);
    }

    try {
      _logger.logRequest(
        method: 'POST',
        url: uri.toString(),
        headers: request.headers,
        hasBody: true,
      );

      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse<T>(response: response, fromJson: fromJson);
    } on SocketException catch (e) {
      throw NetworkError(message: 'Network error: ${e.message}');
    } on TimeoutException catch (e) {
      throw TimeoutError(message: 'Request timeout: ${e.message}');
    } on http.ClientException catch (e) {
      throw ClientConnectionError(message: 'Client error: ${e.message}');
    } catch (e) {
      throw UnknownHttpError(message: 'Unknown error: $e');
    }
  }

  @override
  Future<HttpResponse<T>> request<T>({
    required HttpRequest request,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  }) async {
    HttpRequest processedRequest = request;

    for (final interceptor in _interceptors) {
      processedRequest = await interceptor.interceptRequest(processedRequest);
    }

    final uri = _buildUri(
      processedRequest.path,
      processedRequest.queryParameters,
    );
    final headers = _mergeHeaders(processedRequest.headers);

    try {
      _logger.logRequest(
        method: processedRequest.method.name.toUpperCase(),
        url: uri.toString(),
        headers: headers,
        body: processedRequest.body,
      );

      late final http.Response response;
      final timeout = processedRequest.timeout ?? _timeout;

      switch (processedRequest.method) {
        case HttpMethod.get:
          response = await _client.get(uri, headers: headers).timeout(timeout);
          break;
        case HttpMethod.post:
          response = await _client
              .post(
                uri,
                headers: headers,
                body: jsonEncode(processedRequest.body),
              )
              .timeout(timeout);
          break;
        case HttpMethod.put:
          response = await _client
              .put(
                uri,
                headers: headers,
                body: jsonEncode(processedRequest.body),
              )
              .timeout(timeout);
          break;
        case HttpMethod.patch:
          response = await _client
              .patch(
                uri,
                headers: headers,
                body: jsonEncode(processedRequest.body),
              )
              .timeout(timeout);
          break;
        case HttpMethod.delete:
          response = processedRequest.body != null
              ? await _client
                    .delete(
                      uri,
                      headers: headers,
                      body: jsonEncode(processedRequest.body),
                    )
                    .timeout(timeout)
              : await _client.delete(uri, headers: headers).timeout(timeout);
          break;
      }

      HttpResponse<T> httpResponse = _handleResponse<T>(
        response: response,
        fromJson: fromJson,
        fromJsonList: fromJsonList,
      );

      for (final interceptor in _interceptors.reversed) {
        httpResponse = await interceptor.interceptResponse<T>(httpResponse);
      }

      return httpResponse;
    } on SocketException catch (e) {
      throw NetworkError(message: 'Network error: ${e.message}');
    } on TimeoutException catch (e) {
      throw TimeoutError(message: 'Request timeout: ${e.message}');
    } on http.ClientException catch (e) {
      throw ClientConnectionError(message: 'Client error: ${e.message}');
    } on FormatException catch (e) {
      throw ParseError(message: 'Parse error: ${e.message}');
    } catch (e) {
      throw UnknownHttpError(message: 'Unknown error: $e');
    }
  }

  HttpResponse<T> _handleResponse<T>({
    required http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  }) {
    final status = HttpStatus(response.statusCode);
    final headers = _parseHeaders(response.headers);

    _logger.logResponse(
      statusCode: response.statusCode,
      headers: headers,
      body: response.body,
    );

    if (!status.isSuccess) {
      throw HttpError.fromStatusCode(
        statusCode: response.statusCode,
        body: response.body,
        message: 'HTTP ${response.statusCode} error',
      );
    }

    if (response.body.isEmpty) {
      return HttpResponse<T>(data: null, status: status, headers: headers);
    }

    try {
      final decodedBody = jsonDecode(response.body);
      T? data;

      if (fromJson != null && decodedBody is Map<String, dynamic>) {
        data = fromJson(decodedBody);
      } else if (fromJsonList != null && decodedBody is List) {
        data = fromJsonList(decodedBody);
      } else if (decodedBody is T) {
        data = decodedBody;
      }

      return HttpResponse<T>(data: data, status: status, headers: headers);
    } catch (e) {
      throw ParseError(message: 'Failed to parse response: $e');
    }
  }

  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final baseUri = Uri.parse(_baseUrl);
    final pathSegments = [...baseUri.pathSegments, ...path.split('/')];

    return Uri(
      scheme: baseUri.scheme,
      host: baseUri.host,
      port: baseUri.port,
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }

  Map<String, String> _mergeHeaders(Map<String, String>? additionalHeaders) {
    final merged = <String, String>{};
    merged.addAll(_defaultHeaders);
    if (additionalHeaders != null) {
      merged.addAll(additionalHeaders);
    }
    return merged;
  }

  Map<String, String> _parseHeaders(Map<String, String> headers) {
    return Map<String, String>.from(headers);
  }

  @override
  void addInterceptor(HttpInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  @override
  void removeInterceptor(HttpInterceptor interceptor) {
    _interceptors.remove(interceptor);
  }

  @override
  void clearInterceptors() {
    _interceptors.clear();
  }

  @override
  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  @override
  void setDefaultHeaders(Map<String, String> headers) {
    _defaultHeaders = headers;
  }

  @override
  void setTimeout(Duration timeout) {
    _timeout = timeout;
  }

  void dispose() {
    _client.close();
  }
}
