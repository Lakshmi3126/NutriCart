import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Daily Summary widget displaying total calories, cost, and budget status
class DailySummaryWidget extends StatelessWidget {
  final Map<String, dynamic> summaryData;

  const DailySummaryWidget({Key? key, required this.summaryData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final totalCalories = summaryData['totalCalories'] as int;
    final targetCalories = summaryData['targetCalories'] as int;
    final totalCost = summaryData['totalCost'] as double;
    final budgetLimit = summaryData['budgetLimit'] as double;
    final budgetStatus = summaryData['budgetStatus'] as String;
    final totalSodiumMg = summaryData['totalSodiumMg'] as int? ?? 0;
    final sodiumTargetMg = summaryData['sodiumTargetMg'] as int? ?? 1700;

    final calorieProgress = totalCalories / targetCalories;
    final budgetProgress = totalCost / budgetLimit;
    final sodiumProgress = totalSodiumMg / sodiumTargetMg;
    final isWithinBudget = budgetStatus == 'within';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const CustomIconWidget(
                    iconName: 'analytics',
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  l10n.mealPlanSummaryTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Calories section
            _buildSummaryItem(
              theme,
              l10n.mealPlanTotalCalories,
              l10n.mealPlanKcal('$totalCalories / $targetCalories'),
              calorieProgress,
              theme.colorScheme.secondary,
              'local_fire_department',
            ),
            SizedBox(height: 2.h),

            // Cost section
            _buildSummaryItem(
              theme,
              l10n.mealPlanTotalCost,
              '${l10n.mealPlanRupee(totalCost.toStringAsFixed(0))} / ${l10n.mealPlanRupee(budgetLimit.toStringAsFixed(0))}',
              budgetProgress,
              isWithinBudget
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.error,
              'currency_rupee',
            ),
            SizedBox(height: 2.h),

            _buildSummaryItem(
              theme,
              'Total Sodium',
              '$totalSodiumMg mg / $sodiumTargetMg mg',
              sodiumProgress,
              sodiumProgress <= 1
                  ? const Color(0xFF4A90A4)
                  : theme.colorScheme.error,
              'water_drop',
            ),
            SizedBox(height: 2.h),

            // Budget status
            Container(
              padding: EdgeInsets.all(2.5.w),
              decoration: BoxDecoration(
                color: isWithinBudget
                    ? theme.colorScheme.secondaryContainer
                    : theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: isWithinBudget ? 'check_circle' : 'warning',
                    color: isWithinBudget
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.error,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      isWithinBudget
                          ? l10n.mealPlanBudgetWithin
                          : l10n.mealPlanBudgetExceeded((totalCost - budgetLimit).toStringAsFixed(0)),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isWithinBudget
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    ThemeData theme,
    String label,
    String value,
    double progress,
    Color color,
    String icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomIconWidget(iconName: icon, color: color, size: 18),
                SizedBox(width: 2.w),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
