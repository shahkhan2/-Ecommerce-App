import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dummy_data.dart';

/// Horizontally scrollable category chip list.
///
/// Calls [onCategorySelected] whenever a new category is tapped.
class CategoryList extends StatefulWidget {
  final ValueChanged<String> onCategorySelected;
  final String selectedCategory;

  const CategoryList({
    super.key,
    required this.onCategorySelected,
    required this.selectedCategory,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  static const List<IconData> _icons = [
    Icons.grid_view_rounded,
    Icons.devices_rounded,
    Icons.checkroom_rounded,
    Icons.home_rounded,
    Icons.sports_basketball_rounded,
    Icons.spa_rounded,
    Icons.watch_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final categories = DummyData.categories;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == widget.selectedCategory;
          final bgColor = isSelected
              ? AppColors.primary
              : (index < AppColors.categoryColors.length
                    ? AppColors.categoryColors[index]
                    : AppColors.backgroundLight);
          final iconColor = isSelected
              ? Colors.white
              : (index < AppColors.categoryIconColors.length
                    ? AppColors.categoryIconColors[index]
                    : AppColors.primary);
          final textColor = isSelected
              ? Colors.white
              : AppColors.textPrimaryLight;

          return GestureDetector(
            onTap: () => widget.onCategorySelected(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 72,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? null
                    : Border.all(color: AppColors.borderLight, width: 1),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(80),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _icons[index % _icons.length],
                    color: iconColor,
                    size: 22,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
