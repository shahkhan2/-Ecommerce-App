/// Product domain model.
///
/// Represents a single product entity in the application.
/// All fields are immutable; use [copyWith] to produce modified instances.
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice; // set when product is on sale
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final List<String> tags;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    this.rating = 4.0,
    this.reviewCount = 0,
    this.inStock = true,
    this.tags = const [],
  });

  /// Returns true when the product has a discounted price.
  bool get isOnSale => originalPrice != null && originalPrice! > price;

  /// Discount percentage compared to the original price.
  int get discountPercent {
    if (!isOnSale) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

  /// Formatted price string, e.g. "$29.99"
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Formatted original-price string, e.g. "$49.99"
  String get formattedOriginalPrice =>
      originalPrice != null ? '\$${originalPrice!.toStringAsFixed(2)}' : '';

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    String? category,
    double? rating,
    int? reviewCount,
    bool? inStock,
    List<String>? tags,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      inStock: inStock ?? this.inStock,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductModel(id: $id, name: $name, price: $price)';
}
