import '../../util/import/packages.dart';
import '../../util/import/route.dart';

class HandleRedirect {
  String? get initialDeppLink => _initialDeepLink;
  String? _initialDeepLink;

  static final Set<String> publicRoutes = {Routes.home};

  static final Set<String> protectedRoutes = {
    // TODO: Adicionar rotas protegidas
  };

  bool isProtectedRoute(String route) => protectedRoutes.contains(route);

  String? handleRedirect(BuildContext context, GoRouterState state) {
    _initialDeepLink = state.uri.toString();
    final path = state.uri.path;

    return null;
  }
}
