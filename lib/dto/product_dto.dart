import '../util/import/domain.dart';

class ProductDto {
  final String id;
  final String name;
  final String description;
  final String unit;
  final List<String> images;
  final ProductPriceDto price;
  final List<String> categories;
  final List<String> tags;
  final ProductStockDto stock;
  final ProductDimensionsDto dimensions;
  final String? barcode;
  final String sku;
  final List<ProductAttributeDto> attributes;
  final ProductNutritionDto? nutrition;
  final double rating;
  final int salesCount;
  final String status;
  final int? preparationTimeMinutes;
  final String? warranty;
  final SellerInfoDto seller;
  final String origin;
  final ProductShippingDto shipping;
  final SEOInfoDto seo;
  final String? createdAt;
  final String? updatedAt;
  final ProductFlagsDto flags;

  const ProductDto({
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
    required this.shipping,
    required this.flags,
    this.barcode,
    this.attributes = const [],
    this.nutrition,
    this.rating = 0.0,
    this.salesCount = 0,
    this.status = 'active',
    this.preparationTimeMinutes,
    this.warranty,
    this.origin = 'Local',
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDto.fromDomain(Product product) {
    return ProductDto(
      id: product.id,
      name: product.name,
      description: product.description,
      unit: product.unit,
      images: product.images,
      price: ProductPriceDto.fromDomain(product.price),
      categories: product.categories,
      tags: product.tags,
      stock: ProductStockDto.fromDomain(product.stock),
      dimensions: ProductDimensionsDto.fromDomain(product.dimensions),
      sku: product.sku,
      seller: SellerInfoDto.fromDomain(product.seller),
      seo: SEOInfoDto.fromDomain(product.seo),
      shipping: ProductShippingDto.fromDomain(product.shipping),
      flags: ProductFlagsDto.fromDomain(product.flags),
      barcode: product.barcode,
      attributes: product.attributes
          .map(ProductAttributeDto.fromDomain)
          .toList(),
      nutrition: product.nutrition != null
          ? ProductNutritionDto.fromDomain(product.nutrition!)
          : null,
      rating: product.rating,
      salesCount: product.salesCount,
      status: product.status.name,
      preparationTimeMinutes: product.preparationTime?.inMinutes,
      warranty: product.warranty,
      origin: product.origin,
      createdAt: product.createdAt?.toIso8601String(),
      updatedAt: product.updatedAt?.toIso8601String(),
    );
  }

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      unit: json['unit'] as String,
      images: (json['images'] as List).cast<String>(),
      price: ProductPriceDto.fromJson(json['price'] as Map<String, dynamic>),
      categories: (json['categories'] as List).cast<String>(),
      tags: (json['tags'] as List).cast<String>(),
      stock: ProductStockDto.fromJson(json['stock'] as Map<String, dynamic>),
      dimensions: ProductDimensionsDto.fromJson(
        json['dimensions'] as Map<String, dynamic>,
      ),
      sku: json['sku'] as String,
      seller: SellerInfoDto.fromJson(json['seller'] as Map<String, dynamic>),
      seo: SEOInfoDto.fromJson(json['seo'] as Map<String, dynamic>),
      shipping: json['shipping'] != null
          ? ProductShippingDto.fromJson(
              json['shipping'] as Map<String, dynamic>,
            )
          : const ProductShippingDto(),
      flags: json['flags'] != null
          ? ProductFlagsDto.fromJson(json['flags'] as Map<String, dynamic>)
          : const ProductFlagsDto(),
      barcode: json['barcode'] as String?,
      attributes:
          (json['attributes'] as List?)
              ?.map(
                (e) => ProductAttributeDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      nutrition: json['nutrition'] != null
          ? ProductNutritionDto.fromJson(
              json['nutrition'] as Map<String, dynamic>,
            )
          : null,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      salesCount: (json['salesCount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'active',
      preparationTimeMinutes: json['preparationTimeMinutes'] as int?,
      warranty: json['warranty'] as String?,
      origin: json['origin'] as String? ?? 'Local',
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'unit': unit,
      'images': images,
      'price': price.toJson(),
      'categories': categories,
      'tags': tags,
      'stock': stock.toJson(),
      'dimensions': dimensions.toJson(),
      'sku': sku,
      'seller': seller.toJson(),
      'seo': seo.toJson(),
      'shipping': shipping.toJson(),
      'flags': flags.toJson(),
      'barcode': barcode,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'nutrition': nutrition?.toJson(),
      'rating': rating,
      'salesCount': salesCount,
      'status': status,
      'preparationTimeMinutes': preparationTimeMinutes,
      'warranty': warranty,
      'origin': origin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Product toDomain() {
    return Product(
      id: id,
      name: name,
      description: description,
      unit: unit,
      images: images,
      price: price.toDomain(),
      categories: categories,
      tags: tags,
      stock: stock.toDomain(),
      dimensions: dimensions.toDomain(),
      sku: sku,
      seller: seller.toDomain(),
      seo: seo.toDomain(),
      shipping: shipping.toDomain(),
      flags: flags.toDomain(),
      barcode: barcode,
      attributes: attributes.map((e) => e.toDomain()).toList(),
      nutrition: nutrition?.toDomain(),
      rating: rating,
      salesCount: salesCount,
      status: ProductStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => ProductStatus.active,
      ),
      preparationTime: preparationTimeMinutes != null
          ? Duration(minutes: preparationTimeMinutes ?? 0)
          : null,
      warranty: warranty,
      origin: origin,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }
}

class ProductPriceDto {
  final double original;
  final double? promotional;
  final double? cost;
  final String currency;

  const ProductPriceDto({
    required this.original,
    this.promotional,
    this.cost,
    this.currency = 'BRL',
  });

  factory ProductPriceDto.fromDomain(ProductPrice price) {
    return ProductPriceDto(
      original: price.original,
      promotional: price.promotional,
      cost: price.cost,
      currency: price.currency,
    );
  }

  factory ProductPriceDto.fromJson(Map<String, dynamic> json) {
    return ProductPriceDto(
      original: (json['original'] as num).toDouble(),
      promotional: (json['promotional'] as num?)?.toDouble(),
      cost: (json['cost'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'BRL',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original': original,
      'promotional': promotional,
      'cost': cost,
      'currency': currency,
    };
  }

  ProductPrice toDomain() {
    return ProductPrice(
      original: original,
      promotional: promotional,
      cost: cost,
      currency: currency,
    );
  }
}

class ProductStockDto {
  final int quantity;
  final int reserved;
  final bool allowBackorder;

  const ProductStockDto({
    required this.quantity,
    this.reserved = 0,
    this.allowBackorder = false,
  });

  factory ProductStockDto.fromDomain(ProductStock stock) {
    return ProductStockDto(
      quantity: stock.quantity,
      reserved: stock.reserved,
      allowBackorder: stock.allowBackorder,
    );
  }

  factory ProductStockDto.fromJson(Map<String, dynamic> json) {
    return ProductStockDto(
      quantity: (json['quantity'] as num).toInt(),
      reserved: (json['reserved'] as num?)?.toInt() ?? 0,
      allowBackorder: json['allowBackorder'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'reserved': reserved,
      'allowBackorder': allowBackorder,
    };
  }

  ProductStock toDomain() {
    return ProductStock(
      quantity: quantity,
      reserved: reserved,
      allowBackorder: allowBackorder,
    );
  }
}

class ProductDimensionsDto {
  final double weight;
  final double height;
  final double width;
  final double depth;

  const ProductDimensionsDto({
    this.weight = 0,
    this.height = 0,
    this.width = 0,
    this.depth = 0,
  });

  factory ProductDimensionsDto.fromDomain(ProductDimensions dimensions) {
    return ProductDimensionsDto(
      weight: dimensions.weight,
      height: dimensions.height,
      width: dimensions.width,
      depth: dimensions.depth,
    );
  }

  factory ProductDimensionsDto.fromJson(Map<String, dynamic> json) {
    return ProductDimensionsDto(
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'weight': weight, 'height': height, 'width': width, 'depth': depth};
  }

  ProductDimensions toDomain() {
    return ProductDimensions(
      weight: weight,
      height: height,
      width: width,
      depth: depth,
    );
  }
}

class ProductAttributeDto {
  final String name;
  final String value;
  final String? type;

  const ProductAttributeDto({
    required this.name,
    required this.value,
    this.type,
  });

  factory ProductAttributeDto.fromDomain(ProductAttribute attribute) {
    return ProductAttributeDto(
      name: attribute.name,
      value: attribute.value,
      type: attribute.type,
    );
  }

  factory ProductAttributeDto.fromJson(Map<String, dynamic> json) {
    return ProductAttributeDto(
      name: json['name'] as String,
      value: json['value'] as String,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value, 'type': type};
  }

  ProductAttribute toDomain() {
    return ProductAttribute(name: name, value: value, type: type);
  }
}

class ProductNutritionDto {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final List<String> allergens;
  final List<String> ingredients;

  const ProductNutritionDto({
    this.calories = 0,
    this.protein = 0,
    this.carbohydrates = 0,
    this.fat = 0,
    this.allergens = const [],
    this.ingredients = const [],
  });

  factory ProductNutritionDto.fromDomain(ProductNutrition nutrition) {
    return ProductNutritionDto(
      calories: nutrition.calories,
      protein: nutrition.protein,
      carbohydrates: nutrition.carbohydrates,
      fat: nutrition.fat,
      allergens: nutrition.allergens,
      ingredients: nutrition.ingredients,
    );
  }

  factory ProductNutritionDto.fromJson(Map<String, dynamic> json) {
    return ProductNutritionDto(
      calories: (json['calories'] as num?)?.toDouble() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0,
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble() ?? 0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0,
      allergens: (json['allergens'] as List?)?.cast<String>() ?? const [],
      ingredients: (json['ingredients'] as List?)?.cast<String>() ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'allergens': allergens,
      'ingredients': ingredients,
    };
  }

  ProductNutrition toDomain() {
    return ProductNutrition(
      calories: calories,
      protein: protein,
      carbohydrates: carbohydrates,
      fat: fat,
      allergens: allergens,
      ingredients: ingredients,
    );
  }
}

class SellerInfoDto {
  final String id;
  final String name;
  final double rating;
  final bool verified;

  const SellerInfoDto({
    required this.id,
    required this.name,
    this.rating = 0.0,
    this.verified = false,
  });

  factory SellerInfoDto.fromDomain(SellerInfo seller) {
    return SellerInfoDto(
      id: seller.id,
      name: seller.name,
      rating: seller.rating,
      verified: seller.verified,
    );
  }

  factory SellerInfoDto.fromJson(Map<String, dynamic> json) {
    return SellerInfoDto(
      id: json['id'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      verified: json['verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'rating': rating, 'verified': verified};
  }

  SellerInfo toDomain() {
    return SellerInfo(id: id, name: name, rating: rating, verified: verified);
  }
}

class SEOInfoDto {
  final String metaTitle;
  final String metaDescription;
  final String slug;

  const SEOInfoDto({
    required this.metaTitle,
    required this.metaDescription,
    required this.slug,
  });

  factory SEOInfoDto.fromDomain(SEOInfo seo) {
    return SEOInfoDto(
      metaTitle: seo.metaTitle,
      metaDescription: seo.metaDescription,
      slug: seo.slug,
    );
  }

  factory SEOInfoDto.fromJson(Map<String, dynamic> json) {
    return SEOInfoDto(
      metaTitle: json['metaTitle'] as String,
      metaDescription: json['metaDescription'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
      'slug': slug,
    };
  }

  SEOInfo toDomain() {
    return SEOInfo(
      metaTitle: metaTitle,
      metaDescription: metaDescription,
      slug: slug,
    );
  }
}

class ProductFlagsDto {
  final bool isActive;
  final bool isFeatured;
  final bool isNew;
  final bool isFragile;
  final bool isPerishable;

  const ProductFlagsDto({
    this.isActive = true,
    this.isFeatured = false,
    this.isNew = false,
    this.isFragile = false,
    this.isPerishable = false,
  });

  factory ProductFlagsDto.fromDomain(ProductFlags flags) {
    return ProductFlagsDto(
      isActive: flags.isActive,
      isFeatured: flags.isFeatured,
      isNew: flags.isNew,
      isFragile: flags.isFragile,
      isPerishable: flags.isPerishable,
    );
  }

  factory ProductFlagsDto.fromJson(Map<String, dynamic> json) {
    return ProductFlagsDto(
      isActive: json['isActive'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      isFragile: json['isFragile'] as bool? ?? false,
      isPerishable: json['isPerishable'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'isFeatured': isFeatured,
      'isNew': isNew,
      'isFragile': isFragile,
      'isPerishable': isPerishable,
    };
  }

  ProductFlags toDomain() {
    return ProductFlags(
      isActive: isActive,
      isFeatured: isFeatured,
      isNew: isNew,
      isFragile: isFragile,
      isPerishable: isPerishable,
    );
  }
}

class ProductShippingDto {
  final Map<String, double> regionalCosts;
  final List<String> restrictedRegions;
  final bool freeShipping;
  final double? flatRate;

  const ProductShippingDto({
    this.regionalCosts = const {},
    this.restrictedRegions = const [],
    this.freeShipping = false,
    this.flatRate,
  });

  factory ProductShippingDto.fromDomain(ProductShipping shipping) {
    return ProductShippingDto(
      regionalCosts: shipping.regionalCosts,
      restrictedRegions: shipping.restrictedRegions,
      freeShipping: shipping.freeShipping,
      flatRate: shipping.flatRate,
    );
  }

  factory ProductShippingDto.fromJson(Map<String, dynamic> json) {
    return ProductShippingDto(
      regionalCosts:
          (json['regionalCosts'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, (value as num).toDouble()),
          ) ??
          const {},
      restrictedRegions:
          (json['restrictedRegions'] as List?)?.cast<String>() ?? const [],
      freeShipping: json['freeShipping'] as bool? ?? false,
      flatRate: (json['flatRate'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regionalCosts': regionalCosts,
      'restrictedRegions': restrictedRegions,
      'freeShipping': freeShipping,
      'flatRate': flatRate,
    };
  }

  ProductShipping toDomain() {
    return ProductShipping(
      regionalCosts: regionalCosts,
      restrictedRegions: restrictedRegions,
      freeShipping: freeShipping,
      flatRate: flatRate,
    );
  }
}
