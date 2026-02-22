import '../../import/packages.dart';

class ErrorHandler {
  ErrorHandler._();

  static void handleError(Object error, {String? message}) {
    debugPrint(message ?? 'An error occurred');
    debugPrint('Error: $error');
  }
}
