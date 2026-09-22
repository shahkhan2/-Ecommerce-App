import '../../../features/product/models/product_model.dart';

/// Local dummy product catalog.
///
/// Used throughout the app as a substitute for a real backend.
/// Images are sourced from picsum.photos (stable seed-based placeholders).
abstract class DummyData {
  // ---------- Categories ----------

  static const List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home',
    'Sports',
    'Beauty',
    'Accessories',
  ];

  // ---------- Banner Data ----------

  static const List<Map<String, String>> banners = [
    {
      'title': 'Summer Sale',
      'subtitle': 'Up to 50% off on selected items',
      'imageUrl': 'https://picsum.photos/seed/banner1/800/400',
      'tag': 'HOT DEAL',
    },
    {
      'title': 'New Arrivals',
      'subtitle': 'Fresh styles just dropped',
      'imageUrl': 'https://picsum.photos/seed/banner2/800/400',
      'tag': 'NEW',
    },
    {
      'title': 'Free Shipping',
      'subtitle': 'On all orders above \$49',
      'imageUrl': 'https://picsum.photos/seed/banner3/800/400',
      'tag': 'OFFER',
    },
  ];

  // ---------- Products ----------

  static final List<ProductModel> products = [
    // --- Electronics ---
    ProductModel(
      id: 'p001',
      name: 'Wireless Noise-Cancelling Headphones',
      description:
          'Experience premium audio with active noise cancellation technology. '
          'Up to 30 hours of battery life, foldable design, and plush ear cushions '
          'make these the perfect companion for travel, work, or relaxation.',
      price: 79.99,
      originalPrice: 129.99,
      imageUrl: 'https://picsum.photos/seed/headphone/400/400',
      category: 'Electronics',
      rating: 4.7,
      reviewCount: 2154,
      tags: ['audio', 'wireless', 'noise-cancelling'],
    ),
    ProductModel(
      id: 'p002',
      name: 'Smart Watch Series X',
      description:
          'Track your fitness goals, receive notifications, and monitor your heart rate '
          'with this elegant smartwatch. Water-resistant up to 50 m with a stunning '
          'AMOLED display and 7-day battery life.',
      price: 149.99,
      originalPrice: 199.99,
      imageUrl: 'https://picsum.photos/seed/smartwatch/400/400',
      category: 'Electronics',
      rating: 4.5,
      reviewCount: 876,
      tags: ['wearable', 'fitness', 'smart'],
    ),
    ProductModel(
      id: 'p003',
      name: 'Portable Bluetooth Speaker',
      description:
          'Bold 360° surround sound in a rugged, waterproof shell. Perfect for outdoor '
          'adventures with 20 hours of playtime and a built-in power bank to charge '
          'your devices on the go.',
      price: 49.99,
      imageUrl: 'https://picsum.photos/seed/speaker/400/400',
      category: 'Electronics',
      rating: 4.3,
      reviewCount: 1202,
      tags: ['audio', 'bluetooth', 'outdoor'],
    ),
    ProductModel(
      id: 'p004',
      name: '4K Ultra HD Webcam',
      description:
          'Crystal-clear 4K resolution with auto-focus and built-in noise-reducing '
          'microphone. Plug-and-play USB-C connectivity makes it ideal for remote work, '
          'streaming, and video calls.',
      price: 89.99,
      originalPrice: 119.99,
      imageUrl: 'https://picsum.photos/seed/webcam/400/400',
      category: 'Electronics',
      rating: 4.4,
      reviewCount: 534,
      tags: ['camera', 'streaming', 'remote-work'],
    ),

    // --- Fashion ---
    ProductModel(
      id: 'p005',
      name: 'Classic Slim-Fit Oxford Shirt',
      description:
          'Crafted from 100% premium Egyptian cotton, this slim-fit Oxford shirt '
          'transitions effortlessly from the boardroom to weekend brunch. Available '
          'in a refined palette of timeless colours.',
      price: 34.99,
      originalPrice: 54.99,
      imageUrl: 'https://picsum.photos/seed/shirt/400/400',
      category: 'Fashion',
      rating: 4.6,
      reviewCount: 780,
      tags: ['men', 'formal', 'cotton'],
    ),
    ProductModel(
      id: 'p006',
      name: 'High-Waist Flare Jeans',
      description:
          'Flattering high-rise cut with a modern flare leg. Made from stretchy '
          'eco-conscious denim that keeps you comfortable all day while staying fashion-forward.',
      price: 44.99,
      imageUrl: 'https://picsum.photos/seed/jeans/400/400',
      category: 'Fashion',
      rating: 4.8,
      reviewCount: 1531,
      tags: ['women', 'denim', 'trendy'],
    ),
    ProductModel(
      id: 'p007',
      name: 'Minimalist Leather Sneakers',
      description:
          'Clean, versatile, and built to last. Full-grain leather upper with a '
          'cushioned insole and vulcanised rubber sole ensures all-day comfort and '
          'effortless style.',
      price: 89.99,
      originalPrice: 109.99,
      imageUrl: 'https://picsum.photos/seed/sneakers/400/400',
      category: 'Fashion',
      rating: 4.5,
      reviewCount: 643,
      tags: ['footwear', 'leather', 'unisex'],
    ),

    // --- Home ---
    ProductModel(
      id: 'p008',
      name: 'Ceramic Pour-Over Coffee Set',
      description:
          'Elevate your morning ritual with this handcrafted ceramic pour-over set. '
          'Includes dripper, carafe, and two mugs. Dishwasher safe and available '
          'in a range of earth-tone glazes.',
      price: 39.99,
      imageUrl: 'https://picsum.photos/seed/coffeeset/400/400',
      category: 'Home',
      rating: 4.9,
      reviewCount: 420,
      tags: ['kitchen', 'coffee', 'ceramic'],
    ),
    ProductModel(
      id: 'p009',
      name: 'Nordic Throw Blanket',
      description:
          'Super-soft chunky-knit throw blanket inspired by Scandinavian design. '
          'Made from recycled cotton blend, it adds warmth and texture to any sofa '
          'or bed. Machine washable.',
      price: 29.99,
      originalPrice: 44.99,
      imageUrl: 'https://picsum.photos/seed/blanket/400/400',
      category: 'Home',
      rating: 4.7,
      reviewCount: 892,
      tags: ['decor', 'cosy', 'scandinavian'],
    ),
    ProductModel(
      id: 'p010',
      name: 'Smart LED Desk Lamp',
      description:
          'Adjustable color temperature (2700K–6500K) and brightness with USB-A '
          'charging port. Touch controls with memory function remember your last '
          'setting. Perfect for study or work.',
      price: 34.99,
      imageUrl: 'https://picsum.photos/seed/desklamp/400/400',
      category: 'Home',
      rating: 4.4,
      reviewCount: 315,
      tags: ['lighting', 'smart', 'productivity'],
    ),

    // --- Sports ---
    ProductModel(
      id: 'p011',
      name: 'Resistance Training Band Set',
      description:
          'Five graduated resistance levels from 10 to 50 lbs. Latex-free, '
          'anti-snap construction with door anchor and ankle straps included. '
          'Compact carry bag makes home workouts simple.',
      price: 24.99,
      imageUrl: 'https://picsum.photos/seed/resistanceband/400/400',
      category: 'Sports',
      rating: 4.5,
      reviewCount: 1987,
      tags: ['fitness', 'home-gym', 'training'],
    ),
    ProductModel(
      id: 'p012',
      name: 'Ultra-Light Running Shoes',
      description:
          'Engineered mesh upper provides breathability while the responsive '
          'foam midsole delivers energy return with every stride. Reflective details '
          'keep you visible on early morning runs.',
      price: 74.99,
      originalPrice: 99.99,
      imageUrl: 'https://picsum.photos/seed/runningshoes/400/400',
      category: 'Sports',
      rating: 4.6,
      reviewCount: 745,
      tags: ['running', 'footwear', 'breathable'],
    ),

    // --- Beauty ---
    ProductModel(
      id: 'p013',
      name: 'Vitamin C Brightening Serum',
      description:
          '15% stabilised L-ascorbic acid formula visibly reduces dark spots and '
          'uneven skin tone within 4 weeks. Lightweight, fast-absorbing, and '
          'dermatologically tested for all skin types.',
      price: 28.99,
      originalPrice: 39.99,
      imageUrl: 'https://picsum.photos/seed/serum/400/400',
      category: 'Beauty',
      rating: 4.8,
      reviewCount: 3201,
      tags: ['skincare', 'vitamin-c', 'brightening'],
    ),
    ProductModel(
      id: 'p014',
      name: 'Professional Hair Dryer Pro',
      description:
          'Ionic technology reduces frizz and enhances shine. 2200W motor with '
          'three heat settings, two speed settings, and a cool-shot button. '
          'Includes diffuser and concentrator attachments.',
      price: 59.99,
      imageUrl: 'https://picsum.photos/seed/hairdryer/400/400',
      category: 'Beauty',
      rating: 4.4,
      reviewCount: 1102,
      tags: ['haircare', 'ionic', 'professional'],
    ),

    // --- Accessories ---
    ProductModel(
      id: 'p015',
      name: 'Genuine Leather Bifold Wallet',
      description:
          'Full-grain vegetable-tanned leather that develops a beautiful patina over '
          'time. Slim profile holds up to 8 cards plus cash. RFID-blocking lining '
          'protects your contactless cards.',
      price: 29.99,
      originalPrice: 44.99,
      imageUrl: 'https://picsum.photos/seed/wallet/400/400',
      category: 'Accessories',
      rating: 4.7,
      reviewCount: 564,
      tags: ['mens', 'leather', 'rfid'],
    ),
    ProductModel(
      id: 'p016',
      name: 'Canvas Backpack 25L',
      description:
          'Durable waxed canvas with leather accents and antique brass hardware. '
          'Padded laptop sleeve fits up to 15", with multiple organization pockets '
          'and an ergonomic padded back panel.',
      price: 64.99,
      imageUrl: 'https://picsum.photos/seed/backpack/400/400',
      category: 'Accessories',
      rating: 4.6,
      reviewCount: 321,
      tags: ['bags', 'canvas', 'laptop'],
    ),
  ];

  /// Returns products filtered by [category]. Passing 'All' returns every product.
  static List<ProductModel> getByCategory(String category) {
    if (category == 'All') return products;
    return products.where((p) => p.category == category).toList();
  }

  /// Returns products whose name or description matches [query] (case-insensitive).
  static List<ProductModel> search(String query) {
    if (query.trim().isEmpty) return products;
    final q = query.toLowerCase();
    return products
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q) ||
              p.tags.any((t) => t.toLowerCase().contains(q)),
        )
        .toList();
  }

  /// Returns a list of on-sale products.
  static List<ProductModel> get onSaleProducts =>
      products.where((p) => p.isOnSale).toList();

  /// Returns the four highest-rated products.
  static List<ProductModel> get featuredProducts {
    final sorted = [...products]..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(4).toList();
  }
}
