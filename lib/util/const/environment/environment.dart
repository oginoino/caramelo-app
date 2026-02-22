class Environment {
  Environment._();

  static String? appName = const String.fromEnvironment('APP_NAME');
  static String? appVersion = const String.fromEnvironment('APP_VERSION');
  static String? appTitle = const String.fromEnvironment('APP_TITLE');
  static String? appDescription = const String.fromEnvironment(
    'APP_DESCRIPTION',
  );
  static String? authBaseUrl = const String.fromEnvironment('AUTH_BASE_URL');
  static int authTimeoutMs =
      int.tryParse(const String.fromEnvironment('AUTH_TIMEOUT_MS')) ?? 15000;
  static String authApiPrefix = const String.fromEnvironment(
    'AUTH_API_PREFIX',
    defaultValue: '/api/v1',
  );

  static String? coreApiBaseUrl = const String.fromEnvironment(
    'CORE_API_BASE_URL',
  );
  static String coreApiPrefix = const String.fromEnvironment(
    'CORE_API_PREFIX',
    defaultValue: '/api/v1',
  );
}
