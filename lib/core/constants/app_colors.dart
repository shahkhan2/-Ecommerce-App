import 'package:flutter/material.dart';

/// Centralized color palette for the entire application.
/// All colors are defined here to ensure a consistent visual language.
abstract class AppColors {
  // ---------- Brand Colors ----------
  static const Color primary = Color(0xFF2563EB); // Vivid Blue
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);

  static const Color secondary = Color(0xFF10B981); // Emerald Green
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);

  static const Color accent = Color(0xFFF59E0B); // Amber

  // ---------- Neutral / Surface Colors ----------
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);

  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  // ---------- Text Colors ----------
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textHint = Color(0xFFCBD5E1);

  // ---------- Status Colors ----------
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ---------- Divider & Border ----------
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);

  static const Color borderLight = Color(0xFFCBD5E1);
  static const Color borderDark = Color(0xFF475569);

  // ---------- Category Chip Colors ----------
  static const List<Color> categoryColors = [
    Color(0xFFEFF6FF), // Electronics – light blue tint
    Color(0xFFFFF7ED), // Fashion – warm
    Color(0xFFF0FDF4), // Home – mint
    Color(0xFFFEF9C3), // Sports – yellow
    Color(0xFFFDF4FF), // Beauty – lavender
    Color(0xFFF0F9FF), // Accessories – sky
  ];

  static const List<Color> categoryIconColors = [
    Color(0xFF2563EB),
    Color(0xFFEA580C),
    Color(0xFF16A34A),
    Color(0xFFCA8A04),
    Color(0xFF9333EA),
    Color(0xFF0284C7),
  ];

  // ---------- Overlay / Shadow ----------
  static const Color shadowColor = Color(0x1A000000);
  static const Color overlayDark = Color(0x80000000);

  // ---------- Star Rating ----------
  static const Color starFilled = Color(0xFFFBBF24);
  static const Color starEmpty = Color(0xFFE5E7EB);

  // ---------- Price / Discount ----------
  static const Color discountBadge = Color(0xFFEF4444);
  static const Color originalPrice = Color(0xFF94A3B8);
}
