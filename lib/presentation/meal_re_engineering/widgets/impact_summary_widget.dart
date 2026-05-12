import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Widget displaying impact summary of meal change
class ImpactSummaryWidget extends StatelessWidget {
  final Map<String, dynamic> impactData;

  const ImpactSummaryWidget({Key? key, required this.impactData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calorieChange = impactData['calorieChange'] as int;
    final costChange = impactData['costChange'] as double;
    final healthImpact = impactData['healthImpact'] as String;

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
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: CustomIconWidget(
                    iconName: 'analytics',
                    color: theme.colorScheme.secondary,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  'Impact Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Calorie change
            _buildImpactRow(
              context,
              icon: 'local_fire_department',
              iconColor: const Color(0xFFFF6F00),
              label: 'Calorie Change',
              value: '${calorieChange > 0 ? '+' : ''}$calorieChange kcal',
              percentage: impactData['calorieChangePercentage'] as double,
              isPositive: calorieChange < 0,
            ),

            SizedBox(height: 2.h),

            // Cost change
            _buildImpactRow(
              context,
              icon: 'currency_rupee',
              iconColor: theme.colorScheme.secondary,
              label: 'Cost Impact',
              value: '${costChange > 0 ? '+' : ''}₹${costChange.abs()}',
              percentage: impactData['costChangePercentage'] as double,
              isPositive: costChange < 0,
            ),

            SizedBox(height: 2.h),

            Divider(color: theme.colorScheme.outline.withValues(alpha: 0.2)),

            SizedBox(height: 2.h),

            // Health impact
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: healthImpact == 'improved'
                      ? [
                          const Color(0xFF43A047).withValues(alpha: 0.1),
                          const Color(0xFF66BB6A).withValues(alpha: 0.1),
                        ]
                      : [
                          theme.colorScheme.primaryContainer,
                          theme.colorScheme.primaryContainer.withValues(
                            alpha: 0.5,
                          ),
                        ],
                ),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: healthImpact == 'improved'
                      ? const Color(0xFF43A047).withValues(alpha: 0.3)
                      : theme.colorScheme.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CustomIconWidget(
                      iconName: healthImpact == 'improved'
                          ? 'trending_up'
                          : 'trending_flat',
                      color: healthImpact == 'improved'
                          ? const Color(0xFF43A047)
                          : theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Health Impact: ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: healthImpact == 'improved'
                                    ? const Color(0xFF43A047)
                                    : theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                impactData['healthImpactLabel'] as String,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.8.h),
                        Text(
                          impactData['healthImpactDescription'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.4,
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

  Widget _buildImpactRow(
    BuildContext context, {
    required String icon,
    required Color iconColor,
    required String label,
    required String value,
    required double percentage,
    required bool isPositive,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CustomIconWidget(iconName: icon, color: iconColor, size: 18),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 0.3.h),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.8.h),
          decoration: BoxDecoration(
            color: isPositive
                ? const Color(0xFF43A047).withValues(alpha: 0.1)
                : const Color(0xFFE53935).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: isPositive ? 'arrow_downward' : 'arrow_upward',
                color: isPositive
                    ? const Color(0xFF43A047)
                    : const Color(0xFFE53935),
                size: 14,
              ),
              SizedBox(width: 1.w),
              Text(
                '${percentage.abs().toStringAsFixed(1)}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isPositive
                      ? const Color(0xFF43A047)
                      : const Color(0xFFE53935),
                  fontWeight: FontWeight.w700,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
