import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../provider/cart_provider/cart_provider.dart';
import '../../util/import/service.dart';

final _currencyFormat = NumberFormat.currency(symbol: 'R\$');

class CartMinOrderWarning extends StatelessWidget {
  const CartMinOrderWarning({required this.currentTotal, super.key});

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
