import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../import/ui.dart';
import '../../import/route.dart';

class RouterConfig {
  static final GoRouter router = GoRouter(
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
          AppRoute(
            Routes.cart,
            (context, state) => const CartPage(),
            padding: EdgeInsets.zero,
            hasScrollBody: true,
          ),
        ],
      ),
    ],
  );
}

final GoRouter appRouter = RouterConfig.router;
