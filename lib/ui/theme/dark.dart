import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: UiToken.primaryDarkColor,
  useMaterial3: true,
);

ThemeData get darkTheme => _darkTheme;
