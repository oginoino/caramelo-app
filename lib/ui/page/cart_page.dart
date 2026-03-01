import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../util/import/domain.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/ui_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationService.strings.cartTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _confirmClearCart(context, cart),
                        icon: const Icon(Icons.remove_shopping_cart_outlined, size: 18),
                        label: Text(LocalizationService.strings.cartClear),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    ...cart.items.values.map((item) => _CartItemTile(item: item)),
                    const SizedBox(height: 16),
                    if (cart.totalPrice < CartProvider.minOrderValue)
                       Padding(
                         padding: const EdgeInsets.only(bottom: 16),
                         child: _MinOrderWarning(currentTotal: cart.totalPrice),
                       ),
                    
                    if (cart.totalPrice < CartProvider.minOrderValue)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => context.go('/'),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: Text(LocalizationService.strings.cartAddMoreProducts),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/'),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: Text(LocalizationService.strings.cartAddOtherProducts),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            LocalizationService.strings.cartEmpty,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 200,
            child: FilledButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.add_shopping_cart),
              label: Text(LocalizationService.strings.cartAddProducts),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
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
    final currencyFormat = NumberFormat.currency(symbol: 'R\$');
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationService.strings.cartItemUnit(
                    item.quantity,
                    currencyFormat.format(item.product.price.current),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currencyFormat.format(item.total),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
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
              color: item.quantity == 1 ? colorScheme.error : colorScheme.primary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          IconButton(
            onPressed: () => cart.addItem(item.product),
            icon: Icon(
              Icons.add,
              size: 18,
              color: colorScheme.primary,
            ),
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
    final currencyFormat = NumberFormat.currency(symbol: 'R\$');
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(UiToken.borderRadius8),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              LocalizationService.strings.cartMinOrderWarning(
                currencyFormat.format(remaining),
              ),
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 12,
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
    final currencyFormat = NumberFormat.currency(symbol: 'R\$');
    final canOrder = cart.totalPrice >= CartProvider.minOrderValue && cart.itemCount > 0;
    
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
                Text(
                  currencyFormat.format(cart.totalPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: canOrder ? () {
                // TODO: Implement checkout
                UiHelper.showSnackBar(
                  context,
                  message: 'Checkout not implemented yet',
                  backgroundColor: Colors.orange,
                );
              } : null,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(
                canOrder
                    ? LocalizationService.strings.cartOrderNow
                    : LocalizationService.strings.cartMinOrder(
                        currencyFormat.format(CartProvider.minOrderValue),
                      ),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
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
