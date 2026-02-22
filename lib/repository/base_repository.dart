import '../util/import/http.dart';

abstract class BaseRepository {
  final HttpServiceInterface _httpService;

  BaseRepository({required HttpServiceInterface httpService})
    : _httpService = httpService;

  HttpServiceInterface get httpService => _httpService;

  Future<T> handleResponse<T>({
    required Future<HttpResponse<T>> Function() request,
    required String operation,
    T Function(Map<String, dynamic>)? fromJson,
    T Function(List<dynamic>)? fromJsonList,
  }) async {
    try {
      final response = await request();

      if (response.isSuccess && response.data != null) {
        return response.data!;
      }

      throw HttpError.fromStatusCode(
        statusCode: response.statusCode,
        message: 'Operation failed: $operation',
      );
    } on HttpError {
      rethrow;
    } catch (e) {
      throw UnknownHttpError(message: 'Unexpected error during $operation: $e');
    }
  }

  Future<List<T>> handleListResponse<T>({
    required Future<HttpResponse<List<T>>> Function() request,
    required String operation,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await request();

      if (response.isSuccess && response.data != null) {
        return response.data!;
      }

      if (response.isSuccess && response.data == null) {
        return <T>[];
      }

      throw HttpError.fromStatusCode(
        statusCode: response.statusCode,
        message: 'Operation failed: $operation',
      );
    } on HttpError {
      rethrow;
    } catch (e) {
      throw UnknownHttpError(message: 'Unexpected error during $operation: $e');
    }
  }

  Map<String, dynamic> buildQueryParams(Map<String, dynamic> params) {
    return Map<String, dynamic>.from(params)
      ..removeWhere((key, value) => value == null);
  }

  String buildUrl(String path, [String? id]) {
    if (id != null) {
      return '$path/$id';
    }
    return path;
  }
}
