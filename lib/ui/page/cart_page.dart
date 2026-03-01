import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../components/cart_item_tile.dart';
import '../components/cart_min_order_warning.dart';
import '../components/cart_bottom_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 24),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(
          LocalizationService.strings.cartTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return const _EmptyCartView();
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: UiToken.spacing16,
                    vertical: UiToken.spacing16,
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _confirmClearCart(context, cart),
                        icon: const Icon(
                          Icons.remove_shopping_cart_outlined,
                          size: 18,
                        ),
                        label: Text(LocalizationService.strings.cartClear),
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.error,
                        ),
                      ),
                    ),
                    ...cart.items.values.map(
                      (item) => CartItemTile(item: item),
                    ),
                    SizedBox(height: UiToken.spacing16),
                    if (cart.totalPrice < CartProvider.minOrderValue)
                      Padding(
                        padding: EdgeInsets.only(
                          top: UiToken.spacing8,
                          bottom: UiToken.spacing16,
                        ),
                        child: CartMinOrderWarning(
                          currentTotal: cart.totalPrice,
                        ),
                      ),

                    if (cart.totalPrice < CartProvider.minOrderValue)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => context.go('/home'),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: Text(
                            LocalizationService.strings.cartAddMoreProducts,
                          ),
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: UiToken.spacing16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                UiToken.borderRadiusFull,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/home'),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: Text(
                            LocalizationService.strings.cartAddOtherProducts,
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: UiToken.spacing16,
                            ),
                            foregroundColor: theme.colorScheme.onSurface,
                            backgroundColor:
                                theme.colorScheme.surfaceContainerHighest,
                            side: BorderSide(
                              color: theme.colorScheme.outlineVariant,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                UiToken.borderRadiusFull,
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: UiToken.spacing24),
                  ],
                ),
              ),
              CartBottomBar(cart: cart),
            ],
          );
        },
      ),
    );
  }

  void _confirmClearCart(BuildContext context, CartProvider cart) {
    // Ideally show a dialog, but for now just clear
    cart.clear();
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 64,
            color: theme.disabledColor,
          ),
          SizedBox(height: UiToken.spacing16),
          Text(
            LocalizationService.strings.cartEmpty,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: UiToken.spacing32),
          SizedBox(
            width: 200,
            child: FilledButton.icon(
              onPressed: () => context.go('/home'),
              icon: const Icon(Icons.add_shopping_cart),
              label: Text(LocalizationService.strings.cartAddProducts),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: UiToken.spacing16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
