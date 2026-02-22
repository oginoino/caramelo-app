import '../../util/import/packages.dart';
import '../../util/import/route.dart';
import '../../util/import/ui.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.home,
  redirect: HandleRedirect().handleRedirect,
  routes: [
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        AppRoute(
          Routes.home,
          (context, state) => const Home(),
          padding: EdgeInsets.zero,
          hasScrollBody: true,
        ),
      ],
    ),
  ],
);
