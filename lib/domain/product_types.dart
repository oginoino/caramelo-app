enum ProductStatus { active, inactive, outOfStock, discontinued, preOrder }

class ProductPrice {
  final double original;
  final double? promotional;
  final double? cost;
  final String currency;

  const ProductPrice({
    required this.original,
    this.promotional,
    this.cost,
    this.currency = 'BRL',
  });

  double get current => promotional ?? original;
  bool get onSale => promotional != null && promotional! < original;
  String get formattedOriginal => 'R\$ ${original.toStringAsFixed(2)}';
  String get formattedCurrent => 'R\$ ${current.toStringAsFixed(2)}';
}

class ProductStock {
  final int quantity;
  final int reserved;
  final int available;
  final bool allowBackorder;

  const ProductStock({
    required this.quantity,
    this.reserved = 0,
    this.allowBackorder = false,
  }) : available = quantity - reserved;

  bool get isAvailable => available > 0 || allowBackorder;
  bool get isLowStock => available < 5 && available > 0;
}

class ProductDimensions {
  final double weight; // in kg
  final double height; // in cm
  final double width; // in cm
  final double depth; // in cm

  const ProductDimensions({
    this.weight = 0,
    this.height = 0,
    this.width = 0,
    this.depth = 0,
  });
}

class ProductAttribute {
  final String name;
  final String value;
  final String? type; // color, size, material

  const ProductAttribute({required this.name, required this.value, this.type});
}

class ProductNutrition {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final List<String> allergens;
  final List<String> ingredients;

  const ProductNutrition({
    this.calories = 0,
    this.protein = 0,
    this.carbohydrates = 0,
    this.fat = 0,
    this.allergens = const [],
    this.ingredients = const [],
  });
}

class SellerInfo {
  final String id;
  final String name;
  final double rating;
  final bool verified;

  const SellerInfo({
    required this.id,
    required this.name,
    this.rating = 0.0,
    this.verified = false,
  });
}

class SEOInfo {
  final String metaTitle;
  final String metaDescription;
  final String slug;

  const SEOInfo({
    required this.metaTitle,
    required this.metaDescription,
    required this.slug,
  });
}

class ProductFlags {
  final bool isActive;
  final bool isFeatured;
  final bool isNew;
  final bool isFragile;
  final bool isPerishable;

  const ProductFlags({
    this.isActive = true,
    this.isFeatured = false,
    this.isNew = false,
    this.isFragile = false,
    this.isPerishable = false,
  });
}

class ProductShipping {
  final Map<String, double> regionalCosts; // Region code -> Cost
  final List<String>
  restrictedRegions; // Regions where delivery is NOT available
  final bool freeShipping;
  final double? flatRate;

  const ProductShipping({
    this.regionalCosts = const {},
    this.restrictedRegions = const [],
    this.freeShipping = false,
    this.flatRate,
  });
}
