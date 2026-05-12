import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Portion adjustment slider with real-time calorie updates
/// Shows health impact indicators based on portion changes
class PortionSliderWidget extends StatefulWidget {
  final String mealType;
  final Map<String, dynamic> selectedMeal;
  final Function(String, double) onPortionAdjusted;

  const PortionSliderWidget({
    Key? key,
    required this.mealType,
    required this.selectedMeal,
    required this.onPortionAdjusted,
  }) : super(key: key);

  @override
  State<PortionSliderWidget> createState() => _PortionSliderWidgetState();
}

class _PortionSliderWidgetState extends State<PortionSliderWidget> {
  double _portionMultiplier = 1.0;

  @override
  void initState() {
    super.initState();
    _portionMultiplier =
        widget.selectedMeal['portionMultiplier'] as double? ?? 1.0;
  }

  @override
  void didUpdateWidget(PortionSliderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedMeal['id'] != oldWidget.selectedMeal['id']) {
      setState(() {
        _portionMultiplier =
            widget.selectedMeal['portionMultiplier'] as double? ?? 1.0;
      });
    }
  }

  String _getPortionLabel() {
    if (_portionMultiplier <= 0.5) return 'Half portion';
    if (_portionMultiplier < 1.0) return 'Reduced portion';
    if (_portionMultiplier == 1.0) return 'Standard portion';
    if (_portionMultiplier <= 1.5) return 'Increased portion';
    return 'Double portion';
  }

  Color _getHealthImpactColor(ThemeData theme) {
    if (_portionMultiplier <= 0.75) return Colors.green;
    if (_portionMultiplier <= 1.25) return theme.colorScheme.primary;
    return Colors.orange;
  }

  String _getHealthImpactText() {
    if (_portionMultiplier <= 0.75) return 'Good for weight management';
    if (_portionMultiplier <= 1.25) return 'Balanced nutrition';
    return 'Higher calorie intake';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseCalories = widget.selectedMeal['calories'] as int? ?? 0;
    final adjustedCalories = (baseCalories * _portionMultiplier).round();

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adjust Portion',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    _getPortionLabel(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Column(
                  children: [
                    Text(
                      '$adjustedCalories',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'kcal',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          Row(
            children: [
              CustomIconWidget(
                iconName: 'remove_circle_outline',
                color: theme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.primary.withValues(
                      alpha: 0.3,
                    ),
                    thumbColor: theme.colorScheme.primary,
                    overlayColor: theme.colorScheme.primary.withValues(
                      alpha: 0.2,
                    ),
                    trackHeight: 0.5.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.w),
                  ),
                  child: Slider(
                    value: _portionMultiplier,
                    min: 0.5,
                    max: 2.0,
                    divisions: 6,
                    label: '${(_portionMultiplier * 100).round()}%',
                    onChanged: (value) {
                      setState(() => _portionMultiplier = value);
                      widget.onPortionAdjusted(widget.mealType, value);
                    },
                  ),
                ),
              ),
              CustomIconWidget(
                iconName: 'add_circle_outline',
                color: theme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: _getHealthImpactColor(theme).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: _getHealthImpactColor(theme),
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    _getHealthImpactText(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getHealthImpactColor(theme),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
