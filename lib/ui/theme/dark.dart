import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: UiToken.primaryDarkColor,
  primarySwatch: UiToken.primaryDarkColorSwatch,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
);

ThemeData get darkTheme => _darkTheme;
