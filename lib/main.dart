import 'package:flutter/material.dart';
import 'app.dart';

/// Application entry point.
///
/// Calls [runApp] with [ECommerceApp], which sets up providers,
/// theming, routing, and locale before rendering any UI.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ECommerceApp());
}
