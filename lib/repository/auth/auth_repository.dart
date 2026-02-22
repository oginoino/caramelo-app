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
        final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final expiresAt = nowSeconds + 15 * 60;
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
        final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final expiresAt = nowSeconds + 15 * 60;
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
