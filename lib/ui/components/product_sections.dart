import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../provider/product_provider/product_provider.dart';
import '../../util/import/domain.dart';
import '../../util/import/ui.dart';
import '../../util/import/service.dart';

class ProductSections extends StatefulWidget {
  const ProductSections({super.key});

  @override
  State<ProductSections> createState() => _ProductSectionsState();
}

class _ProductSectionsState extends State<ProductSections> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Carregando produtos...'),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms);
        }

        final errorMessage = provider.errorMessage;
        if (errorMessage != null) {
          return Center(
            child: Text(LocalizationService.strings.errorLoadingProducts),
          );
        }

        final products = provider.filteredProducts;
        final categories = provider.availableCategories;
        final selectedCategory = provider.selectedCategoryId;

        if (selectedCategory != 'all' && selectedCategory != 'deals') {
          if (products.isEmpty) {
            return Center(
              child: Text(LocalizationService.strings.noProductsFound),
            );
          }
          return _ProductGrid(products: products);
        }

        final Iterable<String> categoriesToShow = categories;

        final sections = <Widget>[];
        int sectionIndex = 0;
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
                      child:
                          Text(
                                category[0].toUpperCase() +
                                    category.substring(1),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .slideX(begin: -0.2, end: 0, duration: 400.ms)
                              .move(delay: (sectionIndex * 200).ms),
                    ),
                    const SizedBox(height: 16),
                    ProductCarousel(
                      products: categoryProducts,
                      onViewAll: () => provider.selectCategory(category),
                      viewAllLabel:
                          LocalizationService.strings.viewAllCategories,
                    ),
                    const SizedBox(height: 24),
                  ],
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .move(delay: (sectionIndex * 300).ms),
          );
          sectionIndex++;
        }

        return Column(children: sections)
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.1, end: 0, duration: 600.ms);
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
              padding: EdgeInsets.zero,
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
                          Icon(Icons.arrow_back_ios_new_rounded, size: 24),
                          SizedBox(width: UiToken.spacing8),
                          Text(
                            LocalizationService.strings.categoryAll,
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
                return ProductCard(product: product)
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.2, end: 0, duration: 300.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 300.ms,
                    )
                    .move(delay: (index * 50).ms);
              },
            ),
          ],
        );
      },
    );
  }
}
