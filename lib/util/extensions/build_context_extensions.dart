import 'package:flutter/material.dart';
import '../const/ui/ui_token.dart';

extension AppContext on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  UiToken get tokens => Theme.of(this).extension<UiToken>() ?? const UiToken();
}
