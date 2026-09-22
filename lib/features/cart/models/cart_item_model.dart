import '../../product/models/product_model.dart';

/// Represents a product that has been added to the shopping cart.
///
/// Wraps [ProductModel] and tracks the chosen [quantity].
class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({required this.product, this.quantity = 1});

  /// Total price for this line item.
  double get totalPrice => product.price * quantity;

  /// Formatted total price string, e.g. "$59.97".
  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  CartItemModel copyWith({ProductModel? product, int? quantity}) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          product.id == other.product.id;

  @override
  int get hashCode => product.id.hashCode;

  @override
  String toString() =>
      'CartItemModel(product: ${product.name}, qty: $quantity, total: $formattedTotalPrice)';
}
