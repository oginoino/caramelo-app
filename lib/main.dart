import 'app/app.dart';
import 'app/bootstrap.dart';
import 'util/import/log.dart';
import 'util/import/packages.dart';
import 'util/import/di.dart';
import 'provider/theme/theme_provider.dart';
import 'provider/locale_provider/locale_provider.dart';
import 'provider/product_provider/product_provider.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Bootstrap.init();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(persistenceService),
          ),
          ChangeNotifierProvider(
            create: (_) => LocaleProvider(persistenceService),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductProvider(productRepository),
          ),
        ],
        child: const App(),
      ),
    );
  } catch (e) {
    ErrorHandler.handleError(e, message: 'App error');
  } finally {
    DebugHandler.handleDebug('App finished');
  }
}
