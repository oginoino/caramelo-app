import '../../util/import/domain.dart';
import '../../util/import/packages.dart';
import '../../util/import/repository.dart';
import '../../util/import/service.dart';

enum ProductSortOption {
  relevance,
  priceLowToHigh,
  priceHighToLow,
  nameAsc,
  nameDesc,
}

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider(this._repository) {
    loadProducts();
  }

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<String> _searchHistory = [];
  List<String> get searchHistory => List.unmodifiable(_searchHistory);

  ProductSortOption _sortOption = ProductSortOption.relevance;
  ProductSortOption get sortOption => _sortOption;

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _products = await _repository.getProducts();
    } catch (e) {
      debugPrint('Error loading products: $e');
      _errorMessage = LocalizationService.strings.errorLoadingProducts;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retryLoadProducts() => loadProducts();

  void setSearchQuery(String query) {
    if (query.trim().isEmpty) {
      if (_searchQuery.isEmpty) return;
      _searchQuery = '';
    } else {
      if (_searchQuery == query) return;
      _searchQuery = query;
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void addToHistory(String query) {
    if (query.trim().isEmpty) return;
    final cleanQuery = query.trim();
    _searchHistory.remove(cleanQuery);
    _searchHistory.insert(0, cleanQuery);
    if (_searchHistory.length > 10) {
      _searchHistory = _searchHistory.sublist(0, 10);
    }
    notifyListeners();
  }

  void removeFromHistory(String query) {
    _searchHistory.remove(query);
    notifyListeners();
  }

  void clearHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  void setSortOption(ProductSortOption option) {
    if (_sortOption == option) return;
    _sortOption = option;
    notifyListeners();
  }

  List<String> get availableCategories {
    final categories = <String>{};
    for (final product in _products) {
      categories.addAll(product.categories);
    }
    return categories.toList()..sort();
  }

  List<Product> get deals => _products.where((p) => p.price.onSale).toList();

  List<Product> getByCategory(String category) {
    return _products.where((p) => p.categories.contains(category)).toList();
  }

  Map<String, List<Product>> get sections {
    final sections = <String, List<Product>>{};

    // 1. Deals (Priority)
    final dealsList = deals;
    if (dealsList.isNotEmpty) {
      sections['deals'] = dealsList;
    }

    // 2. Categories
    for (final category in availableCategories) {
      final items = getByCategory(category);
      if (items.isNotEmpty) {
        sections[category] = items;
      }
    }
    return sections;
  }

  String _selectedCategoryId = 'all';
  String get selectedCategoryId => _selectedCategoryId;

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    List<Product> result;

    // 1. Filter by Category
    if (_selectedCategoryId == 'all') {
      result = List.of(_products);
    } else if (_selectedCategoryId == 'deals') {
      result = deals;
    } else {
      result = getByCategory(_selectedCategoryId);
    }

    // 2. Filter by Search Query
    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      result = result.where((p) {
        final matchName = p.name.toLowerCase().contains(lowerQuery);
        final matchDesc = p.description.toLowerCase().contains(lowerQuery);
        final matchSku = p.sku.toLowerCase().contains(lowerQuery);
        final matchTags = p.tags.any(
          (t) => t.toLowerCase().contains(lowerQuery),
        );
        // Add more fields if needed (e.g. barcode)
        final matchBarcode =
            p.barcode?.toLowerCase().contains(lowerQuery) ?? false;

        return matchName || matchDesc || matchSku || matchTags || matchBarcode;
      }).toList();
    }

    // 3. Sort
    switch (_sortOption) {
      case ProductSortOption.priceLowToHigh:
        result.sort((a, b) => a.price.current.compareTo(b.price.current));
        break;
      case ProductSortOption.priceHighToLow:
        result.sort((a, b) => b.price.current.compareTo(a.price.current));
        break;
      case ProductSortOption.nameAsc:
        result.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ProductSortOption.nameDesc:
        result.sort((a, b) => b.name.compareTo(a.name));
        break;
      case ProductSortOption.relevance:
        // Keep default order or implement relevance logic
        // For simple search, default list order is often fine,
        // or we could prioritize name matches over description matches.
        if (_searchQuery.isNotEmpty) {
          final lowerQuery = _searchQuery.toLowerCase();
          result.sort((a, b) {
            // Prioritize exact name match or startsWith
            final aName = a.name.toLowerCase();
            final bName = b.name.toLowerCase();

            final aStarts = aName.startsWith(lowerQuery) ? 1 : 0;
            final bStarts = bName.startsWith(lowerQuery) ? 1 : 0;

            if (aStarts != bStarts) return bStarts.compareTo(aStarts);

            return 0;
          });
        }
        break;
    }

    return result;
  }

  List<String> get suggestions {
    if (_searchQuery.isEmpty) return [];
    final lowerQuery = _searchQuery.toLowerCase();
    final Set<String> suggestions = {};

    for (final p in _products) {
      if (p.name.toLowerCase().contains(lowerQuery)) {
        suggestions.add(p.name);
      }
      for (final tag in p.tags) {
        if (tag.toLowerCase().contains(lowerQuery)) {
          suggestions.add(tag);
        }
      }
    }
    return suggestions.take(5).toList();
  }
}
