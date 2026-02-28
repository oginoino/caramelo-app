import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/import/ui.dart';
import '../../util/const/ui/ui_token.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({
    required this.products,
    this.onViewAll,
    this.viewAllLabel = 'Ver tudo',
    super.key,
  });

  final List<Product> products;
  final VoidCallback? onViewAll;
  final String viewAllLabel;

  @override
  Widget build(BuildContext context) {
    const cardWidth = 160.0;
    final cardHeight = cardWidth / ProductCard.aspectRatio;

    return SizedBox(
      height: cardHeight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: onViewAll == null ? products.length : products.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isViewAllTile = onViewAll != null && index == products.length;
          if (isViewAllTile) {
            final isLight = Theme.of(context).brightness == Brightness.light;
            final bg = isLight
                ? UiToken.primaryLight50
                : UiToken.primaryDark900;
            final fg = Theme.of(context).colorScheme.onSurface;
            return SizedBox(
              width: cardWidth,
              child: Card(
                color: bg,
                child: InkWell(
                  borderRadius: BorderRadius.circular(UiToken.borderRadius12),
                  onTap: onViewAll,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          viewAllLabel,
                          style: TextStyle(
                            color: fg,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.chevron_right_rounded, color: fg),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            final product = products[index];
            return SizedBox(
              width: cardWidth,
              child: ProductCard(product: product),
            );
          }
        },
      ),
    );
  }
}
