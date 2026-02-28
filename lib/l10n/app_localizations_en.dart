// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Caramelo App';

  @override
  String get welcomeMessage => 'Welcome to Caramelo!';

  @override
  String get toggleTheme => 'Toggle Theme';

  @override
  String get search => 'Search';

  @override
  String get home => 'Home';

  @override
  String get newLocationTitle => 'New location';

  @override
  String get newLocationHint => 'E.g.: Mom\'s house';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get addLocation => 'Add location...';

  @override
  String get language => 'Language';

  @override
  String get noProductsFound => 'No products found.';

  @override
  String get viewAllCategories => 'View all categories';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryDeals => 'Deals';

  @override
  String get addLocationTooltip => 'Add new location';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languagePortugueseBrazil => 'Portuguese (Brazil)';

  @override
  String get selectLocation => 'Select location';

  @override
  String get errorLoadingProducts =>
      'Failed to load products. Please try again later.';
}
