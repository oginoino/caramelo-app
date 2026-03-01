import 'package:intl/intl.dart';

import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/ui_helper.dart';

final _currencyFormat = NumberFormat.currency(symbol: 'R\$');

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
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
                          foregroundColor: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    ...cart.items.values.map(
                      (item) => _CartItemTile(item: item),
                    ),
                    SizedBox(height: UiToken.spacing16),
                    if (cart.totalPrice < CartProvider.minOrderValue)
                      Padding(
                        padding: EdgeInsets.only(
                          top: UiToken.spacing8,
                          bottom: UiToken.spacing16,
                        ),
                        child: _MinOrderWarning(currentTotal: cart.totalPrice),
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
                            side: BorderSide(color: theme.colorScheme.primary),
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
              _CartBottomBar(cart: cart),
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

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: UiToken.spacing12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(UiToken.borderRadius8),
            child: CachedNetworkImage(
              imageUrl: item.product.mainImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: UiToken.spacing4),
                Text(
                  LocalizationService.strings.cartItemUnit(
                    item.quantity,
                    _currencyFormat.format(item.product.price.current),
                  ),
                  style: TextStyle(
                    color: textTheme.bodySmall?.color,
                    fontSize: UiToken.textSize12,
                  ),
                ),
                SizedBox(height: UiToken.spacing4),
                Text(
                  _currencyFormat.format(item.total),
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: UiToken.spacing12),
          _CartQuantityController(item: item),
        ],
      ),
    );
  }
}

class _CartQuantityController extends StatelessWidget {
  const _CartQuantityController({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => cart.decreaseItem(item.product.id),
            icon: Icon(
              item.quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 18,
              color: item.quantity == 1
                  ? colorScheme.error
                  : colorScheme.primary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          IconButton(
            onPressed: () => cart.addItem(item.product),
            icon: Icon(Icons.add, size: 18, color: colorScheme.primary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

class _MinOrderWarning extends StatelessWidget {
  const _MinOrderWarning({required this.currentTotal});

  final double currentTotal;

  @override
  Widget build(BuildContext context) {
    final remaining = CartProvider.minOrderValue - currentTotal;
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final bgColor = isLight ? UiToken.alertLight100 : UiToken.alertLight900;
    final iconColor = isLight ? UiToken.alertLight600 : UiToken.alertLight200;

    return Container(
      padding: EdgeInsets.all(UiToken.spacing12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: iconColor),
          SizedBox(width: UiToken.spacing12),
          Expanded(
            child: Text(
              LocalizationService.strings.cartMinOrderWarning(
                _currencyFormat.format(remaining),
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                color: iconColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartBottomBar extends StatelessWidget {
  const _CartBottomBar({required this.cart});

  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final canOrder =
        cart.totalPrice >= CartProvider.minOrderValue && cart.itemCount > 0;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(UiToken.spacing16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizationService.strings.cartTotal,
                  style: TextStyle(
                    color: textTheme.bodySmall?.color,
                    fontSize: UiToken.textSize12,
                  ),
                ),
                Text(
                  _currencyFormat.format(cart.totalPrice),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: canOrder
                  ? () {
                      UiHelper.showSnackBar(
                        context,
                        message: 'Checkout not implemented yet',
                        backgroundColor: UiToken.alertLight500,
                      );
                    }
                  : null,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(
                canOrder
                    ? LocalizationService.strings.cartOrderNow
                    : LocalizationService.strings.cartMinOrder(
                        _currencyFormat.format(CartProvider.minOrderValue),
                      ),
              ),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: UiToken.spacing24,
                  vertical: UiToken.spacing12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
