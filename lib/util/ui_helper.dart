import 'package:flutter/material.dart';

class UiHelper {
  static const Duration snackBarDuration = Duration(seconds: 3);

  static void showSnackBar(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Color? backgroundColor,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: snackBarDuration,
        backgroundColor: backgroundColor,
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction ?? () => messenger.hideCurrentSnackBar(),
              )
            : null,
      ),
    );
  }
}
