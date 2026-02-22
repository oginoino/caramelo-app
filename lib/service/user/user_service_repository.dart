import '../../util/import/http.dart';
import '../../util/import/repository.dart';

class UserServiceRepository extends BaseRepository {
  final String _authPrefix;
  final String _corePrefix;

  UserServiceRepository({
    required super.httpService,
    String authPrefix = '/api/v1',
    String corePrefix = '/api/v1',
  }) : _authPrefix = authPrefix,
       _corePrefix = corePrefix;

  Future<UserProfile> getCurrentUser() async {
    final response = await httpService.get<Map<String, dynamic>>(
      path: '$_authPrefix/validate',
    );

    if (response.isSuccess && response.data != null) {
      return _parseUserProfile(response.data!);
    }

    throw HttpError.fromStatusCode(
      statusCode: response.statusCode,
      message: 'Failed to get current user',
    );
  }

  Future<UserMe> getMe() async {
    final response = await httpService.get<Map<String, dynamic>>(
      path: '$_corePrefix/users/me',
    );

    if (response.isSuccess && response.data != null) {
      return _parseUserMe(response.data!);
    }

    throw HttpError.fromStatusCode(
      statusCode: response.statusCode,
      message: 'Failed to get user profile',
    );
  }

  UserProfile _parseUserProfile(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw ParseError(
        message: 'Invalid user profile response: missing data field',
      );
    }

    final claims = data['claims'] as Map<String, dynamic>?;
    if (claims == null) {
      throw ParseError(
        message: 'Invalid user profile response: missing claims field',
      );
    }

    return UserProfile.fromClaims(claims);
  }

  UserMe _parseUserMe(Map<String, dynamic> json) {
    final status = json['status'] as String?;
    final data = json['data'] as Map<String, dynamic>?;

    if (status != 'success' || data == null) {
      throw ParseError(
        message: 'Invalid user me response: missing status or data field',
      );
    }

    final fullName = data['name'] as String?;
    final email = data['email'] as String?;

    if (fullName == null ||
        fullName.isEmpty ||
        email == null ||
        email.isEmpty) {
      throw ParseError(
        message: 'Invalid user me response: missing required fields',
      );
    }

    return UserMe(fullName: fullName.trim(), email: email.trim().toLowerCase());
  }
}
