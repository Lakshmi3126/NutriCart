import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/app_export.dart';
import '../../../l10n/app_localizations.dart';

class BudgetTrackingWidget extends StatelessWidget {
  final Map<String, dynamic> budgetData;

  const BudgetTrackingWidget({Key? key, required this.budgetData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final monthlyBudget = budgetData["monthlyBudget"] as int;
    final spent = budgetData["spent"] as int;
    final remaining = budgetData["remaining"] as int;
    final daysLeft = budgetData["daysLeft"] as int;
    final avgDailySpend = budgetData["avgDailySpend"] as int;
    final spentPercentage = (spent / monthlyBudget * 100).round();

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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CustomIconWidget(
                        iconName: 'account_balance_wallet',
                        size: 20,
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      l10n.groceryBudgetOverview,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 0.8.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getBudgetStatusColor(
                      spentPercentage,
                      theme,
                    ).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    l10n.groceryUsedPercent(spentPercentage),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: _getBudgetStatusColor(spentPercentage, theme),
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
                  child: _buildBudgetInfo(
                    l10n.groceryMonthlyBudget,
                    '₹$monthlyBudget',
                    theme.colorScheme.primary,
                    theme,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildBudgetInfo(
                    l10n.grocerySpent,
                    '₹$spent',
                    theme.colorScheme.error,
                    theme,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: LinearProgressIndicator(
                value: spent / monthlyBudget,
                minHeight: 8,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getBudgetStatusColor(spentPercentage, theme),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.groceryRemaining,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '₹$remaining',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.secondary,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.h,
                    width: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          l10n.groceryDaysLeftLabel,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          l10n.profileUnitDays(daysLeft),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.h,
                    width: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.groceryAvgDay,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '₹$avgDailySpend',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
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

  Widget _buildBudgetInfo(
    String label,
    String amount,
    Color color,
    ThemeData theme,
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
            amount,
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

  Color _getBudgetStatusColor(int percentage, ThemeData theme) {
    if (percentage >= 90) {
      return theme.colorScheme.error;
    } else if (percentage >= 75) {
      return const Color(0xFFFB8C00);
    } else {
      return theme.colorScheme.primary;
    }
  }
}
