import '../../util/import/const.dart';
import '../../util/import/packages.dart';
import '../../util/import/repository.dart';

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

class AuthRepository extends BaseRepository {
  AuthRepository({required super.httpService});

  final String _authPrefix = Environment.authApiPrefix;

  Future<TokenPair> login({
    required String email,
    required String password,
  }) async {
    return handleResponse(
      request: () => httpService.post(
        path: buildUrl(_authPrefix, 'login'),
        body: {'email': email, 'password': password},
      ),
      operation: 'login',
      fromJson: (json) => TokenPair.fromJson(json),
    );
  }

  Future<void> logout({required String accessToken}) async {
    await handleResponse(
      request: () => httpService.post(
        path: buildUrl(_authPrefix, 'logout'),
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
      operation: 'logout',
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
    await handleResponse(
      request: () => httpService.post(
        path: buildUrl(_authPrefix, 'register'),
        body: {
          'name': fullName,
          'email': email,
          'password': password,
          'role': 'USER',
          'cpf': cpf,
          'phone': phone,
          'acceptTerms': acceptTerms,
        },
      ),
      operation: 'register',
    );
  }

  Future<TokenPair> refreshToken({required String refreshToken}) async {
    return handleResponse(
      request: () => httpService.post(
        path: buildUrl(_authPrefix, 'refresh'),
        body: {'refresh_token': refreshToken},
      ),
      operation: 'refreshToken',
      fromJson: (json) => TokenPair.fromJson(json),
    );
  }

  Future<void> requestPasswordReset({required String email}) async {
    await handleResponse(
      request: () => httpService.post(
        path: buildUrl(_authPrefix, 'forgot-password'),
        body: {'email': email},
      ),
      operation: 'requestPasswordReset',
    );
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await handleResponse(
      request: () => httpService.post(
        path: buildUrl(_authPrefix, 'reset-password'),
        body: {'token': token, 'newPassword': newPassword},
      ),
      operation: 'resetPassword',
    );
  }
}
