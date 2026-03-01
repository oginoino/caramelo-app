import '../../util/import/packages.dart';
import '../../util/import/domain.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  static const double minOrderValue = 10.0;

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get totalQuantity =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.values.fold(0.0, (sum, item) => sum + item.total);

  int getQuantity(String productId) {
    return _items[productId]?.quantity ?? 0;
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    if (!_items.containsKey(productId)) return;

    final currentItem = _items[productId]!;
    // Check stock limit
    final availableStock = currentItem.product.stock.available;
    if (quantity > availableStock) {
      _items[productId] = currentItem.copyWith(quantity: availableStock);
    } else {
      _items[productId] = currentItem.copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void addItem(Product product, {int quantity = 1}) {
    if (quantity <= 0) return;

    if (_items.containsKey(product.id)) {
      final currentItem = _items[product.id]!;
      // Check stock limit
      final newQuantity = currentItem.quantity + quantity;
      if (newQuantity > product.stock.available) {
        // We limit to available stock
        _items[product.id] = currentItem.copyWith(
          quantity: product.stock.available,
        );
      } else {
        _items[product.id] = currentItem.copyWith(quantity: newQuantity);
      }
    } else {
      if (product.stock.available > 0) {
        final initialQuantity = quantity > product.stock.available
            ? product.stock.available
            : quantity;
        _items[product.id] = CartItem(
          product: product,
          quantity: initialQuantity,
        );
      }
    }
    notifyListeners();
  }

  void decreaseItem(String productId) {
    if (!_items.containsKey(productId)) return;

    final currentItem = _items[productId]!;
    if (currentItem.quantity > 1) {
      _items[productId] = currentItem.copyWith(
        quantity: currentItem.quantity - 1,
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Helper to check if we can add more
  bool canAdd(String productId) {
    final item = _items[productId];
    if (item == null) return true; // Assuming product passed has stock > 0
    return item.quantity < item.product.stock.available;
  }
}
