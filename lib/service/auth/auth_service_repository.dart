import '../../util/import/http.dart';
import '../../util/import/repository.dart';

class AuthServiceRepository extends BaseRepository {
  final String _authPrefix;

  AuthServiceRepository({
    required super.httpService,
    String authPrefix = '/api/v1',
  }) : _authPrefix = authPrefix;

  Future<TokenPair> login({
    required String email,
    required String password,
  }) async {
    final response = await httpService.post<Map<String, dynamic>>(
      path: '$_authPrefix/login',
      body: {'email': email, 'password': password},
    );

    if (response.isSuccess && response.data != null) {
      return _parseTokenResponse(response.data!);
    }

    throw HttpError.fromStatusCode(
      statusCode: response.statusCode,
      message: 'Login failed',
    );
  }

  Future<void> logout({required String accessToken}) async {
    await httpService.post<Map<String, dynamic>>(
      path: '$_authPrefix/logout',
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String cpf,
    required String phone,
    required bool acceptTerms,
  }) async {
    final response = await httpService.post<Map<String, dynamic>>(
      path: '$_authPrefix/register',
      body: {
        'name': fullName,
        'email': email,
        'password': password,
        'role': 'USER',
        'cpf': cpf,
        'phone': phone,
        'acceptTerms': acceptTerms,
      },
    );

    if (!response.isSuccess) {
      throw HttpError.fromStatusCode(
        statusCode: response.statusCode,
        message: 'Registration failed',
      );
    }
  }

  Future<TokenPair> refreshToken({required String refreshToken}) async {
    final response = await httpService.post<Map<String, dynamic>>(
      path: '$_authPrefix/refresh',
      body: {'refresh_token': refreshToken},
    );

    if (response.isSuccess && response.data != null) {
      return _parseTokenResponse(response.data!);
    }

    throw HttpError.fromStatusCode(
      statusCode: response.statusCode,
      message: 'Token refresh failed',
    );
  }

  Future<void> requestPasswordReset({required String email}) async {
    final response = await httpService.post<Map<String, dynamic>>(
      path: '$_authPrefix/forgot-password',
      body: {'email': email},
    );

    if (!response.isSuccess) {
      throw HttpError.fromStatusCode(
        statusCode: response.statusCode,
        message: 'Password reset request failed',
      );
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await httpService.post<Map<String, dynamic>>(
      path: '$_authPrefix/reset-password',
      body: {'token': token, 'newPassword': newPassword},
    );

    if (!response.isSuccess) {
      throw HttpError.fromStatusCode(
        statusCode: response.statusCode,
        message: 'Password reset failed',
      );
    }
  }

  TokenPair _parseTokenResponse(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw ParseError(message: 'Invalid token response: missing data field');
    }

    final accessToken = data['access_token'] as String?;
    final refreshToken = data['refresh_token'] as String?;

    if (accessToken == null) {
      throw ParseError(message: 'Invalid token response: missing access_token');
    }

    final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expiresAt = nowSeconds + 15 * 60;

    return TokenPair(
      accessToken: accessToken,
      refreshToken: refreshToken ?? '',
      expiresAt: expiresAt,
    );
  }
}
