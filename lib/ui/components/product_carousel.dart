import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/import/ui.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({required this.products, super.key});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(width: 160, child: ProductCard(product: product));
        },
      ),
    );
  }
}
