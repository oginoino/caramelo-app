import 'dart:math' as math;

import '../../../util/import/http.dart';

class RetryInterceptor implements HttpInterceptor {
  final int maxRetries;
  final Duration baseDelay;
  final double backoffMultiplier;
  final Set<int> retryableStatusCodes;
  final bool retryOnNetworkError;
  final bool retryOnTimeout;
  final HttpLogger _logger;

  RetryInterceptor({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
    this.backoffMultiplier = 2.0,
    this.retryableStatusCodes = const {408, 429, 500, 502, 503, 504},
    this.retryOnNetworkError = true,
    this.retryOnTimeout = true,
    HttpLogger? logger,
  }) : _logger = logger ?? HttpLogger();

  @override
  Future<HttpRequest> interceptRequest(HttpRequest request) async {
    return request;
  }

  @override
  Future<HttpResponse<T>> interceptResponse<T>(HttpResponse<T> response) async {
    return response;
  }

  Future<HttpResponse<T>> executeWithRetry<T>({
    required Future<HttpResponse<T>> Function() request,
    required String method,
    required String url,
  }) async {
    HttpError? lastError;

    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        return await request();
      } catch (error) {
        if (attempt == maxRetries) {
          rethrow;
        }

        if (!_shouldRetry(error)) {
          rethrow;
        }

        lastError = error as HttpError;
        final delay = _calculateDelay(attempt);

        _logger.logError(
          method: method,
          url: url,
          error:
              'Attempt ${attempt + 1} failed, retrying in ${delay.inMilliseconds}ms: $error',
        );

        await Future.delayed(delay);
      }
    }

    throw lastError ?? UnknownHttpError(message: 'Retry failed');
  }

  bool _shouldRetry(dynamic error) {
    if (error is HttpError) {
      if (error.statusCode != null) {
        return retryableStatusCodes.contains(error.statusCode);
      }

      if (error is NetworkError) {
        return retryOnNetworkError;
      }

      if (error is TimeoutError) {
        return retryOnTimeout;
      }
    }

    return false;
  }

  Duration _calculateDelay(int attempt) {
    if (attempt == 0) return Duration.zero;

    final exponentialDelay =
        baseDelay.inMilliseconds * math.pow(backoffMultiplier, attempt - 1);

    final jitteredDelay =
        exponentialDelay +
        (exponentialDelay * 0.1 * (math.Random().nextDouble() - 0.5));

    return Duration(milliseconds: jitteredDelay.round());
  }
}

class RetryHttpService implements HttpServiceInterface {
  final HttpServiceInterface _baseService;
  final RetryInterceptor _retryInterceptor;

  RetryHttpService({
    required HttpServiceInterface baseService,
    RetryInterceptor? retryInterceptor,
  }) : _baseService = baseService,
       _retryInterceptor = retryInterceptor ?? RetryInterceptor();

  @override
  Future<HttpResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  }) async {
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.get<T>(
        path: path,
        queryParameters: queryParameters,
        headers: headers,
        fromJson: fromJson,
        fromJsonList: fromJsonList,
      ),
      method: 'GET',
      url: path,
    );
  }

  @override
  Future<HttpResponse<T>> post<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.post<T>(
        path: path,
        body: body,
        headers: headers,
        fromJson: fromJson,
      ),
      method: 'POST',
      url: path,
    );
  }

  @override
  Future<HttpResponse<T>> put<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.put<T>(
        path: path,
        body: body,
        headers: headers,
        fromJson: fromJson,
      ),
      method: 'PUT',
      url: path,
    );
  }

  @override
  Future<HttpResponse<T>> patch<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.patch<T>(
        path: path,
        body: body,
        headers: headers,
        fromJson: fromJson,
      ),
      method: 'PATCH',
      url: path,
    );
  }

  @override
  Future<HttpResponse<T>> delete<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.delete<T>(
        path: path,
        body: body,
        headers: headers,
        fromJson: fromJson,
      ),
      method: 'DELETE',
      url: path,
    );
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
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.upload<T>(
        path: path,
        fileBytes: fileBytes,
        fileName: fileName,
        fieldName: fieldName,
        additionalFields: additionalFields,
        headers: headers,
        fromJson: fromJson,
      ),
      method: 'UPLOAD',
      url: path,
    );
  }

  @override
  Future<HttpResponse<T>> request<T>({
    required HttpRequest request,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  }) async {
    return _retryInterceptor.executeWithRetry(
      request: () => _baseService.request<T>(
        request: request,
        fromJson: fromJson,
        fromJsonList: fromJsonList,
      ),
      method: request.method.name.toUpperCase(),
      url: request.path,
    );
  }

  @override
  void addInterceptor(HttpInterceptor interceptor) {
    _baseService.addInterceptor(interceptor);
  }

  @override
  void removeInterceptor(HttpInterceptor interceptor) {
    _baseService.removeInterceptor(interceptor);
  }

  @override
  void clearInterceptors() {
    _baseService.clearInterceptors();
  }

  @override
  void setBaseUrl(String baseUrl) {
    _baseService.setBaseUrl(baseUrl);
  }

  @override
  void setDefaultHeaders(Map<String, String> headers) {
    _baseService.setDefaultHeaders(headers);
  }

  @override
  void setTimeout(Duration timeout) {
    _baseService.setTimeout(timeout);
  }
}
