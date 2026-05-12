import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../l10n/app_localizations.dart';

/// Meal suggestion widget showing recipes based on available pantry stock
class MealSuggestionWidget extends StatelessWidget {
  final Map<String, dynamic> meal;

  const MealSuggestionWidget({Key? key, required this.meal}) : super(key: key);

  String _getLocalizedMealName(String name, AppLocalizations l10n) {
    switch (name) {
      case 'Vegetable Pulao':
        return l10n.mockMealVegPulao;
      case 'Paneer Tikka':
        return l10n.mockMealPaneerTikka;
      case 'Dalia Khichdi':
        return l10n.mockMealDaliaKhichdi;
      case 'Dal Tadka':
        return l10n.mockMealDalTadka;
      case 'Paneer Butter Masala':
        return l10n.mockMealPaneerButterMasala;
      case 'Egg Curry':
        return l10n.mockMealEggCurry;
      default:
        return name;
    }
  }

  String _getLocalizedIngredientName(String name, AppLocalizations l10n) {
    switch (name) {
      case 'Capsicum':
        return l10n.mockIngredientCapsicum;
      case 'Mixed Vegetables':
        return l10n.mockIngredientMixedVeg;
      case 'Dalia (Broken Wheat)':
        return l10n.mockIngredientDalia;
      case 'Onions':
        return l10n.mockIngredientOnions;
      case 'Tomatoes':
        return l10n.mockIngredientTomatoes;
      case 'Spinach':
        return l10n.mockIngredientSpinach;
      case 'Carrots':
        return l10n.mockIngredientCarrots;
      case 'Basmati Rice':
        return l10n.mockIngredientBasmatiRice;
      case 'Whole Wheat Flour':
        return l10n.mockIngredientWheatFlour;
      case 'Moong Dal':
        return l10n.mockIngredientMoongDal;
      case 'Turmeric Powder':
        return l10n.mockIngredientTurmeric;
      case 'Cumin Seeds':
        return l10n.mockIngredientCumin;
      case 'Garam Masala':
        return l10n.mockIngredientGaramMasala;
      case 'Milk':
        return l10n.mockIngredientMilk;
      case 'Yogurt':
        return l10n.mockIngredientYogurt;
      case 'Paneer':
        return l10n.mockIngredientPaneer;
      case 'Chicken Breast':
        return l10n.mockIngredientChicken;
      case 'Eggs':
        return l10n.mockIngredientEggs;
      case 'Green Peas':
        return l10n.mockIngredientGreenPeas;
      case 'Cream':
        return l10n.mockIngredientCream;
      case 'Butter':
        return l10n.mockIngredientButter;
      case 'Coconut Milk':
        return l10n.mockIngredientCoconutMilk;
      default:
        return name;
    }
  }

  String _getLocalizedMissingIngredients(
    List ingredients,
    AppLocalizations l10n,
  ) {
    return ingredients
        .map((ing) => _getLocalizedIngredientName(ing.toString(), l10n))
        .join(', ');
  }

  void _showMealDetails(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final requiredIngredients = meal['requiredIngredients'] as List;
    final missingIngredients = meal['missingIngredients'] as List;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(4.w),
          child: ListView(
            controller: scrollController,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 12.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              // Meal image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomImageWidget(
                  imageUrl: meal['image'],
                  height: 25.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 2.h),
              // Meal name
              Text(
                _getLocalizedMealName(meal['name'], l10n),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 1.h),
              // Meal info
              Row(
                children: [
                  _buildInfoChip(
                    theme,
                    Icons.local_fire_department,
                    l10n.pantryMealCal(meal['calories'].toString()),
                    AppTheme.warningLight,
                  ),
                  SizedBox(width: 2.w),
                  _buildInfoChip(
                    theme,
                    Icons.currency_rupee,
                    '${meal['cost']}',
                    AppTheme.successLight,
                  ),
                  SizedBox(width: 2.w),
                  _buildInfoChip(
                    theme,
                    Icons.check_circle,
                    l10n.pantryMealAvailablePercent(meal['availablePercentage']),
                    theme.colorScheme.primary,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              // Required ingredients
              Text(
                l10n.pantryMealRequiredIngredients,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 1.h),
              ...requiredIngredients.map((ingredient) {
                final isAvailable = ingredient['available'] as bool;
                return Container(
                  margin: EdgeInsets.only(bottom: 1.h),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? AppTheme.successLight.withValues(alpha: 0.1)
                        : theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isAvailable
                          ? AppTheme.successLight.withValues(alpha: 0.3)
                          : theme.colorScheme.error.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isAvailable ? Icons.check_circle : Icons.cancel,
                        color: isAvailable
                            ? AppTheme.successLight
                            : theme.colorScheme.error,
                        size: 20,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          _getLocalizedIngredientName(ingredient['name'], l10n),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      if (isAvailable)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            l10n.pantryMealInPantry,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
              if (missingIngredients.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.warningLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.warningLight.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: AppTheme.warningLight,
                            size: 20,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            l10n.pantryMealMissingIngredients,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        _getLocalizedMissingIngredients(missingIngredients, l10n),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        l10n.pantryMealEstimatedCost(meal['estimatedCost'].toString()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 2.h),
              // Action button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        missingIngredients.isEmpty
                            ? l10n.pantryMealReadyToCook
                            : l10n.pantryMealAddedMissingToGrocery,
                      ),
                      backgroundColor: theme.colorScheme.secondary,
                    ),
                  );
                },
                icon: Icon(
                  missingIngredients.isEmpty
                      ? Icons.restaurant
                      : Icons.add_shopping_cart,
                ),
                label: Text(
                  missingIngredients.isEmpty
                      ? l10n.pantryMealStartCooking
                      : l10n.pantryMealAddMissingItems,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    ThemeData theme,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 1.w),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final availablePercentage = meal['availablePercentage'] as int;
    final missingIngredients = meal['missingIngredients'] as List;

    return InkWell(
      onTap: () => _showMealDetails(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal image with availability badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CustomImageWidget(
                    imageUrl: meal['image'],
                    height: 20.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 2.w,
                  right: 2.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: availablePercentage == 100
                          ? AppTheme.successLight
                          : availablePercentage >= 75
                              ? AppTheme.warningLight
                              : theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          availablePercentage == 100
                              ? Icons.check_circle
                              : Icons.info,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '$availablePercentage%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Meal info
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getLocalizedMealName(meal['name'], l10n),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'local_fire_department',
                        color: AppTheme.warningLight,
                        size: 16,
                      ),
                       SizedBox(width: 1.w),
                      Text(
                        l10n.pantryMealCal(meal['calories'].toString()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      CustomIconWidget(
                        iconName: 'currency_rupee',
                        color: AppTheme.successLight,
                        size: 16,
                      ),
                      Text(
                        '${meal['cost']}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  if (missingIngredients.isNotEmpty) ...[
                    SizedBox(height: 1.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.error.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: theme.colorScheme.error,
                            size: 16,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              l10n.pantryMealMissingLabel(
                                _getLocalizedMissingIngredients(
                                  missingIngredients,
                                  l10n,
                                ),
                              ),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          availablePercentage == 100
                              ? l10n.pantryMealAllAvailable
                              : l10n.pantryMealTapToView,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}