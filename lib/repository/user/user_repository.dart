import 'package:caramelo_app/util/import/service.dart';
import 'package:http/http.dart' as http;

import '../../util/import/const.dart';
import '../../util/import/packages.dart';
import '../../util/import/repository.dart';

class UserProfile {
  final String id;
  final String role;

  UserProfile({required this.id, required this.role});

  factory UserProfile.fromClaims(Map<String, dynamic> json) {
    return UserProfile(
      id: json['sub'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }
}

class UserMe {
  final String fullName;
  final String email;

  UserMe({required this.fullName, required this.email});
}

class UserRepository {
  UserRepository({
    http.Client? httpClient,
    PersistenceService? persistence,
    String? authBaseUrl,
    String? coreBaseUrl,
  }) : _httpClient = httpClient ?? http.Client(),
       _persistenceService = persistence ?? GetIt.I<PersistenceService>(),
       _baseUrl = authBaseUrl ?? Environment.authBaseUrl ?? '',
       _coreBaseUrl =
           coreBaseUrl ??
           Environment.coreApiBaseUrl ??
           authBaseUrl ??
           Environment.authBaseUrl ??
           '';

  final http.Client _httpClient;
  final PersistenceService _persistenceService;

  final String _baseUrl;
  final String _coreBaseUrl;
  final Duration _timeout = Duration(milliseconds: Environment.authTimeoutMs);
  String get _authPrefix => Environment.authApiPrefix;
  String get _corePrefix => Environment.coreApiPrefix;

  Uri _buildUri(String baseUrl, String path) {
    final trimmedBaseUrl = baseUrl.trim();
    final base = Uri.tryParse(trimmedBaseUrl);

    final isValidScheme =
        base != null &&
        (base.scheme == 'http' || base.scheme == 'https') &&
        base.host.isNotEmpty;

    if (trimmedBaseUrl.isEmpty || !isValidScheme) {
      throw AuthException(
        'invalid_configuration',
        'API base URL is missing or invalid',
      );
    }

    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return base.replace(path: normalizedPath);
  }

  Future<UserProfile> getCurrentUser() async {
    final accessToken = _persistenceService.getAccessToken();
    if (accessToken == null) {
      throw AuthException('unauthenticated', 'User is not authenticated');
    }

    final uri = _buildUri(_baseUrl, '$_authPrefix/validate');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final root = jsonDecode(response.body) as Map<String, dynamic>;
        final data = root['data'] as Map<String, dynamic>?;
        final claims = data?['claims'] as Map<String, dynamic>?;

        if (claims == null) {
          throw AuthException(
            'profile_parse_error',
            'Invalid profile response payload',
          );
        }

        return UserProfile.fromClaims(claims);
      }

      if (response.statusCode == 401) {
        throw AuthException('unauthorized', 'Invalid or expired token');
      }

      throw AuthException(
        'profile_unexpected_status',
        'Unexpected status code: ${response.statusCode}',
      );
    } on AuthException {
      rethrow;
    } on Exception catch (_) {
      throw ServerUnavailableException('Could not fetch user profile');
    }
  }

  Future<UserMe> getMe() async {
    final accessToken = _persistenceService.getAccessToken();
    if (accessToken == null) {
      throw AuthException('unauthenticated', 'User is not authenticated');
    }

    final uri = _buildUri(_coreBaseUrl, '$_corePrefix/users/me');

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final root = jsonDecode(response.body) as Map<String, dynamic>;
        final status = root['status'] as String?;
        final data = root['data'] as Map<String, dynamic>?;

        final fullName = (data?['name'] as String?)?.trim();
        final email = (data?['email'] as String?)?.trim();

        final emailRegex = RegExp(
          r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
        );

        if (status != 'success' ||
            fullName == null ||
            fullName.isEmpty ||
            email == null ||
            email.isEmpty ||
            !emailRegex.hasMatch(email)) {
          throw AuthException(
            'profile_parse_error',
            'Invalid profile response payload',
          );
        }

        return UserMe(fullName: fullName, email: email.toLowerCase());
      }

      if (response.statusCode == 401) {
        throw AuthException('unauthorized', 'Invalid or expired token');
      }

      if (response.statusCode == 404) {
        throw AuthException('user_not_found', 'User not found');
      }

      throw AuthException(
        'profile_unexpected_status',
        'Unexpected status code: ${response.statusCode}',
      );
    } on AuthException {
      rethrow;
    } on Exception catch (_) {
      throw ServerUnavailableException('Could not fetch user profile');
    }
  }
}
