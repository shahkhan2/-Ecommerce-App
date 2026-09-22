import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Full-screen or inline loading indicator.
///
/// [AppLoader.fullScreen] overlays the entire screen.
/// [AppLoader.inline] is a centered widget for embedding in a layout.
class AppLoader extends StatelessWidget {
  final Color? color;
  final double size;

  const AppLoader({super.key, this.color, this.size = 40});

  // ----------------------------------------------------------------- Factories

  /// Fills the parent and centers a circular progress indicator.
  factory AppLoader.inline({Color? color, double size = 40}) {
    return AppLoader(color: color, size: size);
  }

  /// Overlay that blocks the entire screen with a semi-transparent scrim.
  static Widget fullScreen({Color? indicatorColor}) {
    return ColoredBox(
      color: AppColors.overlayDark,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: CircularProgressIndicator(
            color: indicatorColor ?? AppColors.primary,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------- Build

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
