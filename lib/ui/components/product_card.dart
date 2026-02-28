import '../../util/import/domain.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  static const double aspectRatio = 0.64;

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final quantity = cart.getQuantity(product.id);

        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        UiToken.borderRadius12,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.mainImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: UiToken.spacing4,
                      right: UiToken.spacing4,
                      child: _AddButton(product: product, cart: cart),
                    ),
                    if (quantity > 0)
                      Positioned(
                        top: UiToken.spacing4,
                        left: UiToken.spacing4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isLight
                                ? UiToken.primaryLight600
                                : UiToken.primaryLight500,
                            borderRadius: BorderRadius.circular(
                              UiToken.borderRadius12,
                            ),
                          ),
                          child: Text(
                            '$quantity',
                            style: TextStyle(
                              color: isLight
                                  ? UiToken.primaryLight50
                                  : UiToken.primaryDark800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.unit,
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 2),
                    SizedBox(
                      height: 13 * 1.2 * 2,
                      child: Text(
                        product.name,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      product.formattedPrice,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.product, required this.cart});

  final Product product;
  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final quantity = cart.getQuantity(product.id);
    final canAddMore = cart.canAdd(product.id);

    final VoidCallback? onAdd = canAddMore
        ? () => cart.addItem(product)
        : () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Só temos ${product.stock.available} unidades em estoque.',
                ),
              ),
            );
          };

    if (quantity == 0) {
      return IconButton(
        style: IconButton.styleFrom(
          backgroundColor: isLight
              ? UiToken.primaryLight600
              : UiToken.primaryLight500,
          foregroundColor: isLight
              ? UiToken.primaryLight50
              : UiToken.primaryDark800,
          shape: const CircleBorder(),
        ),
        onPressed: onAdd,
        icon: const Icon(Icons.add_rounded),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: isLight ? UiToken.primaryLight600 : UiToken.primaryLight500,
        borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
      ),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: isLight
                  ? UiToken.primaryLight50
                  : UiToken.primaryDark800,
            ),
            onPressed: () => cart.decreaseItem(product.id),
            icon: const Icon(Icons.remove_rounded),
          ),
          Text(
            '$quantity',
            style: TextStyle(
              color: isLight ? UiToken.primaryLight50 : UiToken.primaryDark800,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: isLight
                  ? UiToken.primaryLight50
                  : UiToken.primaryDark800,
            ),
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
