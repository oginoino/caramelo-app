import '../util/import/di.dart';
import '../util/import/packages.dart';
import '../util/import/provider.dart';

class RegisterProvider {
  RegisterProvider._();

  static List<SingleChildWidget> register() {
    return [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(persistenceService),
      ),
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(persistenceService),
      ),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(
        create: (context) => ProductProvider(productRepository),
      ),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => OrderProvider()),
      ChangeNotifierProvider(
        create: (context) =>
            UserProfileProvider(userRepository, persistenceService),
      ),
      ChangeNotifierProvider(
        create: (context) => LocationProvider(locationRepository),
      ),
    ];
  }
}
