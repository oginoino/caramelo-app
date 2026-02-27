import '../util/import/service.dart';

class AppLocalizationsPtBR extends AppLocalizations {
  AppLocalizationsPtBR([super.locale = 'pt-BR']);

  @override
  String get appTitle => 'Aplicativo Caramelo';

  @override
  String get welcomeMessage => 'Bem-vindo ao Caramelo!';

  @override
  String get toggleTheme => 'Alternar Tema';

  @override
  String get search => 'Buscar';

  @override
  String get home => 'Início';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPtBR {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Aplicativo Caramelo';

  @override
  String get welcomeMessage => 'Bem-vindo ao Caramelo!';

  @override
  String get toggleTheme => 'Alternar Tema';

  @override
  String get search => 'Buscar';

  @override
  String get home => 'Início';
}
