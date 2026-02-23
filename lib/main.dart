import 'util/import/app.dart';
import 'util/import/log.dart';
import 'util/import/packages.dart';
import 'util/import/provider.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Bootstrap.init();

    runApp(
      MultiProvider(providers: RegisterProvider.register(), child: const App()),
    );
  } catch (e) {
    ErrorHandler.handleError(e, message: 'App error');
  }
}
