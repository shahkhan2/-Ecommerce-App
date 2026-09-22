import 'package:flutter/material.dart';

/// Manages the application-wide theme (light / dark / system).
///
/// Consumed at the [MaterialApp] level so that the entire widget tree reacts
/// to theme changes without a restart.
///
/// Example:
/// ```dart
/// context.read<ThemeProvider>().toggleTheme();
/// ```
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  // ----------------------------------------------------------------- Getters

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // ----------------------------------------------------------------- Setters

  /// Switches between [ThemeMode.light] and [ThemeMode.dark].
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  /// Explicitly sets the theme mode.
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }
}
