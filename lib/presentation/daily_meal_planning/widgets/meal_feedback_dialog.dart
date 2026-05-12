import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../models/meal_feedback.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Meal feedback dialog for tracking consumption status
class MealFeedbackDialog extends StatefulWidget {
  final String mealId;
  final String mealName;
  final String mealType;
  final Function(FeedbackStatus, double, String?) onFeedbackSubmit;

  const MealFeedbackDialog({
    Key? key,
    required this.mealId,
    required this.mealName,
    required this.mealType,
    required this.onFeedbackSubmit,
  }) : super(key: key);

  @override
  State<MealFeedbackDialog> createState() => _MealFeedbackDialogState();
}

class _MealFeedbackDialogState extends State<MealFeedbackDialog> {
  FeedbackStatus? _selectedStatus;
  double _portionConsumed = 1.0;
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
      child: Container(
        padding: EdgeInsets.all(4.w),
        constraints: BoxConstraints(maxHeight: 70.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Meal Feedback',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: theme.colorScheme.onSurface,
                    size: 6.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              widget.mealName,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'How was your meal?',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildFeedbackOption(
                    theme,
                    FeedbackStatus.eaten,
                    'Eaten',
                    'check_circle',
                    Colors.green,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildFeedbackOption(
                    theme,
                    FeedbackStatus.partial,
                    'Partial',
                    'pie_chart',
                    Colors.orange,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildFeedbackOption(
                    theme,
                    FeedbackStatus.skipped,
                    'Skipped',
                    'cancel',
                    Colors.red,
                  ),
                ),
              ],
            ),
            if (_selectedStatus == FeedbackStatus.partial) ...[
              SizedBox(height: 3.h),
              Text(
                'How much did you eat?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'restaurant',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.orange,
                        inactiveTrackColor: Colors.orange.withValues(
                          alpha: 0.3,
                        ),
                        thumbColor: Colors.orange,
                        overlayColor: Colors.orange.withValues(alpha: 0.2),
                        trackHeight: 0.5.h,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 3.w,
                        ),
                      ),
                      child: Slider(
                        value: _portionConsumed,
                        min: 0.1,
                        max: 1.0,
                        divisions: 9,
                        label: '${(_portionConsumed * 100).round()}%',
                        onChanged: (value) {
                          setState(() => _portionConsumed = value);
                        },
                      ),
                    ),
                  ),
                  Text(
                    '${(_portionConsumed * 100).round()}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
            if (_selectedStatus == FeedbackStatus.skipped ||
                _selectedStatus == FeedbackStatus.partial) ...[
              SizedBox(height: 3.h),
              Text(
                'Reason (optional)',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              TextField(
                controller: _reasonController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'e.g., Not hungry, Didn\'t like taste...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  contentPadding: EdgeInsets.all(3.w),
                ),
              ),
            ],
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedStatus == null
                    ? null
                    : () {
                        widget.onFeedbackSubmit(
                          _selectedStatus!,
                          _selectedStatus == FeedbackStatus.eaten
                              ? 1.0
                              : (_selectedStatus == FeedbackStatus.skipped
                                    ? 0.0
                                    : _portionConsumed),
                          _reasonController.text.isEmpty
                              ? null
                              : _reasonController.text,
                        );
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                child: Text(
                  'Submit Feedback',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackOption(
    ThemeData theme,
    FeedbackStatus status,
    String label,
    String icon,
    Color color,
  ) {
    final isSelected = _selectedStatus == status;

    return InkWell(
      onTap: () => setState(() => _selectedStatus = status),
      borderRadius: BorderRadius.circular(2.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : theme.colorScheme.surface,
          border: Border.all(
            color: isSelected ? color : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isSelected ? color : theme.colorScheme.onSurfaceVariant,
              size: 8.w,
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? color : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
