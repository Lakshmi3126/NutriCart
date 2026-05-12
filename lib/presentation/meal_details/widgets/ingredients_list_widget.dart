import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Widget displaying ingredients with quantities and substitution suggestions
class IngredientsListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> ingredients;
  final Function(Map<String, dynamic>) onAddToGroceryList;
  final Function(String)? onTapToRead;

  const IngredientsListWidget({
    Key? key,
    required this.ingredients,
    required this.onAddToGroceryList,
    this.onTapToRead,
  }) : super(key: key);

  @override
  State<IngredientsListWidget> createState() => _IngredientsListWidgetState();
}

class _IngredientsListWidgetState extends State<IngredientsListWidget> {
  final Set<int> _selectedIngredients = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: CustomIconWidget(
                      iconName: 'shopping_basket',
                      color: theme.colorScheme.secondary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    l10n.mealPlanIngredients,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              if (_selectedIngredients.isNotEmpty)
                TextButton.icon(
                  onPressed: () => _addSelectedToGroceryList(l10n),
                  icon: CustomIconWidget(
                    iconName: 'add_shopping_cart',
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                  label: Text(
                    l10n.mealPlanAddCount(_selectedIngredients.length),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 2.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.ingredients.length,
            separatorBuilder: (context, index) => Divider(
              height: 3.h,
              color: theme.dividerColor.withValues(alpha: 0.5),
            ),
            itemBuilder: (context, index) {
              final ingredient = widget.ingredients[index];
              final isSelected = _selectedIngredients.contains(index);

              return InkWell(
                onLongPress: () {
                  setState(() {
                    isSelected
                        ? _selectedIngredients.remove(index)
                        : _selectedIngredients.add(index);
                  });
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Row(
                    children: [
                      if (_selectedIngredients.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                value == true
                                    ? _selectedIngredients.add(index)
                                    : _selectedIngredients.remove(index);
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_selectedIngredients.isEmpty) {
                                  final name = ingredient['name'] as String? ?? '';
                                  final qty = ingredient['quantity'] as String? ?? '';
                                  widget.onTapToRead?.call("$name $qty");
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Expanded(
                                          child: Text(
                                            ingredient['name'] as String? ?? '',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13.sp,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w,
                                      vertical: 0.8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      ingredient['quantity'] as String? ?? '',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (ingredient['substitution'] != null) ...[
                              SizedBox(height: 0.8.h),
                              Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.tertiaryContainer
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'swap_horiz',
                                      color: theme.colorScheme.tertiary,
                                      size: 14,
                                    ),
                                    SizedBox(width: 1.5.w),
                                    Expanded(
                                      child: Text(
                                        l10n.mealPlanCanSubstitute(ingredient['substitution'] as String),
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: theme
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                              fontSize: 11.sp,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info_outline',
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    l10n.mealPlanLongPressSelect,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addSelectedToGroceryList(AppLocalizations l10n) {
    for (final index in _selectedIngredients) {
      widget.onAddToGroceryList(widget.ingredients[index]);
    }
    setState(() {
      _selectedIngredients.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.pantryMealAddedMissingToGrocery),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
