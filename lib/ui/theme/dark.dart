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
      color: UiToken.primaryDark50,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: IconThemeData(color: UiToken.primaryDark50),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: UiToken.elevationNone,
      backgroundColor: UiToken.primaryDarkColor,
      foregroundColor: UiToken.primaryDark50,
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
      backgroundColor: UiToken.secondaryDark400,
      foregroundColor: UiToken.secondaryLight300,
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight300,
      side: BorderSide(color: UiToken.secondaryLight500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: UiToken.secondaryDark50,
      foregroundColor: UiToken.secondaryLight300,
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: UiToken.secondaryDark400,
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
      borderSide: BorderSide(color: UiToken.primaryLight400),
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
    hintStyle: TextStyle(color: UiToken.secondaryLight400),
    labelStyle: TextStyle(color: UiToken.secondaryLight300),
    suffixIconColor: UiToken.secondaryLight400,
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
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: UiToken.primaryDark900,
    surfaceTintColor: UiToken.primaryDark900,
    elevation: UiToken.elevationNone,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(UiToken.borderRadius16),
        topRight: Radius.circular(UiToken.borderRadius16),
      ),
    ),
    dragHandleColor: UiToken.secondaryLight400,
  ),
);

ThemeData get darkTheme => _darkTheme;
