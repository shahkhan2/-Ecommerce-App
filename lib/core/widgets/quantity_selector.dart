import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Compact ± quantity selector used in both the product detail and cart screens.
///
/// Usage:
/// ```dart
/// QuantitySelector(
///   quantity: 2,
///   onDecrement: () {},
///   onIncrement: () {},
/// )
/// ```
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final int minQuantity;
  final int maxQuantity;
  final double size;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAtMin = quantity <= minQuantity;
    final isAtMax = quantity >= maxQuantity;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outline.withAlpha(100)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---- Decrement ----
          _ControlButton(
            icon: Icons.remove_rounded,
            onPressed: isAtMin ? null : onDecrement,
            size: size,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9),
              bottomLeft: Radius.circular(9),
            ),
          ),

          // ---- Count ----
          SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Text(
                '$quantity',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ),

          // ---- Increment ----
          _ControlButton(
            icon: Icons.add_rounded,
            onPressed: isAtMax ? null : onIncrement,
            size: size,
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------- Private sub-widget
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final BorderRadius borderRadius;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
    required this.size,
    required this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDisabled = onPressed == null;

    return Material(
      color: isDisabled
          ? scheme.surfaceContainerHighest
          : (color ?? scheme.surfaceContainerHighest),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: 18,
            color: isDisabled
                ? scheme.onSurface.withAlpha(80)
                : (color != null ? Colors.white : scheme.onSurface),
          ),
        ),
      ),
    );
  }
}
