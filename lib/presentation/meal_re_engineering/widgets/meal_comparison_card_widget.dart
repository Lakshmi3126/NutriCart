import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget displaying side-by-side comparison of original and updated meals
class MealComparisonCardWidget extends StatelessWidget {
  final Map<String, dynamic> originalMeal;
  final Map<String, dynamic> updatedMeal;

  const MealComparisonCardWidget({
    Key? key,
    required this.originalMeal,
    required this.updatedMeal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        padding: EdgeInsets.all(3.w),
        child: Column(
          children: [
            // Original meal
            _buildMealCard(
              context,
              meal: originalMeal,
              label: 'Original',
              isOriginal: true,
            ),

            SizedBox(height: 2.h),

            // Arrow indicator
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: 'arrow_downward',
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Updated meal
            _buildMealCard(
              context,
              meal: updatedMeal,
              label: 'Updated',
              isOriginal: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(
    BuildContext context, {
    required Map<String, dynamic> meal,
    required String label,
    required bool isOriginal,
  }) {
    final theme = Theme.of(context);
    final statusColor = Color(
      int.parse(meal['statusColor'].toString().replaceFirst('#', '0xFF')),
    );

    return Container(
      decoration: BoxDecoration(
        color: isOriginal
            ? theme.colorScheme.errorContainer.withValues(alpha: 0.1)
            : theme.colorScheme.secondaryContainer.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isOriginal
              ? theme.colorScheme.error.withValues(alpha: 0.3)
              : theme.colorScheme.secondary.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
            decoration: BoxDecoration(
              color: isOriginal
                  ? theme.colorScheme.error.withValues(alpha: 0.1)
                  : theme.colorScheme.secondary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: isOriginal ? 'cancel' : 'check_circle',
                  color: isOriginal
                      ? theme.colorScheme.error
                      : theme.colorScheme.secondary,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isOriginal
                        ? theme.colorScheme.error
                        : theme.colorScheme.secondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              children: [
                // Meal image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CustomImageWidget(
                    imageUrl: meal['image'] as String,
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                    semanticLabel: meal['semanticLabel'] as String,
                  ),
                ),

                SizedBox(width: 3.w),

                // Meal details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal['name'] as String,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),

                      // Calories
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'local_fire_department',
                            color: const Color(0xFFFF6F00),
                            size: 14,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${meal['calories']} kcal',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),

                      // Cost
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'currency_rupee',
                            color: theme.colorScheme.secondary,
                            size: 14,
                          ),
                          Text(
                            '₹${meal['cost']}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),

                      // Status badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.5.w,
                          vertical: 0.6.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _getStatusLabel(meal['status'] as String),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                          ),
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
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'unavailable':
        return 'Unavailable';
      case 'skipped':
        return 'Skipped';
      case 'over_budget':
        return 'Over Budget';
      case 'recommended':
        return 'Recommended';
      case 'high_gi_high_sodium':
        return 'Needs Rework';
      default:
        return status;
    }
  }
}
