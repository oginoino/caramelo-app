import '../../util/const/environment/environment.dart';
import '../../util/import/http.dart';
import '../../util/import/repository.dart';
import '../../util/import/service.dart';

class ApiServiceConfig {
  final String baseUrl;
  final String apiPrefix;
  final Duration timeout;
  final Map<String, String> defaultHeaders;

  ApiServiceConfig({
    required this.baseUrl,
    this.apiPrefix = '/api/v1',
    this.timeout = const Duration(seconds: 30),
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  });

  factory ApiServiceConfig.auth() {
    return ApiServiceConfig(
      baseUrl: Environment.authBaseUrl ?? '',
      apiPrefix: Environment.authApiPrefix,
      timeout: Duration(milliseconds: Environment.authTimeoutMs),
    );
  }

  factory ApiServiceConfig.core() {
    return ApiServiceConfig(
      baseUrl: Environment.coreApiBaseUrl ?? Environment.authBaseUrl ?? '',
      apiPrefix: Environment.coreApiPrefix,
      timeout: Duration(milliseconds: Environment.authTimeoutMs),
    );
  }
}

class ApiServiceFactory {
  static HttpServiceInterface createAuthService({
    PersistenceService? persistenceService,
    AuthRepository? authRepository,
  }) {
    final config = ApiServiceConfig.auth();

    final baseService = HttpService(
      baseUrl: config.baseUrl,
      defaultHeaders: config.defaultHeaders,
      timeout: config.timeout,
    );

    final retryService = RetryHttpService(
      baseService: baseService,
      retryInterceptor: RetryInterceptor(
        maxRetries: 3,
        baseDelay: const Duration(seconds: 1),
        backoffMultiplier: 2.0,
      ),
    );

    return retryService;
  }

  static HttpServiceInterface createAuthenticatedService({
    required PersistenceService persistenceService,
    required AuthRepository authRepository,
    ApiServiceConfig? config,
  }) {
    final serviceConfig = config ?? ApiServiceConfig.core();

    final baseService = HttpService(
      baseUrl: serviceConfig.baseUrl,
      defaultHeaders: serviceConfig.defaultHeaders,
      timeout: serviceConfig.timeout,
    );

    final authInterceptor = AuthInterceptor(
      persistenceService: persistenceService,
      authRepository: authRepository,
    );

    baseService.addInterceptor(authInterceptor);

    final retryService = RetryHttpService(
      baseService: baseService,
      retryInterceptor: RetryInterceptor(
        maxRetries: 3,
        baseDelay: const Duration(seconds: 1),
        backoffMultiplier: 2.0,
      ),
    );

    return retryService;
  }

  static HttpServiceInterface createPublicService({ApiServiceConfig? config}) {
    final serviceConfig = config ?? ApiServiceConfig.core();

    final baseService = HttpService(
      baseUrl: serviceConfig.baseUrl,
      defaultHeaders: serviceConfig.defaultHeaders,
      timeout: serviceConfig.timeout,
    );

    final retryService = RetryHttpService(
      baseService: baseService,
      retryInterceptor: RetryInterceptor(
        maxRetries: 2,
        baseDelay: const Duration(seconds: 1),
        backoffMultiplier: 1.5,
      ),
    );

    return retryService;
  }
}
