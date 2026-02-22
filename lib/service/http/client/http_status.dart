class HttpStatus {
  final int code;
  final String? message;

  const HttpStatus(this.code, [this.message]);

  bool get isSuccess => code >= 200 && code < 300;
  bool get isError => code >= 400;
  bool get isClientError => code >= 400 && code < 500;
  bool get isServerError => code >= 500;

  static const HttpStatus ok = HttpStatus(200);
  static const HttpStatus created = HttpStatus(201);
  static const HttpStatus accepted = HttpStatus(202);
  static const HttpStatus noContent = HttpStatus(204);

  static const HttpStatus badRequest = HttpStatus(400, 'Bad Request');
  static const HttpStatus unauthorized = HttpStatus(401, 'Unauthorized');
  static const HttpStatus forbidden = HttpStatus(403, 'Forbidden');
  static const HttpStatus notFound = HttpStatus(404, 'Not Found');
  static const HttpStatus methodNotAllowed = HttpStatus(
    405,
    'Method Not Allowed',
  );
  static const HttpStatus conflict = HttpStatus(409, 'Conflict');
  static const HttpStatus unprocessableEntity = HttpStatus(
    422,
    'Unprocessable Entity',
  );
  static const HttpStatus tooManyRequests = HttpStatus(
    429,
    'Too Many Requests',
  );

  static const HttpStatus internalServerError = HttpStatus(
    500,
    'Internal Server Error',
  );
  static const HttpStatus badGateway = HttpStatus(502, 'Bad Gateway');
  static const HttpStatus serviceUnavailable = HttpStatus(
    503,
    'Service Unavailable',
  );
  static const HttpStatus gatewayTimeout = HttpStatus(504, 'Gateway Timeout');

  @override
  String toString() =>
      'HttpStatus($code${message != null ? ': $message' : ''})';
}
