import '../../util/import/packages.dart';
import '../../util/import/service.dart';

class LocaleProvider extends ChangeNotifier {
  final PersistenceService _persistenceService;

  LocaleProvider(this._persistenceService) {
    _loadLocale();
  }

  Locale _currentLocale = const Locale('pt', 'BR');

  Locale get currentLocale => _currentLocale;

  void _loadLocale() {
    final language = _persistenceService.getLocaleLanguage();
    final country = _persistenceService.getLocaleCountry();
    if (language != null) {
      _currentLocale = Locale(language, country);
    }
    _persistenceService.setLocale(
      _currentLocale.languageCode,
      _currentLocale.countryCode,
    );
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      _persistenceService.setLocale(locale.languageCode, locale.countryCode);
      notifyListeners();
    }
  }

  void setPortugueseBrazil() {
    setLocale(const Locale('pt', 'BR'));
  }

  void setEnglish() {
    setLocale(const Locale('en', 'US'));
  }

  void setSpanishLatinAmerica() {
    setLocale(const Locale('es', 'MX'));
  }
}
