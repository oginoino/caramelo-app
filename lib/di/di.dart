import '../util/import/const.dart';
import '../util/import/http.dart';
import '../util/import/packages.dart';
import '../util/import/repository.dart';
import '../util/import/service.dart';

class DependencyInjection {
  DependencyInjection._();

  static Future<void> register() async {
    await _registerPersistencePreferences();
    _registerUtils();
    _registerServices();
    _registerRepositories();
    _registerAuthenticatedService();
  }

  static Future<void> _registerPersistencePreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<PersistenceService>(
      PersistenceService(sharedPreferences),
    );
  }

  static void _registerUtils() {
    GetIt.I.registerLazySingleton<AppConstants>(
      () => AppConstants(
        appName: Environment.appName ?? 'App',
        appVersion: Environment.appVersion ?? '1.0.0',
        appTitle: Environment.appTitle ?? 'App',
        appDescription: Environment.appDescription ?? 'App Description',
      ),
    );
    GetIt.I.registerLazySingleton<LocalizationService>(
      () => LocalizationService(),
    );

    // Initialize localization with default locale
    LocalizationService.load(const Locale('pt', 'BR'));
    GetIt.I.registerLazySingleton<UiToken>(() => UiToken());
  }

  static void _registerServices() {
    final persistenceService = GetIt.I<PersistenceService>();

    GetIt.I.registerLazySingleton<HttpServiceInterface>(
      () => ApiServiceFactory.createAuthService(
        persistenceService: persistenceService,
      ),
      instanceName: 'authService',
    );

    GetIt.I.registerLazySingleton<HttpServiceInterface>(
      () => ApiServiceFactory.createPublicService(),
      instanceName: 'publicService',
    );
  }

  static void _registerRepositories() {
    final authService = GetIt.I<HttpServiceInterface>(
      instanceName: 'authService',
    );
    final persistenceService = GetIt.I<PersistenceService>();

    GetIt.I.registerLazySingleton<ProductRepository>(
      () => ProductRepository(httpService: publicService),
    );

    GetIt.I.registerLazySingleton<AuthRepository>(
      () => AuthRepository(httpService: authService),
    );

    GetIt.I.registerLazySingleton<AuthServiceRepository>(
      () => AuthServiceRepository(
        httpService: authService,
        authPrefix: Environment.authApiPrefix,
      ),
    );

    GetIt.I.registerLazySingleton<UserServiceRepository>(
      () => UserServiceRepository(
        httpService: GetIt.I<HttpServiceInterface>(
          instanceName: 'authenticatedService',
        ),
        authPrefix: Environment.authApiPrefix,
        corePrefix: Environment.coreApiPrefix,
      ),
    );

    GetIt.I.registerLazySingleton<UserRepository>(
      () => UserRepository(
        httpService: GetIt.I<HttpServiceInterface>(
          instanceName: 'authenticatedService',
        ),
        persistenceService: persistenceService,
      ),
    );
  }

  static void _registerAuthenticatedService() {
    final persistenceService = GetIt.I<PersistenceService>();

    GetIt.I.registerLazySingleton<HttpServiceInterface>(
      () => ApiServiceFactory.createAuthenticatedService(
        persistenceService: persistenceService,
        authRepository: GetIt.I<AuthRepository>(),
      ),
      instanceName: 'authenticatedService',
    );
  }
}

PersistenceService get persistenseService => GetIt.I<PersistenceService>();
PersistenceService get persistenceService => GetIt.I<PersistenceService>();

AppConstants get appConstants => GetIt.I<AppConstants>();

LocalizationService get localizationService => GetIt.I<LocalizationService>();

UiToken get uiToken => GetIt.I<UiToken>();

ProductRepository get productRepository => GetIt.I<ProductRepository>();

AuthRepository get authRepository => GetIt.I<AuthRepository>();

AuthServiceRepository get authServiceRepository =>
    GetIt.I<AuthServiceRepository>();

UserServiceRepository get userServiceRepository =>
    GetIt.I<UserServiceRepository>();

UserRepository get userRepository => GetIt.I<UserRepository>();

HttpServiceInterface get authService =>
    GetIt.I<HttpServiceInterface>(instanceName: 'authService');

HttpServiceInterface get authenticatedService =>
    GetIt.I<HttpServiceInterface>(instanceName: 'authenticatedService');

HttpServiceInterface get publicService =>
    GetIt.I<HttpServiceInterface>(instanceName: 'publicService');
