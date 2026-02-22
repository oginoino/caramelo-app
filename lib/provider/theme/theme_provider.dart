import '../../util/import/packages.dart';
import '../../util/import/service.dart';
import '../../util/const/ui/ui_token.dart';

ThemeData buildLightTheme({required Color accentColor}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: accentColor,
    brightness: Brightness.light,
  );
  final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);
  final textTheme = GoogleFonts.interTextTheme(base.textTheme);
  return base.copyWith(
    textTheme: textTheme,
    extensions: const <ThemeExtension<dynamic>>[UiToken()],
  );
}

ThemeData buildDarkTheme({required Color accentColor}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: accentColor,
    brightness: Brightness.dark,
  );
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: Brightness.dark,
  );
  final textTheme = GoogleFonts.interTextTheme(base.textTheme);
  return base.copyWith(
    textTheme: textTheme,
    extensions: const <ThemeExtension<dynamic>>[UiToken()],
  );
}

class ThemeProvider extends ChangeNotifier {
  final PersistenceService _persistenceService;

  ThemeProvider(this._persistenceService) {
    _loadThemeSettings();
  }

  static const Color _defaultAccentColor = Color(0xFF58E700);
  Color _accentColor = _defaultAccentColor;
  bool _isDarkMode = false;
  ThemeData _currentTheme = buildLightTheme(accentColor: _defaultAccentColor);

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;
  Color get accentColor => _accentColor;

  void _loadThemeSettings() {
    _isDarkMode = _persistenceService.getIsDarkMode() ?? false;
    final accentColorValue =
        _persistenceService.getAccentColor() ?? _defaultAccentColor.toARGB32();
    _accentColor = Color(accentColorValue);
    _applyTheme();
  }

  void _applyTheme() {
    _currentTheme = _isDarkMode
        ? buildDarkTheme(accentColor: _accentColor)
        : buildLightTheme(accentColor: _accentColor);
    notifyListeners();
  }

  void toggleLightTheme() {
    _isDarkMode = !_isDarkMode;
    _persistenceService.setIsDarkMode(_isDarkMode);
    _applyTheme();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    _persistenceService.setIsDarkMode(_isDarkMode);
    _applyTheme();
  }

  void setAccentColor(Color color) {
    _accentColor = color;
    _persistenceService.setAccentColor(_accentColor.toARGB32());
    _applyTheme();
  }

  void setCustomTheme(ThemeData theme) {
    _currentTheme = theme;
    _applyTheme();
  }
}
