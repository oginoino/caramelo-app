import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import 'app_tooltip.dart';

class CartActionButton extends StatelessWidget {
  const CartActionButton({
    super.key,
    required this.onPressed,
    this.tooltip = 'Cart',
  });

  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final bg = isLight ? UiToken.primaryDark900 : UiToken.primaryLight200;
    final fg = isLight ? UiToken.primaryLight50 : UiToken.primaryDark900;
    final avatarBg = isLight
        ? UiToken.primaryLight600
        : UiToken.primaryLight500;
    final avatarFg = isLight ? UiToken.primaryLight200 : UiToken.primaryDark800;

    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final count = cart.totalQuantity;

        return AppTooltip(
          message: tooltip,
          child: IconButton(
            onPressed: onPressed,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: UiToken.shadow16,
                  backgroundColor: avatarBg,
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: UiToken.textSize24,
                    color: avatarFg,
                  ),
                ),
                if (count > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        count > 99 ? '99+' : '$count',
                        style: TextStyle(
                          fontSize: UiToken.textSize10,
                          fontWeight: FontWeight.w700,
                          color: fg,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
