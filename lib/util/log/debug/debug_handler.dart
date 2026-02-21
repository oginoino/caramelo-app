import '../../import/packages.dart';

class DebugHandler {
  DebugHandler._();

  static void handleDebug(Object debug, {String? message}) {
    debugPrint(message ?? 'A debug occurred');
    debugPrint('Debug: $debug');
  }
}
