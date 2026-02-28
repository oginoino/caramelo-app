import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/import/ui.dart';
import '../../util/import/service.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({
    required this.products,
    this.onViewAll,
    this.viewAllLabel,
    super.key,
  });

  final List<Product> products;
  final VoidCallback? onViewAll;
  final String? viewAllLabel;

  @override
  Widget build(BuildContext context) {
    const cardWidth = 160.0;
    final cardHeight = cardWidth / ProductCard.aspectRatio;

    return InkWell(
      onTap: onViewAll,
      child: SizedBox(
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
              if (isLight) {
              } else {}
              final fg = Theme.of(context).colorScheme.onSurface;
              final label =
                  viewAllLabel ?? LocalizationService.strings.viewAllCategories;
              return SizedBox(
                width: cardWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 6),
                    Center(
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          label,
                          style: TextStyle(
                            color: fg,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right_rounded, color: fg),
                      onPressed: onViewAll,
                    ),
                  ],
                ),
              );
            } else {
              final product = products[index];
              return SizedBox(
                width: cardWidth,
                child: ProductCard(product: product)
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: 0.2, end: 0, duration: 300.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 300.ms,
                    )
                    .move(delay: (index * 100).ms),
              );
            }
          },
        ),
      ),
    );
  }
}
