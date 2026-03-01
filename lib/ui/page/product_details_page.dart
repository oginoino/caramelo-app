import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/ui.dart';
import '../../util/ui_helper.dart';
import '../components/custom_image.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 24),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            tooltip: MaterialLocalizations.of(context).shareButtonLabel,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border_rounded),
          ),
          SizedBox(width: UiToken.spacing8),
        ],
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.15,
                    child: CustomImage(
                      imageUrl: product.mainImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: BorderRadius.circular(
                        UiToken.borderRadius16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UiToken.spacing16,
                      vertical: UiToken.spacing16,
                    ),
                    child: _ProductDetailsContent(product: product),
                  ),
                ],
              ),
            ),
          ),
          _ProductDetailsBottomBar(product: product),
        ],
      ),
    );
  }
}

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: UiToken.spacing8),
        if (product.rating > 0 || product.salesCount > 0)
          Row(
            children: [
              Icon(Icons.star_rounded, size: 18, color: colorScheme.secondary),
              SizedBox(width: UiToken.spacing4),
              Text(
                product.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(width: UiToken.spacing4),
              Text(
                '• ${product.salesCount} vendas',
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              Icon(
                Icons.new_releases_outlined,
                size: 18,
                color: theme.brightness == Brightness.light
                    ? colorScheme.secondary
                    : UiToken.secondaryLight100,
              ),
              SizedBox(width: UiToken.spacing4),
              Text(
                'Novo',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        SizedBox(height: UiToken.spacing16),
        Text(
          product.formattedPrice,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.brightness == Brightness.light
                ? colorScheme.primary
                : UiToken.primaryLight100,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: UiToken.spacing4),
        Text(
          product.unit,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        SizedBox(height: UiToken.spacing8),
        Builder(
          builder: (context) {
            if (!product.stock.isAvailable) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UiToken.spacing12,
                  vertical: UiToken.spacing8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                  border: Border.all(
                    color: colorScheme.error.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  'Sem estoque',
                  style: TextStyle(
                    color: colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            if (product.stock.isLowStock) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UiToken.spacing12,
                  vertical: UiToken.spacing8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                  border: Border.all(
                    color: colorScheme.tertiary.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  'Poucas unidades',
                  style: TextStyle(
                    color: colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: UiToken.spacing24),
        Text(
          'Descrição',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: UiToken.spacing4),
        Text(
          product.description,
          style: TextStyle(color: colorScheme.onSurfaceVariant, height: 1.4),
        ),
        SizedBox(height: UiToken.spacing24),
        Text(
          'Produtos Relacionados',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: UiToken.spacing8),
        _RelatedProductsSection(product: product),
      ],
    );
  }
}

class _RelatedProductsSection extends StatelessWidget {
  const _RelatedProductsSection({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final related = provider.products
            .where((p) {
              if (p.id == product.id) return false;
              return p.categories.any(product.categories.contains);
            })
            .take(10)
            .toList();

        if (related.isEmpty) {
          return Text(
            LocalizationService.strings.noProductsFound,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        }

        return ProductCarousel(products: related);
      },
    );
  }
}

class _ProductDetailsBottomBar extends StatefulWidget {
  const _ProductDetailsBottomBar({required this.product});

  final Product product;

  @override
  State<_ProductDetailsBottomBar> createState() =>
      _ProductDetailsBottomBarState();
}

class _ProductDetailsBottomBarState extends State<_ProductDetailsBottomBar> {
  late int _selectedQuantity;

  @override
  void initState() {
    super.initState();
    _selectedQuantity = 1;
    _updateQuantityFromCart();
  }

  @override
  void didUpdateWidget(_ProductDetailsBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update quantity when cart changes (e.g., from other pages)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateQuantityFromCart();
    });
  }

  void _updateQuantityFromCart() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final currentQuantity = cart.getQuantity(widget.product.id);

    if (!mounted) {
      return;
    }

    var nextSelectedQuantity = currentQuantity + 1;

    if (nextSelectedQuantity > widget.product.stock.available) {
      nextSelectedQuantity = widget.product.stock.available;
    }

    if (nextSelectedQuantity < 1) {
      nextSelectedQuantity = 1;
    }

    if (_selectedQuantity == nextSelectedQuantity) {
      return;
    }

    setState(() {
      _selectedQuantity = nextSelectedQuantity;
    });
  }

  void _decrease() {
    if (_selectedQuantity > 1) {
      setState(() {
        _selectedQuantity--;
      });
    }
  }

  void _increase() {
    final max = widget.product.stock.available;
    if (_selectedQuantity < max) {
      setState(() {
        _selectedQuantity++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final currentCartQuantity = cart.getQuantity(widget.product.id);
    final canAdd = widget.product.stock.available > 0;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: UiToken.spacing16,
          vertical: UiToken.spacing12,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(UiToken.borderRadius16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: UiToken.spacing8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                border: Border.all(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _decrease,
                    icon: Icon(
                      Icons.remove_rounded,
                      size: 18,
                      color: colorScheme.onSurface,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$_selectedQuantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (currentCartQuantity > 0)
                        Text(
                          'no carrinho: $currentCartQuantity',
                          style: TextStyle(
                            fontSize: 10,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: _increase,
                    icon: Icon(
                      Icons.add,
                      size: 18,
                      color: colorScheme.onSurface,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: UiToken.spacing16),
            Expanded(
              child: FilledButton(
                onPressed: canAdd
                    ? () {
                        cart.addItem(
                          widget.product,
                          quantity: _selectedQuantity,
                        );
                        UiHelper.showSnackBar(
                          context,
                          message: LocalizationService.strings.cartAddProducts,
                        );
                      }
                    : null,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: UiToken.spacing16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      UiToken.borderRadiusFull,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    currentCartQuantity > 0
                        ? 'Adicionar mais ($_selectedQuantity)'
                        : 'Adicionar ($_selectedQuantity)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
