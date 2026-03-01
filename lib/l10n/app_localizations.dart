import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Caramelo App'**
  String get appTitle;

  /// Welcome message displayed to users
  ///
  /// In en, this message translates to:
  /// **'Welcome to Caramelo!'**
  String get welcomeMessage;

  /// Toggle theme button text
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get toggleTheme;

  /// Search placeholder text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Title for adding a new location
  ///
  /// In en, this message translates to:
  /// **'New location'**
  String get newLocationTitle;

  /// Hint text for the new location input
  ///
  /// In en, this message translates to:
  /// **'E.g.: Mom\'s house'**
  String get newLocationHint;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Option to add a new location
  ///
  /// In en, this message translates to:
  /// **'Add location...'**
  String get addLocation;

  /// Language selector label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Message shown when no products match the filters
  ///
  /// In en, this message translates to:
  /// **'No products found.'**
  String get noProductsFound;

  /// Button text to view all product categories
  ///
  /// In en, this message translates to:
  /// **'View all categories'**
  String get viewAllCategories;

  /// Label for the category that shows all products
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// Label for the deals/offers category
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get categoryDeals;

  /// Tooltip for the action to add a new location
  ///
  /// In en, this message translates to:
  /// **'Add new location'**
  String get addLocationTooltip;

  /// Label for English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Label for Spanish language option
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// Label for Brazilian Portuguese language option
  ///
  /// In en, this message translates to:
  /// **'Portuguese (Brazil)'**
  String get languagePortugueseBrazil;

  /// Tooltip or helper text for selecting a location
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocation;

  /// Generic error displayed when products fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load products. Please try again later.'**
  String get errorLoadingProducts;

  /// Shown while products are loading
  ///
  /// In en, this message translates to:
  /// **'Loading products...'**
  String get loadingProducts;

  /// Generic error when locations fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load locations. Please try again later.'**
  String get errorLoadingLocations;

  /// Shown when user tries to add beyond stock limit
  ///
  /// In en, this message translates to:
  /// **'Stock limit reached.'**
  String get stockLimitReached;

  /// Label for closing actions like SnackBar
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Shown after successful user registration
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get authSuccessRegistration;

  /// SnackBar action to clear/hide
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get actionClear;

  /// Shown after requesting password reset email
  ///
  /// In en, this message translates to:
  /// **'Recovery email sent!'**
  String get passwordResetEmailSent;

  /// Shown after password reset completes
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordChangedSuccess;

  /// Login error for wrong credentials
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get errorInvalidCredentials;

  /// Shown when there is no internet
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNetworkOffline;

  /// Shown when a request times out
  ///
  /// In en, this message translates to:
  /// **'The request took too long'**
  String get errorTimeout;

  /// Generic authentication error without specifics
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get errorAuthenticationGeneric;

  /// Shown when trying to register an existing email
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get errorRegistrationConflictEmail;

  /// Shown when email is not found during password reset
  ///
  /// In en, this message translates to:
  /// **'Email not found'**
  String get errorEmailNotFound;

  /// Generic unexpected error message
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get errorUnexpected;

  /// Generic error when resetting password fails
  ///
  /// In en, this message translates to:
  /// **'Error resetting password'**
  String get errorResetPasswordGeneric;

  /// Floating action button label to navigate to cart with item count
  ///
  /// In en, this message translates to:
  /// **'Go to cart ({count})'**
  String goToCart(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
