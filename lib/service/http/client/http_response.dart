import '../../../util/import/http.dart';

class HttpResponse<T> {
  final T? data;
  final HttpStatus status;
  final Map<String, String>? headers;
  final String? message;
  final Map<String, dynamic>? metadata;

  HttpResponse({
    this.data,
    required this.status,
    this.headers,
    this.message,
    this.metadata,
  });

  bool get isSuccess => status.isSuccess;
  bool get isError => status.isError;
  int get statusCode => status.code;

  HttpResponse<R> copyWith<R>({
    R? data,
    HttpStatus? status,
    Map<String, String>? headers,
    String? message,
    Map<String, dynamic>? metadata,
  }) {
    return HttpResponse<R>(
      data: data ?? this.data as R,
      status: status ?? this.status,
      headers: headers ?? this.headers,
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
    );
  }
}
