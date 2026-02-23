import 'package:flutter/material.dart';
import 'package:caramelo_app/l10n/app_localizations.dart';

class LocalizationService {
  static AppLocalizations get strings {
    final strings = _strings;
    if (strings == null) {
      throw Exception(
        'LocalizationService not initialized. Call load() before accessing strings.',
      );
    }
    return strings;
  }

  static AppLocalizations? _strings;

  static void load(Locale locale) {
    _strings = lookupAppLocalizations(locale);
  }
}
