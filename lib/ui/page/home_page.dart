import '../../util/import/packages.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/import/ui.dart';
import '../../util/const/ui/ui_token.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            expandedHeight: 280,
            title: LocalizationService.strings.home,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const HomeMessageCarouselSection(),
                Search(),
                const SizedBox(height: 12),
                const CategoryChips(),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: ProductSections()),
        ],
      ),
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return const SizedBox.shrink();
          }
          final isLight = Theme.of(context).brightness == Brightness.light;
          return FloatingActionButton.extended(
            onPressed: () {
              context.go('/cart');
            },
            label: Text(
              LocalizationService.strings.goToCart(cart.itemCount),
              style: TextStyle(
                color: isLight
                    ? Theme.of(context).colorScheme.onPrimary
                    : UiToken.primaryDark800,
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: isLight
                  ? Theme.of(context).colorScheme.onPrimary
                  : UiToken.primaryDark800,
            ),
            backgroundColor: isLight
                ? Theme.of(context).colorScheme.primary
                : UiToken.primaryLight500,
            elevation: UiToken.elevationNone,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UiToken.borderRadius16),
            ),
          );
        },
      ),
    );
  }
}
