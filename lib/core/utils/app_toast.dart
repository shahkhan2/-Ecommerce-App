import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/app_colors.dart';

/// Global toast notification utility.
///
/// Use [AppToast.show] anywhere in the app to present a non-blocking message.
/// Variants: success, error, warning, and the default info style.
///
/// Example:
/// ```dart
/// AppToast.show(context, 'Item added to cart');
/// AppToast.success(context, 'Order placed!');
/// AppToast.error(context, 'Network error');
/// ```
abstract class AppToast {
  // ------------------------------------------------------------------ show
  /// Shows a neutral (info) toast message.
  static void show(
    BuildContext context,
    String message, {
    Toast length = Toast.LENGTH_SHORT,
  }) {
    _display(
      message: message,
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      length: length,
    );
  }

  // ------------------------------------------------------------------ success
  /// Shows a green success toast.
  static void success(
    BuildContext context,
    String message, {
    Toast length = Toast.LENGTH_SHORT,
  }) {
    _display(
      message: message,
      backgroundColor: AppColors.success,
      textColor: Colors.white,
      length: length,
    );
  }

  // ------------------------------------------------------------------ error
  /// Shows a red error toast.
  static void error(
    BuildContext context,
    String message, {
    Toast length = Toast.LENGTH_LONG,
  }) {
    _display(
      message: message,
      backgroundColor: AppColors.error,
      textColor: Colors.white,
      length: length,
    );
  }

  // ------------------------------------------------------------------ warning
  /// Shows an amber warning toast.
  static void warning(
    BuildContext context,
    String message, {
    Toast length = Toast.LENGTH_SHORT,
  }) {
    _display(
      message: message,
      backgroundColor: AppColors.warning,
      textColor: Colors.white,
      length: length,
    );
  }

  // ------------------------------------------------------------------ _display
  static void _display({
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required Toast length,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }
}
