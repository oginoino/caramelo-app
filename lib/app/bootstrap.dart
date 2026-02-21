import '../util/import/di.dart' as di;
import '../util/import/packages.dart';
import '../util/import/log.dart';

class Bootstrap {
  Bootstrap._();

  static Future<void> init() async {
    try {
      await _registerDependencies();
      await _configureRouter();
    } catch (error) {
      ErrorHandler.handleError(error, message: 'Bootstrap error');
    } finally {
      DebugHandler.handleDebug('Bootstrap finished');
    }
  }

  static Future<void> _registerDependencies() async {
    await di.DependencyInjection.register();
  }

  static Future<void> _configureRouter() async {
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }
}
