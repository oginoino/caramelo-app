import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/product_provider/product_provider.dart';
import '../../util/const/ui/ui_token.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final categories = ['all', 'deals', ...provider.availableCategories];
        final selectedCategory = provider.selectedCategoryId;
        final isLight = Theme.of(context).brightness == Brightness.light;

        // Cores baseadas no tema
        final activeBgColor = isLight
            ? UiToken.primaryLight700
            : UiToken.primaryDark500;
        final activeFgColor = Colors.white;

        final inactiveBgColor = Colors.transparent;
        final inactiveFgColor = isLight
            ? UiToken.primaryLight700
            : UiToken.primaryLight300;
        final inactiveBorderColor = isLight
            ? UiToken.primaryLight700
            : UiToken.primaryLight300;

        return SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;

              String label = category;
              if (category == 'all') label = 'Tudo';
              if (category == 'deals') label = 'Promoções';
              // Capitalize first letter for others
              if (category != 'all' &&
                  category != 'deals' &&
                  category.isNotEmpty) {
                label = category[0].toUpperCase() + category.substring(1);
              }

              return ChoiceChip(
                label: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? activeFgColor : inactiveFgColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: isSelected,
                showCheckmark: false,
                selectedColor: activeBgColor,
                backgroundColor: inactiveBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : inactiveBorderColor,
                    width: 1.5,
                  ),
                ),
                onSelected: (selected) {
                  if (selected) {
                    provider.selectCategory(category);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
