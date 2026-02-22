import 'package:flutter/material.dart';
import 'package:caramelo_app/l10n/app_localizations.dart';

class LocalizationService {
  AppLocalizations get strings => _strings!;
  AppLocalizations? _strings;

  void load(Locale locale) {
    _strings = lookupAppLocalizations(locale);
  }
}
