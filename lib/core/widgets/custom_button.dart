import 'package:flutter/material.dart';

/// Standardized button widget that provides three style variants:
/// primary (filled), secondary (outlined), and ghost (text-only).
///
/// Usage:
/// ```dart
/// CustomButton(label: 'Add to Cart', onPressed: () {})
/// CustomButton.outlined(label: 'Save', onPressed: () {})
/// CustomButton.ghost(label: 'Cancel', onPressed: () {})
/// ```
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final _ButtonVariant _variant;
  final EdgeInsets? padding;
  final double? borderRadius;

  // ----------------------------------------------------------------- Constructors

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.padding,
    this.borderRadius,
  }) : _variant = _ButtonVariant.primary;

  const CustomButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.padding,
    this.borderRadius,
  }) : _variant = _ButtonVariant.outlined;

  const CustomButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.borderRadius,
  }) : _variant = _ButtonVariant.ghost;

  // ----------------------------------------------------------------- Build

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
        : icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
    );

    Widget button;
    switch (_variant) {
      case _ButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(shape: shape, padding: padding),
          child: child,
        );
        break;

      case _ButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(shape: shape, padding: padding),
          child: child,
        );
        break;

      case _ButtonVariant.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(shape: shape, padding: padding),
          child: child,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

enum _ButtonVariant { primary, outlined, ghost }
