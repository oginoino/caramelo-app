import '../../util/import/packages.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/import/ui.dart';

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
          return FloatingActionButton.extended(
            onPressed: () {
              // TODO: navegar para a tela do carrinho
            },
            label: Text('Ir para o carrinho (${cart.itemCount})'),
            icon: const Icon(Icons.shopping_cart_rounded),
          );
        },
      ),
    );
  }
}
