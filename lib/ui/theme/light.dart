import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
  colorScheme: ColorScheme.light(
    primary: UiToken.primaryLightColor,
    secondary: UiToken.secondaryLight500,
    surface: UiToken.primaryLight50,
    error: UiToken.errorLight500,
    onPrimary: UiToken.primaryLight900,
    onSecondary: UiToken.secondaryLight900,
    onSurface: UiToken.primaryLight900,
    onError: UiToken.primaryLight50,
  ),
  appBarTheme: AppBarTheme(
    elevation: UiToken.elevationNone,
    centerTitle: true,
    backgroundColor: UiToken.primaryLightColor,
    titleTextStyle: TextStyle(
      color: UiToken.secondaryDark500,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: IconThemeData(color: UiToken.secondaryDark500),
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
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
      backgroundColor: UiToken.secondaryLight50,
      textStyle: TextStyle(
        color: UiToken.secondaryDark500,
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryDark500,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
      backgroundColor: UiToken.secondaryLight50,
      textStyle: TextStyle(
        color: UiToken.primaryLight500,
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.primaryLight500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryDark500),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryDark500),
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
    hintStyle: TextStyle(color: UiToken.secondaryDark500),
    suffixIconColor: UiToken.secondaryDark500,
    labelStyle: TextStyle(color: UiToken.secondaryDark500),
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
    color: UiToken.primaryLight50,
    elevation: UiToken.elevationNone,
  ),
);

ThemeData get lightTheme => _lightTheme;
