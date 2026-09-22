import 'package:flutter/material.dart';

/// Semantic text widget with predefined styles.
///
/// Mirrors Material typography roles so that all text in the app is
/// consistent and respects the active theme.
///
/// Usage:
/// ```dart
/// AppText.headlineMedium('Hello', context: context)
/// AppText.bodySmall('Subtitle', color: Colors.grey)
/// ```
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
  });

  // ----------------------------------------------------------------- Factories

  factory AppText.displaySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: color,
      ),
      textAlign: textAlign,
    );
  }

  factory AppText.headlineLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.headlineMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: color,
      ),
      textAlign: textAlign,
    );
  }

  factory AppText.titleLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.titleMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
      textAlign: textAlign,
    );
  }

  factory AppText.bodyLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.bodyMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      ),
      textAlign: textAlign,
    );
  }

  factory AppText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      key: key,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
      ),
      textAlign: textAlign,
    );
  }

  // ----------------------------------------------------------------- Build

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style?.copyWith(color: color ?? style?.color) ??
          TextStyle(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
