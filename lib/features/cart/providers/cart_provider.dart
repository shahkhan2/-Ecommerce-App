import 'package:flutter/material.dart';

import '../../product/models/product_model.dart';
import '../models/cart_item_model.dart';

/// Manages all shopping-cart state using [ChangeNotifier].
///
/// Responsibilities:
/// - Add / remove products
/// - Update item quantities
/// - Compute totals (subtotal, tax, grand total)
///
/// Consumed via `context.read<CartProvider>()` or `context.watch<CartProvider>()`.
class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  // ----------------------------------------------------------------- Getters

  /// Unmodifiable view of cart items.
  List<CartItemModel> get items => List.unmodifiable(_items);

  /// Total number of distinct products in the cart.
  int get itemCount => _items.length;

  /// Total number of units across all items.
  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Cart is empty when there are no items.
  bool get isEmpty => _items.isEmpty;

  /// Subtotal before tax and shipping.
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// 8% tax on subtotal.
  double get tax => subtotal * 0.08;

  /// Free shipping threshold is $49; below that, flat $4.99.
  double get shippingCost => subtotal >= 49 ? 0.0 : 4.99;

  /// Grand total = subtotal + tax + shipping.
  double get grandTotal => subtotal + tax + shippingCost;

  // ----------------------------------------------------------------- Formatters

  String get formattedSubtotal => '\$${subtotal.toStringAsFixed(2)}';
  String get formattedTax => '\$${tax.toStringAsFixed(2)}';
  String get formattedShipping =>
      shippingCost == 0 ? 'FREE' : '\$${shippingCost.toStringAsFixed(2)}';
  String get formattedGrandTotal => '\$${grandTotal.toStringAsFixed(2)}';

  // ----------------------------------------------------------------- Queries

  /// Returns true if the product with [productId] is in the cart.
  bool containsProduct(String productId) =>
      _items.any((item) => item.product.id == productId);

  /// Returns the [CartItemModel] for [productId], or null if not present.
  CartItemModel? getCartItem(String productId) {
    try {
      return _items.firstWhere((item) => item.product.id == productId);
    } catch (_) {
      return null;
    }
  }

  // ----------------------------------------------------------------- Mutations

  /// Adds [product] to the cart.
  ///
  /// If the product already exists, its quantity is increased by [quantity].
  void addToCart(ProductModel product, {int quantity = 1}) {
    assert(quantity > 0, 'quantity must be positive');
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + quantity,
      );
    } else {
      _items.add(CartItemModel(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  /// Removes the item matching [productId] from the cart entirely.
  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  /// Sets the quantity for [productId] to [quantity].
  ///
  /// Removes the item if [quantity] drops to zero or below.
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  /// Increments the quantity for [productId] by one.
  void increment(String productId) {
    final item = getCartItem(productId);
    if (item != null) updateQuantity(productId, item.quantity + 1);
  }

  /// Decrements the quantity for [productId] by one.
  ///
  /// Removes the item when quantity would reach zero.
  void decrement(String productId) {
    final item = getCartItem(productId);
    if (item != null) updateQuantity(productId, item.quantity - 1);
  }

  /// Clears all items from the cart (e.g. after checkout).
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
