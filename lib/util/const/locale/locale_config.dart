import '../../import/packages.dart';
import '../../import/service.dart';

class LocaleConfig {
  LocaleConfig._();

  static const List<LocalizationsDelegate<dynamic>> localizationDelegates =
      AppLocalizations.localizationsDelegates;

  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;
}
