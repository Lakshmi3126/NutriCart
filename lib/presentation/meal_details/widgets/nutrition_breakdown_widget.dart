import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Widget displaying detailed nutrition breakdown with visual progress bars
class NutritionBreakdownWidget extends StatelessWidget {
  final Map<String, dynamic> nutritionData;

  const NutritionBreakdownWidget({Key? key, required this.nutritionData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.pie_chart_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                'Nutrition Breakdown',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildNutritionBar(
            context,
            label: 'Carbohydrates',
            value: nutritionData['carbs'] as int? ?? 45,
            unit: 'g',
            color: theme.colorScheme.primary,
            maxValue: 100,
          ),
          SizedBox(height: 2.h),
          _buildNutritionBar(
            context,
            label: 'Protein',
            value: nutritionData['protein'] as int? ?? 25,
            unit: 'g',
            color: theme.colorScheme.secondary,
            maxValue: 100,
          ),
          SizedBox(height: 2.h),
          _buildNutritionBar(
            context,
            label: 'Fiber',
            value: nutritionData['fiber'] as int? ?? 8,
            unit: 'g',
            color: theme.colorScheme.tertiary,
            maxValue: 30,
          ),
          SizedBox(height: 2.h),
          _buildNutritionBar(
            context,
            label: 'Fat',
            value: nutritionData['fat'] as int? ?? 12,
            unit: 'g',
            color: const Color(0xFFFB8C00),
            maxValue: 70,
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionBar(
    BuildContext context, {
    required String label,
    required int value,
    required String unit,
    required Color color,
    required int maxValue,
  }) {
    final theme = Theme.of(context);
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '$value$unit',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 8,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
