import '../../util/import/packages.dart';
import '../../util/import/route.dart';
import '../../util/import/ui.dart';
import '../../util/import/domain.dart';

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
        AppRoute(
          Routes.cart,
          (context, state) => const CartPage(),
          padding: EdgeInsets.zero,
          hasScrollBody: true,
        ),
        AppRoute(
          Routes.productDetails,
          (context, state) {
            final product = state.extra as Product;
            return ProductDetailsPage(product: product);
          },
          padding: EdgeInsets.zero,
          hasScrollBody: true,
        ),
      ],
    ),
  ],
);
