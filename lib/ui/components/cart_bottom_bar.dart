import 'package:intl/intl.dart';

import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/ui_helper.dart';

final _currencyFormat = NumberFormat.currency(symbol: 'R\$');

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({required this.cart, super.key});

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
              color: Colors.black.withAlpha((255 * 0.05).round()),
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
                    color: colorScheme.onSurfaceVariant,
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
                foregroundColor: colorScheme.onPrimary,
                backgroundColor: colorScheme.primary,
                disabledForegroundColor: colorScheme.onSurface.withAlpha(
                  (255 * 0.38).round(),
                ),
                disabledBackgroundColor: colorScheme.onSurface.withAlpha(
                  (255 * 0.12).round(),
                ),
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
