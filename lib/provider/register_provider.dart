import '../util/import/di.dart';
import '../util/import/packages.dart';
import '../util/import/provider.dart';

class RegisterProvider {
  RegisterProvider._();

  static List<SingleChildWidget> register() {
    return [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(storageService),
      ),
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(storageService),
      ),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(
        create: (context) => ProductProvider(productRepository),
      ),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => OrderProvider()),
      ChangeNotifierProvider(
        create: (context) =>
            UserProfileProvider(userRepository, storageService),
      ),
    ];
  }
}
