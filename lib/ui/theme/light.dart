import '../../util/import/packages.dart';

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  useMaterial3: true,
);

ThemeData get lightTheme => _lightTheme;
