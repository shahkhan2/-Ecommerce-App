import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/quantity_selector.dart';
import '../../cart/providers/cart_provider.dart';
import '../models/product_model.dart';

/// Full-screen product detail page.
///
/// Accepts a [ProductModel] argument via named-route navigation:
/// ```dart
/// Navigator.pushNamed(context, AppRoutes.productDetail, arguments: product);
/// ```
///
/// Features:
/// - Hero-animated image with network loading state
/// - Category badge, scrollable description
/// - Discount & rating info
/// - Inline quantity selector
/// - Add to Cart / Buy Now CTAs
class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  ProductModel get _product => widget.product;

  void _addToCart(BuildContext context) {
    final cart = context.read<CartProvider>();
    final alreadyInCart = cart.containsProduct(_product.id);
    cart.addToCart(_product, quantity: _quantity);

    if (alreadyInCart) {
      AppToast.show(context, context.l10n.productAlreadyInCart);
    } else {
      AppToast.success(context, context.l10n.productAddedToCart);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartCount = context.watch<CartProvider>().totalQuantity;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: scheme.surface.withAlpha(230),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: scheme.onSurface,
            ),
          ),
        ),
        actions: [
          // Cart badge
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              backgroundColor: AppColors.error,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: scheme.surface.withAlpha(230),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 20,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -------------------------------------------------------- Image
                  _ProductHeroImage(product: _product),

                  // -------------------------------------------------------- Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category badge
                        _CategoryBadge(category: _product.category),
                        const SizedBox(height: 10),

                        // Product name
                        AppText.headlineLarge(_product.name),
                        const SizedBox(height: 12),

                        // Price row
                        _PriceRow(product: _product),
                        const SizedBox(height: 12),

                        // Rating + reviews
                        _RatingRow(product: _product, l10n: l10n),
                        const SizedBox(height: 20),

                        // Stock status
                        _StockBadge(inStock: _product.inStock, l10n: l10n),
                        const SizedBox(height: 24),

                        // Description section
                        AppText.headlineMedium(l10n.productDescription),
                        const SizedBox(height: 8),
                        AppText.bodyLarge(
                          _product.description,
                          color: scheme.onSurface.withAlpha(180),
                        ),
                        const SizedBox(height: 28),

                        // Tags
                        if (_product.tags.isNotEmpty) ...[
                          _TagsRow(tags: _product.tags),
                          const SizedBox(height: 28),
                        ],

                        // Quantity selector
                        Row(
                          children: [
                            AppText.titleLarge(l10n.productQuantity),
                            const Spacer(),
                            QuantitySelector(
                              quantity: _quantity,
                              onDecrement: () => setState(
                                () => _quantity = (_quantity - 1).clamp(1, 99),
                              ),
                              onIncrement: () => setState(
                                () => _quantity = (_quantity + 1).clamp(1, 99),
                              ),
                            ),
                          ],
                        ),

                        // Padding for bottom bar
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -------------------------------------------------------- Bottom CTA
          _BottomCTA(
            l10n: l10n,
            isDark: isDark,
            product: _product,
            onAddToCart: () => _addToCart(context),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------- Hero Image
class _ProductHeroImage extends StatelessWidget {
  final ProductModel product;
  const _ProductHeroImage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'product-${product.id}',
      child: Container(
        height: 320,
        width: double.infinity,
        color: Theme.of(context).colorScheme.surface,
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.backgroundLight,
            child: const Icon(
              Icons.image_outlined,
              size: 72,
              color: AppColors.textHint,
            ),
          ),
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Container(
              color: AppColors.backgroundLight,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                      : null,
                  color: AppColors.primary,
                  strokeWidth: 2.5,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------- Category Badge
class _CategoryBadge extends StatelessWidget {
  final String category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// --------------------------------------------------------------- Price Row
class _PriceRow extends StatelessWidget {
  final ProductModel product;
  const _PriceRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          product.formattedPrice,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: -0.5,
          ),
        ),
        if (product.isOnSale) ...[
          const SizedBox(width: 10),
          Text(
            product.formattedOriginalPrice,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.originalPrice,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.discountBadge,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '-${product.discountPercent}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// -------------------------------------------------------------- Rating Row
class _RatingRow extends StatelessWidget {
  final ProductModel product;
  final AppLocalizations l10n;
  const _RatingRow({required this.product, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          final filled = i < product.rating.floor();
          final half = !filled && i < product.rating;
          return Icon(
            half
                ? Icons.star_half_rounded
                : (filled ? Icons.star_rounded : Icons.star_border_rounded),
            color: AppColors.starFilled,
            size: 20,
          );
        }),
        const SizedBox(width: 8),
        AppText.titleMedium(
          product.rating.toStringAsFixed(1),
          color: AppColors.starFilled,
        ),
        const SizedBox(width: 4),
        AppText.bodySmall(
          '(${product.reviewCount} ${AppStrings.productReviews})',
          color: Theme.of(context).colorScheme.onSurface.withAlpha(130),
        ),
      ],
    );
  }
}

// --------------------------------------------------------------- Stock Badge
class _StockBadge extends StatelessWidget {
  final bool inStock;
  final AppLocalizations l10n;
  const _StockBadge({required this.inStock, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: inStock ? AppColors.success : AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          inStock ? l10n.productInStock : l10n.productOutOfStock,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: inStock ? AppColors.success : AppColors.error,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------- Tags Row
class _TagsRow extends StatelessWidget {
  final List<String> tags;
  const _TagsRow({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(80),
            ),
          ),
          child: Text(
            '#$tag',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ------------------------------------------------------------ Bottom CTA
class _BottomCTA extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isDark;
  final ProductModel product;
  final VoidCallback onAddToCart;
  const _BottomCTA({
    required this.l10n,
    required this.isDark,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 40 : 12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Buy Now (ghost)
          Expanded(
            child: CustomButton.outlined(
              label: l10n.productBuyNow,
              onPressed: product.inStock ? onAddToCart : null,
            ),
          ),
          const SizedBox(width: 12),
          // Add to Cart (primary)
          Expanded(
            flex: 2,
            child: CustomButton(
              label: l10n.productAddToCart,
              icon: Icons.shopping_bag_outlined,
              onPressed: product.inStock ? onAddToCart : null,
            ),
          ),
        ],
      ),
    );
  }
}
