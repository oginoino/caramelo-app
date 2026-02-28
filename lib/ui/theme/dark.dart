import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: GoogleFonts.nunito().fontFamily,
  visualDensity: VisualDensity.standard,
  shadowColor: Colors.black.withValues(alpha: 0.24),
  colorScheme: ColorScheme.dark(
    primary: UiToken.primaryDarkColor,
    secondary: UiToken.secondaryDark500,
    surface: UiToken.primaryDark900,
    error: UiToken.errorLight500,
    onPrimary: UiToken.primaryLight50,
    onSecondary: UiToken.secondaryLight200,
    onSurface: UiToken.secondaryLight200,
    onError: UiToken.primaryLight50,
  ),
  appBarTheme: AppBarTheme(
    elevation: UiToken.elevationNone,
    centerTitle: true,
    backgroundColor: UiToken.primaryDarkColor,
    titleTextStyle: TextStyle(
      color: UiToken.secondaryLight200,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: IconThemeData(color: UiToken.secondaryLight200),
  ),
  iconTheme: IconThemeData(color: UiToken.secondaryLight200),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: UiToken.secondaryLight200,
      fontSize: UiToken.textSize24,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: UiToken.secondaryLight200,
      fontSize: UiToken.textSize20,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: UiToken.secondaryLight200,
      fontSize: UiToken.textSize16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: UiToken.secondaryLight200,
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      color: UiToken.secondaryLight200,
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: UiToken.elevationNone,
      backgroundColor: UiToken.primaryDarkColor,
      foregroundColor: UiToken.secondaryLight200,
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: UiToken.secondaryDark400,
      foregroundColor: UiToken.secondaryLight300,
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w600,
      ),
      iconColor: UiToken.secondaryLight300,
      side: BorderSide(color: UiToken.secondaryLight500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: UiToken.secondaryDark50,
      foregroundColor: UiToken.secondaryLight300,
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
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
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: UiToken.primaryDark50,
      foregroundColor: UiToken.primaryDark900,
      padding: EdgeInsets.symmetric(
        horizontal: UiToken.spacing16,
        vertical: UiToken.spacing12,
      ),
      textStyle: TextStyle(
        fontSize: UiToken.textSize16,
        fontWeight: FontWeight.w700,
      ),
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
    color: UiToken.secondaryDark400,
    surfaceTintColor: UiToken.secondaryDark400,
    elevation: UiToken.elevationNone,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius12),
      side: BorderSide(color: UiToken.secondaryDark600),
    ),
    clipBehavior: Clip.antiAlias,
  ),
  dialogTheme: DialogThemeData(
    elevation: UiToken.elevationNone,
    backgroundColor: UiToken.primaryDark900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius12),
    ),
    titleTextStyle: TextStyle(
      color: UiToken.primaryDark50,
      fontSize: UiToken.textSize20,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: TextStyle(
      color: UiToken.primaryDark50,
      fontSize: UiToken.textSize16,
      fontWeight: FontWeight.w400,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: UiToken.secondaryDark800,
    contentTextStyle: TextStyle(
      color: UiToken.secondaryLight300,
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
      color: UiToken.primaryLight100,
      borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    textStyle: TextStyle(
      color: UiToken.primaryDark900,
      fontSize: UiToken.textSize12,
      fontWeight: FontWeight.w600,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: UiToken.spacing12,
      vertical: UiToken.spacing8,
    ),
    waitDuration: const Duration(milliseconds: 500),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: UiToken.primaryDark50,
    unselectedLabelColor: UiToken.secondaryLight400,
    labelStyle: TextStyle(
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: UiToken.textSize14,
      fontWeight: FontWeight.w400,
    ),
    indicatorColor: UiToken.primaryDark50,
    dividerColor: UiToken.secondaryDark500,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: UiToken.secondaryLight200,
    textColor: UiToken.secondaryLight200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius12),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: UiToken.spacing16,
      vertical: UiToken.spacing8,
    ),
  ),
  dividerTheme: DividerThemeData(
    color: UiToken.secondaryDark600,
    thickness: 1,
    space: 1,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStatePropertyAll(UiToken.primaryDark50),
    checkColor: WidgetStatePropertyAll(UiToken.primaryDark900),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius4),
    ),
    side: BorderSide(color: UiToken.secondaryDark600),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStatePropertyAll(UiToken.primaryDark50),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return UiToken.secondaryDark600.withValues(alpha: 0.6);
      }
      if (states.contains(WidgetState.selected)) {
        return UiToken.primaryDark50.withValues(alpha: 0.6);
      }
      return UiToken.secondaryDark600;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return UiToken.secondaryDark500;
      }
      if (states.contains(WidgetState.selected)) {
        return UiToken.primaryDark50;
      }
      return UiToken.secondaryLight200;
    }),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: UiToken.primaryDarkColor,
    foregroundColor: UiToken.primaryDark50,
    elevation: UiToken.elevationNone,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(UiToken.borderRadius16),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: UiToken.primaryDark50,
    linearTrackColor: UiToken.secondaryDark600,
    circularTrackColor: UiToken.secondaryDark600,
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
