import '../../util/import/http.dart';

abstract class HttpServiceInterface {
  Future<HttpResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  });

  Future<HttpResponse<T>> post<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<HttpResponse<T>> put<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<HttpResponse<T>> patch<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<HttpResponse<T>> delete<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<HttpResponse<T>> upload<T>({
    required String path,
    required Uint8List fileBytes,
    required String fileName,
    String? fieldName,
    Map<String, String>? additionalFields,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<HttpResponse<T>> request<T>({
    required HttpRequest request,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  });

  void addInterceptor(HttpInterceptor interceptor);
  void removeInterceptor(HttpInterceptor interceptor);
  void clearInterceptors();

  void setBaseUrl(String baseUrl);
  void setDefaultHeaders(Map<String, String> headers);
  void setTimeout(Duration timeout);
}

abstract class HttpInterceptor {
  Future<HttpRequest> interceptRequest(HttpRequest request);
  Future<HttpResponse<T>> interceptResponse<T>(HttpResponse<T> response);
}
