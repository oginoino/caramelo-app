import '../../util/import/packages.dart';
import '../../provider/product_provider/product_provider.dart';
import '../../util/import/ui.dart';

class ProductSections extends StatelessWidget {
  const ProductSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        final products = provider.filteredProducts;
        final categories = provider.availableCategories;
        final selectedCategory = provider.selectedCategoryId;

        if (selectedCategory != 'all' && selectedCategory != 'deals') {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProductCarousel(products: products),
          );
        }

        final sections = <Widget>[];
        for (final category in categories) {
          final categoryProducts = products
              .where((p) => p.categories.contains(category))
              .toList();
          if (categoryProducts.isEmpty) continue;

          sections.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category[0].toUpperCase() + category.substring(1),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProductCarousel(products: categoryProducts),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        }

        return Column(children: sections);
      },
    );
  }
}
