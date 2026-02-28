// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación Caramelo';

  @override
  String get welcomeMessage => '¡Bienvenido a Caramelo!';

  @override
  String get toggleTheme => 'Alternar Tema';

  @override
  String get search => 'Buscar';

  @override
  String get home => 'Inicio';

  @override
  String get newLocationTitle => 'Nueva ubicación';

  @override
  String get newLocationHint => 'Ej.: Casa de mamá';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get addLocation => 'Agregar ubicación...';

  @override
  String get language => 'Idioma';
}
