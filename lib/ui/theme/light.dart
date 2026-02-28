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
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: IconThemeData(color: UiToken.primaryLight900),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: UiToken.elevationNone,
      backgroundColor: UiToken.primaryLightColor,
      foregroundColor: UiToken.primaryLight900,
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: UiToken.secondaryLight100,
      foregroundColor: UiToken.secondaryLight900,
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight900,
      side: BorderSide(color: UiToken.secondaryLight400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: UiToken.secondaryLight50,
      foregroundColor: UiToken.secondaryLight900,
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: UiToken.secondaryLight50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryLight400),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.secondaryLight400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      borderSide: BorderSide(color: UiToken.primaryLight600),
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
    hintStyle: TextStyle(color: UiToken.secondaryLight600),
    labelStyle: TextStyle(color: UiToken.secondaryLight700),
    suffixIconColor: UiToken.secondaryLight600,
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
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: UiToken.primaryLight50,
    surfaceTintColor: UiToken.primaryLight50,
    elevation: UiToken.elevationNone,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(UiToken.borderRadius16),
        topRight: Radius.circular(UiToken.borderRadius16),
      ),
    ),
    dragHandleColor: UiToken.secondaryLight600,
  ),
);

ThemeData get lightTheme => _lightTheme;
