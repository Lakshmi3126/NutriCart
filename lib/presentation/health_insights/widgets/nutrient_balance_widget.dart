import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';


class NutrientBalanceWidget extends StatelessWidget {
  final Map<String, dynamic> nutrients;

  const NutrientBalanceWidget({Key? key, required this.nutrients})
    : super(key: key);

  String _getLocalizedText(BuildContext context, String? key) {
    if (key == null) return '';
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'mealPlanCalories':
        return l10n.mealPlanCalories;
      case 'mealPlanProtein':
        return l10n.mealPlanProtein;
      case 'mealPlanFiber':
        return l10n.mealPlanFiber;
      case 'mealPlanSugar':
        return l10n.mealPlanSugar;
      case 'mealPlanSodium':
        return l10n.mealPlanSodium;
      default:
        return key;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'good':
        return const Color(0xFF43A047);
      case 'borderline':
        return const Color(0xFFFB8C00);
      case 'needs_improvement':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF4A90A4);
    }
  }

  String _getStatusLabel(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status.toLowerCase()) {
      case 'good':
        return l10n.insightsStatusWithinRange;
      case 'borderline':
        return l10n.insightsStatusBorderline;
      case 'needs_improvement':
        return l10n.insightsStatusNeedsImprovement;
      default:
        return l10n.insightsStatusStable;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
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
            children: [
              Icon(Icons.pie_chart, color: theme.colorScheme.primary, size: 20),
              SizedBox(width: 2.w),
              Text(
                AppLocalizations.of(context)!.insightsNutrientTracking,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ...nutrients.entries.map((entry) {
            final nutrient = entry.value as Map<String, dynamic>;
            return _buildNutrientRow(context, nutrient);
          }),
        ],
      ),
    );
  }

  Widget _buildNutrientRow(
    BuildContext context,
    Map<String, dynamic> nutrient,
  ) {
    final theme = Theme.of(context);
    final name = nutrient['name'] ?? 'Unknown';
    final current = nutrient['current'] ?? 0;
    final target = nutrient['target'] ?? 0;
    final percentage = nutrient['percentage'] ?? 0;
    final status = nutrient['status'] ?? 'good';
    final unit = nutrient['unit'] ?? '';

    final statusColor = _getStatusColor(status);

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getLocalizedText(context, name),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
              Row(
                children: [
                  Text(
                    '$current',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: statusColor,
                    ),
                  ),
                  Text(
                    ' / $target $unit',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: LinearProgressIndicator(
                  value: (percentage / 100).clamp(0.0, 1.0),
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _getStatusLabel(context, status),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              Text(
                '$percentage%',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
