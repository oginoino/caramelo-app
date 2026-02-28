import '../../util/import/di.dart' as di;
import '../../util/import/http.dart';
import '../../util/import/packages.dart';
import '../../util/import/repository.dart';
import '../../util/import/service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthServiceRepository _authRepository;
  final PersistenceService _persistenceService;

  AuthProvider({
    AuthServiceRepository? authRepository,
    PersistenceService? persistenceService,
  }) : _authRepository = authRepository ?? di.authServiceRepository,
       _persistenceService = persistenceService ?? di.persistenceService;

  bool _isLoading = false;
  String? _error;
  TokenPair? _tokenPair;

  bool get isLoading => _isLoading;
  String? get error => _error;
  TokenPair? get tokenPair => _tokenPair;
  bool get isAuthenticated => _persistenceService.isAccessTokenValid;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final tokenPair = await _authRepository.login(
        email: email,
        password: password,
      );

      await _persistenceService.saveTokens(
        accessToken: tokenPair.accessToken,
        refreshToken: tokenPair.refreshToken,
        accessTokenExpiryEpochSeconds: tokenPair.expiresAt,
      );
      _tokenPair = tokenPair;
    } on UnauthorizedError {
      _setError('Email ou senha inválidos');
    } on NetworkError {
      _setError('Sem conexão com internet');
    } on TimeoutError {
      _setError('A requisição demorou muito tempo');
    } on HttpError catch (e) {
      _setError('Erro de autenticação: ${e.message}');
      if (kDebugMode) {
        debugPrint('Login error: $e');
      }
    } catch (e) {
      _setError('Erro inesperado durante login');
      if (kDebugMode) {
        debugPrint('Unexpected login error: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String cpf,
    required String phone,
    required bool acceptTerms,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      await _authRepository.register(
        fullName: fullName,
        email: email,
        password: password,
        cpf: cpf,
        phone: phone,
        acceptTerms: acceptTerms,
      );

      if (context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(
          SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on ConflictError {
      _setError('Email já cadastrado');
    } on NetworkError {
      _setError('Sem conexão com internet');
    } on TimeoutError {
      _setError('A requisição demorou muito tempo');
    } on HttpError catch (e) {
      _setError('Erro no cadastro: ${e.message}');
      if (kDebugMode) {
        debugPrint('Register error: $e');
      }
    } catch (e) {
      _setError('Erro inesperado durante cadastro');
      if (kDebugMode) {
        debugPrint('Unexpected register error: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> requestPasswordReset({
    required String email,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      await _authRepository.requestPasswordReset(email: email);

      if (context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(
          SnackBar(
            content: Text('Email de recuperação enviado!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on NotFoundError {
      _setError('Email não encontrado');
    } on NetworkError {
      _setError('Sem conexão com internet');
    } on TimeoutError {
      _setError('A requisição demorou muito tempo');
    } on HttpError catch (e) {
      _setError('Erro: ${e.message}');
      if (kDebugMode) {
        debugPrint('Password reset error: $e');
      }
    } catch (e) {
      _setError('Erro inesperado');
      if (kDebugMode) {
        debugPrint('Unexpected password reset error: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      await _authRepository.resetPassword(
        token: token,
        newPassword: newPassword,
      );

      if (context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(
          SnackBar(
            content: Text('Senha alterada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on HttpError catch (e) {
      _setError('Erro ao redefinir senha: ${e.message}');
      if (kDebugMode) {
        debugPrint('Reset password error: $e');
      }
    } catch (e) {
      _setError('Erro inesperado');
      if (kDebugMode) {
        debugPrint('Unexpected reset password error: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout({required BuildContext context}) async {
    _setLoading(true);
    _setError(null);

    try {
      final accessToken = _persistenceService.getAccessToken();
      if (accessToken != null) {
        await _authRepository.logout(accessToken: accessToken);
      }

      await _persistenceService.clearAuth();
      _tokenPair = null;
    } on HttpError catch (e) {
      if (kDebugMode) {
        debugPrint('Logout error (best effort): $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _setError(null);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
