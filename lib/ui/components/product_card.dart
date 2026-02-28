import '../../util/import/domain.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  static const double aspectRatio = 0.64;

  final Product product;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final quantity = cart.getQuantity(product.id);

        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        UiToken.borderRadius12,
                      ),
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
                      child: _AddButton(product: product, cart: cart),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.unit,
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 2),
                    SizedBox(
                      height: 13 * 1.2 * 2,
                      child: Text(
                        product.name,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2),
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
      },
    );
  }
}

class _AddButton extends StatefulWidget {
  const _AddButton({required this.product, required this.cart});

  final Product product;
  final CartProvider cart;

  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton> {
  bool _isExpanded = false;
  Timer? _collapseTimer;

  @override
  void dispose() {
    _collapseTimer?.cancel();
    super.dispose();
  }

  void _restartCollapseTimer() {
    _collapseTimer?.cancel();
    _collapseTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _isExpanded = false;
      });
    });
  }

  void _showStockLimitMessage(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Só temos ${widget.product.stock.available} unidades em estoque.',
          style: TextStyle(
            color: isLight ? UiToken.primaryLight50 : UiToken.primaryDark50,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isLight
            ? UiToken.secondaryLight800
            : UiToken.secondaryDark800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiToken.borderRadius8),
        ),
      ),
    );
  }

  void _handleAddPressed(BuildContext context) {
    final canAddMore = widget.cart.canAdd(widget.product.id);
    if (!canAddMore) {
      _showStockLimitMessage(context);
      return;
    }
    widget.cart.addItem(widget.product);
    setState(() {
      _isExpanded = true;
    });
    _restartCollapseTimer();
  }

  void _handleDecreasePressed() {
    final quantity = widget.cart.getQuantity(widget.product.id);
    if (quantity <= 0) {
      return;
    }
    widget.cart.decreaseItem(widget.product.id);
    if (quantity == 1) {
      _collapseTimer?.cancel();
      setState(() {
        _isExpanded = false;
      });
      return;
    }
    setState(() {
      _isExpanded = true;
    });
    _restartCollapseTimer();
  }

  void _handleCompactTap() {
    final quantity = widget.cart.getQuantity(widget.product.id);
    if (quantity == 0) {
      return;
    }
    setState(() {
      _isExpanded = true;
    });
    _restartCollapseTimer();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final quantity = widget.cart.getQuantity(widget.product.id);
    final canAddMore = widget.cart.canAdd(widget.product.id);

    if (quantity == 0) {
      _collapseTimer?.cancel();
      _isExpanded = false;
      return IconButton(
            style: IconButton.styleFrom(
              backgroundColor: isLight
                  ? UiToken.primaryLight600
                  : UiToken.primaryLight500,
              foregroundColor: isLight
                  ? UiToken.primaryLight50
                  : UiToken.primaryDark800,
              shape: const CircleBorder(),
            ),
            onPressed: () => _handleAddPressed(context),
            icon: const Icon(Icons.add_rounded),
          )
          .animate(key: ValueKey('add_${widget.product.id}_icon'))
          .scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1, 1),
            duration: 200.ms,
          )
          .fadeIn(duration: 200.ms);
    }

    if (!_isExpanded) {
      return GestureDetector(
            onTap: _handleCompactTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isLight
                    ? UiToken.primaryLight600
                    : UiToken.primaryLight500,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$quantity',
                style: TextStyle(
                  color: isLight
                      ? UiToken.primaryLight50
                      : UiToken.primaryDark800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .animate(key: ValueKey('add_${widget.product.id}_compact'))
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
            duration: 220.ms,
            curve: Curves.easeOutBack,
          )
          .fadeIn(duration: 220.ms);
    }

    return Container(
          decoration: BoxDecoration(
            color: isLight ? UiToken.primaryLight600 : UiToken.primaryLight500,
            borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
          ),
          child: Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: isLight
                      ? UiToken.primaryLight50
                      : UiToken.primaryDark800,
                ),
                onPressed: _handleDecreasePressed,
                icon: Icon(
                  quantity == 1 ? Icons.delete_rounded : Icons.remove_rounded,
                ),
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  color: isLight
                      ? UiToken.primaryLight50
                      : UiToken.primaryDark800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: isLight
                      ? UiToken.primaryLight50
                      : UiToken.primaryDark800,
                ),
                onPressed: canAddMore
                    ? () {
                        _handleAddPressed(context);
                      }
                    : () {
                        _showStockLimitMessage(context);
                      },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        )
        .animate(key: ValueKey('add_${widget.product.id}_expanded'))
        .fadeIn(duration: 200.ms)
        .slideX(begin: 0.2, end: 0, duration: 200.ms);
  }
}
