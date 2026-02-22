import 'package:caramelo_app/util/import/service.dart';

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

class UserRepository extends BaseRepository {
  final PersistenceService _persistenceService;
  final String _authPrefix = Environment.authApiPrefix;
  final String _corePrefix = Environment.coreApiPrefix;

  UserRepository({
    required super.httpService,
    required PersistenceService persistenceService,
  }) : _persistenceService = persistenceService;

  Future<UserProfile> getCurrentUser() async {
    final accessToken = _persistenceService.getAccessToken();
    return handleResponse(
      request: () => httpService.get(
        path: buildUrl(_authPrefix, 'validate').toString(),
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
      operation: 'getCurrentUser',
      fromJson: (json) => UserProfile.fromClaims(json['claims']),
    );
  }

  Future<UserMe> getMe() async {
    final accessToken = _persistenceService.getAccessToken();
    return handleResponse(
      request: () => httpService.get(
        path: buildUrl(_corePrefix, 'users/me').toString(),
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
      operation: 'getMe',
      fromJson: (json) => UserMe(fullName: json['name'], email: json['email']),
    );
  }
}
