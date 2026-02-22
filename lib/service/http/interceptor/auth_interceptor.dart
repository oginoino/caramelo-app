import '../../../util/import/http.dart';
import '../../../util/import/packages.dart';
import '../../../util/import/repository.dart';
import '../../../util/import/service.dart';

class AuthInterceptor implements HttpInterceptor {
  final PersistenceService _persistenceService;
  final AuthRepository _authRepository;
  final HttpLogger _logger;
  bool _isRefreshing = false;
  final Queue<Completer<void>> _refreshCompleters = Queue<Completer<void>>();

  AuthInterceptor({
    required PersistenceService persistenceService,
    required AuthRepository authRepository,
    HttpLogger? logger,
  }) : _persistenceService = persistenceService,
       _authRepository = authRepository,
       _logger = logger ?? HttpLogger();

  @override
  Future<HttpRequest> interceptRequest(HttpRequest request) async {
    if (_shouldAddAuthHeader(request)) {
      final accessToken = _persistenceService.getAccessToken();
      if (accessToken != null) {
        final headers = Map<String, String>.from(request.headers ?? {});
        headers['Authorization'] = 'Bearer $accessToken';
        return request.copyWith(headers: headers);
      }
    }
    return request;
  }

  @override
  Future<HttpResponse<T>> interceptResponse<T>(HttpResponse<T> response) async {
    if (response.statusCode == 401) {
      debugPrint('Received 401 response, attempting token refresh');

      try {
        await _refreshToken();

        debugPrint('Token refreshed successfully');
      } catch (e) {
        debugPrint('Token refresh failed: $e');
        await _persistenceService.clearAuth();
        throw UnauthorizedError(message: 'Authentication failed');
      }
    }
    return response;
  }

  bool _shouldAddAuthHeader(HttpRequest request) {
    final authEndpoints = [
      '/login',
      '/register',
      '/forgot-password',
      '/reset-password',
    ];
    final requestPath = request.path.toLowerCase();

    for (final endpoint in authEndpoints) {
      if (requestPath.contains(endpoint)) {
        return false;
      }
    }
    return true;
  }

  Future<void> _refreshToken() async {
    if (_isRefreshing) {
      final completer = Completer<void>();
      _refreshCompleters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      final refreshToken = _persistenceService.getRefreshToken();
      if (refreshToken == null) {
        throw UnauthorizedError(message: 'No refresh token available');
      }

      final tokenPair = await _authRepository.refreshToken(
        refreshToken: refreshToken,
      );

      await _persistenceService.saveTokens(
        accessToken: tokenPair.accessToken,
        refreshToken: tokenPair.refreshToken,
        accessTokenExpiryEpochSeconds: tokenPair.expiresAt,
      );

      while (_refreshCompleters.isNotEmpty) {
        _refreshCompleters.removeFirst().complete();
      }
    } catch (e) {
      while (_refreshCompleters.isNotEmpty) {
        _refreshCompleters.removeFirst().completeError(e);
      }
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<bool> isAuthenticated() async {
    return _persistenceService.isAccessTokenValid;
  }

  Future<void> logout() async {
    final accessToken = _persistenceService.getAccessToken();
    if (accessToken != null) {
      try {
        await _authRepository.logout(accessToken: accessToken);
      } catch (e) {
        _logger.logError(method: 'POST', url: '/logout', error: e);
      }
    }
    await _persistenceService.clearAuth();
  }
}
