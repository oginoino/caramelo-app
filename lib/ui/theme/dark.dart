import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: UiToken.primaryDarkColorSwatch,
  ),
);

ThemeData get darkTheme => _darkTheme;
