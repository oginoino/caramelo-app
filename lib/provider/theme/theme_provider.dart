import '../../util/import/packages.dart';
import '../../util/import/service.dart';
import '../../ui/theme/light.dart';
import '../../ui/theme/dark.dart';

ThemeData _lightTheme = lightTheme;
ThemeData _darkTheme = darkTheme;

ThemeData buildLightTheme() {
  return _lightTheme;
}

ThemeData buildDarkTheme() {
  return _darkTheme;
}

class ThemeProvider extends ChangeNotifier {
  final PersistenceService _persistenceService;

  ThemeProvider(this._persistenceService) {
    _loadThemeSettings();
  }

  bool _isDarkMode = false;
  ThemeData _currentTheme = buildLightTheme();

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void _loadThemeSettings() {
    _isDarkMode = _persistenceService.getIsDarkMode() ?? false;
    _applyTheme();
  }

  void _applyTheme() {
    _currentTheme = _isDarkMode ? buildDarkTheme() : buildLightTheme();
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

  void setCustomTheme(ThemeData theme) {
    _currentTheme = theme;
    _applyTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _persistenceService.setIsDarkMode(_isDarkMode);
    _applyTheme();
  }
}
