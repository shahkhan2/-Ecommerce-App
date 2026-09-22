import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/providers/cart_provider.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/product/screens/product_detail_screen.dart';
import 'features/profile/providers/locale_provider.dart';
import 'features/profile/providers/theme_provider.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/product/models/product_model.dart';
import 'main_scaffold.dart';
import 'routes/app_routes.dart';

/// Root application widget.
///
/// Wires together:
/// - [MultiProvider] — injects [CartProvider], [ThemeProvider], [LocaleProvider]
/// - [MaterialApp] — handles theming, routing, and locale
///
/// All child widgets access providers via `context.read / context.watch`.
class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          // Lock status bar to transparent for a full-bleed look
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: themeProvider.isDarkMode
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopWave',

            // ---- Theme ----
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            // ---- Locale ----
            locale: localeProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            // ---- Routes ----
            initialRoute: AppRoutes.initial,
            routes: {
              AppRoutes.initial: (_) => const MainScaffold(),
              AppRoutes.cart: (_) => const CartScreen(),
              AppRoutes.profile: (_) => const ProfileScreen(),
              AppRoutes.productDetail: (routeCtx) {
                final product =
                    ModalRoute.of(routeCtx)!.settings.arguments as ProductModel;
                return ProductDetailScreen(product: product);
              },
            },
          );
        },
      ),
    );
  }
}
