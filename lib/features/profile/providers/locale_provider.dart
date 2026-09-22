import 'package:flutter/material.dart';

/// Manages the application-wide locale (language).
///
/// Supported locales: English (en) and Spanish (es).
/// Consumed at the [MaterialApp] level via [locale].
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  // ----------------------------------------------------------------- Getters

  Locale get locale => _locale;

  bool get isEnglish => _locale.languageCode == 'en';

  // ----------------------------------------------------------------- Setters

  /// Toggles between English and Spanish.
  void toggleLocale() {
    _locale = isEnglish ? const Locale('es') : const Locale('en');
    notifyListeners();
  }

  /// Explicitly sets the locale.
  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
