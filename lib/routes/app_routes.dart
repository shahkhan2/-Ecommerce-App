import 'package:flutter/material.dart';
import '../features/product/models/product_model.dart';

/// Centralized named-route definitions.
///
/// Use these constants everywhere instead of string literals to prevent typos
/// and make refactoring trivial.
///
/// Routes are registered in [ECommerceApp] (app.dart).
///
/// Navigation example:
/// ```dart
/// Navigator.pushNamed(context, AppRoutes.productDetail, arguments: product);
/// // or via helper:
/// AppRoutes.goToProductDetail(context, product);
/// ```
abstract class AppRoutes {
  // ---------------------------------------------------------------- Route names

  /// Main scaffold with bottom navigation (initial route).
  static const String initial = '/';

  /// Product-detail page. Requires a [ProductModel] argument.
  static const String productDetail = '/product/detail';

  /// Stand-alone cart page (deep-link / push friendly).
  static const String cart = '/cart';

  /// User profile page.
  static const String profile = '/profile';

  // ----------------------------------------------------------------- Helpers

  /// Push product-detail page with a [ProductModel].
  static Future<void> goToProductDetail(
    BuildContext context,
    ProductModel product,
  ) {
    return Navigator.pushNamed(context, productDetail, arguments: product);
  }

  /// Push the cart page.
  static Future<void> goToCart(BuildContext context) {
    return Navigator.pushNamed(context, cart);
  }

  /// Push the profile page.
  static Future<void> goToProfile(BuildContext context) {
    return Navigator.pushNamed(context, profile);
  }
}
