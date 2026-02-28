import 'package:flutter/material.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.waitDuration,
  });

  final String message;
  final Widget child;
  final Duration? waitDuration;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      waitDuration: waitDuration,
      // The decoration and text style are inherited from the global Theme,
      // which we have customized in light.dart and dark.dart to match
      // the Caramelo App identity (Green palette).
      //
      // If we wanted to enforce specific overrides here, we could, but
      // using the Theme is the best practice for consistency.
      child: child,
    );
  }
}
