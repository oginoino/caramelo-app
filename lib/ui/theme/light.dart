import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
  visualDensity: VisualDensity.standard,
  shadowColor: Colors.black.withValues(alpha: 0.12),
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
  iconTheme: IconThemeData(color: UiToken.primaryLight900),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize20,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: UiToken.elevationNone,
      backgroundColor: UiToken.primaryLightColor,
      foregroundColor: UiToken.primaryLight900,
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
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
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
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
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
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
  dialogTheme: DialogThemeData(
    elevation: UiToken.elevationNone,
    backgroundColor: UiToken.primaryLight50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius12),
    ),
    titleTextStyle: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize20,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: TextStyle(
      color: UiToken.primaryLight900,
      fontSize: UiToken.textSize16,
      fontWeight: FontWeight.w400,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: UiToken.secondaryLight800,
    contentTextStyle: TextStyle(
      color: UiToken.secondaryLight50,
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w600,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius8),
    ),
    elevation: UiToken.elevationNone,
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: UiToken.secondaryLight900,
      borderRadius: BorderRadius.circular(UiToken.borderRadius8),
    ),
    textStyle: TextStyle(
      color: UiToken.secondaryLight50,
      fontSize: UiToken.textSize12,
      fontWeight: FontWeight.w600,
    ),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: UiToken.primaryLight900,
    unselectedLabelColor: UiToken.secondaryLight600,
    labelStyle: TextStyle(
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w400,
    ),
    indicatorColor: UiToken.primaryLight600,
    dividerColor: UiToken.secondaryLight200,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: UiToken.primaryLight900,
    textColor: UiToken.primaryLight900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius12),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: UiToken.spacing16,
      vertical: UiToken.spacing8,
    ),
  ),
  dividerTheme: DividerThemeData(
    color: UiToken.secondaryLight200,
    thickness: 1,
    space: 1,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStatePropertyAll(UiToken.primaryLight600),
    checkColor: WidgetStatePropertyAll(UiToken.primaryLight50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius4),
    ),
    side: BorderSide(color: UiToken.secondaryLight400),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStatePropertyAll(UiToken.primaryLight600),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStatePropertyAll(UiToken.secondaryLight200),
    thumbColor: WidgetStatePropertyAll(UiToken.primaryLight600),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: UiToken.primaryLightColor,
    foregroundColor: UiToken.primaryLight900,
    elevation: UiToken.elevationNone,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius16),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: UiToken.primaryLight600,
    linearTrackColor: UiToken.secondaryLight200,
    circularTrackColor: UiToken.secondaryLight200,
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
