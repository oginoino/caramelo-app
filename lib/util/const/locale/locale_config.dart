import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class LocaleConfig {
  static const List<LocalizationsDelegate<dynamic>> localizationDelegates =
      AppLocalizations.localizationsDelegates;

  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;
}
