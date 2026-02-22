import 'app/app.dart';
import 'app/bootstrap.dart';
import 'util/import/log.dart';
import 'util/import/packages.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Bootstrap.init();
    runApp(const App());
  } catch (e) {
    ErrorHandler.handleError(e, message: 'App error');
  } finally {
    DebugHandler.handleDebug('App finished');
  }
}
