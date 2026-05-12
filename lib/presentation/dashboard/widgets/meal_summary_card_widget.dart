import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

import '../../../l10n/app_localizations.dart';

class MealSummaryCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> meals;
  final Function(int) onMealTap;
  final Function(int) onMealLongPress;

  const MealSummaryCardWidget({
    Key? key,
    required this.meals,
    required this.onMealTap,
    required this.onMealLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final completedMeals = meals
        .where((meal) => meal["isCompleted"] == true)
        .length;
    final totalCalories = meals.fold<int>(
      0,
      (sum, meal) => sum + (meal["calories"] as int),
    );
    final consumedCalories = meals
        .where((meal) => meal["isCompleted"] == true)
        .fold<int>(0, (sum, meal) => sum + (meal["calories"] as int));

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.dashboardOverviewTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    fontSize: 16.sp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 0.8.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    l10n.dashboardMealCompletedCount(completedMeals, meals.length),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildCalorieInfo(
                    l10n.dashboardCalorieConsumed,
                    consumedCalories,
                    theme.colorScheme.primary,
                    theme,
                    l10n,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildCalorieInfo(
                    l10n.dashboardCalorieRemaining,
                    totalCalories - consumedCalories,
                    theme.colorScheme.secondary,
                    theme,
                    l10n,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: LinearProgressIndicator(
                value: consumedCalories / totalCalories,
                minHeight: 8,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Divider(color: theme.dividerColor.withValues(alpha: 0.5)),
            SizedBox(height: 1.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meals.length,
              separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
              itemBuilder: (context, index) {
                final meal = meals[index];
                return _buildMealItem(meal, theme, l10n);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieInfo(
    String label,
    int calories,
    Color color,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            l10n.dashboardCalorieValue(calories),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(
    Map<String, dynamic> meal,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final isCompleted = meal["isCompleted"] as bool;

    return InkWell(
      onTap: () => onMealTap(meal["id"] as int),
      onLongPress: () => onMealLongPress(meal["id"] as int),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isCompleted
              ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.3)
              : theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isCompleted
                ? theme.colorScheme.secondary.withValues(alpha: 0.3)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: isCompleted
                    ? theme.colorScheme.secondary
                    : theme.colorScheme.surface,
                shape: BoxShape.circle,
                boxShadow: isCompleted
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.secondary.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: CustomIconWidget(
                iconName: isCompleted
                    ? 'check'
                    : _getMealIcon(meal["mealType"] as String),
                size: 20,
                color: isCompleted
                    ? theme.colorScheme.onSecondary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  _localizeMealType(meal["mealType"] as String, l10n),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  _localizeMealName(meal["name"] as String, l10n),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    fontSize: 13.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'schedule',
                      size: 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      _localizeTime(meal["time"] as String, l10n),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                l10n.mealPlanKcal(meal["calories"].toString()),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                  fontSize: 13.sp,
                ),
              ),
                SizedBox(height: 0.5.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.3.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getHealthScoreColor(
                      meal["healthScore"] as int,
                      theme,
                    ).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${meal["healthScore"]}%',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getHealthScoreColor(
                        meal["healthScore"] as int,
                        theme,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

String _localizeTime(String time, AppLocalizations l10n) {
  return time.replaceAll('AM', l10n.timeAM).replaceAll('PM', l10n.timePM);
}

String _localizeMealType(String mealType, AppLocalizations l10n) {
  switch (mealType.toLowerCase()) {
    case 'breakfast':
      return l10n.mealPlanBreakfast;
    case 'lunch':
      return l10n.mealPlanLunch;
    case 'snacks':
      return l10n.mealPlanSnacks;
    case 'dinner':
      return l10n.mealPlanDinner;
    default:
      return mealType;
  }
}

String _localizeMealName(String name, AppLocalizations l10n) {
  switch (name) {
    case "Oats Upma with Vegetables":
      return l10n.mealPlanOatsUpma;
    case "Brown Rice with Dal Tadka & Salad":
      return l10n.mealPlanBrownRiceDal;
    case "Roasted Makhana with Green Tea":
      return l10n.mealPlanRoastedMakhana;
    case "Roti with Palak Paneer & Cucumber Raita":
      return l10n.mealPlanRotiPalakPaneer;
    default:
      return name;
  }
}

  String _getMealIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return 'wb_sunny';
      case 'lunch':
        return 'restaurant';
      case 'snacks':
        return 'cookie';
      case 'dinner':
        return 'nightlight';
      default:
        return 'restaurant_menu';
    }
  }

  Color _getHealthScoreColor(int score, ThemeData theme) {
    if (score >= 85) {
      return theme.colorScheme.primary;
    } else if (score >= 70) {
      return theme.colorScheme.secondary;
    } else {
      return theme.colorScheme.error;
    }
  }
}
