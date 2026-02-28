import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../provider/product_provider/product_provider.dart';
import '../../util/import/domain.dart';
import '../../util/import/ui.dart';

class ProductSections extends StatefulWidget {
  const ProductSections({super.key});

  @override
  State<ProductSections> createState() => _ProductSectionsState();
}

class _ProductSectionsState extends State<ProductSections> {
  bool _showAllCategories = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final errorMessage = provider.errorMessage;
        if (errorMessage != null) {
          return Center(child: Text(errorMessage));
        }

        final products = provider.filteredProducts;
        final categories = provider.availableCategories;
        final selectedCategory = provider.selectedCategoryId;
        final searchQuery = provider.searchQuery;

        if (selectedCategory != 'all' && selectedCategory != 'deals') {
          if (products.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }
          return _ProductGrid(products: products);
        }

        const maxPreviewCategories = 3;
        final usePreview =
            selectedCategory == 'all' &&
            searchQuery.isEmpty &&
            !_showAllCategories &&
            categories.length > maxPreviewCategories;

        final Iterable<String> categoriesToShow = usePreview
            ? categories.take(maxPreviewCategories)
            : categories;

        final sections = <Widget>[];
        for (final category in categoriesToShow) {
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
                ProductCarousel(
                  products: categoryProducts,
                  onViewAll: () => provider.selectCategory(category),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }

        if (usePreview) {
          sections.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showAllCategories = true;
                    });
                  },
                  child: const Text('Ver todas as categorias'),
                ),
              ),
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UiToken.spacing16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      UiToken.borderRadiusFull,
                    ),
                    onTap: () => Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).selectCategory('all'),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UiToken.spacing16,
                        vertical: UiToken.spacing12,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded),
                          SizedBox(width: UiToken.spacing8),
                          Text(
                            'Tudo',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: UiToken.spacing16),

            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: ProductCard.aspectRatio,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ],
        );
      },
    );
  }
}
