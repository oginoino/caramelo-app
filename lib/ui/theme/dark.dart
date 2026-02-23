import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
  colorScheme: ColorScheme.dark(
    primary: UiToken.primaryDarkColor,
    secondary: UiToken.secondaryDark500,
    surface: UiToken.primaryDark900,
    error: UiToken.errorLight500,
    onPrimary: UiToken.primaryDark50,
    onSecondary: UiToken.secondaryDark50,
    onSurface: UiToken.primaryDark50,
    onError: UiToken.primaryDark50,
  ),
  appBarTheme: AppBarTheme(
    elevation: UiToken.elevationNone,
    centerTitle: true,
    backgroundColor: UiToken.primaryDarkColor,
    titleTextStyle: TextStyle(
      color: UiToken.secondaryLight500,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: IconThemeData(color: UiToken.secondaryLight500),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: UiToken.elevationNone,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
      backgroundColor: UiToken.secondaryDark50,
      textStyle: TextStyle(
        color: UiToken.secondaryLight400,
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight400,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
      backgroundColor: UiToken.secondaryDark50,
      textStyle: TextStyle(
        color: UiToken.secondaryLight400,
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryLight500),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryLight500),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryLight500),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.errorLight500),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.errorLight500),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: UiToken.spacing16,
      vertical: UiToken.spacing12,
    ),
    hintStyle: TextStyle(color: UiToken.secondaryLight500),
    suffixIconColor: UiToken.secondaryLight500,
    labelStyle: TextStyle(color: UiToken.secondaryLight500),
  ),
  cardTheme: CardThemeData(
    elevation: UiToken.elevationNone,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius12),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
    ),
    color: UiToken.primaryDark900,
    elevation: UiToken.elevationNone,
  ),
);

ThemeData get darkTheme => _darkTheme;
