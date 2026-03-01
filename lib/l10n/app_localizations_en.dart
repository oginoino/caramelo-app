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

  @override
  String get loadingProducts => 'Loading products...';

  @override
  String get errorLoadingLocations =>
      'Failed to load locations. Please try again later.';

  @override
  String get stockLimitReached => 'Stock limit reached.';

  @override
  String get close => 'Close';

  @override
  String get cartTitle => 'Your Cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get cartClear => 'Clear cart';

  @override
  String get cartAddProducts => 'Add products';

  @override
  String get cartAddMoreProducts => 'Add more products';

  @override
  String get cartAddOtherProducts => 'Add other products';

  @override
  String cartMinOrder(String value) {
    return 'Min. order $value';
  }

  @override
  String cartMinOrderWarning(String value) {
    return 'Add $value more to reach minimum order.';
  }

  @override
  String get cartTotal => 'Total';

  @override
  String get cartOrderNow => 'Order now';

  @override
  String cartItemUnit(int quantity, String price) {
    return '$quantity unit(s) for $price';
  }

  @override
  String get authSuccessRegistration => 'Registration successful!';

  @override
  String get actionClear => 'Clear';

  @override
  String get passwordResetEmailSent => 'Recovery email sent!';

  @override
  String get passwordChangedSuccess => 'Password changed successfully!';

  @override
  String get errorInvalidCredentials => 'Invalid email or password';

  @override
  String get errorNetworkOffline => 'No internet connection';

  @override
  String get errorTimeout => 'The request took too long';

  @override
  String get errorAuthenticationGeneric => 'Authentication error';

  @override
  String get errorRegistrationConflictEmail => 'Email already registered';

  @override
  String get errorEmailNotFound => 'Email not found';

  @override
  String get errorUnexpected => 'Unexpected error';

  @override
  String get errorResetPasswordGeneric => 'Error resetting password';

  @override
  String goToCart(int count) {
    return 'Go to cart ($count)';
  }

  @override
  String get newProduct => 'New';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get lowStock => 'Low stock';

  @override
  String get description => 'Description';

  @override
  String get relatedProducts => 'Related Products';

  @override
  String inCartCount(int count) {
    return 'in cart: $count';
  }
}
