/// Centralized string constants for the entire application.
/// All user-facing strings are stored here to prevent hardcoded text in UI
/// and to simplify future localization.
abstract class AppStrings {
  // ---------- App ----------
  static const String appName = 'ShopWave';
  static const String appTagline = 'Discover. Shop. Love.';

  // ---------- Navigation ----------
  static const String navHome = 'Home';
  static const String navCart = 'Cart';
  static const String navProfile = 'Profile';

  // ---------- Home Screen ----------
  static const String homeGreeting = 'Good Day,';
  static const String homeUser = 'Shopper 👋';
  static const String homeSearchHint = 'Search products...';
  static const String homeCategoriesTitle = 'Categories';
  static const String homeFeaturedTitle = 'Featured Products';
  static const String homeNewArrivalsTitle = 'New Arrivals';
  static const String homeSeeAll = 'See All';

  // ---------- Banner Slogans ----------
  static const String banner1Title = 'Summer Sale';
  static const String banner1Subtitle = 'Up to 50% off on selected items';
  static const String banner2Title = 'New Arrivals';
  static const String banner2Subtitle = 'Fresh styles just dropped';
  static const String banner3Title = 'Free Shipping';
  static const String banner3Subtitle = 'On all orders above \$49';

  // ---------- Product Detail Screen ----------
  static const String productDetailTitle = 'Product Details';
  static const String productDescription = 'Description';
  static const String productQuantity = 'Quantity';
  static const String productAddToCart = 'Add to Cart';
  static const String productBuyNow = 'Buy Now';
  static const String productRating = 'Rating';
  static const String productReviews = 'reviews';
  static const String productInStock = 'In Stock';
  static const String productOutOfStock = 'Out of Stock';
  static const String productAddedToCart = 'Added to cart!';
  static const String productAlreadyInCart = 'Quantity updated in cart.';

  // ---------- Cart Screen ----------
  static const String cartTitle = 'My Cart';
  static const String cartEmpty = 'Your cart is empty';
  static const String cartEmptySubtitle =
      'Add some products and\nstart shopping!';
  static const String cartGoShopping = 'Start Shopping';
  static const String cartTotal = 'Order Total';
  static const String cartSubtotal = 'Subtotal';
  static const String cartShipping = 'Shipping';
  static const String cartShippingFree = 'FREE';
  static const String cartTax = 'Tax (8%)';
  static const String cartCheckout = 'Proceed to Checkout';
  static const String cartItemRemoved = 'Item removed from cart';
  static const String cartOrderPlaced = '🎉 Order placed successfully!';
  static const String cartItems = 'items';
  static const String cartItem = 'item';

  // ---------- Profile Screen ----------
  static const String profileTitle = 'Profile';
  static const String profileName = 'Alex Johnson';
  static const String profileEmail = 'alex.johnson@example.com';
  static const String profileJoined = 'Member since Jan 2024';
  static const String profileOrders = 'Orders';
  static const String profileWishlist = 'Wishlist';
  static const String profileWallet = 'Wallet';
  static const String profileOrdersCount = '12';
  static const String profileWishlistCount = '5';
  static const String profileWalletBalance = '\$240';
  static const String profileSettingsTitle = 'Preferences';
  static const String profileDarkMode = 'Dark Mode';
  static const String profileLanguage = 'Language';
  static const String profileNotifications = 'Notifications';
  static const String profilePrivacy = 'Privacy Policy';
  static const String profileLogout = 'Log Out';
  static const String profileVersion = 'Version 1.0.0';
  static const String profileThemeFeature = 'Toggle app theme';
  static const String profileLanguageFeature =
      'Switch between English & Spanish';

  // ---------- Languages ----------
  static const String langEnglish = 'English';
  static const String langSpanish = 'Español';

  // ---------- Common ----------
  static const String commonLoading = 'Loading...';
  static const String commonError = 'Something went wrong';
  static const String commonRetry = 'Retry';
  static const String commonCancel = 'Cancel';
  static const String commonConfirm = 'Confirm';
  static const String commonClose = 'Close';
  static const String commonSave = 'Save';
  static const String commonDelete = 'Delete';
  static const String commonSearch = 'Search';
  static const String commonNoResults = 'No results found';
  static const String commonCurrency = '\$';

  // ---------- Categories ----------
  static const String catAll = 'All';
  static const String catElectronics = 'Electronics';
  static const String catFashion = 'Fashion';
  static const String catHome = 'Home';
  static const String catSports = 'Sports';
  static const String catBeauty = 'Beauty';
  static const String catAccessories = 'Accessories';
}
