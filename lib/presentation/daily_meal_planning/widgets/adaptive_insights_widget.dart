import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../models/adaptive_meal_plan.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Widget displaying adaptive meal planning insights and nutrient rebalancing
class AdaptiveInsightsWidget extends StatelessWidget {
  final double adaptationScore;
  final NutrientTargets dailyTargets;
  final NutrientTargets adjustedTargets;
  final Map<String, Map<String, dynamic>> selectedMeals;

  const AdaptiveInsightsWidget({
    Key? key,
    required this.adaptationScore,
    required this.dailyTargets,
    required this.adjustedTargets,
    required this.selectedMeals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final hasAdjustments = adaptationScore > 0.1;

    if (!hasAdjustments) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: theme.colorScheme.secondary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'auto_awesome',
                color: theme.colorScheme.secondary,
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  l10n.adaptivePlanActive,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Text(
                  '${(adaptationScore * 100).round()}% ${l10n.adaptivePersonalized}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            l10n.adaptiveAdjustedDesc,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
          SizedBox(height: 1.h),
          _buildAdjustmentItem(
            theme,
            l10n.adaptivePortionsOptimized,
            'restaurant',
          ),
          _buildAdjustmentItem(
            theme,
            l10n.adaptiveMealsReplaced,
            'swap_horiz',
          ),
          _buildAdjustmentItem(
            theme,
            l10n.adaptiveNutrientsRebalanced,
            'balance',
          ),
        ],
      ),
    );
  }

  Widget _buildAdjustmentItem(ThemeData theme, String text, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: theme.colorScheme.secondary,
            size: 4.w,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
