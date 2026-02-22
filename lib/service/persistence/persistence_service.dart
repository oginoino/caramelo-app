import '../../util/import/packages.dart';

class PersistenceService {
  final SharedPreferences _preferences;

  PersistenceService(this._preferences);

  static const String _keyIsDarkMode = 'is_dark_mode';
  static const String _keyAccentColor = 'accent_color';
  static const String _keyLocaleLanguage = 'locale_language';
  static const String _keyLocaleCountry = 'locale_country';
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyAccessTokenExpiry = 'access_token_expiry';

  bool? getIsDarkMode() => _preferences.getBool(_keyIsDarkMode);

  void setIsDarkMode(bool isDarkMode) =>
      _preferences.setBool(_keyIsDarkMode, isDarkMode);

  int? getAccentColor() => _preferences.getInt(_keyAccentColor);

  Future<void> setAccentColor(int accentColor) async =>
      await _preferences.setInt(_keyAccentColor, accentColor);

  void setLocale(String language, String? country) {
    _preferences.setString(_keyLocaleLanguage, language);
    if (country != null) {
      _preferences.setString(_keyLocaleCountry, country);
    }
  }

  String? getLocaleLanguage() => _preferences.getString(_keyLocaleLanguage);

  String? getLocaleCountry() => _preferences.getString(_keyLocaleCountry);

  bool getOnboardingCompleted() =>
      _preferences.getBool(_keyOnboardingCompleted) ?? false;

  Future<void> setOnboardingCompleted() async =>
      await _preferences.setBool(_keyOnboardingCompleted, true);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int accessTokenExpiryEpochSeconds,
  }) async {
    await _preferences.setString(_keyAccessToken, accessToken);
    await _preferences.setString(_keyRefreshToken, refreshToken);
    await _preferences.setInt(
      _keyAccessTokenExpiry,
      accessTokenExpiryEpochSeconds,
    );
  }

  String? getAccessToken() => _preferences.getString(_keyAccessToken);

  String? getRefreshToken() => _preferences.getString(_keyRefreshToken);

  int? getAccessTokenExpiryEpochSeconds() =>
      _preferences.getInt(_keyAccessTokenExpiry);

  bool get isAccessTokenValid {
    final expiry = getAccessTokenExpiryEpochSeconds();
    if (expiry == null) return false;
    final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // add small clock skew tolerance
    return nowSeconds + 30 < expiry;
  }

  Future<void> clearAuth() async {
    await _preferences.remove(_keyAccessToken);
    await _preferences.remove(_keyRefreshToken);
    await _preferences.remove(_keyAccessTokenExpiry);
  }
}
