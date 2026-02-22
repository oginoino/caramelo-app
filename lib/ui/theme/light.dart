import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: UiToken.primaryLightColor,
  primarySwatch: UiToken.primaryLightColorSwatch,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
);

ThemeData get lightTheme => _lightTheme;
