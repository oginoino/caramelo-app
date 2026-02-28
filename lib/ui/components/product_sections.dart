import '../../util/import/packages.dart';
import '../../provider/product_provider/product_provider.dart';
import '../../util/import/domain.dart';
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
          if (products.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }
          return _ProductGrid(products: products);
        }

        final sections = <Widget>[];
        for (final category in categories) {
          final categoryProducts = products
              .where((p) => p.categories.contains(category))
              .toList();
          if (categoryProducts.isEmpty) continue;

          sections.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    category[0].toUpperCase() + category.substring(1),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ProductCarousel(products: categoryProducts),
                const SizedBox(height: 24),
              ],
            ),
          );
        }

        return Column(children: sections);
      },
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = (width / 190).floor().clamp(2, 4);

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        );
      },
    );
  }
}
