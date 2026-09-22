import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_button.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_widget.dart';

/// Shopping cart screen.
///
/// Features:
/// - Slide-to-dismiss cart items
/// - Inline quantity ± controls via [CartItemWidget]
/// - Live order summary (subtotal / tax / shipping / total)
/// - Dummy checkout action with toast confirmation
/// - Empty-cart illustration with CTA back to shopping
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cartTitle),
        actions: [
          if (!cart.isEmpty)
            TextButton.icon(
              onPressed: () => _confirmClear(context, cart, l10n),
              icon: const Icon(Icons.delete_sweep_outlined, size: 18),
              label: const Text('Clear'),
            ),
        ],
      ),
      body: cart.isEmpty
          ? _EmptyCart(l10n: l10n)
          : Column(
              children: [
                // ---- Item list ----
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return CartItemWidget(
                        item: item,
                        onRemove: () {
                          cart.removeFromCart(item.product.id);
                          AppToast.show(context, l10n.cartItemRemoved);
                        },
                      );
                    },
                  ),
                ),

                // ---- Order summary ----
                _OrderSummary(cart: cart, l10n: l10n),
              ],
            ),
    );
  }

  // ------------------------------------------------------------------ helpers

  Future<void> _confirmClear(
    BuildContext context,
    CartProvider cart,
    AppLocalizations l10n,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Remove all items from your cart?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
    if (result == true) cart.clearCart();
  }
}

// -------------------------------------------------------------- Empty Cart
class _EmptyCart extends StatelessWidget {
  final AppLocalizations l10n;
  const _EmptyCart({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            AppText.headlineLarge(l10n.cartEmpty, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            AppText.bodyLarge(
              l10n.cartEmptySubtitle,
              textAlign: TextAlign.center,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: l10n.cartGoShopping,
              icon: Icons.arrow_back_rounded,
              isFullWidth: false,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------- Order Summary
class _OrderSummary extends StatelessWidget {
  final CartProvider cart;
  final AppLocalizations l10n;
  const _OrderSummary({required this.cart, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 30 : 10),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: scheme.outline.withAlpha(80),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Items count
          _SummaryRow(
            label:
                '${cart.itemCount} ${cart.itemCount == 1 ? "item" : "items"}',
            value: '',
            isLabel: true,
          ),
          const SizedBox(height: 8),

          // Subtotal
          _SummaryRow(label: l10n.cartSubtotal, value: cart.formattedSubtotal),
          const SizedBox(height: 6),

          // Shipping
          _SummaryRow(
            label: l10n.cartShipping,
            value: cart.formattedShipping,
            valueColor: cart.shippingCost == 0 ? AppColors.success : null,
          ),
          const SizedBox(height: 6),

          // Tax
          _SummaryRow(label: l10n.cartTax, value: cart.formattedTax),
          const SizedBox(height: 12),

          Divider(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          const SizedBox(height: 12),

          // Grand total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.headlineMedium(l10n.cartTotal),
              Text(
                cart.formattedGrandTotal,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Checkout button
          CustomButton(
            label: l10n.cartCheckout,
            icon: Icons.lock_outline_rounded,
            onPressed: () {
              cart.clearCart();
              AppToast.success(context, l10n.cartOrderPlaced);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------- Summary Row
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLabel;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (isLabel) {
      return AppText.bodySmall(label, color: scheme.onSurface.withAlpha(140));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bodyMedium(label, color: scheme.onSurface.withAlpha(160)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
