import 'package:go_router/go_router.dart';
import '../../../app/pages/home_page.dart';

class RouterConfig {
  static final GoRouter router = GoRouter(
    routes: [GoRoute(path: '/', builder: (context, state) => const HomePage())],
  );
}

final GoRouter appRouter = RouterConfig.router;
