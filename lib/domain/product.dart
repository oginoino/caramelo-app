import '../util/import/domain.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String unit; // For UI compatibility (e.g., '1 pack', '500g')
  final List<String> images;
  final ProductPrice price;
  final List<String> categories;
  final List<String> tags;
  final ProductStock stock;
  final ProductDimensions dimensions;
  final String? barcode;
  final String sku;
  final List<ProductAttribute> attributes;
  final ProductNutrition? nutrition;
  final double rating;
  final int salesCount;
  final ProductStatus status;
  final Duration? preparationTime;
  final String? warranty; // Warranty policy/period
  final SellerInfo seller;
  final String origin; // Geolocation/Region
  final ProductShipping shipping;
  final SEOInfo seo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProductFlags flags;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.unit,
    required this.images,
    required this.price,
    required this.categories,
    required this.tags,
    required this.stock,
    required this.dimensions,
    required this.sku,
    required this.seller,
    required this.seo,
    this.shipping = const ProductShipping(),
    this.barcode,
    this.attributes = const [],
    this.nutrition,
    this.rating = 0.0,
    this.salesCount = 0,
    this.status = ProductStatus.active,
    this.preparationTime,
    this.warranty,
    this.origin = 'Local',
    this.flags = const ProductFlags(),
    this.createdAt,
    this.updatedAt,
  });

  // Helper to get main image
  String get mainImage => images.isNotEmpty ? images.first : '';

  // Helper to formatted price string for UI compatibility
  String get formattedPrice => price.formattedCurrent;
}
