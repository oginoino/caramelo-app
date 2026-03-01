// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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

  @override
  String get newLocationTitle => 'Nova localização';

  @override
  String get newLocationHint => 'Ex.: Casa da mãe';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get addLocation => 'Adicionar localização...';

  @override
  String get language => 'Idioma';

  @override
  String get noProductsFound => 'Nenhum produto encontrado.';

  @override
  String get viewAllCategories => 'Ver todas as categorias';

  @override
  String get categoryAll => 'Tudo';

  @override
  String get categoryDeals => 'Promoções';

  @override
  String get addLocationTooltip => 'Adicionar nova localização';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get selectLocation => 'Selecionar localização';

  @override
  String get errorLoadingProducts =>
      'Falha ao carregar produtos. Tente novamente mais tarde.';

  @override
  String get loadingProducts => 'Carregando produtos...';

  @override
  String get errorLoadingLocations =>
      'Falha ao carregar localizações. Tente novamente mais tarde.';

  @override
  String get stockLimitReached => 'Limite de estoque atingido.';

  @override
  String get close => 'Fechar';

  @override
  String get cartTitle => 'Seu carrinho';

  @override
  String get cartEmpty => 'Seu carrinho está vazio';

  @override
  String get cartClear => 'Limpar carrinho';

  @override
  String get cartAddProducts => 'Adicionar produtos';

  @override
  String get cartAddMoreProducts => 'Adicionar mais produtos';

  @override
  String get cartAddOtherProducts => 'Adicionar outros produtos';

  @override
  String cartMinOrder(String value) {
    return 'Pedido min. $value';
  }

  @override
  String cartMinOrderWarning(String value) {
    return 'Adicione mais $value para atingir o valor mínimo.';
  }

  @override
  String get cartTotal => 'Total';

  @override
  String get cartOrderNow => 'Pedir agora';

  @override
  String cartItemUnit(int quantity, String price) {
    return '$quantity unidade(s) por $price';
  }

  @override
  String get authSuccessRegistration => 'Cadastro realizado com sucesso!';

  @override
  String get actionClear => 'Limpar';

  @override
  String get passwordResetEmailSent => 'Email de recuperação enviado!';

  @override
  String get passwordChangedSuccess => 'Senha alterada com sucesso!';

  @override
  String get errorInvalidCredentials => 'Email ou senha inválidos';

  @override
  String get errorNetworkOffline => 'Sem conexão com internet';

  @override
  String get errorTimeout => 'A requisição demorou muito tempo';

  @override
  String get errorAuthenticationGeneric => 'Erro de autenticação';

  @override
  String get errorRegistrationConflictEmail => 'Email já cadastrado';

  @override
  String get errorEmailNotFound => 'Email não encontrado';

  @override
  String get errorUnexpected => 'Erro inesperado';

  @override
  String get errorResetPasswordGeneric => 'Erro ao redefinir senha';

  @override
  String goToCart(int count) {
    return 'Ir para o carrinho ($count)';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
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

  @override
  String get newLocationTitle => 'Nova localização';

  @override
  String get newLocationHint => 'Ex.: Casa da mãe';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get addLocation => 'Adicionar localização...';

  @override
  String get language => 'Idioma';

  @override
  String get noProductsFound => 'Nenhum produto encontrado.';

  @override
  String get viewAllCategories => 'Ver todas as categorias';

  @override
  String get categoryAll => 'Tudo';

  @override
  String get categoryDeals => 'Promoções';

  @override
  String get addLocationTooltip => 'Adicionar nova localização';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get selectLocation => 'Selecionar localização';

  @override
  String get errorLoadingProducts =>
      'Falha ao carregar produtos. Tente novamente mais tarde.';

  @override
  String get loadingProducts => 'Carregando produtos...';

  @override
  String get errorLoadingLocations =>
      'Falha ao carregar localizações. Tente novamente mais tarde.';

  @override
  String get stockLimitReached => 'Limite de estoque atingido.';

  @override
  String get close => 'Fechar';

  @override
  String get cartTitle => 'Seu carrinho';

  @override
  String get cartEmpty => 'Seu carrinho está vazio';

  @override
  String get cartClear => 'Limpar carrinho';

  @override
  String get cartAddProducts => 'Adicionar produtos';

  @override
  String get cartAddMoreProducts => 'Adicionar mais produtos';

  @override
  String get cartAddOtherProducts => 'Adicionar outros produtos';

  @override
  String cartMinOrder(String value) {
    return 'Pedido min. $value';
  }

  @override
  String cartMinOrderWarning(String value) {
    return 'Adicione mais $value para atingir o valor mínimo.';
  }

  @override
  String get cartTotal => 'Total';

  @override
  String get cartOrderNow => 'Pedir agora';

  @override
  String cartItemUnit(int quantity, String price) {
    return '$quantity unidade(s) por $price';
  }

  @override
  String get authSuccessRegistration => 'Cadastro realizado com sucesso!';

  @override
  String get actionClear => 'Limpar';

  @override
  String get passwordResetEmailSent => 'Email de recuperação enviado!';

  @override
  String get passwordChangedSuccess => 'Senha alterada com sucesso!';

  @override
  String get errorInvalidCredentials => 'Email ou senha inválidos';

  @override
  String get errorNetworkOffline => 'Sem conexão com internet';

  @override
  String get errorTimeout => 'A requisição demorou muito tempo';

  @override
  String get errorAuthenticationGeneric => 'Erro de autenticação';

  @override
  String get errorRegistrationConflictEmail => 'Email já cadastrado';

  @override
  String get errorEmailNotFound => 'Email não encontrado';

  @override
  String get errorUnexpected => 'Erro inesperado';

  @override
  String get errorResetPasswordGeneric => 'Erro ao redefinir senha';

  @override
  String goToCart(int count) {
    return 'Ir para o carrinho ($count)';
  }
}
