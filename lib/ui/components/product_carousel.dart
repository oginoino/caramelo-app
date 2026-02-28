import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/import/ui.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({required this.products, super.key});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    const cardWidth = 160.0;
    final cardHeight = cardWidth / ProductCard.aspectRatio;

    return SizedBox(
      height: cardHeight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: cardWidth,
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }
}
