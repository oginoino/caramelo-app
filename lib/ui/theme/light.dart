import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: UiToken.primaryLightColorSwatch,
  ),
);

ThemeData get lightTheme => _lightTheme;
