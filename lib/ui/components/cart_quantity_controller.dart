import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/domain.dart';

class CartQuantityController extends StatelessWidget {
  const CartQuantityController({required this.item, super.key});

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
