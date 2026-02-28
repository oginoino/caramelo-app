import '../../util/import/domain.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(UiToken.borderRadius12),
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
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: isLight
                          ? UiToken.primaryLight600
                          : UiToken.primaryLight500,
                      foregroundColor: isLight
                          ? UiToken.primaryLight50
                          : UiToken.primaryDark800,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UiToken.spacing4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.unit,
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                Text(
                  product.name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
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
  }
}
