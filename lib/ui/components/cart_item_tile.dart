import 'package:intl/intl.dart';

import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/import/service.dart';
import '../../util/const/ui/ui_token.dart';
import 'cart_quantity_controller.dart';

final _currencyFormat = NumberFormat.currency(symbol: 'R\$');

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, super.key});

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
          SizedBox(width: UiToken.spacing12),
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
          CartQuantityController(item: item),
        ],
      ),
    );
  }
}
