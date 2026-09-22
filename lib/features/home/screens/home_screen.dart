import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/product_card.dart';
import '../../../features/cart/providers/cart_provider.dart';
import '../../../features/product/models/product_model.dart';
import '../../../routes/app_routes.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_list.dart';
import '../widgets/search_bar_widget.dart';

/// Entry screen of the app — shown as one tab of the main scaffold.
///
/// Displays:
/// - Personalised greeting + cart shortcut in the AppBar
/// - Search bar with live dummy-data filtering
/// - Auto-advancing banner slider
/// - Horizontal category chips
/// - Responsive product grid (2 columns)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<ProductModel> get _filteredProducts {
    List<ProductModel> products;

    if (_searchQuery.trim().isNotEmpty) {
      products = DummyData.search(_searchQuery);
    } else {
      products = DummyData.getByCategory(_selectedCategory);
    }
    return products;
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _searchQuery = '';
    });
  }

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query);
  }

  void _addToCart(BuildContext context, ProductModel product) {
    context.read<CartProvider>().addToCart(product);
    AppToast.success(context, '${product.name} added to cart!');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final cartCount = context.watch<CartProvider>().totalQuantity;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ---------------------------------------------------------------- AppBar
          SliverAppBar(
            floating: true,
            snap: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodySmall(
                  l10n.homeGreeting,
                  color: scheme.onSurface.withAlpha(150),
                ),
                AppText.headlineMedium(l10n.homeUser, color: scheme.onSurface),
              ],
            ),
            actions: [
              // Cart icon with badge
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  backgroundColor: AppColors.error,
                  child: IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () => AppRoutes.goToCart(context),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // ---------------------------------------------------------------- Search
                SearchBarWidget(onChanged: _onSearchChanged),

                const SizedBox(height: 20),

                // ---------------------------------------------------------------- Banner
                if (_searchQuery.isEmpty) ...[
                  const BannerSlider(),
                  const SizedBox(height: 24),
                ],

                // ---------------------------------------------------------------- Categories
                if (_searchQuery.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.headlineMedium(l10n.homeCategoriesTitle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  CategoryList(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _onCategorySelected,
                  ),
                  const SizedBox(height: 24),
                ],

                // ---------------------------------------------------------------- Section title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.headlineMedium(
                        _searchQuery.isNotEmpty
                            ? 'Results (${_filteredProducts.length})'
                            : (_selectedCategory == 'All'
                                  ? l10n.homeFeaturedTitle
                                  : _selectedCategory),
                      ),
                      if (_searchQuery.isEmpty && _selectedCategory == 'All')
                        TextButton(
                          onPressed: () {},
                          child: Text(l10n.homeSeeAll),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),

          // ---------------------------------------------------------------- Product Grid
          if (_filteredProducts.isEmpty)
            SliverFillRemaining(child: _EmptyState(query: _searchQuery))
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = _filteredProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () => AppRoutes.goToProductDetail(context, product),
                    onAddToCart: () => _addToCart(context, product),
                  );
                }, childCount: _filteredProducts.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------- Empty State
class _EmptyState extends StatelessWidget {
  final String query;
  const _EmptyState({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            AppText.headlineMedium(
              'No results for "$query"',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppText.bodyMedium(
              'Try a different search term or browse categories.',
              textAlign: TextAlign.center,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ],
        ),
      ),
    );
  }
}
