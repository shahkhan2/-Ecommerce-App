import 'package:flutter/material.dart';

/// Manual, delegate-based localization class.
///
/// Supports English (en) and Spanish (es) without requiring code generation.
/// Access via the BuildContext extension: `context.l10n.homeTitle`.
///
/// Registration in MaterialApp:
/// ```dart
/// localizationsDelegates: AppLocalizations.localizationsDelegates,
/// supportedLocales: AppLocalizations.supportedLocales,
/// ```
class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  // -------------------------------------------------------- Delegate helper
  static const delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    _AppLocalizationsDelegate(),
    DefaultMaterialLocalizations.delegate,
    DefaultWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [Locale('en'), Locale('es')];

  /// Retrieve the nearest [AppLocalizations] instance from [context].
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations(Locale('en'));
  }

  bool get _isSpanish => locale.languageCode == 'es';

  // ----------------------------------------------------------------- Strings

  // App
  String get appName => _isSpanish ? 'ShopWave' : 'ShopWave';
  String get appTagline =>
      _isSpanish ? 'Descubre. Compra. Ama.' : 'Discover. Shop. Love.';

  // Navigation
  String get navHome => _isSpanish ? 'Inicio' : 'Home';
  String get navCart => _isSpanish ? 'Carrito' : 'Cart';
  String get navProfile => _isSpanish ? 'Perfil' : 'Profile';

  // Home
  String get homeGreeting => _isSpanish ? '¡Buenas,' : 'Good Day,';
  String get homeUser => _isSpanish ? 'Comprador 👋' : 'Shopper 👋';
  String get homeSearchHint =>
      _isSpanish ? 'Buscar productos...' : 'Search products...';
  String get homeCategoriesTitle => _isSpanish ? 'Categorías' : 'Categories';
  String get homeFeaturedTitle =>
      _isSpanish ? 'Productos Destacados' : 'Featured Products';
  String get homeSeeAll => _isSpanish ? 'Ver todo' : 'See All';

  // Banner
  String get banner1Title => _isSpanish ? 'Rebajas de Verano' : 'Summer Sale';
  String get banner1Subtitle =>
      _isSpanish ? 'Hasta 50% de descuento' : 'Up to 50% off selected items';
  String get banner2Title => _isSpanish ? 'Novedades' : 'New Arrivals';
  String get banner2Subtitle =>
      _isSpanish ? 'Nuevos estilos disponibles' : 'Fresh styles just dropped';
  String get banner3Title => _isSpanish ? 'Envío Gratis' : 'Free Shipping';
  String get banner3Subtitle =>
      _isSpanish ? 'En pedidos superiores a \$49' : 'On all orders above \$49';

  // Product Detail
  String get productDetailTitle =>
      _isSpanish ? 'Detalle del Producto' : 'Product Details';
  String get productDescription => _isSpanish ? 'Descripción' : 'Description';
  String get productQuantity => _isSpanish ? 'Cantidad' : 'Quantity';
  String get productAddToCart =>
      _isSpanish ? 'Añadir al Carrito' : 'Add to Cart';
  String get productBuyNow => _isSpanish ? 'Comprar Ahora' : 'Buy Now';
  String get productInStock => _isSpanish ? 'En Stock' : 'In Stock';
  String get productOutOfStock => _isSpanish ? 'Sin Stock' : 'Out of Stock';
  String get productAddedToCart =>
      _isSpanish ? '¡Añadido al carrito!' : 'Added to cart!';
  String get productAlreadyInCart =>
      _isSpanish ? 'Cantidad actualizada.' : 'Quantity updated in cart.';

  // Cart
  String get cartTitle => _isSpanish ? 'Mi Carrito' : 'My Cart';
  String get cartEmpty =>
      _isSpanish ? 'Tu carrito está vacío' : 'Your cart is empty';
  String get cartEmptySubtitle => _isSpanish
      ? 'Añade productos y\n¡empieza a comprar!'
      : 'Add some products and\nstart shopping!';
  String get cartGoShopping =>
      _isSpanish ? 'Empezar a Comprar' : 'Start Shopping';
  String get cartTotal => _isSpanish ? 'Total del Pedido' : 'Order Total';
  String get cartSubtotal => _isSpanish ? 'Subtotal' : 'Subtotal';
  String get cartShipping => _isSpanish ? 'Envío' : 'Shipping';
  String get cartShippingFree => _isSpanish ? 'GRATIS' : 'FREE';
  String get cartTax => _isSpanish ? 'Impuesto (8%)' : 'Tax (8%)';
  String get cartCheckout =>
      _isSpanish ? 'Proceder al Pago' : 'Proceed to Checkout';
  String get cartItemRemoved =>
      _isSpanish ? 'Artículo eliminado' : 'Item removed from cart';
  String get cartOrderPlaced =>
      _isSpanish ? '🎉 ¡Pedido realizado!' : '🎉 Order placed successfully!';

  // Profile
  String get profileTitle => _isSpanish ? 'Perfil' : 'Profile';
  String get profileSettings => _isSpanish ? 'Preferencias' : 'Preferences';
  String get profileDarkMode => _isSpanish ? 'Modo Oscuro' : 'Dark Mode';
  String get profileLanguage => _isSpanish ? 'Idioma' : 'Language';
  String get profileNotifications =>
      _isSpanish ? 'Notificaciones' : 'Notifications';
  String get profilePrivacy =>
      _isSpanish ? 'Política de Privacidad' : 'Privacy Policy';
  String get profileLogout => _isSpanish ? 'Cerrar Sesión' : 'Log Out';

  // Common
  String get commonLoading => _isSpanish ? 'Cargando...' : 'Loading...';
  String get commonNoResults =>
      _isSpanish ? 'Sin resultados' : 'No results found';
  String get commonCancel => _isSpanish ? 'Cancelar' : 'Cancel';
  String get commonConfirm => _isSpanish ? 'Confirmar' : 'Confirm';
}

// ----------------------------------------------------------------- Delegate
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// ----------------------------------------------------------------- Extension
extension AppLocalizationsX on BuildContext {
  /// Shorthand: `context.l10n.homeGreeting`
  AppLocalizations get l10n => AppLocalizations.of(this);
}
