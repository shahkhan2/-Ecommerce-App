import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../features/product/models/product_model.dart';

/// Reusable product card used in grid and list layouts.
///
/// Displays the product image, name, price, rating, and an optional
/// discount badge. Tapping the card triggers [onTap].
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDark ? 30 : 15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Image ----
            _ProductImage(product: product),

            // ---- Info ----
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Rating row
                    _RatingRow(product: product),

                    const Spacer(),

                    // Price row + add button
                    _PriceRow(product: product, onAddToCart: onAddToCart),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------- Product Image
class _ProductImage extends StatelessWidget {
  final ProductModel product;
  const _ProductImage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.backgroundLight,
                child: const Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: AppColors.textHint,
                ),
              ),
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppColors.backgroundLight,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Discount badge
        if (product.isOnSale)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.discountBadge,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '-${product.discountPercent}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ------------------------------------------------------------ Rating Row
class _RatingRow extends StatelessWidget {
  final ProductModel product;
  const _RatingRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: AppColors.starFilled, size: 14),
        const SizedBox(width: 3),
        Text(
          product.rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.starFilled,
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '(${product.reviewCount})',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondaryLight,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------- Price Row
class _PriceRow extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onAddToCart;
  const _PriceRow({required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Prices
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product.formattedPrice,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (product.isOnSale)
                Text(
                  product.formattedOriginalPrice,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.originalPrice,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
        ),

        // Add to cart button
        if (onAddToCart != null)
          GestureDetector(
            onTap: onAddToCart,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }
}
