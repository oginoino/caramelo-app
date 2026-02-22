import '../../../util/import/packages.dart';

abstract class HttpError implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? responseBody;
  final StackTrace? stackTrace;

  HttpError({
    required this.message,
    this.statusCode,
    this.responseBody,
    this.stackTrace,
  });

  factory HttpError.fromStatusCode({
    required int statusCode,
    String? body,
    String? message,
  }) {
    final responseBody = body != null && body.isNotEmpty
        ? jsonDecode(body) as Map<String, dynamic>
        : null;

    switch (statusCode) {
      case 400:
        return BadRequestError(
          message: message ?? 'Bad Request',
          responseBody: responseBody,
        );
      case 401:
        return UnauthorizedError(
          message: message ?? 'Unauthorized',
          responseBody: responseBody,
        );
      case 403:
        return ForbiddenError(
          message: message ?? 'Forbidden',
          responseBody: responseBody,
        );
      case 404:
        return NotFoundError(
          message: message ?? 'Not Found',
          responseBody: responseBody,
        );
      case 409:
        return ConflictError(
          message: message ?? 'Conflict',
          responseBody: responseBody,
        );
      case 422:
        return UnprocessableEntityError(
          message: message ?? 'Unprocessable Entity',
          responseBody: responseBody,
        );
      case 429:
        return TooManyRequestsError(
          message: message ?? 'Too Many Requests',
          responseBody: responseBody,
        );
      case 500:
        return InternalServerError(
          message: message ?? 'Internal Server Error',
          responseBody: responseBody,
        );
      case 502:
        return BadGatewayError(
          message: message ?? 'Bad Gateway',
          responseBody: responseBody,
        );
      case 503:
        return ServiceUnavailableError(
          message: message ?? 'Service Unavailable',
          responseBody: responseBody,
        );
      case 504:
        return GatewayTimeoutError(
          message: message ?? 'Gateway Timeout',
          responseBody: responseBody,
        );
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return ClientError(
            message: message ?? 'Client Error',
            statusCode: statusCode,
            responseBody: responseBody,
          );
        } else if (statusCode >= 500) {
          return ServerError(
            message: message ?? 'Server Error',
            statusCode: statusCode,
            responseBody: responseBody,
          );
        } else {
          return UnknownHttpError(
            message: message ?? 'Unknown HTTP Error',
            statusCode: statusCode,
            responseBody: responseBody,
          );
        }
    }
  }

  factory HttpError.networkError(String message) =>
      NetworkError(message: message);
  factory HttpError.timeoutError(String message) =>
      TimeoutError(message: message);
  factory HttpError.clientError(String message) =>
      ClientConnectionError(message: message);
  factory HttpError.parseError(String message) => ParseError(message: message);
  factory HttpError.unknownError(String message) =>
      UnknownHttpError(message: message);

  @override
  String toString() => 'HttpError: $message';
}

class BadRequestError extends HttpError {
  BadRequestError({required super.message, super.responseBody})
    : super(statusCode: 400);
}

class UnauthorizedError extends HttpError {
  UnauthorizedError({required super.message, super.responseBody})
    : super(statusCode: 401);
}

class ForbiddenError extends HttpError {
  ForbiddenError({required super.message, super.responseBody})
    : super(statusCode: 403);
}

class NotFoundError extends HttpError {
  NotFoundError({required super.message, super.responseBody})
    : super(statusCode: 404);
}

class ConflictError extends HttpError {
  ConflictError({required super.message, super.responseBody})
    : super(statusCode: 409);
}

class UnprocessableEntityError extends HttpError {
  UnprocessableEntityError({required super.message, super.responseBody})
    : super(statusCode: 422);
}

class TooManyRequestsError extends HttpError {
  TooManyRequestsError({required super.message, super.responseBody})
    : super(statusCode: 429);
}

class InternalServerError extends HttpError {
  InternalServerError({required super.message, super.responseBody})
    : super(statusCode: 500);
}

class BadGatewayError extends HttpError {
  BadGatewayError({required super.message, super.responseBody})
    : super(statusCode: 502);
}

class ServiceUnavailableError extends HttpError {
  ServiceUnavailableError({required super.message, super.responseBody})
    : super(statusCode: 503);
}

class GatewayTimeoutError extends HttpError {
  GatewayTimeoutError({required super.message, super.responseBody})
    : super(statusCode: 504);
}

class ClientError extends HttpError {
  ClientError({
    required super.message,
    required super.statusCode,
    super.responseBody,
  });
}

class ServerError extends HttpError {
  ServerError({
    required super.message,
    required super.statusCode,
    super.responseBody,
  });
}

class NetworkError extends HttpError {
  NetworkError({required super.message}) : super(statusCode: null);
}

class TimeoutError extends HttpError {
  TimeoutError({required super.message}) : super(statusCode: null);
}

class ClientConnectionError extends HttpError {
  ClientConnectionError({required super.message}) : super(statusCode: null);
}

class ParseError extends HttpError {
  ParseError({required super.message}) : super(statusCode: null);
}

class UnknownHttpError extends HttpError {
  UnknownHttpError({
    required super.message,
    super.statusCode,
    super.responseBody,
  });
}
