import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Widget displaying meal preparation time, serving size, and quick stats
class MealInfoWidget extends StatelessWidget {
  final Map<String, dynamic> mealData;

  const MealInfoWidget({Key? key, required this.mealData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            context,
            icon: 'schedule',
            label: l10n.mealPlanPrepTime,
            value: mealData['prepTime'] as String? ?? '30 min',
          ),
          Container(width: 1, height: 6.h, color: theme.dividerColor),
          _buildInfoItem(
            context,
            icon: 'restaurant',
            label: l10n.mealPlanServings,
            value: mealData['servings'] as String? ?? '4',
          ),
          Container(width: 1, height: 6.h, color: theme.dividerColor),
          _buildInfoItem(
            context,
            icon: 'local_fire_department',
            label: l10n.mealPlanCalories,
            value: l10n.mealPlanKcalValue(mealData['calories']?.toString() ?? '450'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: icon,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
