import 'package:http/http.dart' as http;

import '../../util/import/const.dart';
import '../../util/import/packages.dart';

class AuthException implements Exception {
  final String code;
  final String message;
  AuthException(this.code, this.message);
  @override
  String toString() => 'AuthException($code): $message';
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(String message)
    : super('invalid_credentials', message);
}

class AccountNotVerifiedException extends AuthException {
  AccountNotVerifiedException(String message)
    : super('account_not_verified', message);
}

class ServerUnavailableException extends AuthException {
  ServerUnavailableException(String message)
    : super('server_unavailable', message);
}

class TokenPair {
  final String accessToken;
  final String refreshToken;
  final int expiresAt; // epoch seconds
  TokenPair({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
  factory TokenPair.fromJson(Map<String, dynamic> json) => TokenPair(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    expiresAt: (json['expiresAt'] as num).toInt(),
  );
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt,
  };
}

class AuthRepository {
  final String _baseUrl = Environment.authBaseUrl ?? '';
  final Duration _timeout = Duration(milliseconds: Environment.authTimeoutMs);
  String get _prefix => Environment.authApiPrefix;

  int _parseExpiresAtSeconds({
    required Map<String, dynamic>? data,
    required String accessToken,
  }) {
    final dynamic expiresAtRaw =
        data?['expires_at'] ??
        data?['expiresAt'] ??
        data?['access_token_expires_at'] ??
        data?['accessTokenExpiresAt'];
    final parsedExpiresAt = _tryParseEpochSecondsOrIso(expiresAtRaw);
    if (parsedExpiresAt != null) return parsedExpiresAt;

    final dynamic expiresInRaw =
        data?['expires_in'] ??
        data?['expiresIn'] ??
        data?['access_token_expires_in'] ??
        data?['accessTokenExpiresIn'];
    final expiresInSeconds = _tryParseInt(expiresInRaw);
    if (expiresInSeconds != null) {
      final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return nowSeconds + expiresInSeconds;
    }

    final jwtExpSeconds = _tryParseJwtExp(accessToken);
    if (jwtExpSeconds != null) return jwtExpSeconds;

    throw AuthException(
      'token_expiry_missing',
      'Token expiry not provided by server',
    );
  }

  int? _tryParseEpochSecondsOrIso(dynamic value) {
    if (value == null) return null;
    if (value is num) {
      final v = value.toInt();
      return v > 9999999999 ? v ~/ 1000 : v;
    }
    if (value is String) {
      final asInt = int.tryParse(value);
      if (asInt != null) {
        return asInt > 9999999999 ? asInt ~/ 1000 : asInt;
      }
      try {
        return DateTime.parse(value).millisecondsSinceEpoch ~/ 1000;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  int? _tryParseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  int? _tryParseJwtExp(String accessToken) {
    final parts = accessToken.split('.');
    if (parts.length < 2) return null;

    try {
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final obj = jsonDecode(decoded);
      if (obj is! Map<String, dynamic>) return null;
      final exp = obj['exp'];
      if (exp is num) return exp.toInt();
      if (exp is String) return int.tryParse(exp);
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<TokenPair> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$_prefix/login');
      final resp = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(_timeout);
      if (resp.statusCode == 200) {
        final root = jsonDecode(resp.body) as Map<String, dynamic>;
        final data = root['data'] as Map<String, dynamic>?;
        final accessToken = data?['access_token'] as String?;
        final refreshToken = data?['refresh_token'] as String?;
        if (accessToken == null || refreshToken == null) {
          throw AuthException(
            'login_parse_error',
            'Invalid login response payload',
          );
        }
        final expiresAt = _parseExpiresAtSeconds(
          data: data,
          accessToken: accessToken,
        );
        return TokenPair(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );
      }
      if (resp.statusCode == 401) {
        throw InvalidCredentialsException('Invalid email or password');
      }
      if (resp.statusCode == 403) {
        throw AccountNotVerifiedException('Account not verified');
      }
      throw AuthException('login_failed', 'Login failed (${resp.statusCode})');
    } on SocketException {
      throw ServerUnavailableException('Server unavailable');
    } on TimeoutException {
      throw ServerUnavailableException('Server timeout');
    }
  }

  Future<void> logout({required String accessToken}) async {
    try {
      final uri = Uri.parse('$_baseUrl$_prefix/logout');
      await http
          .post(
            uri,
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
          )
          .timeout(_timeout);
    } catch (_) {
      // Best-effort; ignore network errors on logout
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String cpf,
    required String phone,
    required bool acceptTerms,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$_prefix/register');
      final resp = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': fullName,
              'email': email,
              'password': password,
              'role': 'USER',
              'cpf': cpf,
              'phone': phone,
              'acceptTerms': acceptTerms,
            }),
          )
          .timeout(_timeout);
      if (resp.statusCode == 201 || resp.statusCode == 200) {
        return;
      }
      if (resp.statusCode == 409) {
        throw AuthException('email_taken', 'Email already registered');
      }
      throw AuthException(
        'register_failed',
        'Registration failed (${resp.statusCode})',
      );
    } on SocketException {
      throw ServerUnavailableException('Server unavailable');
    } on TimeoutException {
      throw ServerUnavailableException('Server timeout');
    }
  }

  Future<TokenPair> refreshToken({required String refreshToken}) async {
    try {
      final uri = Uri.parse('$_baseUrl$_prefix/refresh');
      final resp = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refresh_token': refreshToken}),
          )
          .timeout(_timeout);
      if (resp.statusCode == 200) {
        final root = jsonDecode(resp.body) as Map<String, dynamic>;
        final data = root['data'] as Map<String, dynamic>?;
        final accessToken = data?['access_token'] as String?;
        if (accessToken == null) {
          throw AuthException(
            'refresh_parse_error',
            'Invalid refresh response payload',
          );
        }
        final expiresAt = _parseExpiresAtSeconds(
          data: data,
          accessToken: accessToken,
        );
        return TokenPair(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );
      }
      throw AuthException(
        'refresh_failed',
        'Refresh failed (${resp.statusCode})',
      );
    } on SocketException {
      throw ServerUnavailableException('Server unavailable');
    } on TimeoutException {
      throw ServerUnavailableException('Server timeout');
    }
  }

  Future<void> requestPasswordReset({required String email}) async {
    try {
      final uri = Uri.parse('$_baseUrl$_prefix/forgot-password');
      final resp = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email}),
          )
          .timeout(_timeout);
      if (resp.statusCode == 200) return;
      if (resp.statusCode == 404) {
        throw AuthException('account_not_found', 'Account not found');
      }
      throw AuthException(
        'forgot_failed',
        'Password reset request failed (${resp.statusCode})',
      );
    } on SocketException {
      throw ServerUnavailableException('Server unavailable');
    } on TimeoutException {
      throw ServerUnavailableException('Server timeout');
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$_prefix/reset-password');
      final resp = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'token': token, 'newPassword': newPassword}),
          )
          .timeout(_timeout);
      if (resp.statusCode == 200) return;
      throw AuthException(
        'reset_failed',
        'Password reset failed (${resp.statusCode})',
      );
    } on SocketException {
      throw ServerUnavailableException('Server unavailable');
    } on TimeoutException {
      throw ServerUnavailableException('Server timeout');
    }
  }
}
